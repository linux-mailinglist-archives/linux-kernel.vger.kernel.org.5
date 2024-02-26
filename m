Return-Path: <linux-kernel+bounces-80550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C55086695D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EAF1F2509F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AF41B59D;
	Mon, 26 Feb 2024 04:26:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3108A1B270
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921600; cv=none; b=JN5jZojENkwbLknr2BQydIxr9xNlvG+qnHzS5/m/IEk6h3SivHDJ628EVmXSx8xlPp3VyjVOPYgF9BmDo+r6aGOAKveYl96hLPTanw9CBO+grLVyk2ICEVgHKwMvB5VuR3QirByxc5bqFdUTwucDkRt+PYCRQqsK0tVAY/cd6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921600; c=relaxed/simple;
	bh=kN/30hnphBLUZUDAalCs0F00ZD4Mmo4HCmywnZe6880=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7GBxQhqBVy8xQHzimjWUy02TZi18hsRkl8y9JCetvd26bYJI7jU8GIKdHBJeyf6IvK45JbFFAOrf7Z0HK35PK+XYeP1LkamjUcP0dbohDJKJ5/snB49adWLbmSAfBg2FZ6Pym32mztsJ1Fvn0DYq/Kxoh8ZWukGIV2k7GFSFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74762C15;
	Sun, 25 Feb 2024 20:27:17 -0800 (PST)
Received: from [10.162.40.19] (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D8C73F6C4;
	Sun, 25 Feb 2024 20:26:36 -0800 (PST)
Message-ID: <21ee46a1-5e5a-4e8a-b1ba-e7f26c39e325@arm.com>
Date: Mon, 26 Feb 2024 09:56:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/hw_breakpoint: Determine lengths from generic perf
 breakpoint macros
Content-Language: en-US
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org, mark.rutland@arm.com, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org
References: <20240125094119.2542332-2-anshuman.khandual@arm.com>
 <20240226042249.4098185-1-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240226042249.4098185-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/26/24 09:52, Anshuman Khandual wrote:
> Both platform i.e ARM_BREAKPOINT_LEN_X and generic i.e HW_BREAKPOINT_LEN_X
> macros are used interchangeably to convert event->attr.bp_len and platform
> breakpoint control arch_hw_breakpoint_ctrl->len. Let's be consistent while
> deriving one from the other. This does not cause any functional changes.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.8-rc5
> 
>  arch/arm64/kernel/hw_breakpoint.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 35225632d70a..1ab9fc865ddd 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -301,28 +301,28 @@ static int get_hbp_len(u8 hbp_len)
>  
>  	switch (hbp_len) {
>  	case ARM_BREAKPOINT_LEN_1:
> -		len_in_bytes = 1;
> +		len_in_bytes = HW_BREAKPOINT_LEN_1;
>  		break;
>  	case ARM_BREAKPOINT_LEN_2:
> -		len_in_bytes = 2;
> +		len_in_bytes = HW_BREAKPOINT_LEN_2;
>  		break;
>  	case ARM_BREAKPOINT_LEN_3:
> -		len_in_bytes = 3;
> +		len_in_bytes = HW_BREAKPOINT_LEN_3;
>  		break;
>  	case ARM_BREAKPOINT_LEN_4:
> -		len_in_bytes = 4;
> +		len_in_bytes = HW_BREAKPOINT_LEN_4;
>  		break;
>  	case ARM_BREAKPOINT_LEN_5:
> -		len_in_bytes = 5;
> +		len_in_bytes = HW_BREAKPOINT_LEN_5;
>  		break;
>  	case ARM_BREAKPOINT_LEN_6:
> -		len_in_bytes = 6;
> +		len_in_bytes = HW_BREAKPOINT_LEN_6;
>  		break;
>  	case ARM_BREAKPOINT_LEN_7:
> -		len_in_bytes = 7;
> +		len_in_bytes = HW_BREAKPOINT_LEN_7;
>  		break;
>  	case ARM_BREAKPOINT_LEN_8:
> -		len_in_bytes = 8;
> +		len_in_bytes = HW_BREAKPOINT_LEN_8;
>  		break;
>  	}
>  

Please ignore this. Wrong patch got picked up in the git send-email :)

