Return-Path: <linux-kernel+bounces-128391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC4895A35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2511F21870
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A366515A48D;
	Tue,  2 Apr 2024 16:48:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7215A482;
	Tue,  2 Apr 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076536; cv=none; b=YQMm4ZsLccOgmEfzNOW9bd7ENJ8gr5kCg2bR7P2gqKnooJm2RRRbeLk+Mz4bhDbEQuWJtMAEoUKdqmsc2q8obf97iDGx4UEqPsIn+xXBT9mb+femz2mnTNpnOzeUPZi5kbTAHB/UWjCvngbyj2pFmLPeJuLmX+6ljNmzH4AAUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076536; c=relaxed/simple;
	bh=H4NbtFoqyo/GMJxvalTUhJ8tEsp+AaFSnlTfV6/ANRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNkEQnozOAE4tEg3IxMDfQplkeQyCmdb6aCGnQUELQ0zhqtZ4HLGU5BPjzepBvyGFYA/dvJiDISVUFqqqgHoF952RjCIhNt+0bhXEdlbHE8+1+q7uJP7B5ey02CEQNyZ6CXs9p7+S+cENK1WHyNE/nY5uayh4kHgjoCm93Babl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DDD51007;
	Tue,  2 Apr 2024 09:49:25 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A0AE3F7B4;
	Tue,  2 Apr 2024 09:48:52 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:48:46 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Haris Okanovic <harisokn@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-assembly@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 2/3] arm64: add __READ_ONCE_EX()
Message-ID: <Zgw27hoEwKxAkyjh@FVFF77S0Q05N>
References: <20240402014706.3969151-1-harisokn@amazon.com>
 <20240402014706.3969151-2-harisokn@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402014706.3969151-2-harisokn@amazon.com>

On Mon, Apr 01, 2024 at 08:47:05PM -0500, Haris Okanovic wrote:
> Perform an exclusive load, which atomically loads a word and arms the
> execusive monitor to enable wfe() polling of an address.
> 
> Adding this macro in preparation for an arm64 cpuidle driver which
> supports a wfe() based polling state.
> 
> https://developer.arm.com/documentation/dht0008/a/arm-synchronization-primitives/exclusive-accesses/exclusive-monitors
> 
> Signed-off-by: Haris Okanovic <harisokn@amazon.com>
> ---
>  arch/arm64/include/asm/readex.h | 46 +++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 arch/arm64/include/asm/readex.h
> 
> diff --git a/arch/arm64/include/asm/readex.h b/arch/arm64/include/asm/readex.h
> new file mode 100644
> index 000000000000..51963c3107e1
> --- /dev/null
> +++ b/arch/arm64/include/asm/readex.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Based on arch/arm64/include/asm/rwonce.h
> + *
> + * Copyright (C) 2020 Google LLC.
> + * Copyright (C) 2024 Amazon.com, Inc. or its affiliates.
> + */
> +
> +#ifndef __ASM_READEX_H
> +#define __ASM_READEX_H
> +
> +#define __LOAD_EX(sfx, regs...) "ldaxr" #sfx "\t" #regs
> +
> +#define __READ_ONCE_EX(x)						\
> +({									\
> +	typeof(&(x)) __x = &(x);					\
> +	int atomic = 1;							\
> +	union { __unqual_scalar_typeof(*__x) __val; char __c[1]; } __u;	\
> +	switch (sizeof(x)) {						\
> +	case 1:								\
> +		asm volatile(__LOAD_EX(b, %w0, %1)			\
> +			: "=r" (*(__u8 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	case 2:								\
> +		asm volatile(__LOAD_EX(h, %w0, %1)			\
> +			: "=r" (*(__u16 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	case 4:								\
> +		asm volatile(__LOAD_EX(, %w0, %1)			\
> +			: "=r" (*(__u32 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	case 8:								\
> +		asm volatile(__LOAD_EX(, %0, %1)			\
> +			: "=r" (*(__u64 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	default:							\
> +		atomic = 0;						\
> +	}								\
> +	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
> +})

Why can't you use the existing smp_cond_load_relaxed() or
smp_cond_load_acquire()?

I don't believe this is necessary.

Mark.

