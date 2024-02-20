Return-Path: <linux-kernel+bounces-72149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F11085B006
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251CD282C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718BC186F;
	Tue, 20 Feb 2024 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j8uvtFpw"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828415B1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708388966; cv=none; b=EuoVM2lnd0TS1vbo9SbVSRYKgAqskO/JCPD++SNw+Hul/S9SVOjD5BvKKSu9IXvpvHFwuI8yUt513ryz58bp/7OiSWBqZvLvvbIswiyiimi9ab0GzZXB9O8e0Ut+42Yh69M57l51HjPBg6xeP5e1+H6QspmfoE0mpMiMSBfOt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708388966; c=relaxed/simple;
	bh=183g6vtbcZ2b2MRFPH32KglvjXRItRCSep4zZ+9EpJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7xD/9RkvoQE1oTlZBJjTLQOhKkYCNXUDt90U4N8cY9+BtwFotv5TbwL3MbyhE/iteh/Nm6EGz+I3PCkEor/KR8o1gsIhCqN+aVB/ItKYsqIqZG7UMSuDCcpkT2SsfESV0CZCllZkMOKtU/c+K6E9DkaoHUGAyWXki76YGgf/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j8uvtFpw; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 09:29:14 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708388962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYuTBsJkK+AK+LNE5sjpfw0BQt+vbyg0B6ux0rgRMjs=;
	b=j8uvtFpwxAr72QZh5GM/HSk2IRsS1PuaeTOYAPj4KqGK3VGUKculE9G0tz2LXcMUTrcNIK
	kWh8UT4674eYs33gxDvHfs2KSw6MvoglCdl5OqtWFoOBdbt+MdhoQ/mXKuDnPfGV+bwzeL
	4ryqHETlIO2kWEwXoxnIQvgJmK1xShs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Mark Rutland <mark.rutland@arm.com>
Cc: skseofh@gmail.com, catalin.marinas@arm.com, will@kernel.org,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add early fixmap initialization flag
Message-ID: <ZdPyWkOlUan5AI9r@vm3>
References: <20240217140326.2367186-1-skseofh@gmail.com>
 <ZdMx-svsHgrfguxX@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdMx-svsHgrfguxX@FVFF77S0Q05N>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 19, 2024 at 10:48:26AM +0000, Mark Rutland wrote:
> On Sat, Feb 17, 2024 at 11:03:26PM +0900, skseofh@gmail.com wrote:
> > From: Daero Lee <skseofh@gmail.com>
> > 
> > early_fixmap_init may be called multiple times. Since there is no
> > change in the page table after early fixmap initialization, an
> > initialization flag was added.
> 
> Why is that better?
> 
> We call early_fixmap_init() in two places:
> 
> * early_fdt_map()
> * setup_arch()
> 
> ... and to get to setup_arch() we *must* have gone through early_fdt_map(),
> since __primary_switched() calls that before going to setup_arch().
> 
> So AFAICT we can remove the second call to early_fixmap_init() in setup_arch(),
> and rely on the earlier one in early_fdt_map().

Removing the second call makes the code base a bit harder to understand
as the functions related to DT and ACPI setup are not separated cleanly.
I prefer calling the early_fixmap_init() in setup_arch() as well.

Itaru.

> 
> Mark.
> 
> > 
> > Signed-off-by: Daero Lee <skseofh@gmail.com>
> > ---
> >  arch/arm64/mm/fixmap.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> > index c0a3301203bd..fbdd5f30f3a1 100644
> > --- a/arch/arm64/mm/fixmap.c
> > +++ b/arch/arm64/mm/fixmap.c
> > @@ -32,6 +32,8 @@ static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
> >  static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
> >  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
> >  
> > +static int early_fixmap_initialized __initdata;
> > +
> >  static inline pte_t *fixmap_pte(unsigned long addr)
> >  {
> >  	return &bm_pte[BM_PTE_TABLE_IDX(addr)][pte_index(addr)];
> > @@ -100,10 +102,15 @@ void __init early_fixmap_init(void)
> >  	unsigned long addr = FIXADDR_TOT_START;
> >  	unsigned long end = FIXADDR_TOP;
> >  
> > +	if (early_fixmap_initialized)
> > +		return;
> > +
> >  	pgd_t *pgdp = pgd_offset_k(addr);
> >  	p4d_t *p4dp = p4d_offset(pgdp, addr);
> >  
> >  	early_fixmap_init_pud(p4dp, addr, end);
> > +
> > +	early_fixmap_initialized = 1;
> >  }
> >  
> >  /*
> > -- 
> > 2.25.1
> > 

