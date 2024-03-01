Return-Path: <linux-kernel+bounces-89049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1086E9EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320971C22CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF723B797;
	Fri,  1 Mar 2024 19:46:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566B3B789
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322408; cv=none; b=KrNBpX57ccn6gcRSferERDHp/kChBFPDG2wA8ZEqHB8ChcwhJstuwQ4WuVazm7QZKAAsRl5vCoSzE8b55PaGVYFQ8DF+/6VhcR2ZVY2WBjnnwsv9w7I117hOX1VM8irTF3D23iHr3vPwpE5hiTyEVbUyVz+L5ci3uXpAyGosbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322408; c=relaxed/simple;
	bh=o3IBGAAxgjLskllDlyxITmlmSeHn8XSVOcj3er0/LLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDOBx5fZ+YOY70M5SYESS+F6vwd2ug9fX5+//rR9jCsm54hUkON5H3JwR+/K/HmRzjnQttQUNExi2WrkQD+ebFLcZaXZNKTkrlgDmEOblW6C4Oh0S8X9KX+OZQiJ026fmyZhmARZfbLfOwjl8yjJ67KH34jWTyDipkTQyFa0ELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 522331FB;
	Fri,  1 Mar 2024 11:47:23 -0800 (PST)
Received: from [172.27.42.98] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1AA73F6C4;
	Fri,  1 Mar 2024 11:46:44 -0800 (PST)
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



