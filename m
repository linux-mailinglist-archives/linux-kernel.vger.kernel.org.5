Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EED7E1C89
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjKFIlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjKFIlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:41:08 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0A6D42;
        Mon,  6 Nov 2023 00:41:05 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=068806c1c2=fe@dev.tdt.de>)
        id 1qzvAD-00FsM4-63; Mon, 06 Nov 2023 09:40:53 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qzvAC-00DzxJ-1p; Mon, 06 Nov 2023 09:40:52 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id A66C3240049;
        Mon,  6 Nov 2023 09:40:51 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 037C4240040;
        Mon,  6 Nov 2023 09:40:51 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 8F6B02267B;
        Mon,  6 Nov 2023 09:40:50 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Nov 2023 09:40:50 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     m.brock@vanmierlo.com
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: ledtrig-tty: add new line mode evaluation
In-Reply-To: <ceec1d36f889eb82e724335d007334fd@vanmierlo.com>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-3-fe@dev.tdt.de>
 <ddf9439a092576cd18c6e025d0b61602@vanmierlo.com>
 <2951fd563fc6a364d8cddfb7ec17808b@dev.tdt.de>
 <ceec1d36f889eb82e724335d007334fd@vanmierlo.com>
Message-ID: <092914b1a78135f7dcd0bab40e7995af@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1699260052-F88EE49D-D8F789CF/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-04 14:59, m.brock@vanmierlo.com wrote:
> Florian Eckert wrote on 2023-10-30 09:15:
> 
>>> Shouldn't the led return to the line controlled steady state?
>> 
>> Sorry I do not understand your question.
>> 
>>> Set an invert variable to true if state was TTY_LED_ENABLE before it 
>>> got set
>>> to TTY_LED_BLINK
>> 
>> No matter whether the LED is on or off beforehand. I understand that 
>> the
>> LED is always on for the first half of the period and off for the rest 
>> of
>> the period. I think that is correct and I don't need to make a 
>> distinction
>> via invert here. I hope I have understood your comment correctly here.
>> 
>>> How do interval and the frequency of ledtrig_tty_work() relate?
>> 
>> The work is twice as long as of the interval. So the variable
>> LEDTRIG_TTY_INTERVAL = 50 and the work is scheduled 
>> LEDTRIG_TTY_INTERVAL * 2.
>> But that was also before my change.
> 
> This explains why you don't necessarily need to invert the blink.
> If E.g. both CTS and TX are configured I would expect to see the led 
> turn on
> once CTS actives and then blink off when something is transmitted. 
> After that
> I expect to see the led still on because CTS is still active.

The evaluation starts again with the next iteration of the work.
And if no data was transferred but CTS was set, the LED is enabled again
but does not flash.

> Now only because the work interval is 2*LEDTRIG_TTY_INTERVAL and the 
> blink
> uses an interval of LEDTRIG_TTY_INTERVAL for both on and off the user 
> doesn't
> notice any difference except maybe a bit of delay of the blink.

That is correct

> If either the work schedule was larger than 2*LEDTRIG_TTY_INTERVAL or 
> the on
> interval would differ from the off interval the behaviour would differ
> noticably.
> 
> This is why I recommend to use an invert variable that is set to true 
> when
> the previous state was TTY_LED_ENABLE.

In the next patch round, I will save the state of the LED and evaluate 
whether
I need to invert the LED if the state of the LED has been set to blink.

> Maarten

Thanks for your feedback

--
Florian
