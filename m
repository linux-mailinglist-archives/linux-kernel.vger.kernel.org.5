Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B3803EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjLDUCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDUCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:02:24 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB28C4;
        Mon,  4 Dec 2023 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=Iudy9bNgGP1tF6Dq9Kz4Szt32tEwdS+2umgrF9xjPTQ=; b=iIggT4z2KmYa6t/offRhSz1vc6
        IA3B/3moj35Y3iLfFSdAkkhntwaMvto5vgSfAyr9U74su9LF9jlrKRCHPqdbrHjWEy+z+ci2eat+1
        pYRMjLfUg+Zt2OwBR+DsB6eIVBcm1cVZPU3kMdxOChF3Pe1jDf+W3FY0LiACl9zgkkLY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:34148 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rAF96-0001DF-RY; Mon, 04 Dec 2023 15:02:25 -0500
Date:   Mon, 4 Dec 2023 15:02:24 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jan =?ISO-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <20231204150224.add8b07a59bf737edb0b5c1c@hugovil.com>
In-Reply-To: <f6e93e9c-1c7a-424e-afe0-425b24b99e5c@sirena.org.uk>
References: <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
        <f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
        <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
        <20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
        <06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
        <20231204120151.f0afbee2ebc69e93e7977547@hugovil.com>
        <50b24985-cb30-4a75-a15d-9c165a276f1d@sirena.org.uk>
        <20231204135922.0355f030945920086d21b8b6@hugovil.com>
        <66946666-eb33-431d-9870-7046c39ffb4e@sirena.org.uk>
        <20231204144136.89fec6da9be49e3db96994e0@hugovil.com>
        <f6e93e9c-1c7a-424e-afe0-425b24b99e5c@sirena.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 19:48:05 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Dec 04, 2023 at 02:41:36PM -0500, Hugo Villeneuve wrote:
> 
> > But that is not was my question was about. Here a pseudo code
> > example to select "page" 1:
> 
> > 1. save original value of LCR register.
> > 2. write 0xBF to LCR register
> > 3. access desired register in page 1
> > 4. restore original LCR value saved in step 1
> 
> > How do you do that with regmap range?
> 
> Are you saying that the selector has other, non-selector functions?

Yes! There is no bit or bit range in that register that is used to
select a praticular set of registers or "page". It is only when
writing the special magic value of $BF that the IC switches to "page"
1. And if the value is NOT $BF, then it switches back to "page" 0.

When I told you if you could point to other IC/drivers that had the
same configuration, I tough you were aware of this. That explains some
of the confusion.

> This is truly innovative hardware,...

Well, I would not say innovative, but more "crappy" hardware design :)

> ...generally the selector is just a 
> bitfield that you write paging values to.

This is also what I am accustomed to normally.

>  You'd need to extend the core
> so that it knows about this quirk, right now that's not possible and
> we'll just leave the window pointing at whatever was last accessed.

Ok. I am not sure that adding support for it would make sense, since I
do not know of other ICs that could reuse this very specific and
particular method for switching "paged" registers.

Thank you,
Hugo Villeneuve
