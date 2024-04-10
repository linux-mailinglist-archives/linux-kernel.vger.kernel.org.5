Return-Path: <linux-kernel+bounces-138956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114AA89FC90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C272C285547
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2496179673;
	Wed, 10 Apr 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqedj5om"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6A176FB8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765543; cv=none; b=e01sv0+qQuxyZPOE+cG0F/B3dTEkiAeVG10ZDo2A8drVpoUits7YuV8OntqEbNXWOUXjNblW/N/90aqoXwYfpWJsJECqoiRm6ChZlKIe+HYCXEPzUzTT3KN0ouoIE/5ScbWjKWbQCLZVsY2eV9q63kIYXrVF1NMbRiU+V8XjSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765543; c=relaxed/simple;
	bh=c9PGCuY6rG9FxgXioiP1w/MDaTwBhRCGq7HHEAVFV74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKQFf7L7oimh6LpBrp0CBGyjo2hzT0aEJ0fZSOgJH6VH1IDtK8SJNH1I4I/lp84quNGgXuHQcrNpt4nuNeGY83sToLCFiyxSlPcE5/642nPeH7FfhcrXzwEqlIsWB0z2o+wPGPGRCQUNPSc5KQSmImiQep6P6I5VzohoklqeZRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqedj5om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF765C433F1;
	Wed, 10 Apr 2024 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712765542;
	bh=c9PGCuY6rG9FxgXioiP1w/MDaTwBhRCGq7HHEAVFV74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aqedj5omVgbmpMFYJ6Z9B7DU1WW6aZgVjXVZFlj5VzwDBu9GaLotEXRVCxogUjbsT
	 mN65c5N9KQTvC1K+HAVdEUhAHk37q3g8jq5sKtdjaz5XJT73la1fGa9Kda3jSD3rW2
	 tLsDrSnDrLS4FZ6owabRYjfzcTCVXAdCY8iB4rTrjm/tpbx4vbhxWL64y/y5UtEWIb
	 ZZ7bcninalRWKzg1a3FAk59lTE6D0XRTF1lxIaCyaK0o077M/0vAGWs1BygYqqA9/8
	 XIqYZp9idUEUujtfzFqeHXUsXCQ/ZVeYnTJ3WB9iwkXGDMJrjiKfyxDB+lOjU5N1nv
	 Q1LCdSEVKOS/g==
Date: Wed, 10 Apr 2024 17:12:17 +0100
From: Will Deacon <will@kernel.org>
To: Seongsu Park <sgsu.park@samsung.com>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Leem ChaeHoon <infinite.run@gmail.com>,
	Gyeonggeon Choi <gychoi@student.42seoul.kr>,
	Soomin Cho <to.soomin@gmail.com>, DaeRo Lee <skseofh@gmail.com>,
	kmasta <kmasta.study@gmail.com>
Subject: Re: [PATCH v3] arm64: Cleanup __cpu_set_tcr_t0sz()
Message-ID: <20240410161217.GB25225@willie-the-truck>
References: <CGME20240408024022epcas1p176f9509f6f85fd8dbfa2dd17067a8aee@epcas1p1.samsung.com>
 <20240408024016.490516-1-sgsu.park@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408024016.490516-1-sgsu.park@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 08, 2024 at 11:40:16AM +0900, Seongsu Park wrote:
> In cpu_set_default_tcr_t0sz(), it is an error to shift TCR_T0SZ_OFFSET
> twice form TCR_T0SZ() and __cpu_set_tcr_t0sz().
> Since TCR_T0SZ_OFFSET is 0, no error occurred.
> We need to clarify whether the parameter of __cpu_set_tcr_t0sz is a
> shifted value or an unshifted value.
> 
> We have already shifted the value of t0sz in TCR_T0SZ by TCR_T0SZ_OFFSET.
> This is necessary for consistency with TCR_T1SZ.
> Therefore, the parameter of __cpu_set_tcr_t0sz is clarified as a shifted
> value.

This commit message needs reworking. I would suggest something like:

  The T0SZ field of TCR_EL1 occupies bits 0-5 of the register and
  encodes the virtual address space translated by TTBR0_EL1. When
  updating the field (for example, because we are switching to/from
  the idmap page-table), __cpu_set_tcr_t0sz() erroneously treats its
  't0sz' argument as unshifted, resulting in harmless but confusing
  double shifts by 0 in the code.

  Remove the unnecessary shifts.

> Co-developed-by: Leem ChaeHoon <infinite.run@gmail.com>
> Signed-off-by: Leem ChaeHoon <infinite.run@gmail.com>
> Co-developed-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
> Signed-off-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
> Co-developed-by: Soomin Cho <to.soomin@gmail.com>
> Signed-off-by: Soomin Cho <to.soomin@gmail.com>
> Co-developed-by: DaeRo Lee <skseofh@gmail.com>
> Signed-off-by: DaeRo Lee <skseofh@gmail.com>
> Co-developed-by: kmasta <kmasta.study@gmail.com>
> Signed-off-by: kmasta <kmasta.study@gmail.com>
> Signed-off-by: Seongsu Park <sgsu.park@samsung.com>

Honestly, although it's great that you all meet up to look at the kernel,
this long list of credits is a little absurd for a trivial patch like
this. Please can you decide who did the most work and give them the
credit? Hopefully there will be future opportunities for you all to
contribute!

> ---
> 
> v2:
>  - Condition is updated
> v3:
>  - Commit message is updated
>  - cpu_set_tcr_t0sz macro is added
> 
> ---
>  arch/arm64/include/asm/mmu_context.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index c768d16b81a4..fb603ec7f61f 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -72,15 +72,16 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
>  {
>  	unsigned long tcr = read_sysreg(tcr_el1);
>  
> -	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
> +	if ((tcr & TCR_T0SZ_MASK) == t0sz)
>  		return;
>  
>  	tcr &= ~TCR_T0SZ_MASK;
> -	tcr |= t0sz << TCR_T0SZ_OFFSET;
> +	tcr |= t0sz;
>  	write_sysreg(tcr, tcr_el1);
>  	isb();
>  }
>  
> +#define cpu_set_tcr_t0sz(t0sz)		__cpu_set_tcr_t0sz(TCR_T0SZ(t0sz))
>  #define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(vabits_actual))
>  #define cpu_set_idmap_tcr_t0sz()	__cpu_set_tcr_t0sz(idmap_t0sz)
>  
> @@ -134,7 +135,7 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
>  {
>  	cpu_set_reserved_ttbr0();
>  	local_flush_tlb_all();
> -	__cpu_set_tcr_t0sz(t0sz);
> +	cpu_set_tcr_t0sz(t0sz);

Sorry, but this is wrong. Please have a look at how cpu_install_ttbr0()
is called; specifically how trans_pgd_idmap_page() sets up 't0sz'.

So I don't think you should change cpu_install_ttbr0() at all and adding
a cpu_set_tcr_t0sz() macro which calls TCR_T0SZ on the 't0sz' argument
is a mistake.

Will

