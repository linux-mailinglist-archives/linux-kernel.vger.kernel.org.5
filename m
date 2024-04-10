Return-Path: <linux-kernel+bounces-137959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A5189EA58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E951F22F33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B46200D9;
	Wed, 10 Apr 2024 06:07:41 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08C20DDB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729260; cv=none; b=axxiqtl3osTGDBJqM00ebRNNgI9g2uPDurJBd7TqyzY3NGW7s95VbzUj9FUb+ACJ6Np6clDGtbpSpmqvzgAFvriOHuVHYIOx5UNQ1SrqWcKVWQymhgsCL/Er61hVpdBo6a5YenWIlCYJk/N9RXOxIQBpM9gxUTmVBtMR6mk7P4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729260; c=relaxed/simple;
	bh=WX1tDgIme+L3XE+HZdKDtwNhwJATQz0mcJAPfpArHVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYz0Qblyc08u3h+7icbClS/PnJ72F+qgxfqQHroygtxv6w9aPXK7fkDgnMPvb3Cs5bcPw6TNeq1QiuK/r538WnB21LMzFYUbHr+K63hV0WIVuGQOS99I8azhSboPVKlPgwlMPfbXjv82B7zeL+EN8vztZfph5Hn2tv+r8linuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDECDC0007;
	Wed, 10 Apr 2024 06:07:33 +0000 (UTC)
Message-ID: <d534e73a-a7c0-4116-98bf-09617b7f89b3@ghiti.fr>
Date: Wed, 10 Apr 2024 08:07:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH riscv/fixes] riscv: hwprobe: fix invalid sign extension
 for RISCV_HWPROBE_EXT_ZVFHMIN
Content-Language: en-US
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20240409143839.558784-1-cleger@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240409143839.558784-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Clément,

On 09/04/2024 16:38, Clément Léger wrote:
> The current definition yields a negative 32bits signed value which
> result in a mask with is obviously incorrect. Replace it by using a
> 1ULL bit shift value to obtain a single set bit mask.
>
> Fixes: 5dadda5e6a59 ("riscv: hwprobe: export Zvfh[min] ISA extensions")
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>   arch/riscv/include/uapi/asm/hwprobe.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 9f2a8e3ff204..2902f68dc913 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -54,7 +54,7 @@ struct riscv_hwprobe {
>   #define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 28)
>   #define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 29)
>   #define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
> -#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 31)
> +#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1ULL << 31)
>   #define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
>   #define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
>   #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


