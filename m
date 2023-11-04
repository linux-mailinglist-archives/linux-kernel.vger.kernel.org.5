Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D36F7E0FC6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjKDN71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjKDN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:59:25 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880C2187;
        Sat,  4 Nov 2023 06:59:21 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 10.0.2 patch 1) with ESMTPA;
        Sat, 4 Nov 2023 14:59:17 +0100
MIME-Version: 1.0
Date:   Sat, 04 Nov 2023 14:59:17 +0100
From:   m.brock@vanmierlo.com
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: ledtrig-tty: add new line mode evaluation
In-Reply-To: <2951fd563fc6a364d8cddfb7ec17808b@dev.tdt.de>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-3-fe@dev.tdt.de>
 <ddf9439a092576cd18c6e025d0b61602@vanmierlo.com>
 <2951fd563fc6a364d8cddfb7ec17808b@dev.tdt.de>
Message-ID: <ceec1d36f889eb82e724335d007334fd@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Eckert wrote on 2023-10-30 09:15:
>>> +	/* The rx/tx handling must come after the evaluation of TIOCM_*,
>>> +	 * since the display for rx/tx has priority
>>> +	 */
>>> +	if (test_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger) ||
>>> +	    test_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger)) {
>>> +		ret = tty_get_icount(trigger_data->tty, &icount);
>>> +		if (ret) {
>>> +			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped 
>>> polling\n");
>>> +			mutex_unlock(&trigger_data->mutex);
>>> +			return;
>>> +		}
>>> +
>>> +		if (test_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger) &&
>>> +		    (icount.tx != trigger_data->tx)) {
>> 
>> You check for TRIGGER_TTY_RX and then compare icount.tx, is that 
>> correct?
> 
> I would say this is correct. At first I check if the tx path should be 
> evaluated
> and if this is correct I check if there was a tx transmission during
> the last run.

No, you check if the *RX* path should be evaluated! On the bright side: 
this is
fixed in the new patch set.

>>> +			trigger_data->tx = icount.tx;
>>> +			state = TTY_LED_BLINK;
>>> +		}
>>> +
>>> +		if (test_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger) &&
>>> +		    (icount.rx != trigger_data->rx)) {
>> 
>> You check for TRIGGER_TTY_TX and then compare icount.rx, is that 
>> correct?
> 
> I would say this is correct. At first I check if the rx path should be 
> evaluated
> and if this is correct I check if there was a rx transmission during
> the last run.

Same difference.

>>> +			trigger_data->rx = icount.rx;
>>> +			state = TTY_LED_BLINK;
>>> +		}
>>>  	}
>>> 
>>> -	if (icount.rx != trigger_data->rx ||
>>> -	    icount.tx != trigger_data->tx) {
>>> -		unsigned long interval = LEDTRIG_TTY_INTERVAL;
>>> +	current_brightness = led_cdev->brightness;
>>> +	if (current_brightness)
>>> +		led_cdev->blink_brightness = current_brightness;
>>> 
>>> +	if (!led_cdev->blink_brightness)
>>> +		led_cdev->blink_brightness = led_cdev->max_brightness;
>> 
>> Is it OK to override the chosen brightness here?
> 
> In my setup my brightness in the sysfs path of the LED ist set to '0'.
> Even though the tty trigger was configured correctly the LED was not
> turned on. If I set max_brightness in this path the LED works 
> correctly.
> I would check this a gain if this is still needed.

I see you've dropped this from the new patch set. Thank you.

>> Shouldn't the led return to the line controlled steady state?
> 
> Sorry I do not understand your question.
> 
>> Set an invert variable to true if state was TTY_LED_ENABLE before it 
>> got set
>> to TTY_LED_BLINK
> 
> No matter whether the LED is on or off beforehand. I understand that 
> the
> LED is always on for the first half of the period and off for the rest 
> of
> the period. I think that is correct and I don't need to make a 
> distinction
> via invert here. I hope I have understood your comment correctly here.
> 
>> How do interval and the frequency of ledtrig_tty_work() relate?
> 
> The work is twice as long as of the interval. So the variable
> LEDTRIG_TTY_INTERVAL = 50 and the work is scheduled 
> LEDTRIG_TTY_INTERVAL * 2.
> But that was also before my change.

This explains why you don't necessarily need to invert the blink.
If E.g. both CTS and TX are configured I would expect to see the led 
turn on
once CTS actives and then blink off when something is transmitted. After 
that
I expect to see the led still on because CTS is still active.

Now only because the work interval is 2*LEDTRIG_TTY_INTERVAL and the 
blink
uses an interval of LEDTRIG_TTY_INTERVAL for both on and off the user 
doesn't
notice any difference except maybe a bit of delay of the blink.

If either the work schedule was larger than 2*LEDTRIG_TTY_INTERVAL or 
the on
interval would differ from the off interval the behaviour would differ
noticably.

This is why I recommend to use an invert variable that is set to true 
when
the previous state was TTY_LED_ENABLE.

Maarten

