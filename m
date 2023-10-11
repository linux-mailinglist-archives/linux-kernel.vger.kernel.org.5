Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEDD7C5A92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjJKRyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjJKRye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:54:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4108F;
        Wed, 11 Oct 2023 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yQuflZknAaX5vJ1EZ6o+wAPQXDxUxCR33+Rnjm4NbOQ=; b=Lp2My/UPdj1AnaGq/FFwxrBhP9
        Tq2BaHTf2WtxrbhbuRLviKE7AFBQ+fNx7q9lhDPH6RXgN+Llcb3buwyG9IeQUVypSF5dvmYus8V4v
        iQljyxkiuLrHLuEM8KjxP/TFFjOYLiOPqaTHIG28sRNQUkAqdRroZADkiBTXd6n+bwHWPfU9swkms
        nepJEixZrMjqAmbvwmVmap5AYkqL5VaXkueujmLbboOjt8fd7uZdfyCZlXy1Pv7JSh81c5248gP8r
        7NE5OzO57loVEjqFkSoJfD4BNvEX+2cA/bH7he2TF6kU/MsiueJpmp/VzJXfk5t1g5vgpj1jr1gMh
        rpoUSnFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqdPL-00C8hH-Sz; Wed, 11 Oct 2023 17:54:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78BDA30036C; Wed, 11 Oct 2023 19:54:07 +0200 (CEST)
Date:   Wed, 11 Oct 2023 19:54:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <20231011175407.GG6307@noisy.programming.kicks-ass.net>
References: <20231009123118.4487a0e1@canb.auug.org.au>
 <20231009084812.GB14330@noisy.programming.kicks-ass.net>
 <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
 <20231009141351.GD14330@noisy.programming.kicks-ass.net>
 <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
 <66e09ad5-2dcf-4159-9c98-f37ac739a445@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e09ad5-2dcf-4159-9c98-f37ac739a445@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:21:06AM -0600, Jens Axboe wrote:
> On 10/9/23 8:16 AM, Jens Axboe wrote:
> > On 10/9/23 8:13 AM, Peter Zijlstra wrote:
> >> On Mon, Oct 09, 2023 at 11:00:19AM +0200, Arnd Bergmann wrote:
> >>> On Mon, Oct 9, 2023, at 10:48, Peter Zijlstra wrote:
> >>>> On Mon, Oct 09, 2023 at 12:31:18PM +1100, Stephen Rothwell wrote:
> >>>>> diff --cc arch/alpha/kernel/syscalls/syscall.tbl
> >>>>> index 5d05ab716a74,b1865f9bb31e..000000000000
> >>>>> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> >>>>> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> >>>>> @@@ -492,4 -492,6 +492,7 @@@
> >>>>>   560	common	set_mempolicy_home_node		sys_ni_syscall
> >>>>>   561	common	cachestat			sys_cachestat
> >>>>>   562	common	fchmodat2			sys_fchmodat2
> >>>>>  -563	common	futex_wake			sys_futex_wake
> >>>>>  -564	common	futex_wait			sys_futex_wait
> >>>>>  -565	common	futex_requeue			sys_futex_requeue
> >>>>>  +563	common	map_shadow_stack		sys_map_shadow_stack
> >>>>> ++564	common	futex_wake			sys_futex_wake
> >>>>> ++565	common	futex_wait			sys_futex_wait
> >>>>> ++566	common	futex_requeue			sys_futex_requeue
> >>>>
> >>>> So this renumbers the (futex) stuff on Alpha, does anybody care? AFAICT
> >>>> Alpha does not follow the unistd order and meh.
> >>>
> >>> Let's not make it worse for now. All the numbers since the
> >>> introduction of the time64 syscalls are offset by exactly 120
> >>> on alpha, and I'd prefer to keep it that way for the moment.
> >>>
> >>> I still hope to eventually finish the conversion of all architectures
> >>> to a single syscall.tbl for numbers >400, and if that happens before
> >>> the end of alpha, a different ordering would just be extra pain.
> >>
> >> Fair enough; should we look at rebase those futex patches for this? (bit
> >> of a pain as that would also mean rebasing block)
> > 
> > From my point of view, this isn't a huge problem if we do it now. The
> > io_uring-futex branch is a separate branch and I have nothing on top of
> > it, so I could easily just re-pull your updated branch and rebase my
> > changes on top.
> > 
> >> Or do we want to keep this fixup in the merge resolution and make sure
> >> Linus is aware?
> > 
> > If you're OK with it, I'd say let's rebase and save ourselves the
> > trouble at merge time.
> 
> Peter, what's the verdict - do you want to rebase it, or leave it as-is?

Ah, I looked into doing this, but tip/locking/core has since grown a
bunch of patches and has a merge commit -- I talked to Ingo yesterday
and he proposed just queueing a fix on top instead of doing a full
rebase.

Ingo, that still your preferred solution?
