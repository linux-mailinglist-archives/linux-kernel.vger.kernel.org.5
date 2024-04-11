Return-Path: <linux-kernel+bounces-140275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BD8A1187
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0461C23C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613C7146A8D;
	Thu, 11 Apr 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOEcasxU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CD86BB29
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832305; cv=none; b=o2gNhf3KpMWs6bJphTewsZt2noGzuFnBq+WDo6sqRCbdBmxRoGLKo/m2F1xTovc31/98xWkKqkltD/9G/R/ThhVrVf5pzD5TW934VTcR4HBK/5dkOb/ndkWHE31eqi5eDSBF2QHsWQQoVKXx8NAZPJmWGDmXmcv0YIo7kQXC72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832305; c=relaxed/simple;
	bh=zOZhCyofInF5tJbvL/B8olmi0NZALP0fLW9K93F807s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+X5zPc+I4+CIFN/dE9M9w50U85Y4ad+9Q5sw5+xFCVH3CYAY4hDS2iXq3eD9zf8bt9bzS1LLAr7GVVS4frqRSFI8JvSC/gdfpyMFZjOllQnqGXJD3Ruykc71/rcsQexKhv2PwFHVYpuV/97v8KWS7uOZ2PP29xMIdgQgofgGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOEcasxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86122C433C7;
	Thu, 11 Apr 2024 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712832305;
	bh=zOZhCyofInF5tJbvL/B8olmi0NZALP0fLW9K93F807s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOEcasxUTg6Pr2luRZ2/mV3+jf37n8Rpxs4riV2P4Iy5kIE25//PUqixha9xn+1vj
	 usPjbZ3z3J69PWNXoY2BOVEaGUR3mO82gtprhkca/cUMZAO7TVyXZ50C1wxWy9jBa4
	 gy3LelbrSGfCWu+pGsY3KmGX2cashZxalVApJHIwLGl3EY1rAhCQNRwsi6W0+nF2s9
	 P0zwq+0MKxP4EeHRdqvEfXVhZTOEAmrpsjAV3RPzsRpq7nfbauI13M8JQxGWnVAKuJ
	 /eG4EBxk2Gw6tU0Tde8hG7lymliNPFVhZPzPoEL4Wa0r3pzsLX1iuBBcux5uUJm3T2
	 9pQk3HWSM7nHA==
Date: Thu, 11 Apr 2024 11:44:58 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Gavin Shan <gshan@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com, akpm@linux-foundation.org,
	oliver.upton@linux.dev, apopple@nvidia.com, rananta@google.com,
	mark.rutland@arm.com, v-songbaohua@oppo.com,
	yangyicong@hisilicon.com, shahuang@redhat.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH v3 3/3] arm64: tlb: Allow range operation for
 MAX_TLBI_RANGE_PAGES
Message-ID: <20240411104458.GA26265@willie-the-truck>
References: <20240405035852.1532010-1-gshan@redhat.com>
 <20240405035852.1532010-4-gshan@redhat.com>
 <27718d41-32cb-4976-b50e-e9237da7aedf@arm.com>
 <86v84psisz.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86v84psisz.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 10, 2024 at 09:50:20AM +0100, Marc Zyngier wrote:
> On Mon, 08 Apr 2024 09:43:44 +0100,
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> > 
> > On 05/04/2024 04:58, Gavin Shan wrote:
> > > MAX_TLBI_RANGE_PAGES pages is covered by SCALE#3 and NUM#31 and it's
> > > supported now. Allow TLBI RANGE operation when the number of pages is
> > > equal to MAX_TLBI_RANGE_PAGES in __flush_tlb_range_nosync().
> > > 
> > > Suggested-by: Marc Zyngier <maz@kernel.org>
> > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > 
> > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > 
> > > ---
> > >  arch/arm64/include/asm/tlbflush.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> > > index 243d71f7bc1f..95fbc8c05607 100644
> > > --- a/arch/arm64/include/asm/tlbflush.h
> > > +++ b/arch/arm64/include/asm/tlbflush.h
> > > @@ -446,11 +446,11 @@ static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
> > >  	 * When not uses TLB range ops, we can handle up to
> > >  	 * (MAX_DVM_OPS - 1) pages;
> > >  	 * When uses TLB range ops, we can handle up to
> > > -	 * (MAX_TLBI_RANGE_PAGES - 1) pages.
> > > +	 * MAX_TLBI_RANGE_PAGES pages.
> > >  	 */
> > >  	if ((!system_supports_tlb_range() &&
> > >  	     (end - start) >= (MAX_DVM_OPS * stride)) ||
> > > -	    pages >= MAX_TLBI_RANGE_PAGES) {
> > > +	    pages > MAX_TLBI_RANGE_PAGES) {
> > 
> > As a further enhancement, I wonder if it might be better to test:
> > 
> > 	pages * 4 / MAX_TLBI_RANGE_PAGES > MAX_DVM_OPS
> > 
> > Then add an extra loop over __flush_tlb_range_op(), like KVM does.
> > 
> > The math is trying to express that there are a maximum of 4 tlbi range
> > instructions for MAX_TLBI_RANGE_PAGES pages (1 per scale) and we only need to
> > fall back to flushing the whole mm if it could generate more than MAX_DVM_OPS ops.
> 
> That'd be a good enhancement indeed, although I wonder if that occurs
> as often as we see it on the KVM side. But in any case, adding
> consistency amongst the users of __flush_tlb_range_op() can only be
> beneficial.

I'll pick patches 2 & 3 up for 6.10, but feel free to send stuff on top
if you want to tweak this.

Will

