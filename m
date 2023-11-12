Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865897E8DDD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 02:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjKLBWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 20:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLBWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 20:22:34 -0500
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309B430CF;
        Sat, 11 Nov 2023 17:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yADV1ulXB9BsULTxUaygaf07JUsdLPV9Eeilk9tnlmo=; b=SIugYXvN6tvVYT8so2Ov6RbVlY
        qT0NIYsCYiHmg2tBXYScZVjYlCToYA+8HvF+6zBkj2iAoPTEFsA6WerAKWsj1wHr4d3Hh/uklsD37
        l7Ktel8sqe6oCqX90cPliC5EQwBofqmxa2jl/U84uHIG2ZJtRPMGjM1XhuvEH7h8yPn0+KaCaKiNq
        R00bIZtskU37BjvxjQsKAo9Pp2fB+L2DXRf4PeuyNOuoVHP3wD2/dFhvb29GhgpqrDYjSXu21bGm2
        /knIvyUYqRNxNvlgvJu+zdVBSg1fjacUaezyVFMRbp7KzL8ByG+RrI+81xqre1GsA10B+NKIyUjGV
        6skWaoxA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
        (envelope-from <dg@treblig.org>)
        id 1r1zBD-008mui-2e;
        Sun, 12 Nov 2023 01:22:27 +0000
Date:   Sun, 12 Nov 2023 01:22:27 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     matoro <matoro_mailinglist_kernel@matoro.tk>,
        HelgeDeller@treblig.org, deller@gmx.de
Cc:     Sam James <sam@gentoo.org>, linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bisected stability regression in 6.6
Message-ID: <ZVAo0wbqiSC3kB3-@gallifrey>
References: <75318812c588816e0c741b4cd094524f@matoro.tk>
 <71ab4fa2-311f-4221-9f50-2f49f2f80b5c@gmx.de>
 <87edgw6kuz.fsf@gentoo.org>
 <9a84b68e9a538a66842dccc5efb8bdf8@matoro.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a84b68e9a538a66842dccc5efb8bdf8@matoro.tk>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-12-amd64 (x86_64)
X-Uptime: 01:20:00 up 57 days,  4:18,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* matoro (matoro_mailinglist_kernel@matoro.tk) wrote:
> On 2023-11-11 16:27, Sam James wrote:
> > Helge Deller <deller@gmx.de> writes:
> > 
> > > On 11/11/23 07:31, matoro wrote:
> > > > Hi Helge, I have bisected a regression in 6.6 which is causing
> > > > userspace segfaults at a significantly increased rate in kernel 6.6.
> > > > There seems to be a pathological case triggered by the ninja build
> > > > tool.  The test case I have been using is cmake with ninja backend to
> > > > attempt to build the nghttp2 package.  In 6.6, this segfaults, not at
> > > > the same location every time, but with enough reliability that I was
> > > > able to use it as a bisection regression case, including immediately
> > > > after a reboot.  In the kernel log, these show up as "trap #15: Data
> > > > TLB miss fault" messages.  Now these messages can and do show up in
> > > > 6.5 causing segfaults, but never immediately after a reboot and
> > > > infrequently enough that the system is stable.  With kernel 6.6 I am
> > > > completely unable to build nghttp2 under any circumstances.
> > > > 
> > > > I have bisected this down to the following commit:
> > > > 
> > > > $ git bisect good
> > > > 3033cd4307681c60db6d08f398a64484b36e0b0f is the first bad commit
> > > > commit 3033cd4307681c60db6d08f398a64484b36e0b0f
> > > > Author: Helge Deller <deller@gmx.de>
> > > > Date:   Sat Aug 19 00:53:28 2023 +0200
> > > > 
> > > >      parisc: Use generic mmap top-down layout and brk randomization
> > > > 
> > > >      parisc uses a top-down layout by default that exactly fits
> > > > the generic
> > > >      functions, so get rid of arch specific code and use the
> > > > generic version
> > > >      by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
> > > > 
> > > >      Note that on parisc the stack always grows up and a "unlimited stack"
> > > >      simply means that the value as defined in
> > > > CONFIG_STACK_MAX_DEFAULT_SIZE_MB
> > > >      should be used. So RLIM_INFINITY is not an indicator to use
> > > > the legacy
> > > >      memory layout.
> > > > 
> > > >      Signed-off-by: Helge Deller <deller@gmx.de>
> > > > 
> > > >   arch/parisc/Kconfig             | 17 +++++++++++++
> > > >   arch/parisc/kernel/process.c    | 14 -----------
> > > >   arch/parisc/kernel/sys_parisc.c | 54
> > > > +----------------------------------------
> > > >   mm/util.c                       |  5 +++-
> > > >   4 files changed, 22 insertions(+), 68 deletions(-)
> > > 
> > > Thanks for your report!
> > > I think it's quite unlikely that this patch introduces such a bad
> > > regression.
> > > I'd suspect some other bad commmit, but I'll try to reproduce.
> > 
> > matoro, does a revert apply cleanly? Does it help?
> 
> Yes, I just tested this and it cleanly reverts on linux-6.6.y and the revert
> does fix the issue.

Helge:
  In that patch is:

diff --git a/mm/util.c b/mm/util.c
index dd12b9531ac4c..8810206444977 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -396,7 +396,10 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
        if (current->personality & ADDR_COMPAT_LAYOUT)
                return 1;

-       if (rlim_stack->rlim_cur == RLIM_INFINITY)
+       /* On parisc the stack always grows up - so a unlimited stack should
+        * not be an indicator to use the legacy memory layout. */
+       if (rlim_stack->rlim_cur == RLIM_INFINITY &&
+               !IS_ENABLED(CONFIG_STACK_GROWSUP))
                return 1;

        return sysctl_legacy_va_layout;

is that:
   '!IS_ENABLED(CONFIG_STACK_GROWSUP))'

 the right way around?

That feels inverted to me;  non-parisc don't have that config
set, so !IS_ENABLED... is true,  so they return 1 instead of checking
the flag?

Dave

> > > 
> > > In any case, do you have CONFIG_BPF_JIT enabled? If so, could you try
> > > to reproduce with CONFIG_BPF_JIT disabled?
> > > The JIT is quite new in v6.6 and I did face some crashes and disabling
> > > it helped me so far.
> > > 
> > > > I have tried applying ad4aa06e1d92b06ed56c7240252927bd60632efe
> > > > ("parisc: Add nop instructions after TLB inserts") on top of 6.6, but
> > > > it does NOT fix the issue.
> > > 
> > > Ok.
> > > 
> > > Helge
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
