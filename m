Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0634879F377
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjIMVIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjIMVIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:08:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7461BCD;
        Wed, 13 Sep 2023 14:08:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C62C433C7;
        Wed, 13 Sep 2023 21:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694639315;
        bh=5uXQ/MUoI+OPMZgSFDNwh5ZmrI/YFQfFSeNZsw31vV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYPtSt1GiKpw2FOrIQ7WE96DeFSJk/kFuLkq2bpTcRsXREgFs9On4H4fU2FM6fvWx
         voURpXUnAtNfCyN+8T57/21FYq9UfR6beM7LUjl8m0mXyrbnquPz39dCP364HacXQV
         g+XyuMlgMiFhgIpw7qmXNk8UxLBqbqx7vR/PUho3cbI/AjgRYxK9gN6rpZxpN4q79k
         V3qzUnmiMwC8W96i9ASswBPmAIVJyic1t3MUilrCWN9WmhIjm9eDXmtaDUFi1jl01/
         /Ej7RYhdXfIUhTK7zkaZxg+0U/WjCdaS2WYpxljVK/4TbXDioeQY5GLxS10MgXzDy7
         CHQRZCQxnrRTA==
Date:   Wed, 13 Sep 2023 23:08:29 +0200
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Sep 12 (bcachefs, objtool)
Message-ID: <20230913210829.zkxv6qqlamymhatr@treble>
References: <20230912152645.0868a96a@canb.auug.org.au>
 <d60dac60-1e38-4a8c-98ad-a769ab1dfccd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d60dac60-1e38-4a8c-98ad-a769ab1dfccd@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 04:36:55PM -0700, Randy Dunlap wrote:
> 
> 
> On 9/11/23 22:26, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20230911:
> > 
> > New tree: bcachefs
> > 
> > The bcachefs tree gained a semantic conflict against Linus' tree for
> > which I applied a patch.
> > 
> > The wireless-next tree gaind a conflict against the wireless tree.
> > 
> > Non-merge commits (relative to Linus' tree): 4095
> >  1552 files changed, 346893 insertions(+), 22945 deletions(-)
> > 
> > ----------------------------------------------------------------------------
> 
> on x86_64:
> 
> vmlinux.o: warning: objtool: bch2_dev_buckets_reserved.part.0() is missing an ELF size annotation

Here ya go:

---8<---

From: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] bcachefs: Remove undefined behavior in bch2_dev_buckets_reserved()

In general it's a good idea to avoid using bare unreachable() because it
introduces undefined behavior in compiled code.  In this case it even
confuses GCC into emitting an empty unused
bch2_dev_buckets_reserved.part.0() function.

Use BUG() instead, which is nice and defined.  While in theory it should
never trigger, if something were to go awry and the BCH_WATERMARK_NR
case were to actually hit, the failure mode is much more robust.

Fixes the following warnings:

  vmlinux.o: warning: objtool: bch2_bucket_alloc_trans() falls through to next function bch2_reset_alloc_cursors()
  vmlinux.o: warning: objtool: bch2_dev_buckets_reserved.part.0() is missing an ELF size annotation

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 fs/bcachefs/buckets.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index f192809f50cf..0eff05c79c65 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -180,7 +180,7 @@ static inline u64 bch2_dev_buckets_reserved(struct bch_dev *ca, enum bch_waterma
 
 	switch (watermark) {
 	case BCH_WATERMARK_NR:
-		unreachable();
+		BUG();
 	case BCH_WATERMARK_stripe:
 		reserved += ca->mi.nbuckets >> 6;
 		fallthrough;
-- 
2.41.0

