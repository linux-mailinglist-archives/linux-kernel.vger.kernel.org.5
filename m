Return-Path: <linux-kernel+bounces-89050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3C86E9F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC181286B51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B03BB53;
	Fri,  1 Mar 2024 19:46:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC420DCD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322409; cv=none; b=iElS6uW9XNN7o4w3zORApbtbOD+2uHPjMhdmj53CBWZ6l4vFuh7aUsTNLXd969hhJZlqxNgr/AgyjFUZz+BT1ibvwIWn+Ydaoz7VQdFuA5ej028XEQKNkWKDsUZTMHbq2koo9W8BH69qdIKxkoGsF9VBad3X3cjDJJmRPasVa9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322409; c=relaxed/simple;
	bh=o3IBGAAxgjLskllDlyxITmlmSeHn8XSVOcj3er0/LLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLyIcSt0+VAqWJuGBePyFh6xKWZ64qAhly9yLUfrFLefJYOqM4MiZzXL+ZYUbkUQmy1potE2Pu/LaYQ68wqLRkGOZJlBrWC9Rspu0aAspipqCEAIn75YB/6C/s1ARqmZ76ulVYbtFDNtbQ+9h6foPmEdy/lEcxbbgJYYZTzuOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40ED011FB;
	Fri,  1 Mar 2024 11:47:25 -0800 (PST)
Received: from [172.27.42.98] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AD1C3F6C4;
	Fri,  1 Mar 2024 11:46:47 -0800 (PST)
Message-ID: <e364b4f9-ce92-43a9-ab06-a0391c5dcc5f@arm.com>
Date: Fri, 1 Mar 2024 13:46:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: cpufeatures: Clean up temporary variable to
 simplify code
Content-Language: en-US
To: Liao Chang <liaochang1@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, broonie@kernel.org, mark.rutland@arm.com, maz@kernel.org,
 joey.gouly@arm.com, kristina.martsenko@arm.com, ryan.roberts@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240229105208.456704-1-liaochang1@huawei.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20240229105208.456704-1-liaochang1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2/29/24 04:52, Liao Chang wrote:
> Clean up one temporary variable to simplifiy code in capability
> detection.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>   arch/arm64/kernel/cpufeature.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 8d1a634a403e..0e900b23f7ab 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3052,13 +3052,9 @@ static void __init enable_cpu_capabilities(u16 scope_mask)
>   	boot_scope = !!(scope_mask & SCOPE_BOOT_CPU);
>   
>   	for (i = 0; i < ARM64_NCAPS; i++) {
> -		unsigned int num;
> -
>   		caps = cpucap_ptrs[i];
> -		if (!caps || !(caps->type & scope_mask))
> -			continue;
> -		num = caps->capability;
> -		if (!cpus_have_cap(num))
> +		if (!caps || !(caps->type & scope_mask) ||
> +		    !cpus_have_cap(caps->capability))
>   			continue;
>   
>   		if (boot_scope && caps->cpu_enable)

Looks functionality equivalent to me, and just to see if it makes a 
binary difference I compiled both variations (gcc 14.0.1) and they do 
result in the same instruction sequence. Meaning gcc is smart enough to 
drop the tmp, its also smart enough equate/apply de Morgan's law. The 
latter might make it more readable too, but I guess its all a matter of 
taste.


Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>



