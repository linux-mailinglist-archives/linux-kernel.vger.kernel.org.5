Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337867D2299
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjJVKZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjJVKZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:25:01 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2E0D61
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:24:58 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9673dbd9fc=fe@dev.tdt.de>)
        id 1quVdX-004cA4-GA; Sun, 22 Oct 2023 12:24:47 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1quVdW-008ki4-MM; Sun, 22 Oct 2023 12:24:46 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 515A2240049;
        Sun, 22 Oct 2023 12:24:46 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id A5935240040;
        Sun, 22 Oct 2023 12:24:45 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 6BC85213BE;
        Sun, 22 Oct 2023 12:24:45 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 22 Oct 2023 12:24:45 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        ansuelsmth@gmail.com, m.brock@vanmierlo.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 2/3] tty: add new helper function tty_get_tiocm
In-Reply-To: <2023102115-stock-scrambled-f7d5@gregkh>
References: <20231019112809.881730-1-fe@dev.tdt.de>
 <20231019112809.881730-3-fe@dev.tdt.de>
 <2023102115-stock-scrambled-f7d5@gregkh>
Message-ID: <2935341a3c8d98299b1619efc8d73cad@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1697970287-D369D639-371F78F9/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-10-21 18:15, Greg KH wrote:
> On Thu, Oct 19, 2023 at 01:28:08PM +0200, Florian Eckert wrote:
>> The struct 'tty_struct' has a callback to read the status flags of the 
>> tty
>> if the tty driver provides them. So fare, the data is transferred 
>> directly
>> to userspace with the function 'tty_tiocmget'. This function cannot be
>> used to evaluate the status line of the tty interface in the 
>> ledtrig-tty
>> trigger. To make this possible, a new function must be added that does
>> not immediately pass the data on to userspace.
>> 
>> The new function 'tty_get_tiocm' only returns the status register.
>> This information can then be processed further in the ledtrig-tty
>> trigger.
> 
> Writing changelogs are hard.  You are including a lot of information in
> here that really doesn't need to be, as you are focusing on your
> specific use case, which is fine, but you are creating a generic
> function.

Yes, that is absolutely right. I'll try to take that into account next
time, thanks for your advice.

> This can be simpler, how about something like this:
> 
> 	There is no in-kernel function to get the status register of a
> 	tty device like the TIOCMGET ioctl returns to userspace.  Create
> 	a new function, tty_get_tiocm(), to obtain the status register
> 	that other portions of the kernel can call if they need this
> 	information, and move the existing internal tty_tiocmget()
> 	function to use this interface.

I will replace the commit message with your suggestion in the next round 
of
the patch series. Thanks!

---
Florian
