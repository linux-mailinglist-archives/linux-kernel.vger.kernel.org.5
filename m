Return-Path: <linux-kernel+bounces-133118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C4D899F1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229791F21D98
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B80316E897;
	Fri,  5 Apr 2024 14:10:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B861316D9CB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326249; cv=none; b=VHXCNMJC+VTftnl14KfjpWcQ6xIxIvRe66+blrjWD7dQNmfxXZkeQzvIGYHxkgeZixCez8/oF20Zc6GbfVEMxWKwTZG+PXDiW0GivfgsP5ajwltxrJVh0XvWsAh2vTHN35KvHwHSNjGhdFlT4/tiJuZaiF5/3liL0uyC3ifbZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326249; c=relaxed/simple;
	bh=4o+tiL4tTItW31ssCDv587z93PxTKL2+LphWEd/vWFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWZKDtOzEeL4iM39YoBomvK1XMFTBAhSU6yvzGNrv/fbwRp7CMTOqWlCtNCyposdDRxW7ibBn0IdLx/g22y7xaQhm+z99tZiw3hEtt7z9G6kwdwTtSYvIQpn0cabimVMIY/XabbPcqbNN3RrmWpg47uTr84rsKNe7KzBQpsklqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7941FEC;
	Fri,  5 Apr 2024 07:11:17 -0700 (PDT)
Received: from [10.57.54.111] (unknown [10.57.54.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 222D73F7B4;
	Fri,  5 Apr 2024 07:10:44 -0700 (PDT)
Message-ID: <94af4af9-8cef-4673-bce5-16bd5edb28dd@arm.com>
Date: Fri, 5 Apr 2024 15:10:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Fix double TCR_T0SZ_OFFSET shift
Content-Language: en-GB
To: Seongsu Park <sgsu.park@samsung.com>, catalin.marinas@arm.com,
 will@kernel.org, ardb@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Leem ChaeHoon <infinite.run@gamil.com>,
 Gyeonggeon Choi <gychoi@student.42seoul.kr>, Soomin Cho
 <to.soomin@gmail.com>, DaeRo Lee <skseofh@gmail.com>,
 kmasta <kmasta.study@gmail.com>
References: <CGME20240402104742epcas1p306e175348a3a7c1bdba9422ce22284f8@epcas1p3.samsung.com>
 <20240402104735.170539-1-sgsu.park@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240402104735.170539-1-sgsu.park@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-02 11:47 am, Seongsu Park wrote:
> We have already shifted the value of t0sz in TCR_T0SZ by TCR_T0SZ_OFFSET.
> So, the TCR_T0SZ_OFFSET shift here should be removed.

If the shift for assigning the t0sz value to the TCR field is wrong, 
then the other shift for comparing the same t0sz value to the existing 
TCR field must also be wrong. Really, this many people involved in 
writing a patch and still nobody spotted the obvious?

Thanks,
Robin.

> Co-developed-by: Leem ChaeHoon <infinite.run@gamil.com>
> Signed-off-by: Leem ChaeHoon <infinite.run@gamil.com>
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
>   arch/arm64/include/asm/mmu_context.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index c768d16b81a4..58de99836d2e 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -76,7 +76,7 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
>   		return;
>   
>   	tcr &= ~TCR_T0SZ_MASK;
> -	tcr |= t0sz << TCR_T0SZ_OFFSET;
> +	tcr |= t0sz;
>   	write_sysreg(tcr, tcr_el1);
>   	isb();
>   }

