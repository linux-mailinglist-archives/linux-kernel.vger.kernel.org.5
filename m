Return-Path: <linux-kernel+bounces-63488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7851853047
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C4A28B5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9E742070;
	Tue, 13 Feb 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLdx5kyF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F53FE2E;
	Tue, 13 Feb 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826327; cv=none; b=MB5UAAOYJFMxht1vMT0BX/f1fKIWM44KgsJA8MRkUQu6XKJODsrP1Q92NUKHR6o/TLoHnRXfaNVHdJc8zyQJvhJNzNh+L2OREWv77qK6HcvbjwFin+7MscCylswe4jzDHLVVqHMzWhcFeGJSQ/fHu8LIsJwEmwciousdZucTAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826327; c=relaxed/simple;
	bh=ib6PZ8xXRpfgU5jIgXHVcqSo6CO9mgmFcvdOj5YPt6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1F2cDUptuSAx7RNnRX857VXbkWYqGrUgq6+cbv7U1Wgfi56LrJVmaZ8BfWwRM200vF7dQy/bvnSwKC5P8bgXlHeO8km8UGqCEAWf9NK8uVvPziIbwf0G8bv5IC1Ve90/1zm+zKnOE4HX+/h3ON7XlIwQCWQIYoCJfIHbXkYJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLdx5kyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0FDC43390;
	Tue, 13 Feb 2024 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707826326;
	bh=ib6PZ8xXRpfgU5jIgXHVcqSo6CO9mgmFcvdOj5YPt6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLdx5kyFQjxOp5IYua7o7cVsJmsJy2pBEm3Yy7q2STJO4bSvzi7zwLSe5tzY8sIa7
	 uZmcgQrvfFs6LT+qVv7aKjSDO3j45v7i6IRtRta/LiSFQfkYGHZWpTBgUdOToX/GVp
	 y0z5d9wIQAEsjkxVZKagE/t5lap6MwcngGWPt29IafqIQH3DAZfC+WumxJRLqM6fKr
	 nFZDvcIJQEJbEB3idooxRE2/u1w0YV513qPeqwnnUKJJe8enga9EaLfd5EGKrYwFgc
	 vTIQPSsNLJ53oNstXGzX8ZymOi0KYRNflmALGumljUjorSn0IXqw5YoKOzA9Iv/lYA
	 ZKXiy/ZJG2C8Q==
Date: Tue, 13 Feb 2024 12:12:01 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ricardo Koller <ricarkol@google.com>
Subject: Re: [RFC PATCH] KVM: arm64: Fix double-free following
 kvm_pgtable_stage2_free_unlinked()
Message-ID: <20240213121201.GA28682@willie-the-truck>
References: <20240212193052.27765-1-will@kernel.org>
 <Zcp8LcvsZiZVkNKe@linux.dev>
 <86cyt062jh.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cyt062jh.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 13, 2024 at 11:12:34AM +0000, Marc Zyngier wrote:
> On Mon, 12 Feb 2024 20:14:37 +0000,
> Oliver Upton <oliver.upton@linux.dev> wrote:
> > On Mon, Feb 12, 2024 at 07:30:52PM +0000, Will Deacon wrote:
> > > Sending this as an RFC as I only spotted it from code inspection and I'm
> > > surprised others aren't seeing fireworks if it's a genuine bug. I also
> > > couldn't come up with a sensible Fixes tag, as all of:
> > > 
> > >  e7c05540c694b ("KVM: arm64: Add helper for creating unlinked stage2 subtrees")
> > >  8f5a3eb7513fc ("KVM: arm64: Add kvm_pgtable_stage2_split()")
> > >  f6a27d6dc51b2 ("KVM: arm64: Drop last page ref in kvm_pgtable_stage2_free_removed()")
> 
> I'd blame it on the last commit, as we really ought to have it if we
> have the others.

Yes, that's probably the best approach if you're adding a Fixes tag.

> > > @@ -1502,7 +1501,6 @@ static int stage2_split_walker(const struct kvm_pgtable_visit_ctx *ctx,
> > >  
> > >  	if (!stage2_try_break_pte(ctx, mmu)) {
> > >  		kvm_pgtable_stage2_free_unlinked(mm_ops, childp, level);
> > > -		mm_ops->put_page(childp);
> > >  		return -EAGAIN;
> > >  	}
> > 
> > This, on the other hand, seems possible. There exists a race where an
> > old block PTE could have the AF set on it and the underlying cmpxchg()
> > could fail. There shouldn't be a race with any software walkers, as we
> > hold the MMU lock for write here.
> 
> AF update is indeed a likely candidate.
> 
> In any case, this patch looks good to me as it is, and we can always
> have a separate tweak to adjust the severity of the first case as
> required. Unless anyone objects, I'd like to queue it shortly.

Fine by me! Even though I found it by inspection, I have taken the patch
for a spin to check that I (somehow) didn't break something else.

Will

