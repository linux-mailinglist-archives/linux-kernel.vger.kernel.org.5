Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9ED7F9AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjK0HN2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 02:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjK0HNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:13:24 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C089D13E;
        Sun, 26 Nov 2023 23:13:28 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=1709d64187=fe@dev.tdt.de>)
        id 1r7Vnx-0045BN-4D; Mon, 27 Nov 2023 08:13:17 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1r7Vnv-00GDYD-QO; Mon, 27 Nov 2023 08:13:15 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 5FB2124004B;
        Mon, 27 Nov 2023 08:13:15 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id AE144240040;
        Mon, 27 Nov 2023 08:13:14 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id F187133D23;
        Mon, 27 Nov 2023 08:13:13 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date:   Mon, 27 Nov 2023 08:13:13 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [Patch v8 2/6] leds: ledtrig-tty: free allocated ttyname buffer
 on deactivate
In-Reply-To: <2023112356-amount-undertook-cdb2@gregkh>
References: <20231109085038.371977-1-fe@dev.tdt.de>
 <20231109085038.371977-3-fe@dev.tdt.de>
 <2023112356-amount-undertook-cdb2@gregkh>
Message-ID: <71eeb0fad7c6d2c4a407df34facee232@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8BIT
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1701069196-E2F2A49D-09E08CA6/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-23 15:06, Greg KH wrote:
> On Thu, Nov 09, 2023 at 09:50:34AM +0100, Florian Eckert wrote:
>> The ttyname buffer for the ledtrig_tty_data struct is allocated in the
>> sysfs ttyname_store() function. This buffer must be released on 
>> trigger
>> deactivation. This was missing and is thus a memory leak.
>> 
>> While we are at it, the tty handler in the ledtrig_tty_data struct 
>> should
>> also be returned in case of the trigger deactivation call.
>> 
>> Fixes: fd4a641ac88f ("leds: trigger: implement a tty trigger")
>> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>>  drivers/leds/trigger/ledtrig-tty.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/leds/trigger/ledtrig-tty.c 
>> b/drivers/leds/trigger/ledtrig-tty.c
>> index 8ae0d2d284af..3e69a7bde928 100644
>> --- a/drivers/leds/trigger/ledtrig-tty.c
>> +++ b/drivers/leds/trigger/ledtrig-tty.c
>> @@ -168,6 +168,10 @@ static void ledtrig_tty_deactivate(struct 
>> led_classdev *led_cdev)
>> 
>>  	cancel_delayed_work_sync(&trigger_data->dwork);
>> 
>> +	kfree(trigger_data->ttyname);
>> +	tty_kref_put(trigger_data->tty);
>> +	trigger_data->tty = NULL;
>> +
> 
> This should be a stand-alone patch with a proper cc: stable tag added 
> as
> well so that it can be accepted now, as it is independent of this new
> feature you are adding.

I already send this to stable@vger.kernel.org [1].
The patch already got an 'Reviewed-by:' from Uwe [2].
I hope I did everything right and it only slipped through?

I will omit the patch from the v9 patchset of 'ledtrig-tty'.
This patch set will come later today with your requested changes.

Links;
[1] 
https://lore.kernel.org/stable/20231106141205.3376954-1-fe@dev.tdt.de/
[2] 
https://lore.kernel.org/stable/20231106144914.bflq2jxejdxs6zjb@pengutronix.de/

Best regards

Florian
