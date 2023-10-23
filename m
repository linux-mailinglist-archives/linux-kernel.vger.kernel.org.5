Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA217D3636
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjJWMQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjJWMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:16:14 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050ABE9;
        Mon, 23 Oct 2023 05:16:11 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9674b5d38b=fe@dev.tdt.de>)
        id 1qutqg-005KOP-CI; Mon, 23 Oct 2023 14:15:58 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qutqf-005KO4-EO; Mon, 23 Oct 2023 14:15:57 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 1619924004B;
        Mon, 23 Oct 2023 14:15:57 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 638D1240049;
        Mon, 23 Oct 2023 14:15:56 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id B385D21272;
        Mon, 23 Oct 2023 14:15:55 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Oct 2023 14:15:55 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: ledtrig-tty: add new line mode evaluation
In-Reply-To: <2023102341-jogger-matching-dded@gregkh>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-3-fe@dev.tdt.de>
 <2023102341-jogger-matching-dded@gregkh>
Message-ID: <7e8860574413505c314bdfd0f3e10188@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1698063358-DEFDB1F7-744701C5/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-10-23 12:06, Greg KH wrote:
>> ---
>>  .../ABI/testing/sysfs-class-led-trigger-tty   |  54 +++++
>>  drivers/leds/trigger/ledtrig-tty.c            | 187 
>> ++++++++++++++++--
>>  2 files changed, 230 insertions(+), 11 deletions(-)
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty 
>> b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
>> index 2bf6b24e781b..08127b1a4602 100644
>> --- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
>> @@ -4,3 +4,57 @@ KernelVersion:	5.10
>>  Contact:	linux-leds@vger.kernel.org
>>  Description:
>>  		Specifies the tty device name of the triggering tty
>> +
>> +What:		/sys/class/leds/<led>/rx
>> +Date:		October 2023
>> +KernelVersion:	6.7
>> +Description:
>> +		Signal reception (rx) of data on the named tty device.
>> +		If set to 0, the LED will not blink on reception.
>> +		If set to 1 (default), the LED will blink on reception.
>> +
>> +What:		/sys/class/leds/<led>/tx
>> +Date:		October 2023
>> +KernelVersion:	6.7
>> +Description:
>> +		Signal transmission (tx) of data on the named tty device.
>> +		If set to 0, the LED will not blink on transmission.
>> +		If set to 1 (default), the LED will blink on transmission.
> 
> Were these existing files not documented already?  If not, they should
> be a separate patch we can take now.
> 
>> +
>> +car rng
> 
> What is that line for?

Oops, my fault!

> 
>> +What:		/sys/class/leds/<led>/line_cts
> 
> Why are these all "line_" now?  What is wrong with just "cts" and "dsr"
> and the like?  That keeps them in sync with the "rx" and "tx" files,
> right?

I can change that, I just thought it makes sense to prefix the line 
state
to emphasize the meaning compared to rx and tx.

>> +Date:		October 2023
> 
> October ends in a few days, I think this needs some more work.

But then that's tricky! I do not know when the 6.8 is released. February 
2024?

>> +KernelVersion:	6.7
> 
> And trees should probably be closed now, this looks like 6.8 stuff.


Ok will change this to 6.8

>> +Description:
>> +		DCE is ready to accept data from the DTE (Clear To Send). If
>> +		the line state is detected, the LED is switched on.
>> +		If set to 0 (default), the LED will not evaluate CTS.
>> +		If set to 1, the LED will evaluate CTS.
>> +
>> +What:		/sys/class/leds/<led>/line_dsr
>> +Date:		October 2023
>> +KernelVersion:	6.7
>> +Description:
>> +		DCE is ready to receive and send data (Data Set Ready). If
>> +		the line state is detected, the LED is switched on.
>> +		If set to 0 (default), the LED will not evaluate DSR.
>> +		If set to 1, the LED will evaluate DSR.
>> +
>> +What:		/sys/class/leds/<led>/line_car
>> +Date:		October 2023
>> +KernelVersion:	6.7
>> +Description:
>> +		DTE is receiving a carrier from the DCE (Data Carrier Detect).
>> +		If the line state is detected, the LED is switched on.
>> +		If set to 0 (default), the LED will not evaluate CAR (DCD).
>> +		If set to 1, the LED will evaluate CAR (DCD).
>> +
>> +What:		/sys/class/leds/<led>/line_cts
>> +Date:		October 2023
>> +KernelVersion:	6.7
>> +Description:
>> +		DCE has detected an incoming ring signal on the telephone
>> +		line (Ring Indicator). If the line state is detected, the
>> +		LED is switched on.
>> +		If set to 0 (default), the LED will not evaluate RNG (RI).
>> +		If set to 1, the LED will evaluate RNG (RI).
>> diff --git a/drivers/leds/trigger/ledtrig-tty.c 
>> b/drivers/leds/trigger/ledtrig-tty.c
>> index 8ae0d2d284af..5c8aea1791cf 100644
>> --- a/drivers/leds/trigger/ledtrig-tty.c
>> +++ b/drivers/leds/trigger/ledtrig-tty.c
>> @@ -16,6 +16,28 @@ struct ledtrig_tty_data {
>>  	const char *ttyname;
>>  	struct tty_struct *tty;
>>  	int rx, tx;
>> +	unsigned long ttytrigger;
> 
> Please explain why "unsigned long" is needed here.

As described by me a few lines below and wanted by you, I will change 
this to
boolean flags for rx,tx,cts,dsr,car and rng.

> 
>> +};
>> +
>> +/* Indicates which state the LED should now display */
>> +enum led_trigger_tty_state {
>> +	TTY_LED_BLINK,
>> +	TTY_LED_ENABLE,
>> +	TTY_LED_DISABLE,
>> +};
> 
> Shouldn't we need these states for rx/tx already?

Before my change, the LED has only flashed if there was a transmission.
This is now the TTY_LED_BLINK state. I could rename this to
TTY_LED_FLASH if that is more familiar.

>> +
>> +/* This enum is used to read and write the ttytrigger selection via 
>> the
>> + * sysfs entry and also to evaluate the TIOCM_* bits.
>> + */
>> +enum led_trigger_tty_bits {
>> +	TRIGGER_TTY_RX = 0,
>> +	TRIGGER_TTY_TX,
>> +	TRIGGER_TTY_CTS,
>> +	TRIGGER_TTY_DSR,
>> +	TRIGGER_TTY_CAR,
>> +	TRIGGER_TTY_RNG,
> 
> These are bit values (more on that below), so please explicitly set 
> them
> to a value.

OK

> 
>> +	/* Keep last */
>> +	__TRIGGER_TTY_MAX,
> 
> You never use this, so it is not needed at all.

I saw it in other source files, so I added it. I thought this was
common in the kernel. If this is not the case I will remove this in
the next round.

>>  };
>> 
>>  static void ledtrig_tty_restart(struct ledtrig_tty_data 
>> *trigger_data)
>> @@ -78,13 +100,94 @@ static ssize_t ttyname_store(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RW(ttyname);
>> 
>> +static ssize_t ledtrig_tty_attr_show(struct device *dev, char *buf,
>> +	enum led_trigger_tty_bits attr)
>> +{
>> +	struct ledtrig_tty_data *trigger_data = 
>> led_trigger_get_drvdata(dev);
>> +	int trigger;
>> +
>> +	switch (attr) {
>> +	case TRIGGER_TTY_RX:
>> +	case TRIGGER_TTY_TX:
>> +	case TRIGGER_TTY_CTS:
>> +	case TRIGGER_TTY_DSR:
>> +	case TRIGGER_TTY_CAR:
>> +	case TRIGGER_TTY_RNG:
>> +		trigger = attr;
>> +		break;
>> +	default:
>> +		return -EINVAL;
> 
> How can default ever happen?

If I use the DEFINE_TTY_TRIGGER then this cannot happen.
This is an artifact from when I didn't used the DEFINE_TTY_TRIGGER 
macro.
I will remove it in the next round.

>> +	}
>> +
>> +	return sysfs_emit(buf, "%u\n", test_bit(trigger, 
>> &trigger_data->ttytrigger));
>> +}
>> +
>> +static ssize_t ledtrig_tty_attr_store(struct device *dev, const char 
>> *buf,
>> +	size_t size, enum led_trigger_tty_bits attr)
>> +{
>> +	struct ledtrig_tty_data *trigger_data = 
>> led_trigger_get_drvdata(dev);
>> +	bool enable;
>> +	int trigger;
>> +	int ret;
>> +
>> +	ret = kstrtobool(buf, &enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (attr) {
>> +	case TRIGGER_TTY_RX:
>> +	case TRIGGER_TTY_TX:
>> +	case TRIGGER_TTY_CTS:
>> +	case TRIGGER_TTY_DSR:
>> +	case TRIGGER_TTY_CAR:
>> +	case TRIGGER_TTY_RNG:
>> +		trigger = attr;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (enable)
>> +		set_bit(trigger, &trigger_data->ttytrigger);
>> +	else
>> +		clear_bit(trigger, &trigger_data->ttytrigger);
>> +
>> +	return size;
>> +}
>> +
>> +#define DEFINE_TTY_TRIGGER(trigger_name, trigger) \
>> +	static ssize_t trigger_name##_show(struct device *dev, \
>> +		struct device_attribute *attr, char *buf) \
>> +	{ \
>> +		return ledtrig_tty_attr_show(dev, buf, trigger); \
>> +	} \
>> +	static ssize_t trigger_name##_store(struct device *dev, \
>> +		struct device_attribute *attr, const char *buf, size_t size) \
>> +	{ \
>> +		return ledtrig_tty_attr_store(dev, buf, size, trigger); \
>> +	} \
>> +	static DEVICE_ATTR_RW(trigger_name)
>> +
>> +DEFINE_TTY_TRIGGER(rx, TRIGGER_TTY_RX);
>> +DEFINE_TTY_TRIGGER(tx, TRIGGER_TTY_TX);
> 
> Again, I thought we supported rx/tx already?  If so, this should be
> split out into "redo the rx/tx into a new style" and then "add new
> attributes".  Well maybe, more below...

Yes, but the trigger rx/tx was already support before my change.
It could not be configured via the sysfs.

In my setup I do not want to show if data is being transferred.
I want to display the line stats.
Therefore I made it configurable to turn it off.

>> +DEFINE_TTY_TRIGGER(line_cts, TRIGGER_TTY_CTS);
>> +DEFINE_TTY_TRIGGER(line_dsr, TRIGGER_TTY_DSR);
>> +DEFINE_TTY_TRIGGER(line_car, TRIGGER_TTY_CAR);
>> +DEFINE_TTY_TRIGGER(line_rng, TRIGGER_TTY_RNG);
>> +
>>  static void ledtrig_tty_work(struct work_struct *work)
>>  {
>>  	struct ledtrig_tty_data *trigger_data =
>>  		container_of(work, struct ledtrig_tty_data, dwork.work);
>> +	struct led_classdev *led_cdev = trigger_data->led_cdev;
>> +	unsigned long interval = LEDTRIG_TTY_INTERVAL;
>>  	struct serial_icounter_struct icount;
>> +	enum led_trigger_tty_state state;
>> +	int current_brightness;
>> +	int status;
>>  	int ret;
>> 
>> +	state = TTY_LED_DISABLE;
>>  	mutex_lock(&trigger_data->mutex);
>> 
>>  	if (!trigger_data->ttyname) {
>> @@ -115,22 +218,74 @@ static void ledtrig_tty_work(struct work_struct 
>> *work)
>>  		trigger_data->tty = tty;
>>  	}
>> 
>> -	ret = tty_get_icount(trigger_data->tty, &icount);
>> -	if (ret) {
>> -		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped 
>> polling\n");
>> -		mutex_unlock(&trigger_data->mutex);
>> -		return;
>> +	status = tty_get_tiocm(trigger_data->tty);
>> +	if (status > 0) {
>> +		if (test_bit(TRIGGER_TTY_CTS, &trigger_data->ttytrigger)) {
>> +			if (status & TIOCM_CTS)
>> +				state = TTY_LED_ENABLE;
>> +		}
>> +
>> +		if (test_bit(TRIGGER_TTY_DSR, &trigger_data->ttytrigger)) {
>> +			if (status & TIOCM_DSR)
>> +				state = TTY_LED_ENABLE;
>> +		}
>> +
>> +		if (test_bit(TRIGGER_TTY_CAR, &trigger_data->ttytrigger)) {
>> +			if (status & TIOCM_CAR)
>> +				state = TTY_LED_ENABLE;
>> +		}
>> +
>> +		if (test_bit(TRIGGER_TTY_RNG, &trigger_data->ttytrigger)) {
>> +			if (status & TIOCM_RNG)
>> +				state = TTY_LED_ENABLE;
>> +		}
> 
> Let's ask why you are using bits at all here.  Why?  What is it helping
> with?  Is it faster than a normal "bool" value?  I am guessing not
> (requires mask and test instead of just test).
> 
> So let's just make these individual values in the structure, that makes
> things much simpler and easier and you never have to worry about bit
> field values anywhere.  And the end code will be easier to read as well
> as probably faster (which matters in this codepath, right?)

I had never thought of it that way. I will have a look at that.
Thanks for this.

>> +	}
>> +
>> +	/* The rx/tx handling must come after the evaluation of TIOCM_*,
>> +	 * since the display for rx/tx has priority
>> +	 */
>> +	if (test_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger) ||
>> +	    test_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger)) {
>> +		ret = tty_get_icount(trigger_data->tty, &icount);
>> +		if (ret) {
>> +			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped 
>> polling\n");
> 
> Not your fault, but this should NOT be "dev_info()" but rather,
> "dev_err()", or "dev_warn()".

This is what I have adopted from the code before my change.
But it will change this in dev_warn.

> 
>> +			mutex_unlock(&trigger_data->mutex);
> 
> This looks ready-made for the completion.h usage so we always make sure
> to drop the mutex when done.

I'll have to take a closer look, I don't know that one.
This is what I have adopted from the code before my change.
Shouldn't that be done in a different patch set?

>> +			return;
>> +		}
>> +
>> +		if (test_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger) &&
>> +		    (icount.tx != trigger_data->tx)) {
>> +			trigger_data->tx = icount.tx;
>> +			state = TTY_LED_BLINK;
>> +		}
>> +
>> +		if (test_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger) &&
>> +		    (icount.rx != trigger_data->rx)) {
>> +			trigger_data->rx = icount.rx;
>> +			state = TTY_LED_BLINK;
>> +		}
>>  	}
>> 
>> -	if (icount.rx != trigger_data->rx ||
>> -	    icount.tx != trigger_data->tx) {
>> -		unsigned long interval = LEDTRIG_TTY_INTERVAL;
>> +	current_brightness = led_cdev->brightness;
>> +	if (current_brightness)
>> +		led_cdev->blink_brightness = current_brightness;
>> 
>> +	if (!led_cdev->blink_brightness)
>> +		led_cdev->blink_brightness = led_cdev->max_brightness;
>> +
>> +	switch (state) {
>> +	case TTY_LED_BLINK:
>>  		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
>>  				      &interval, 0);
>> -
>> -		trigger_data->rx = icount.rx;
>> -		trigger_data->tx = icount.tx;
>> +		break;
>> +	case TTY_LED_ENABLE:
>> +		led_set_brightness(led_cdev, led_cdev->blink_brightness);
>> +		break;
>> +	case TTY_LED_DISABLE:
>> +		fallthrough;
>> +	default:
>> +		led_set_brightness(led_cdev, LED_OFF);
>> +		break;
>>  	}
>> 
>>  out:
>> @@ -141,6 +296,12 @@ static void ledtrig_tty_work(struct work_struct 
>> *work)
>> 
>>  static struct attribute *ledtrig_tty_attrs[] = {
>>  	&dev_attr_ttyname.attr,
>> +	&dev_attr_rx.attr,
>> +	&dev_attr_tx.attr,
> 
> Again, I thought we had rx/tx already?  If not, how was that controlled
> today?

It could not be controlled! The LED flashed when data where transferred.
This was the only function that the trigger supported.

Thanks for your review!

---
Florian
