Return-Path: <linux-kernel+bounces-83251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217298690D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8FC1F27B93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F4D139594;
	Tue, 27 Feb 2024 12:44:59 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596B1CFA9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037898; cv=none; b=W6IPinhGka6vvCUcvdpaZ3WgLUk6/LEdGDVC4iaV3H9okMY7Rb74EErCtZ3lrhFBcyyyY0mhS2LlPdtlIh3cO8XHz704AC4YhFZY4ta6P6L8xZpgcSsV5+BVDiiulcUMfkSvorqZLQwB4I3fiNUMURqHsfKzSI1hfJJWF3fq94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037898; c=relaxed/simple;
	bh=I7/ZaEcRs6BiBx2UPCfsMsU+coYB7Zf1ZECjZKENGFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XJsmHFgklSwuO/uV0ut38kISBNotMQ7pji+rgKF/Cvp/yVhkuAgbuuFcILQSfUgdu6xbjRXz3LhAojW8ep8MHp7HUdiHfqnsMqzBBG7//Lvx7LFey1bIYoEFWzsxq+Zg0lLGlX7kTPqaudw4LmS8wmvflABeqfNXNueD1hr1Ulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E3490240007;
	Tue, 27 Feb 2024 12:44:50 +0000 (UTC)
Message-ID: <20db97b7-6225-42a4-9f2a-b926aa26b7aa@ghiti.fr>
Date: Tue, 27 Feb 2024 13:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix definition of _PAGE_NOCACHE_THEAD
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, guoren@kernel.org, jszhang@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240227124412.2565716-1-fei2.wu@intel.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240227124412.2565716-1-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Fei,

On 27/02/2024 13:44, Fei Wu wrote:
> _PAGE_NOCACHE_THEAD is not used but the definition is wrong.
>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>   arch/riscv/include/asm/pgtable-64.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index b42017d76924..b99bd66107a6 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -136,7 +136,7 @@ enum napot_cont_order {
>    * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
>    */
>   #define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
> -#define _PAGE_NOCACHE_THEAD	((1UL < 61) | (1UL << 60))
> +#define _PAGE_NOCACHE_THEAD	((1UL << 61) | (1UL << 60))
>   #define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
>   #define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
>   


This fix is already in -fixes: 
https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?id=c21f014818600ae017f97ee087e7c136b1916aa7

Thanks,

Alex


