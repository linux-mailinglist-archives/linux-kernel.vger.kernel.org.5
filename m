Return-Path: <linux-kernel+bounces-99333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CFB8786C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A888D1C20F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553E5467F;
	Mon, 11 Mar 2024 17:55:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D80F5466C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179699; cv=none; b=GWRoGQf8L8WFmPpa397S7greh+lWujoNMhzLx6jzkEmUTmLb5Xv27W4hIZN7UiUX9vYPGExjkZhBYEriQQ9z6YjjY4JVF/d9cx1RUQuVVMkIrZreGOwsrElR7bdj5YUsMtqjicCkvGo2+nRJf8aQxW5TqWYLOIIKKwKY91enOeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179699; c=relaxed/simple;
	bh=LrLIuqYmgtYw0Pf1y+c/lSOuQYABIIK/vkLDl8q4yTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avPswGu0a1oUw3JmvJSOunxDHTwAaK2UOFQM2Q3Sygl3PQJwsgjA5tsPLWE5/NvhhQ4oY1r4CrjgMGNo2ArOKN/j4Hjs4dogql2PXh5N+KDV9EiuBviPltcItiVzuh20EjLiR0k+qSytGCJq7ECN6QNsaL9V4XVcNqndQmLfkY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 767C3FEC;
	Mon, 11 Mar 2024 10:55:33 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E7BF3F762;
	Mon, 11 Mar 2024 10:54:55 -0700 (PDT)
Message-ID: <e731b262-c201-4294-9b1e-abfa0c6ac817@arm.com>
Date: Mon, 11 Mar 2024 17:54:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl: Uniform data type of
 component_id/domid/id/cache_id
Content-Language: en-GB
To: Rex Nie <rex.nie@jaguarmicro.com>
Cc: fenghua.yu@intel.com, reinette.chatre@intel.com, rohit.mathew@arm.com,
 linux-kernel@vger.kernel.org
References: <20240311081839.937-1-rex.nie@jaguarmicro.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <20240311081839.937-1-rex.nie@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rex Nie,

(for those following along at home - this is a patch against the MPAM tree, not mainline)

On 11/03/2024 08:18, Rex Nie wrote:
> This patch uniform data type of component_id/domid/id/cache_id to
> u32 to avoid type confusion. According to ACPI for mpam, cache id
> is used as locator for cache MSC. Reference to RD_PPTT_CACHE_ID
> definition from edk2-platforms, u32 is enough for cache_id.
> 
> 	(                                                              \
> 	  (((PackageId) & 0xF) << 20) | (((ClusterId) & 0xFF) << 12) | \
> 	  (((CoreId) & 0xFF) << 4) | ((CacheType) & 0xF)               \
> 	)

Aha, this is where those numbers are coming from! Thanks for digging that out.


> refs:
> 1. ACPI for mpam: https://developer.arm.com/documentation/den0065/latest/
> 2. RD_PPTT_CACHE_ID from edk2-platforms: https://github.com/tianocore/edk2-platforms/blob/master/Platform/ARM/SgiPkg/Include/SgiAcpiHeader.h#L202

Just to check - you don't see any side effects from doing this, its just cleaner.
I agree - today this is only an int because that's what it is in struct rdt_domain.


> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index dd34523469a5..b00a89addf91 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -108,7 +108,7 @@ struct resctrl_staged_config {
>   */
>  struct rdt_domain {
>  	struct list_head		list;
> -	int				id;
> +	u32						id;
>  	struct cpumask			cpu_mask;
>  	unsigned long			*rmid_busy_llc;
>  	struct mbm_state		*mbm_total;


We should probably only make this change if we clean this up in restrl, not just the MPAM
driver.


I'll pick the MPAM bits of this up for the MPAM tree. This will eventually get merged with
the patch that adds the original code as there is no point preserving the history of code
that isn't merged yet. I'll add you to 'CC' of those patches. (The joke is 'CC' also
stands for Celebrate Contribution!)


Thanks!

James

