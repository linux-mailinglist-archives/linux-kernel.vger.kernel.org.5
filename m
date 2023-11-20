Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EDB7F16AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjKTPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjKTPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:05:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA05F93
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:05:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA398C433C8;
        Mon, 20 Nov 2023 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700492721;
        bh=wkDFkqWY1q+7TNnh5FBjMJrCHmKUB6aLYQbdLpZqwSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nf37+MGouG1zQ31cVpFoLYz4Q3JdOGJ2KdrauMtMigOEAKXQY9aNLsyOo+rGpUjsf
         aLsPbrR8LlQv6etrojYjeLvn+nkaDC4vNLCxVbwc5nU9tumi4+cqHnujmWpoRGkziE
         7YgUZnmGWKlnSHTuar2CA44JXgd88+kqru1oHVOcUudm4Y5S1k/P2XxKJbEMqJOXWu
         KQ/LWrQrsZdXOEF/DyqUIxGBNgJxA1H9fkI3ZPFGdZNwhSLrCb7AcFefSTzAzd9HBC
         06Me0sJT+1oVQYAjL08izkU7iQ2QKtcGqrMNjLL/uvq9zybglyCWiF1rLJ0vhotWc1
         Kr14ETS5/dloQ==
Date:   Mon, 20 Nov 2023 15:05:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andi Shyti <andi.shyti@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PULL REQUEST] i2c-for-6.7-rc2
Message-ID: <20231120150515.GA32570@willie-the-truck>
References: <ZVf/pqw5YcF7sldg@shikoro>
 <CAHk-=wi9a9u+1cAxxHw7KxXsfPvdWCbhatK7enFSjgwjrovCZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi9a9u+1cAxxHw7KxXsfPvdWCbhatK7enFSjgwjrovCZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 09:56:59AM -0800, Linus Torvalds wrote:
> On Fri, 17 Nov 2023 at 16:05, Wolfram Sang <wsa@kernel.org> wrote:
> >
> > Jan Bottorff (1):
> >       i2c: designware: Fix corrupted memory seen in the ISR
> 
> I have pulled this, but honestly, looking at the patch, I really get
> the feeling that there's some deeper problem going on.
> 
> Either the designware driver doesn't do the right locking, or the
> relaxed IO accesses improperly are escaping the locks that do exist.
> 
> Either way, just changing "writel_relaxed()" to "writel()" seems to be wrong.
> 
> Of course, it is entirely possible that those accesses should never
> have been relaxed in the first place, and that the actual access
> ordering between two accesses in the same thread matters. For example,
> the code did
> 
>         *val = readw_relaxed(dev->base + reg) |
>                 (readw_relaxed(dev->base + reg + 2) << 16);
> 
> and if the order of those two readw's mattered, then the "relaxed" was
> always entirely wrong.
> 
> But the commit message seems to very much imply a multi-thread issue,
> and for *that* issue, doing "writel_relaxed" -> "writel" is very much
> wrong. The only thing fixing threading issues is proper locks (or
> _working_ locks).
> 
> Removing the "relaxed" may *hide* the issue, but doesn't really fix it.
> 
> For the arm64 people I brought in: this is now commit f726eaa787e9
> ("i2c: designware: Fix corrupted memory seen in the ISR") upstream.
> I've done the pull, because even if this is purely a "hide the
> problem" fix, it's better than what the code did. I'm just asking that
> people look at this a bit more.

Thanks for putting me on CC. The original issue was discussed quite a bit
over at:

https://lore.kernel.org/all/20230913232938.420423-1-janb@os.amperecomputing.com/

and I think the high-level problem was something like:

1. CPU x writes some stuff to memory (I think one example was i2c_dw_xfer()
   setting 'dev->msg_read_idx' to 0)
2. CPU x writes to an I/O register on this I2C controller which generates
   an IRQ (end of i2c_dw_xfer_init())
3. CPU y takes the IRQ
4. CPU y reads 'dev->msg_read_idx' and doesn't see the write from (1)

(i2c folks: please chime in if I got this wrong)

the issue being that the writes in (1) are not ordered before the I/O
access in (2) if the relaxed accessor is used. Rather than upgrade only
the register writes which can trigger an interrupt, the more conservative
approach of upgrading everything to non-relaxed I/O accesses was taken
(which is probably necessary to deal with spurious IRQs properly anyway
because otherwise 'dev->msg_read_idx' could be read early in step (4)).

Your point about locking is interesting. I don't see any obvious locks
being taken in i2c_dw_isr(), so I don't think the issue is because relaxed
accesses are escaping existing locks. An alternative would be putting
steps (1) and (2) in a critical section and then taking the lock again
in the interrupt handler. Or did you have something else in mind?

Will
