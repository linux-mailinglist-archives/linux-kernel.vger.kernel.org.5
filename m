Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2728E7DB4F2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjJ3IPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjJ3IPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:15:48 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974E4BD;
        Mon, 30 Oct 2023 01:15:45 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9681cd3a30=fe@dev.tdt.de>)
        id 1qxNQq-00GSKG-5Q; Mon, 30 Oct 2023 09:15:32 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qxNQp-000Zs3-1p; Mon, 30 Oct 2023 09:15:31 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id A3726240049;
        Mon, 30 Oct 2023 09:15:30 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 01A4E240040;
        Mon, 30 Oct 2023 09:15:29 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 2BE07215D4;
        Mon, 30 Oct 2023 09:15:28 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Oct 2023 09:15:28 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     m.brock@vanmierlo.com
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: ledtrig-tty: add new line mode evaluation
In-Reply-To: <ddf9439a092576cd18c6e025d0b61602@vanmierlo.com>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-3-fe@dev.tdt.de>
 <ddf9439a092576cd18c6e025d0b61602@vanmierlo.com>
Message-ID: <2951fd563fc6a364d8cddfb7ec17808b@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1698653731-DCC6A3D8-37093731/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-28 12:43, m.brock@vanmierlo.com wrote:
> Florian Eckert wrote on 2023-10-23 11:42:
> 
>> @@ -16,6 +16,28 @@ struct ledtrig_tty_data {
>>      const char *ttyname;
>>      struct tty_struct *tty;
>>      int rx, tx;
>> +     unsigned long ttytrigger;
>> +};
> 
> ttytriggers ?

Yes that would be nicer name. thanks

> [...]
> 
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
>> +			mutex_unlock(&trigger_data->mutex);
>> +			return;
>> +		}
>> +
>> +		if (test_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger) &&
>> +		    (icount.tx != trigger_data->tx)) {
> 
> You check for TRIGGER_TTY_RX and then compare icount.tx, is that 
> correct?

I would say this is correct. At first I check if the tx path should be 
evaluated
and if this is correct I check if there was a tx transmission during the 
last run.

>> +			trigger_data->tx = icount.tx;
>> +			state = TTY_LED_BLINK;
>> +		}
>> +
>> +		if (test_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger) &&
>> +		    (icount.rx != trigger_data->rx)) {
> 
> You check for TRIGGER_TTY_TX and then compare icount.rx, is that 
> correct?

I would say this is correct. At first I check if the rx path should be 
evaluated
and if this is correct I check if there was a rx transmission during the 
last run.

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
> 
> Is it OK to override the chosen brightness here?

In my setup my brightness in the sysfs path of the LED ist set to '0'.
Even though the tty trigger was configured correctly the LED was not
turned on. If I set max_brightness in this path the LED works correctly.
I would check this a gain if this is still needed.

>> +
>> +	switch (state) {
>> +	case TTY_LED_BLINK:
>>  		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
>>  				      &interval, 0);
> 
> Change trigger_data->led_cdev to simply led_cdev

Thanks for the hint. I will change this.

> Shouldn't the led return to the line controlled steady state?

Sorry I do not understand your question.

> Set an invert variable to true if state was TTY_LED_ENABLE before it 
> got set
> to TTY_LED_BLINK

No matter whether the LED is on or off beforehand. I understand that the
LED is always on for the first half of the period and off for the rest 
of
the period. I think that is correct and I don't need to make a 
distinction
via invert here. I hope I have understood your comment correctly here.

> How do interval and the frequency of ledtrig_tty_work() relate?

The work is twice as long as of the interval. So the variable
LEDTRIG_TTY_INTERVAL = 50 and the work is scheduled LEDTRIG_TTY_INTERVAL 
* 2.
But that was also before my change.

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
> 
> Maarten

Thank you for your feedback. I must say, however, that I am currently in
the process of preparing v6, which will implement the comments and
change requests from 'greg k-h' [1]. The big change here in v6 is, that 
I have
switched to completion and split the change in more reviewable commits.
I will see if your comments can also be incorporated into the new 
approach.

---

Florian

[1] 
https://lore.kernel.org/linux-leds/2023102341-jogger-matching-dded@gregkh/
