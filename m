Return-Path: <linux-kernel+bounces-129475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68047896B55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0710F1F2A2FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE3137777;
	Wed,  3 Apr 2024 10:01:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6435313775D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138516; cv=none; b=liBoa0Thz08hax4rXPJjkoxjd0x8X2YPDwzIsUXI1mG5obxW0sASbnMZ+AC2FHZISHeDjr9BGGVsPts3525rcCPqOo1G7nzoZDHNhT9ymbLEiV5zMD1uZFGthaY9oYu6GK0vLQH51ydllwbtMXLvwUxUKlrrJSY+GyorQNPTfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138516; c=relaxed/simple;
	bh=m8OL45WGc8UgK6yb9pP1r2KBpUYXIKaBpx6utXio7m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGdKRoMLyDYtVnHkuaIevNcdEYL/Jg7G/xHCr5t2SiAsam6LBuP6lNeGBate5BgUc88S7Y7tM1p8sORMEA/Qd0ZNCw/QBmgTJS5hrDmsjPsaRnd6I77JDYwobaNONfKj24bcIjmoWHrLVGTK0W0qop09fqED8K6NrIMaCBpgLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C44C2FEC;
	Wed,  3 Apr 2024 03:02:25 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3FF53F64C;
	Wed,  3 Apr 2024 03:01:52 -0700 (PDT)
Date: Wed, 3 Apr 2024 11:01:49 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Seongsu Park <sgsu.park@samsung.com>
Cc: will@kernel.org, catalin.marinas@arm.com, ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Leem ChaeHoon <infinite.run@gmail.com>,
	Gyeonggeon Choi <gychoi@student.42seoul.kr>,
	Soomin Cho <to.soomin@gmail.com>, DaeRo Lee <skseofh@gmail.com>,
	kmasta <kmasta.study@gmail.com>
Subject: Re: [PATCH v2] arm64: Fix double TCR_T0SZ_OFFSET shift
Message-ID: <Zg0pDYADt1YnlQaj@FVFF77S0Q05N>
References: <CGME20240403024240epcas1p155cd55ca8c1dae6114b970cf3f57084e@epcas1p1.samsung.com>
 <20240403024236.193428-1-sgsu.park@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403024236.193428-1-sgsu.park@samsung.com>

On Wed, Apr 03, 2024 at 11:42:36AM +0900, Seongsu Park wrote:
> We have already shifted the value of t0sz in TCR_T0SZ by TCR_T0SZ_OFFSET.
> So, the TCR_T0SZ_OFFSET shift here should be removed.

Can we please write a better commit message?

This doesn't explain:

* Where we have already shifted the value of t0sz, nor why it makes sense to do
  that there.

* That the value of TCR_T0SZ_OFFSET is 0, and hence shifting this repeatedly is
  beningn, and this patch is a cleanup rather than a fix.

Mark.

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
> ---
> 
> Changes in v2:
> - Condition is updated
> 
> ---
>  arch/arm64/include/asm/mmu_context.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index c768d16b81a4..bd19f4c758b7 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -72,11 +72,11 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
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
> -- 
> 2.34.1
> 

