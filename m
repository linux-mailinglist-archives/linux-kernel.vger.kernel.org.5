Return-Path: <linux-kernel+bounces-62325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BCF851E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28341C22382
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B4C481C6;
	Mon, 12 Feb 2024 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="so9pZx2X"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A915481AD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769163; cv=none; b=AdC31GOS0XJovsJJ/f8KZmCpO9CnznoEzZNUEa01nIwaBg3rahXfXG515B4muIhQ4DWPHLGnjg+r/lduOH2M/4DCGtYEdJGj4TMnv5E9fdQ4sDqrwBonnC/7hB2lB2bhHvBDpolJls4zFt4FpFfhaqZDm7ONzCd5evBklP6oLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769163; c=relaxed/simple;
	bh=PtFTQv9o+TuEraIql2Vy9ZUzDPdFkvliaeecMICn+jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHnFcp0vijzIzyb9djuIlVA80XGaBBnoUyENvqgm4wSNVzmCqh/DEcuotNxNvA4itdbcjiBysTcFTViWOzSJp3K4LiB35SPRb4xGVsQaVxxU6M+LoMSrXw4OkdOB66PzL1LONxQ9r5JwZ0NeFikG4iDZvSe0FVO34cFVYxj6t+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=so9pZx2X; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Feb 2024 20:19:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707769158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6nYiM9R96Ih/XpIMMmFH+5yUjveGVIQsheV6FPrZ+VA=;
	b=so9pZx2XjKB64K0F7Ovv4TTtHHFnJmlCTCzvwDMbF9/PstYHS0el9ZsBz2GwYAeeCYjKEa
	Pd3RWdiTYlrIIhx5PJrCJNE1kfa2ogHN5YGtM6KjWQpil7l1FvhQGUckcZL397s8z3GJ94
	hCczhgKqMVSG9Y1umyUVP+Uw+GAFvUM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Will Deacon <will@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Ricardo Koller <ricarkol@google.com>
Subject: Re: [RFC PATCH] KVM: arm64: Fix double-free following
 kvm_pgtable_stage2_free_unlinked()
Message-ID: <Zcp9PiPCWKKn0Tkd@linux.dev>
References: <20240212193052.27765-1-will@kernel.org>
 <Zcp8LcvsZiZVkNKe@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcp8LcvsZiZVkNKe@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 12, 2024 at 08:14:41PM +0000, Oliver Upton wrote:
> On Mon, Feb 12, 2024 at 07:30:52PM +0000, Will Deacon wrote:
> > kvm_pgtable_stage2_free_unlinked() does the final put_page() on the
> > root page of the sub-tree before returning, so remove the additional
> > put_page() invocations in the callers.
> > 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Oliver Upton <oliver.upton@linux.dev>
> > Cc: Ricardo Koller <ricarkol@google.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > 
> > Hi folks,
> > 
> > Sending this as an RFC as I only spotted it from code inspection and I'm
> > surprised others aren't seeing fireworks if it's a genuine bug. I also
> > couldn't come up with a sensible Fixes tag, as all of:
> > 
> >  e7c05540c694b ("KVM: arm64: Add helper for creating unlinked stage2 subtrees")
> >  8f5a3eb7513fc ("KVM: arm64: Add kvm_pgtable_stage2_split()")
> >  f6a27d6dc51b2 ("KVM: arm64: Drop last page ref in kvm_pgtable_stage2_free_removed()")
> > 
> > are actually ok in isolation. Hrm. Please tell me I'm wrong?
> > 
> >  arch/arm64/kvm/hyp/pgtable.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index c651df904fe3..ab9d05fcf98b 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -1419,7 +1419,6 @@ kvm_pte_t *kvm_pgtable_stage2_create_unlinked(struct kvm_pgtable *pgt,
> >  				 level + 1);
> >  	if (ret) {
> >  		kvm_pgtable_stage2_free_unlinked(mm_ops, pgtable, level);
> > -		mm_ops->put_page(pgtable);
> >  		return ERR_PTR(ret);
> >  	}
> 
> AFAICT, this entire branch is effectively dead code, unless there's a
> KVM bug lurking behind the page table walk. The sub-tree isn't visible
> to other software or hardware walkers yet, so none of the PTE races
> could cause this to pop.
> 
> So while this is very obviously a bug, it might be pure luck that folks
> haven't seen smoke here. Perhaps while fixing the bug we should take the
> opportunity to promote the condition to WARN_ON_ONCE().
> 
> > @@ -1502,7 +1501,6 @@ static int stage2_split_walker(const struct kvm_pgtable_visit_ctx *ctx,
> >  
> >  	if (!stage2_try_break_pte(ctx, mmu)) {
> >  		kvm_pgtable_stage2_free_unlinked(mm_ops, childp, level);
> > -		mm_ops->put_page(childp);
> >  		return -EAGAIN;
> >  	}
> 
> This, on the other hand, seems possible. There exists a race where an
> old block PTE could have the AF set on it and the underlying cmpxchg()
> could fail.

That is to say, a race with a *HW* update to the PTE that sets AF.

> There shouldn't be a race with any software walkers, as we
> hold the MMU lock for write here.
> 
> -- 
> Thanks,
> Oliver

-- 
Thanks,
Oliver

