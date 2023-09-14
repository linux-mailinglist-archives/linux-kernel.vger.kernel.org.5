Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948887A0672
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbjINNvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbjINNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:51:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66461BE3;
        Thu, 14 Sep 2023 06:51:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0533C433C7;
        Thu, 14 Sep 2023 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694699509;
        bh=hMh7eQopqrtQZLsj75qHwGwk96M3LrHj3/pLM+3yCto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSMnqBWNIGvXAmtdsuQZYI+7yZYvTNV//weL23ZrRgBOiOazVE+4nkZ7h/wj8P1t3
         sbbSVmK4oHzDxvBCPNwEyh0ubGnxWINbTa9rACgoVHp3Z+9rKKZvcmFMXuewTyRWCR
         lhRxPCHvNy/EGC/dj08TyHIs7cQJxLVpfsFbXRJnuxyjA1wMauYFFE0JzKVjew77bA
         ntnSxefW4fYC8jZFTJYrbwT61KZ4R1smXLkhF4DscH/K1VpWP13h1xZeVARF5td7jJ
         eBwC31IT8mp1fwmuRpn+VXqCBtc30VNt2Imb5j94W1KsJvqDqkRLVwC6UoTJ0qokVy
         lKBmzY9tht2Ug==
Date:   Thu, 14 Sep 2023 15:51:44 +0200
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Sep 12 (bcachefs, objtool)
Message-ID: <20230914135144.udwf3lmhh5zael5e@treble>
References: <20230912152645.0868a96a@canb.auug.org.au>
 <d60dac60-1e38-4a8c-98ad-a769ab1dfccd@infradead.org>
 <20230913210829.zkxv6qqlamymhatr@treble>
 <202309131758.208804F4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202309131758.208804F4@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 06:01:42PM -0700, Kees Cook wrote:
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

Sure, see below.

BTW, I'm about to go off grid for 1.5 weeks, so there will be no v3
coming from me anytime soon :-)

---8<---

From: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v2] bcachefs: Remove undefined behavior in bch2_dev_buckets_reserved()

In general it's a good idea to avoid using bare unreachable() because it
introduces undefined behavior in compiled code.  In this case it even
confuses GCC into emitting an empty unused
bch2_dev_buckets_reserved.part.0() function.

Use WARN_ON(1) instead, which is nice and defined.  While in theory it
should never trigger, if something were to go awry and the
BCH_WATERMARK_NR case were to actually hit, the failure mode is more
robust.

Fixes the following warnings:

  vmlinux.o: warning: objtool: bch2_bucket_alloc_trans() falls through to next function bch2_reset_alloc_cursors()
  vmlinux.o: warning: objtool: bch2_dev_buckets_reserved.part.0() is missing an ELF size annotation

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 fs/bcachefs/buckets.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index f192809f50cf..211f054bf83d 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -180,7 +180,8 @@ static inline u64 bch2_dev_buckets_reserved(struct bch_dev *ca, enum bch_waterma
 
 	switch (watermark) {
 	case BCH_WATERMARK_NR:
-		unreachable();
+		WARN_ON(1);
+		break;
 	case BCH_WATERMARK_stripe:
 		reserved += ca->mi.nbuckets >> 6;
 		fallthrough;
-- 
2.41.0

