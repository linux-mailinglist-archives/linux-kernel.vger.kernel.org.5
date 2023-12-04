Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2789F803A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344793AbjLDQ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344769AbjLDQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:29:14 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519195;
        Mon,  4 Dec 2023 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=wGtsBteNQqaSCK4EDE+x10UvfaU6Z2WzVNRFRs3sZQ0=; b=jR6Vi1byfKj4eEfDp2We+QPSLh
        UFAyOexoNSlfHvl0g0BPwhYUERxVte5s/JZGzRqs5Vch4quYzPZRqQ5fiQ/SUuEMst8NAkjk1Lsj8
        KYMl1CxgPiOchAoGzXFHbDIHKrAWUrWMcuXYDh2+nY0qsEP4DQ45u6DwwUu9vFPycUoE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:32824 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rABog-0008Ca-4H; Mon, 04 Dec 2023 11:29:06 -0500
Date:   Mon, 4 Dec 2023 11:29:05 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jan =?ISO-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
In-Reply-To: <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
        <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
        <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
        <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
        <f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
        <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
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

On Fri, 1 Dec 2023 17:16:44 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> On Fri, 1 Dec 2023 21:41:48 +0000
> Mark Brown <broonie@kernel.org> wrote:
> 
> > On Fri, Dec 01, 2023 at 04:38:46PM -0500, Hugo Villeneuve wrote:
> > > Mark Brown <broonie@kernel.org> wrote:
> > 
> > > > If you're working on that driver it'd also be good to update the current
> > > > use of cache bypass for the enhanced features/interrupt identification
> > > > register (and anything else in there, that did seem to be the only one)
> > > > to use regmap ranges instead - that'd remove the need for the efr_lock
> > > > and be a much more sensible/idiomatic use of the regmap APIs.
> > 
> > > I will also look to remove the efr_lock, altough it has more
> > > implications since this ship has some registers that share a common
> > > address, and selected by bits in other registers, and I think this
> > > is why there is this efr_lock.
> > 
> > Right, the registers sharing a common address with the register selected
> > by bits in another register is what regmap ranges support - the less
> > creative use of this is banked blocks of registers with a selector
> > register which picks which page bank is in use, that's moderately common
> > especially for TI.
> 
> Hi Mark,
> thanks for the info, I was not aware of that, and will look into it.
> 
> Hugo Villeneuve.

Hi Mark,
I am having a hard time finding documentation on how regmap ranges
work.

Do you have an example of a driver which is using regmap ranges like it
should be done in this driver, that is using the exact same address for
two or more registers? I found an example, but it doesn't seem
applicable to the sc16is7xx driver because the two registers do not
share a common address, for example they have addresses like 0x01 and
0x81, even though with the proper page selection, they finally map to
address 0x01.

Thank you,
Hugo Villeneuve
