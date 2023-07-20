Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746C475B50F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGTQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGTQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:56:12 -0400
X-Greylist: delayed 362 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 09:56:09 PDT
Received: from smtp4.goneo.de (smtp4.goneo.de [IPv6:2001:1640:5::8:59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDAC119
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:56:09 -0700 (PDT)
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by smtp4.goneo.de (Postfix) with ESMTPS id 47BAB10A1E83;
        Thu, 20 Jul 2023 18:50:02 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by hub1.goneo.de (Postfix) with ESMTPS id B2A55105C5F8;
        Thu, 20 Jul 2023 18:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lemonage.de; s=DKIM001;
        t=1689871800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iWOmNXCe1n/AaDrwwRNqn13hsApWVf7kAvHyrB0V0vg=;
        b=O267U7dftQNtEcPGlVfA3cEXnQXDCz0DY/e9grKyujNdPLAs8Z4QDweI+9V5IZ8+lk7WoZ
        eec1lKtdMHTvyM8s75vwxonXRkNcGguOPJHYhBVFt8nbRvs5dpndoONgev9zw0nw/7L1co
        syVsee07nYS3Fqo52Bez14iQRec9MOqiqGMTpzWcmXbU4vI0byi81ZjiuhF/VDNXMZO8rb
        loydPvPZBt9RrjQOql5rw6k1hGB8A7rcarc5Dn8yt2L1tlyiB9F9YRuAzJBYwWCfSao/fY
        INEuOBisRWgfQKzwN9IvZqbRN9YrJDDje3C9plzYNIa4TRHYHaHfWcwCp5+rAA==
Received: from webmail.goneo.de (webmail.goneo.de [IPv6:2001:1640:5::2:12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hub1.goneo.de (Postfix) with ESMTPSA id 6407D105C5C4;
        Thu, 20 Jul 2023 18:49:59 +0200 (CEST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 18:49:59 +0200
From:   poeschel@lemonage.de
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Christian Meusel <christian.meusel@posteo.de>
Subject: Re: [PATCH] auxdisplay: hd44780: move cursor home after clear display
 command
In-Reply-To: <20230706154937.1380bdcf9d84e1cff78911fa@hugovil.com>
References: <20230706185100.84322-1-hugo@hugovil.com>
 <CANiq72kZ0cHxCKkm_781G__9tJxYCw3tpJarqvLOFB4Jw6ZONw@mail.gmail.com>
 <20230706154937.1380bdcf9d84e1cff78911fa@hugovil.com>
User-Agent: goneo Webmail
Message-ID: <7eb2d50baf269310e51854f700936e94@lemonage.de>
X-Sender: poeschel@lemonage.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 22c9a0
X-Rspamd-UID: cd634c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-07-06 21:49, schrieb Hugo Villeneuve:
> On Thu, 6 Jul 2023 21:33:05 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> 
>> On Thu, Jul 6, 2023 at 8:51 PM Hugo Villeneuve <hugo@hugovil.com> 
>> wrote:
>> >
>> > The "clear display" command on the NewHaven NHD-0220DZW-AG5 display
>> > does NOT change the DDRAM address to 00h (home position) like the
>> > standard Hitachi HD44780 controller. As a consequence, the starting
>> > position of the initial string LCD_INIT_TEXT is not guaranteed to be
>> > at 0,0 depending on where the cursor was before the clear display
>> > command.
>> >
>> > Extract of CLEAR_DISPLAY command from datasheets of:
>> >
>> >     Hitachi HD44780:
>> >         ... It then sets DDRAM address 0 into the address counter...
>> >
>> >     NewHaven NHD-0220DZW-AG5 datasheet:
>> >         ... This instruction does not change the DDRAM Address
>> >
>> > Move the cursor home after sending clear display command to support
>> > non-standard LCDs.
>> >
>> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>> 
>> Thanks! Sounds good to me, as long the extra command does not
>> introduce some issue with the actual HD44780 -- can we double-check
>> the HD44780 still works as expected?
>> 
>> Cc'ing Lars and Geert since they may be able to give it a quick test.
> 
> Hi Miguel,
> I do not have a standard Hitachi controller to test it on, so lets wait
> for feedback from Lars and Geert or others.

Sorry guys,
I do not have access to the relevant hardware anymore. I am CC'ing 
Christian,
who has the relevant hardware and maybe he can help testing the patch.
Christian is on vacation up until mid august, so we have to wait a bit 
more
for someone able to test this.

BTW: The displays I did the work back then on were for sure not genuine
Hitachi ones either.
I do not see, that the little patch should do any harm.

Regards,
Lars
