Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD4E7A0DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbjINTPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbjINTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:15:51 -0400
Received: from out-213.mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD826B2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:15:47 -0700 (PDT)
Date:   Thu, 14 Sep 2023 15:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694718945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZTgCiWE0chaqwM5saw2BuBDfsLuZ1U35lfHL2wRKK8=;
        b=bFLwUJkB0zkmQGFVYoxn7V0I+LuYOiFMSNiaGXBAPlHCb8qVe/uKBQqwtUxszFnz4ORieC
        08UGXIrHUScc4zDxeTzsNu88HRT6x+zzXRrC9I26tDGerefdVSeJFvNs2T5jJLvLpqnDLu
        jxDp99iIwtWKAvhIrSgi34Myij4d35Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Sep 12 (bcachefs, objtool)
Message-ID: <20230914191541.yo6riwrmntqchmgu@moria.home.lan>
References: <20230912152645.0868a96a@canb.auug.org.au>
 <d60dac60-1e38-4a8c-98ad-a769ab1dfccd@infradead.org>
 <20230913210829.zkxv6qqlamymhatr@treble>
 <202309131758.208804F4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309131758.208804F4@keescook>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 06:01:42PM -0700, Kees Cook wrote:
> On Wed, Sep 13, 2023 at 11:08:29PM +0200, Josh Poimboeuf wrote:
> > On Tue, Sep 12, 2023 at 04:36:55PM -0700, Randy Dunlap wrote:
> > > 
> > > 
> > > On 9/11/23 22:26, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > Changes since 20230911:
> > > > 
> > > > New tree: bcachefs
> > > > 
> > > > The bcachefs tree gained a semantic conflict against Linus' tree for
> > > > which I applied a patch.
> > > > 
> > > > The wireless-next tree gaind a conflict against the wireless tree.
> > > > 
> > > > Non-merge commits (relative to Linus' tree): 4095
> > > >  1552 files changed, 346893 insertions(+), 22945 deletions(-)
> > > > 
> > > > ----------------------------------------------------------------------------
> > > 
> > > on x86_64:
> > > 
> > > vmlinux.o: warning: objtool: bch2_dev_buckets_reserved.part.0() is missing an ELF size annotation
> > 
> > Here ya go:
> > 
> > ---8<---
> > 
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > Subject: [PATCH] bcachefs: Remove undefined behavior in bch2_dev_buckets_reserved()
> > 
> > In general it's a good idea to avoid using bare unreachable() because it
> > introduces undefined behavior in compiled code.  In this case it even
> > confuses GCC into emitting an empty unused
> > bch2_dev_buckets_reserved.part.0() function.
> > 
> > Use BUG() instead, which is nice and defined.  While in theory it should
> > never trigger, if something were to go awry and the BCH_WATERMARK_NR
> > case were to actually hit, the failure mode is much more robust.
> > 
> > Fixes the following warnings:
> > 
> >   vmlinux.o: warning: objtool: bch2_bucket_alloc_trans() falls through to next function bch2_reset_alloc_cursors()
> >   vmlinux.o: warning: objtool: bch2_dev_buckets_reserved.part.0() is missing an ELF size annotation
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  fs/bcachefs/buckets.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
> > index f192809f50cf..0eff05c79c65 100644
> > --- a/fs/bcachefs/buckets.h
> > +++ b/fs/bcachefs/buckets.h
> > @@ -180,7 +180,7 @@ static inline u64 bch2_dev_buckets_reserved(struct bch_dev *ca, enum bch_waterma
> >  
> >  	switch (watermark) {
> >  	case BCH_WATERMARK_NR:
> > -		unreachable();
> > +		BUG();
> 
> Linus gets really upset about new BUG() usage (takes out the entire
> system):
> https://docs.kernel.org/process/deprecated.html#bug-and-bug-on
> 
> It'd be nicer to actually handle the impossible case. (WARN and return
> 0?)

No, I'm not going to be doing that.

These are truly impossible cases, i.e. if we were writing code in a
language with embedded correctness proofs this is something the compiler
would be checking and proving.

Changing all the BUG()s to WARNS() and writing error paths would mean
etiher a shit ton of error paths that never get tested, or deleting a
lot of a assertions, and I'm not doing either of those things.
