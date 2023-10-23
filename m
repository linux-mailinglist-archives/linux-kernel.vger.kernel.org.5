Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F07D37A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjJWNTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjJWNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:19:16 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1DDE5;
        Mon, 23 Oct 2023 06:19:14 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9674b5d38b=fe@dev.tdt.de>)
        id 1quupl-001Btl-JW; Mon, 23 Oct 2023 15:19:05 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1quupk-0000u5-LJ; Mon, 23 Oct 2023 15:19:04 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 3D494240049;
        Mon, 23 Oct 2023 15:19:04 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 9128B240040;
        Mon, 23 Oct 2023 15:19:03 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 30A0F2112C;
        Mon, 23 Oct 2023 15:19:03 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Oct 2023 15:19:03 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: ledtrig-tty: add new line mode evaluation
In-Reply-To: <2023102333-skewer-reclining-8d04@gregkh>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-3-fe@dev.tdt.de>
 <2023102341-jogger-matching-dded@gregkh>
 <7e8860574413505c314bdfd0f3e10188@dev.tdt.de>
 <2023102320-princess-issuing-be13@gregkh>
 <c4398f09d5a07672ad77f2100ccae0f4@dev.tdt.de>
 <2023102333-skewer-reclining-8d04@gregkh>
Message-ID: <f5825b317d4f6ca3a5c3a27c46f3c30e@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1698067145-D2E9A639-B61EDC45/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-23 14:59, Greg KH wrote:
> On Mon, Oct 23, 2023 at 02:45:55PM +0200, Florian Eckert wrote:
>> 
>> 
>> On 2023-10-23 14:27, Greg KH wrote:
>> > On Mon, Oct 23, 2023 at 02:15:55PM +0200, Florian Eckert wrote:
>> > > > Again, I thought we had rx/tx already?  If not, how was that controlled
>> > > > today?
>> > >
>> > > It could not be controlled! The LED flashed when data where
>> > > transferred.
>> > > This was the only function that the trigger supported.
>> >
>> > Ok, then maybe this needs to be a bit longer of a series.  One that does
>> > the "tx/rx" feature, as that is needed today, and will be the more
>> > complex one, and then one-per-line-setting that you want to apply.
>> >
>> > That should make it much easier to review overall, right?
>> 
>> Sorry for asking, but why should I split the change.
>> What is the added value? But if it is necessary, then I will do it.
>> 
>> Before my change, the trigger could not be configured.
>> The LED always flashed when data was transferred.
> 
> But you could configure that, right?  on/off, correct?

No, this could not be configured before. It always flashed as
soon as data went through the configured tty. It couldn't even
be switched off, only if I change the tty interface via sysfs

>> So that the trigger behaves the same as before (flash on rx/tx
>> transmission),
>> I set the rx/tx bits in the function ledtrig_tty_activate() with the
>> following code. Nothing changes for the user of the trigger.
>> 
>> /* Enable default rx/tx LED blink */
>> set_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger);
>> set_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger);
> 
> I agree, but now you are splitting this up into a much finer grained
> feature.
> 
> Anyway, just a thought, I'll defer to the LED maintainers here as to 
> how
> they want to see this, I thought it would actually be easier this way,
> maybe not, your call.

Thank you for your review. I will incorporate your comments and split 
the changes.
:+1:

---
Florian
