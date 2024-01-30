Return-Path: <linux-kernel+bounces-44386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A76F84215A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24FD288351
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6AA60ED2;
	Tue, 30 Jan 2024 10:34:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6F360AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610869; cv=none; b=IGzWsefZGYWZA190qIltQlHtdj5PPeRDahLBXVxX22fVmkSQ6UEOpiim7p/av8O+t7wTOEy/Df6+s5EVeJFS0xmKGlu1PKM2mIpTq+dKbuNHw8KEmSP5ETr+gYxXR7QxnBQMf6IQufYjbwS8hF3HLmSIc2TX8djs+z7YiXnmtj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610869; c=relaxed/simple;
	bh=T3gGNMPwCH3MMYOBJy9nDihF4Sd9waF/RayDJzaEarI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVGugwHycGirDSMQLGwhjMfAqe+x0e0dU9BBaibRWRP6PuXs4fHemAOsGgUi6NQbeXNC0l9LRfcTprWxelEMC4t7u3aDzd7bbsBLIYPozfO3A2Rx9iV7VhAWYn02oi7AkVhgr3ceNQmbR8lBOkiF95jqWFG6Zo5QpxSziWrtjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43DEFDA7;
	Tue, 30 Jan 2024 02:35:10 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2453D3F5A1;
	Tue, 30 Jan 2024 02:34:25 -0800 (PST)
Date: Tue, 30 Jan 2024 10:34:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: catalin.marinas@arm.com, will@kernel.org, revest@chromium.org,
	rostedt@goodmis.org, arnd@arndb.de, pengdonglin@sangfor.com.cn,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: make member of struct pt_regs and it's offset
 macro in the same order
Message-ID: <ZbjQrtHOvC4Igsur@FVFF77S0Q05N>
References: <20240130175504.106364-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130175504.106364-1-shikemeng@huaweicloud.com>

On Wed, Jan 31, 2024 at 01:55:04AM +0800, Kemeng Shi wrote:
> In struct pt_regs, member pstate is after member pc. Move offset macro
> of pstate after offset macro of pc to improve readability a little.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

I think this makes sense as a trivial cleanup, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/asm-offsets.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 5ff1942b04fc..865ba901c233 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -75,8 +75,8 @@ int main(void)
>    DEFINE(S_FP,			offsetof(struct pt_regs, regs[29]));
>    DEFINE(S_LR,			offsetof(struct pt_regs, regs[30]));
>    DEFINE(S_SP,			offsetof(struct pt_regs, sp));
> -  DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
>    DEFINE(S_PC,			offsetof(struct pt_regs, pc));
> +  DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
>    DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
>    DEFINE(S_SDEI_TTBR1,		offsetof(struct pt_regs, sdei_ttbr1));
>    DEFINE(S_PMR_SAVE,		offsetof(struct pt_regs, pmr_save));
> -- 
> 2.30.0
> 

