Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC557D2F72
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjJWKG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJWKGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:06:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5146CDA;
        Mon, 23 Oct 2023 03:06:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEF0C433C8;
        Mon, 23 Oct 2023 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698055581;
        bh=NLuiI1+dM/ReNljlzos+MI+A0anBz+UbVcTAs3ldz9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibUAT8camhKi3nWwuwD3hpS8UnIBDoQbAwvdjs7uBxEKbRog2HBCDiFQnM623MY5T
         pVpLBKbxCyapug5L+PL2ZVJcibYZCWfkI7EGC323srRXU8YAyzmtS4o7HJxUYX2md2
         eQR5zoMoouquuMH12ZDEIM34NqkTPl8v0o//dn4k=
Date:   Mon, 23 Oct 2023 12:06:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: ledtrig-tty: add new line mode evaluation
Message-ID: <2023102341-jogger-matching-dded@gregkh>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023094205.2706812-3-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:42:05AM +0200, Florian Eckert wrote:
> Until now, the LED blinks when data is sent via the tty (rx/tx).
> The serial tty interface also supports additional input signals, that can
> also be evaluated within this trigger. This change is adding the following
> additional input sources, which could be controlled
> via the '/sys/class/<leds>/' sysfs interface.
> 
> - line_cts:
>   DCE is ready to accept data from the DTE (CTS = Clear To  Send). If the

nit, one too many spaces in this line.

>   line state is detected, the LED is switched on.
>   If set to 0 (default), the LED will not evaluate CTS.
>   If set to 1, the LED will evaluate CTS.
> 
> - line_dsr:
>   DCE is ready to receive and send data (DSR = Data Set Ready). If the line
>   state is detected, the LED is switched on.
>   If set to 0 (default), the LED will not evaluate DSR.
>   If set to 1, the LED will evaluate DSR.
> 
> - line_car:
>   DTE is receiving a carrier from the DCE (DCD = Data Carrier Detect). If
>   the line state is detected, the LED is switched on.
>   If set to 0 (default), the LED will not evaluate CAR (DCD).
>   If set to 1, the LED will evaluate CAR (DCD).
> 
> - line_rng:
>   DCE has detected an incoming ring signal on the telephone line
>   (RI = Ring Indicator). If the line state is detected, the LED is
>   switched on.
>   If set to 0 (default), the LED will not evaluate RNG (RI).
>   If set to 1, the LED will evaluate RNG (RI).
> 
> Explanation:
> DCE = Data Communication Equipment (Modem)
> DTE = Data Terminal Equipment (Computer)

These definitions should be above where you use them.

> In addition to the new line_* entries in sysfs, the indication for the
> direction of the transmitted data is independently controllable via the
> new rx and tx sysfs entrie now too. These are on by default. Thus the

"entries"

> trigger behaves as before this change.
> 
> - rx:
>   Signal reception (rx) of data on the named tty device.
>   If set to 0, the LED will not blink on reception.
>   If set to 1 (default), the LED will blink on reception.
> 
> - tx:
>   Signal transmission (tx) of data on the named tty device.
>   If set to 0, the LED will not blink on transmission.
>   If set to 1 (default), the LED will blink on transmission.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  .../ABI/testing/sysfs-class-led-trigger-tty   |  54 +++++
>  drivers/leds/trigger/ledtrig-tty.c            | 187 ++++++++++++++++--
>  2 files changed, 230 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> index 2bf6b24e781b..08127b1a4602 100644
> --- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> @@ -4,3 +4,57 @@ KernelVersion:	5.10
>  Contact:	linux-leds@vger.kernel.org
>  Description:
>  		Specifies the tty device name of the triggering tty
> +
> +What:		/sys/class/leds/<led>/rx
> +Date:		October 2023
> +KernelVersion:	6.7
> +Description:
> +		Signal reception (rx) of data on the named tty device.
> +		If set to 0, the LED will not blink on reception.
> +		If set to 1 (default), the LED will blink on reception.
> +
> +What:		/sys/class/leds/<led>/tx
> +Date:		October 2023
> +KernelVersion:	6.7
> +Description:
> +		Signal transmission (tx) of data on the named tty device.
> +		If set to 0, the LED will not blink on transmission.
> +		If set to 1 (default), the LED will blink on transmission.

Were these existing files not documented already?  If not, they should
be a separate patch we can take now.

> +
> +car rng

What is that line for?

> +What:		/sys/class/leds/<led>/line_cts

Why are these all "line_" now?  What is wrong with just "cts" and "dsr"
and the like?  That keeps them in sync with the "rx" and "tx" files,
right?

> +Date:		October 2023

October ends in a few days, I think this needs some more work.

> +KernelVersion:	6.7

And trees should probably be closed now, this looks like 6.8 stuff.

> +Description:
> +		DCE is ready to accept data from the DTE (Clear To Send). If
> +		the line state is detected, the LED is switched on.
> +		If set to 0 (default), the LED will not evaluate CTS.
> +		If set to 1, the LED will evaluate CTS.
> +
> +What:		/sys/class/leds/<led>/line_dsr
> +Date:		October 2023
> +KernelVersion:	6.7
> +Description:
> +		DCE is ready to receive and send data (Data Set Ready). If
> +		the line state is detected, the LED is switched on.
> +		If set to 0 (default), the LED will not evaluate DSR.
> +		If set to 1, the LED will evaluate DSR.
> +
> +What:		/sys/class/leds/<led>/line_car
> +Date:		October 2023
> +KernelVersion:	6.7
> +Description:
> +		DTE is receiving a carrier from the DCE (Data Carrier Detect).
> +		If the line state is detected, the LED is switched on.
> +		If set to 0 (default), the LED will not evaluate CAR (DCD).
> +		If set to 1, the LED will evaluate CAR (DCD).
> +
> +What:		/sys/class/leds/<led>/line_cts
> +Date:		October 2023
> +KernelVersion:	6.7
> +Description:
> +		DCE has detected an incoming ring signal on the telephone
> +		line (Ring Indicator). If the line state is detected, the
> +		LED is switched on.
> +		If set to 0 (default), the LED will not evaluate RNG (RI).
> +		If set to 1, the LED will evaluate RNG (RI).
> diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
> index 8ae0d2d284af..5c8aea1791cf 100644
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -16,6 +16,28 @@ struct ledtrig_tty_data {
>  	const char *ttyname;
>  	struct tty_struct *tty;
>  	int rx, tx;
> +	unsigned long ttytrigger;

Please explain why "unsigned long" is needed here.

> +};
> +
> +/* Indicates which state the LED should now display */
> +enum led_trigger_tty_state {
> +	TTY_LED_BLINK,
> +	TTY_LED_ENABLE,
> +	TTY_LED_DISABLE,
> +};

Shouldn't we need these states for rx/tx already?

> +
> +/* This enum is used to read and write the ttytrigger selection via the
> + * sysfs entry and also to evaluate the TIOCM_* bits.
> + */
> +enum led_trigger_tty_bits {
> +	TRIGGER_TTY_RX = 0,
> +	TRIGGER_TTY_TX,
> +	TRIGGER_TTY_CTS,
> +	TRIGGER_TTY_DSR,
> +	TRIGGER_TTY_CAR,
> +	TRIGGER_TTY_RNG,

These are bit values (more on that below), so please explicitly set them
to a value.

> +	/* Keep last */
> +	__TRIGGER_TTY_MAX,

You never use this, so it is not needed at all.

>  };
>  
>  static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
> @@ -78,13 +100,94 @@ static ssize_t ttyname_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(ttyname);
>  
> +static ssize_t ledtrig_tty_attr_show(struct device *dev, char *buf,
> +	enum led_trigger_tty_bits attr)
> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	int trigger;
> +
> +	switch (attr) {
> +	case TRIGGER_TTY_RX:
> +	case TRIGGER_TTY_TX:
> +	case TRIGGER_TTY_CTS:
> +	case TRIGGER_TTY_DSR:
> +	case TRIGGER_TTY_CAR:
> +	case TRIGGER_TTY_RNG:
> +		trigger = attr;
> +		break;
> +	default:
> +		return -EINVAL;

How can default ever happen?

> +	}
> +
> +	return sysfs_emit(buf, "%u\n", test_bit(trigger, &trigger_data->ttytrigger));
> +}
> +
> +static ssize_t ledtrig_tty_attr_store(struct device *dev, const char *buf,
> +	size_t size, enum led_trigger_tty_bits attr)
> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	bool enable;
> +	int trigger;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	switch (attr) {
> +	case TRIGGER_TTY_RX:
> +	case TRIGGER_TTY_TX:
> +	case TRIGGER_TTY_CTS:
> +	case TRIGGER_TTY_DSR:
> +	case TRIGGER_TTY_CAR:
> +	case TRIGGER_TTY_RNG:
> +		trigger = attr;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (enable)
> +		set_bit(trigger, &trigger_data->ttytrigger);
> +	else
> +		clear_bit(trigger, &trigger_data->ttytrigger);
> +
> +	return size;
> +}
> +
> +#define DEFINE_TTY_TRIGGER(trigger_name, trigger) \
> +	static ssize_t trigger_name##_show(struct device *dev, \
> +		struct device_attribute *attr, char *buf) \
> +	{ \
> +		return ledtrig_tty_attr_show(dev, buf, trigger); \
> +	} \
> +	static ssize_t trigger_name##_store(struct device *dev, \
> +		struct device_attribute *attr, const char *buf, size_t size) \
> +	{ \
> +		return ledtrig_tty_attr_store(dev, buf, size, trigger); \
> +	} \
> +	static DEVICE_ATTR_RW(trigger_name)
> +
> +DEFINE_TTY_TRIGGER(rx, TRIGGER_TTY_RX);
> +DEFINE_TTY_TRIGGER(tx, TRIGGER_TTY_TX);

Again, I thought we supported rx/tx already?  If so, this should be
split out into "redo the rx/tx into a new style" and then "add new
attributes".  Well maybe, more below...


> +DEFINE_TTY_TRIGGER(line_cts, TRIGGER_TTY_CTS);
> +DEFINE_TTY_TRIGGER(line_dsr, TRIGGER_TTY_DSR);
> +DEFINE_TTY_TRIGGER(line_car, TRIGGER_TTY_CAR);
> +DEFINE_TTY_TRIGGER(line_rng, TRIGGER_TTY_RNG);
> +
>  static void ledtrig_tty_work(struct work_struct *work)
>  {
>  	struct ledtrig_tty_data *trigger_data =
>  		container_of(work, struct ledtrig_tty_data, dwork.work);
> +	struct led_classdev *led_cdev = trigger_data->led_cdev;
> +	unsigned long interval = LEDTRIG_TTY_INTERVAL;
>  	struct serial_icounter_struct icount;
> +	enum led_trigger_tty_state state;
> +	int current_brightness;
> +	int status;
>  	int ret;
>  
> +	state = TTY_LED_DISABLE;
>  	mutex_lock(&trigger_data->mutex);
>  
>  	if (!trigger_data->ttyname) {
> @@ -115,22 +218,74 @@ static void ledtrig_tty_work(struct work_struct *work)
>  		trigger_data->tty = tty;
>  	}
>  
> -	ret = tty_get_icount(trigger_data->tty, &icount);
> -	if (ret) {
> -		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");
> -		mutex_unlock(&trigger_data->mutex);
> -		return;
> +	status = tty_get_tiocm(trigger_data->tty);
> +	if (status > 0) {
> +		if (test_bit(TRIGGER_TTY_CTS, &trigger_data->ttytrigger)) {
> +			if (status & TIOCM_CTS)
> +				state = TTY_LED_ENABLE;
> +		}
> +
> +		if (test_bit(TRIGGER_TTY_DSR, &trigger_data->ttytrigger)) {
> +			if (status & TIOCM_DSR)
> +				state = TTY_LED_ENABLE;
> +		}
> +
> +		if (test_bit(TRIGGER_TTY_CAR, &trigger_data->ttytrigger)) {
> +			if (status & TIOCM_CAR)
> +				state = TTY_LED_ENABLE;
> +		}
> +
> +		if (test_bit(TRIGGER_TTY_RNG, &trigger_data->ttytrigger)) {
> +			if (status & TIOCM_RNG)
> +				state = TTY_LED_ENABLE;
> +		}

Let's ask why you are using bits at all here.  Why?  What is it helping
with?  Is it faster than a normal "bool" value?  I am guessing not
(requires mask and test instead of just test).

So let's just make these individual values in the structure, that makes
things much simpler and easier and you never have to worry about bit
field values anywhere.  And the end code will be easier to read as well
as probably faster (which matters in this codepath, right?)

> +	}
> +
> +	/* The rx/tx handling must come after the evaluation of TIOCM_*,
> +	 * since the display for rx/tx has priority
> +	 */
> +	if (test_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger) ||
> +	    test_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger)) {
> +		ret = tty_get_icount(trigger_data->tty, &icount);
> +		if (ret) {
> +			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");

Not your fault, but this should NOT be "dev_info()" but rather,
"dev_err()", or "dev_warn()".

> +			mutex_unlock(&trigger_data->mutex);

This looks ready-made for the completion.h usage so we always make sure
to drop the mutex when done.

> +			return;
> +		}
> +
> +		if (test_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger) &&
> +		    (icount.tx != trigger_data->tx)) {
> +			trigger_data->tx = icount.tx;
> +			state = TTY_LED_BLINK;
> +		}
> +
> +		if (test_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger) &&
> +		    (icount.rx != trigger_data->rx)) {
> +			trigger_data->rx = icount.rx;
> +			state = TTY_LED_BLINK;
> +		}
>  	}
>  
> -	if (icount.rx != trigger_data->rx ||
> -	    icount.tx != trigger_data->tx) {
> -		unsigned long interval = LEDTRIG_TTY_INTERVAL;
> +	current_brightness = led_cdev->brightness;
> +	if (current_brightness)
> +		led_cdev->blink_brightness = current_brightness;
>  
> +	if (!led_cdev->blink_brightness)
> +		led_cdev->blink_brightness = led_cdev->max_brightness;
> +
> +	switch (state) {
> +	case TTY_LED_BLINK:
>  		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
>  				      &interval, 0);
> -
> -		trigger_data->rx = icount.rx;
> -		trigger_data->tx = icount.tx;
> +		break;
> +	case TTY_LED_ENABLE:
> +		led_set_brightness(led_cdev, led_cdev->blink_brightness);
> +		break;
> +	case TTY_LED_DISABLE:
> +		fallthrough;
> +	default:
> +		led_set_brightness(led_cdev, LED_OFF);
> +		break;
>  	}
>  
>  out:
> @@ -141,6 +296,12 @@ static void ledtrig_tty_work(struct work_struct *work)
>  
>  static struct attribute *ledtrig_tty_attrs[] = {
>  	&dev_attr_ttyname.attr,
> +	&dev_attr_rx.attr,
> +	&dev_attr_tx.attr,

Again, I thought we had rx/tx already?  If not, how was that controlled
today?

thanks,

greg k-h
