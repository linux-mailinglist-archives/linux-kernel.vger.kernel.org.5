Return-Path: <linux-kernel+bounces-21010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F582886E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51A71C244DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45DB39AEE;
	Tue,  9 Jan 2024 14:46:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075AA39ACB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B048ADA7;
	Tue,  9 Jan 2024 06:47:20 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.161])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B64A3F5A1;
	Tue,  9 Jan 2024 06:46:33 -0800 (PST)
Date: Tue, 9 Jan 2024 14:46:30 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, sumit.garg@linaro.org,
	dianders@chromium.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	andre.draszik@linaro.org, willmcvicker@google.com,
	peter.griffin@linaro.org
Subject: Re: [PATCH] arm64: irq: include <linux/cpumask.h>
Message-ID: <ZZ1cRnjNlryrqAL0@FVFF77S0Q05N.cambridge.arm.com>
References: <20240109140437.3703330-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109140437.3703330-1-tudor.ambarus@linaro.org>

On Tue, Jan 09, 2024 at 02:04:37PM +0000, Tudor Ambarus wrote:
> Sorting include files in alphabetic order in
> drivers/tty/serial/samsung.c revealed the following error:
> 
> In file included from drivers/tty/serial/samsung_tty.c:24:
> ./arch/arm64/include/asm/irq.h:9:43: error: unknown type name 'cpumask_t'
>     9 | void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
>       |                                           ^~~~~~~~~
> 
> Include cpumask.h to avod unknown type errors for parents of irq.h that
> don't include cpumask.h.

s/avod/avoid/

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm64/include/asm/irq.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index 50ce8b697ff3..d5612bc770da 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -5,6 +5,7 @@
>  #ifndef __ASSEMBLER__
>  
>  #include <asm-generic/irq.h>
> +#include <linux/cpumask.h>

Minor nit: we usually have the <linux/*.h> headers first, then a line space,
then the <asm/*.h> headers, e.g.

| #include <linux/cpumask.h>
| 
| #include <asm-generic/irq.h>

With those changes, the patch itself looks good to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
>  #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

