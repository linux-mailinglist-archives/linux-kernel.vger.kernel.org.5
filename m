Return-Path: <linux-kernel+bounces-20422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CAB827EA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED32F1F2474B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77576FA9;
	Tue,  9 Jan 2024 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UniqjT2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D96126
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 06:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C862EC433F1;
	Tue,  9 Jan 2024 06:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704780332;
	bh=XPd0RK08tWKOZINB6b6dqpbqY/JsdvIb4rb1JcNGbh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UniqjT2uQSbEWk9DR7Gyj5TlU4bsscbhMppvDMl1CKeQWbyj0/7Duu9+WFjkQRiXg
	 +0VwpTibsiZI0CxW98HdwKO3yFXMphC2Slz5GGwzK9UwGwnoHcO9pKT2Dq3RgSoPpR
	 MPnT7lWfyUxy0TpSNkAaX+qVBhwkNcsnxGLUIysFHb+0Hz+W/53j2nCd3nRPavstZP
	 OALIy6yn9Ca7qXrGurgw8kMc9amlBqhd800wDtAtI0Dn55BvNaSMcXkUyQFJ0dKEs8
	 lXQjS5OCq1+wMumKJEB+qcGHon6T1uH7Sp5aYET8Xw3Zcd5xHfcZbE+5dagsSolXPO
	 UYuniVAYlB6oA==
Date: Tue, 9 Jan 2024 08:05:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wupeng Ma <mawupeng1@huawei.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: Disable mirror feature during crashkernel
Message-ID: <ZZziDIc0C9BHhhu4@kernel.org>
References: <20240109041536.3903042-1-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109041536.3903042-1-mawupeng1@huawei.com>

On Tue, Jan 09, 2024 at 12:15:36PM +0800, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> If system have no mirrored memory or use crashkernel.high while
> kernelcore=mirror is enabled in cmdline, during crashkernel,
> there will be limited mirrored memory and this usually lead to
> OOM.
> 
> To solve this problem, disable mirror feature during crashkernel.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 077bfe393b5e..513bad672708 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -26,6 +26,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/swap.h>
>  #include <linux/cma.h>
> +#include <linux/crash_dump.h>
>  #include "internal.h"
>  #include "slab.h"
>  #include "shuffle.h"
> @@ -381,6 +382,11 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>  			goto out;
>  		}
>  
> +		if (is_kdump_kernel()) {
> +			pr_warn("The system is under kdump, ignore kernelcore=mirror.\n");
> +			goto out;
> +		}
> +
>  		for_each_mem_region(r) {
>  			if (memblock_is_mirror(r))
>  				continue;
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

