Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491997D2292
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjJVKYq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 22 Oct 2023 06:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJVKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:24:44 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9389597
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:24:42 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9673dbd9fc=fe@dev.tdt.de>)
        id 1quVdG-003Xem-ER; Sun, 22 Oct 2023 12:24:30 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1quVdF-009emP-GD; Sun, 22 Oct 2023 12:24:29 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 1542524004B;
        Sun, 22 Oct 2023 12:24:29 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 61CA6240040;
        Sun, 22 Oct 2023 12:24:28 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id C441D213BE;
        Sun, 22 Oct 2023 12:24:27 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date:   Sun, 22 Oct 2023 12:24:27 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        ansuelsmth@gmail.com, m.brock@vanmierlo.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 3/3] leds: ledtrig-tty: add new line mode evaluation
In-Reply-To: <2023102136-reenact-cash-7295@gregkh>
References: <20231019112809.881730-1-fe@dev.tdt.de>
 <20231019112809.881730-4-fe@dev.tdt.de>
 <2023102136-reenact-cash-7295@gregkh>
Message-ID: <72be6923ff6dd03a5d02d04ee1c5796f@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8BIT
X-purgate: clean
X-purgate-ID: 151534::1697970270-DD48F3D8-8F2C12EC/0/0
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-21 18:07, Greg KH wrote:
>> diff --git a/drivers/leds/trigger/ledtrig-tty.c 
>> b/drivers/leds/trigger/ledtrig-tty.c
>> index 8ae0d2d284af..6a96439a7e55 100644
>> --- a/drivers/leds/trigger/ledtrig-tty.c
>> +++ b/drivers/leds/trigger/ledtrig-tty.c
>> @@ -16,6 +16,24 @@ struct ledtrig_tty_data {
>>  	const char *ttyname;
>>  	struct tty_struct *tty;
>>  	int rx, tx;
>> +	unsigned long mode;
> 
> Why is mode "unsigned long" when the tty layer treats it as an int?  
> And
> really, this should be set to an explit size, u32 perhaps?  Or am I
> confused as to exactly what this is?

This is about the line state that the LED should show "altogether".
All states that the LED is to display are stored here.

For example:
Via the sysfs of the LED I can set the flags rx, tx and line_cts to
a "not" zero value. That means that the led is enable if the CTS of the
tty ist set, and the LED flashes if rx/tx data are transmitted via
this tty.

Therefore, the bits 0 (TRIGGER_TTY_RX), 1 (TRIGGER_TTY_TX) and
2 (TRIGGER_TTY_CTS) are set in the variable. As defined in the
enum led_trigger_tty_modes

I think I have not chosen the correct name for the variable there.
Maybe line_state, would be a better choice?

>> +};
>> +
>> +enum led_trigger_tty_state {
>> +	TTY_LED_BLINK,
>> +	TTY_LED_ENABLE,
>> +	TTY_LED_DISABLE,
>> +};
>> +
>> +enum led_trigger_tty_modes {
>> +	TRIGGER_TTY_RX = 0,
>> +	TRIGGER_TTY_TX,
>> +	TRIGGER_TTY_CTS,
>> +	TRIGGER_TTY_DSR,
>> +	TRIGGER_TTY_CAR,
>> +	TRIGGER_TTY_RNG,
>> +	/* Keep last */
>> +	__TRIGGER_TTY_MAX,
>>  };
>> 
> 
> Oh wait, is "mode" this?  If so, why not define it as an enum?  Or if
> not, I'm totally confused as to what is going on here, sorry.

See explanation above. I can not set this to an enum because I could
set more then one Flag via the sysfs.

> 
>>  static void ledtrig_tty_restart(struct ledtrig_tty_data 
>> *trigger_data)
>> @@ -78,13 +96,106 @@ static ssize_t ttyname_store(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RW(ttyname);
>> 
>> +static ssize_t ledtrig_tty_attr_show(struct device *dev, char *buf,
>> +	enum led_trigger_tty_modes attr)
>> +{
>> +	struct ledtrig_tty_data *trigger_data = 
>> led_trigger_get_drvdata(dev);
>> +	int bit;
>> +
>> +	switch (attr) {
>> +	case TRIGGER_TTY_RX:
>> +	case TRIGGER_TTY_TX:
>> +	case TRIGGER_TTY_CTS:
>> +	case TRIGGER_TTY_DSR:
>> +	case TRIGGER_TTY_CAR:
>> +	case TRIGGER_TTY_RNG:
>> +		bit = attr;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return sprintf(buf, "%u\n", test_bit(bit, &trigger_data->mode));
> 
> sysfs_emit() for all new sysfs attributes please.

Correct. Thanks for the hint will use sysf_emit() function in the next
patchset round.

> 
>> +}
>> +
>> +static ssize_t ledtrig_tty_attr_store(struct device *dev, const char 
>> *buf,
>> +	size_t size, enum led_trigger_tty_modes attr)
>> +{
>> +	struct ledtrig_tty_data *trigger_data = 
>> led_trigger_get_drvdata(dev);
>> +	unsigned long state;
>> +	int ret;
>> +	int bit;
>> +
>> +	ret = kstrtoul(buf, 0, &state);
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
>> +		bit = attr;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (state)
>> +		set_bit(bit, &trigger_data->mode);
>> +	else
>> +		clear_bit(bit, &trigger_data->mode);
> 
> I think your test of "state" here is wrong, if you write in "40000" you
> are treating it as "1", which I don't think you want, right?

If I have understood your question correctly, then I would say that your
assumption is not correct. I just want to check here whether it is a 
number
greater than zero or not. If the number is greater than zero then the 
bit
should be set in the 'mode' variable of the struct and if it is zero 
then
it should be cleared.

The LED could indicate more then one state there. As described above.
This was requested by Uwe Kleine-König in the old v7 patch series [1].

Thanks for your review!

---
Florian

Links:
[1] 
https://lore.kernel.org/linux-leds/20230306093524.amm7o4ppa7gon4ew@pengutronix.de/
