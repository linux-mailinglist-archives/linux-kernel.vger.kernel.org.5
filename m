Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD1D7D1E22
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjJUQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjJUQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:07:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAA91A4;
        Sat, 21 Oct 2023 09:07:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D10C433C8;
        Sat, 21 Oct 2023 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697904432;
        bh=ZD4gnNZ4sd1nQ6aNB8FAQiCnaG/10E18+QxR7q3dmZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEXT7xVWscHDKwBRbWZ6RY4BLI0cAnkl7Y4DaZ5t/cMA876i5KndYfNIWQTZRy/hr
         FWKS7hk8a7WlrUdPgbAOaGjEfRzlYV+Z0Gq3k6KceJ+GjPNG28sOgimtmkjYT50/aV
         3ZouC08j9Fim5gosmDAuMLrcWmaMSLDVoQwEjrlI=
Date:   Sat, 21 Oct 2023 18:07:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        ansuelsmth@gmail.com, m.brock@vanmierlo.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 3/3] leds: ledtrig-tty: add new line mode evaluation
Message-ID: <2023102136-reenact-cash-7295@gregkh>
References: <20231019112809.881730-1-fe@dev.tdt.de>
 <20231019112809.881730-4-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019112809.881730-4-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 01:28:09PM +0200, Florian Eckert wrote:
> Until now, the LED blinks when data is sent via the tty (rx/tx).
> The serial tty interface also supports additional input signals, that can
> also be evaluated within this trigger. This change is adding the following
> additional input sources, which could be controlled
> via the '/sys/class/<leds>/' sysfs interface.
> 
> - line_cts:
>   DCE is ready to accept data from the DTE (CTS = Clear To  Send). If the
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
> 
> In addition to the new line_* entries in sysfs, the indication for the
> direction of the transmitted data is independently controllable via the
> new rx and tx sysfs entrie now too. These are on by default. Thus the
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
>  drivers/leds/trigger/ledtrig-tty.c            | 192 +++++++++++++++++-
>  2 files changed, 235 insertions(+), 11 deletions(-)
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
> +
> +car rng
> +What:		/sys/class/leds/<led>/line_cts
> +Date:		October 2023
> +KernelVersion:	6.7
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
> index 8ae0d2d284af..6a96439a7e55 100644
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -16,6 +16,24 @@ struct ledtrig_tty_data {
>  	const char *ttyname;
>  	struct tty_struct *tty;
>  	int rx, tx;
> +	unsigned long mode;

Why is mode "unsigned long" when the tty layer treats it as an int?  And
really, this should be set to an explit size, u32 perhaps?  Or am I
confused as to exactly what this is?

> +};
> +
> +enum led_trigger_tty_state {
> +	TTY_LED_BLINK,
> +	TTY_LED_ENABLE,
> +	TTY_LED_DISABLE,
> +};
> +
> +enum led_trigger_tty_modes {
> +	TRIGGER_TTY_RX = 0,
> +	TRIGGER_TTY_TX,
> +	TRIGGER_TTY_CTS,
> +	TRIGGER_TTY_DSR,
> +	TRIGGER_TTY_CAR,
> +	TRIGGER_TTY_RNG,
> +	/* Keep last */
> +	__TRIGGER_TTY_MAX,
>  };
>

Oh wait, is "mode" this?  If so, why not define it as an enum?  Or if
not, I'm totally confused as to what is going on here, sorry.


>  static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
> @@ -78,13 +96,106 @@ static ssize_t ttyname_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(ttyname);
>  
> +static ssize_t ledtrig_tty_attr_show(struct device *dev, char *buf,
> +	enum led_trigger_tty_modes attr)
> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	int bit;
> +
> +	switch (attr) {
> +	case TRIGGER_TTY_RX:
> +	case TRIGGER_TTY_TX:
> +	case TRIGGER_TTY_CTS:
> +	case TRIGGER_TTY_DSR:
> +	case TRIGGER_TTY_CAR:
> +	case TRIGGER_TTY_RNG:
> +		bit = attr;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return sprintf(buf, "%u\n", test_bit(bit, &trigger_data->mode));

sysfs_emit() for all new sysfs attributes please.

> +}
> +
> +static ssize_t ledtrig_tty_attr_store(struct device *dev, const char *buf,
> +	size_t size, enum led_trigger_tty_modes attr)
> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	unsigned long state;
> +	int ret;
> +	int bit;
> +
> +	ret = kstrtoul(buf, 0, &state);
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
> +		bit = attr;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (state)
> +		set_bit(bit, &trigger_data->mode);
> +	else
> +		clear_bit(bit, &trigger_data->mode);

I think your test of "state" here is wrong, if you write in "40000" you
are treating it as "1", which I don't think you want, right?

thanks,

greg k-h
