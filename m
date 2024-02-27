Return-Path: <linux-kernel+bounces-83428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2548698F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116EF1F24AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE91420B3;
	Tue, 27 Feb 2024 14:46:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE68145FF5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045169; cv=none; b=VFEIvnR6wt/xn8tBawkwZrkyLyxJJfh3U0RKJOasl1r9z/82xM09MqC+e4ixK7KhYQLWSxN4SMejVYbAYom/HvehWOymaJcIM+szn6tD5HJowy5l3b4Bp/xnJo1gkqLWR1K0LVSkuWz6RACJm+kjYReSMW4kvwSTgbarOSVaM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045169; c=relaxed/simple;
	bh=rA2ouloplBahFw6aPm+M6eqJhkWBhN9/FNEMgW4HAUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqh1BcFwkK/XnG2Vs80v+ObmekuehaB69PM0GiH0Sbungt2tylpUc9FeO5E3eZKJ87w55GiA9EGkEj4LnrjQVSTz7eMsCAiKn52qZXtPRpI/9EqLIcp/VlB8YJUccVy6f/7p37WI2O3rZqMK6x9tZMs/FdABJ7O/nTPPXO8dwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D979DA7;
	Tue, 27 Feb 2024 06:46:45 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 828063F762;
	Tue, 27 Feb 2024 06:46:05 -0800 (PST)
Message-ID: <46b1d475-4542-4840-8685-6a3d2f9b5002@arm.com>
Date: Tue, 27 Feb 2024 14:46:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdso/datapage: Quick fix - use asm/page-def.h for ARM64
Content-Language: en-US
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Arnd Bergmann <arnd@kernel.org>, Kees Cook <keescook@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Linux Kernel Functional Testing <lkft@linaro.org>
References: <20240226175023.56679-1-anna-maria@linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20240226175023.56679-1-anna-maria@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/02/2024 17:50, Anna-Maria Behnsen wrote:
> The vdso rework for the generic union vdso_data_store broke compat VDSO on
> arm64:
> 
> In file included from arch/arm64/include/asm/lse.h:5,
> 		 from arch/arm64/include/asm/cmpxchg.h:14,
> 		 from arch/arm64/include/asm/atomic.h:16,
> 		 from include/linux/atomic.h:7,
> 		 from include/asm-generic/bitops/atomic.h:5,
> 		 from arch/arm64/include/asm/bitops.h:25,
> 		 from include/linux/bitops.h:68,
> 		 from arch/arm64/include/asm/memory.h:209,
> 		 from arch/arm64/include/asm/page.h:46,
> 		 from include/vdso/datapage.h:22,
> 		 from lib/vdso/gettimeofday.c:5,
> 		 from <command-line>:
> arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
>   298 |         u128 full;
>       |         ^~~~
> arch/arm64/include/asm/atomic_ll_sc.h:305:24: error: unknown type name 'u128'
>   305 | static __always_inline u128
> 	 \
>       |
> 
> The reason is the include of asm/page.h which in turn includes headers
> which are outside the scope of compat VDSO. The only reason for the
> asm/page.h include is the required definition of PAGE_SIZE. But as arm64
> defines PAGE_SIZE in asm/page-def.h without extra header includes, this
> could be used instead.
> 
> Caution: this is a quick fix only! The final fix is an upcoming cleanup of
> Arnd which consolidates PAGE_SIZE definition. After the cleanup, the
> include of asm/page.h to access PAGE_SIZE is no longer required.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Fixes: a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store available for all architectures")
> Link: https://lore.kernel.org/lkml/CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com/
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> 
> Patch applies on tip/timers/core and was tested with clang-14

Waiting for Arnd's fix:

Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>


