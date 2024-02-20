Return-Path: <linux-kernel+bounces-73194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1B485BF19
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9026D1F250AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8846D1AA;
	Tue, 20 Feb 2024 14:48:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEF36BB38
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440520; cv=none; b=Xk216TnlzeS0yeJBpKiHyuKN2cdDUXUt6M0VqUSH0qqDlp8XagAfM1j3/FrCWCRIfImYEwJsDjkjbioThuZLRBOxbO+g0UFtg6LenG7Du5rcWDgj0aZTwuD7wC7spbCz5MXJDH9PcJOpvc14J8FdLaI7zUJVu/1yu05JS/L9mkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440520; c=relaxed/simple;
	bh=XN9YZw6gqiGlmKU+T7UoDdupQ3CvU5WcIwPaA9Hk8Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlE6IbGkhGf+MNd8loh79CdfKX+ph3K86znZVpQWFZgaWdPeoeFVVecm9W3stTd81fRTwo8Zub1cUAQFGWrrXT14+WJBvbcIlSdODkGY5kYJJb50AhOeXB6k1H04Fa3ZZQGD9/uTJZ48/dEAesi/egNIDrayhIwJZz/j1a7Jz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E896FEC;
	Tue, 20 Feb 2024 06:49:15 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD30B3F73F;
	Tue, 20 Feb 2024 06:48:35 -0800 (PST)
Message-ID: <a32f4a4a-b2ce-4c34-aa8b-1954189436c9@arm.com>
Date: Tue, 20 Feb 2024 14:48:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] vdso: Misc cleanups and prevent code duplication
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20240219153939.75719-1-anna-maria@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/02/2024 15:39, Anna-Maria Behnsen wrote:
> Hi,
> 
> the vdso related cleanup queue contains two parts:
> 
> - Patch 1-3: Misc cleanups related to a comment, a superfluous header
> 	     include and ifdeffery
> 
> - Patch 4-10: The union vdso_data_store is defined in seven
>   	      architectures. Make this union available in a generic vdso
>   	      header file to prevent code duplication and fix the
>   	      architectures one by one to use the generic vdso_data_store.
> 
> Thanks,
> 
> 	Anna-Maria
> 
> 

Really good cleanup. Thank you for this.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Anna-Maria Behnsen (10):
>   vdso/helpers: Fix grammar in comments
>   s390/vdso/data: Drop unnecessary header include
>   csky/vdso: Remove superfluous ifdeffery
>   vdso/arm: make union vdso_data_store available for all
>   arm64/vdso: Use generic union vdso_data_store
>   riscv/vdso: Use generic union vdso_data_store
>   s390/vdso: Use generic union vdso_data_store
>   loongarch/vdso: Use generic union vdso_data_store
>   mips/vdso: Use generic union vdso_data_store
>   csky/vdso: Use generic union vdso_data_store
> 
>  arch/arm/include/asm/elf.h           |  1 -
>  arch/arm/include/asm/vdso_datapage.h | 26 --------------------------
>  arch/arm/kernel/asm-offsets.c        |  4 +++-
>  arch/arm/kernel/vdso.c               |  4 ----
>  arch/arm64/kernel/vdso.c             |  5 +----
>  arch/csky/include/asm/vdso.h         |  5 -----
>  arch/csky/kernel/vdso.c              | 14 ++------------
>  arch/loongarch/kernel/vdso.c         |  6 ++----
>  arch/mips/include/asm/vdso.h         |  5 -----
>  arch/mips/kernel/vdso.c              |  2 +-
>  arch/riscv/kernel/vdso.c             |  8 +-------
>  arch/s390/include/asm/vdso/data.h    |  1 -
>  arch/s390/kernel/vdso.c              |  5 +----
>  include/vdso/datapage.h              | 10 ++++++++++
>  include/vdso/helpers.h               |  8 ++++----
>  15 files changed, 25 insertions(+), 79 deletions(-)
>  delete mode 100644 arch/arm/include/asm/vdso_datapage.h
> 

-- 
Regards,
Vincenzo

