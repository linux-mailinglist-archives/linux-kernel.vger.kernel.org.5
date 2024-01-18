Return-Path: <linux-kernel+bounces-29744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B68312CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6F5B2343A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08011CAF;
	Thu, 18 Jan 2024 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFiQrywG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE911C80
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705560143; cv=none; b=OkrGAoWT4GTURkvjrfXioIofHLhjby01gI/I6VGfBg2OUVox61VyDFtkZG3+7juQRBihVHqtXi2FkdUIvgJKcS+pCw6ba6gCociNoqDOj6OTGux8oxO+gXh2TJI9lfILuxkam69O2tLyipUe8h3knjf27kofrL2w7zsD8GcnKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705560143; c=relaxed/simple;
	bh=7irHwcUOlLLvJ2czZrHOJqq3RhjBpa00ankX30HggNE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=fnAJPHwIQdYfcIrfnHeHnmu2b/efSGTe3vIQ6rXfpQOSwBWIeAm9+8gmMM7sVSS0UiDO6mfdVy1IwPWpS2ClYVekgHCsTcwhakScYA9kyDHl6TA8O6MWYYtLFXtANnhKV2mFz2W44yhab3CUCclOViHol2UOhi9NqNQgwIkzO1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFiQrywG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98146C43390;
	Thu, 18 Jan 2024 06:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705560143;
	bh=7irHwcUOlLLvJ2czZrHOJqq3RhjBpa00ankX30HggNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFiQrywGk1L0FEqB3zgPffyixtDSEM16hHyBN8bHBAmzU71ff7sCJqTwVgsvAKDlt
	 eZs379UnaSF2wDZaqEyGTl2qmoIrPmW0f+Rby1pW6+FpJ2kqCKuHMnwGQbhPzggAo5
	 xQ3Znn82qCXhFiC0/Gg8vV4OsxLpDb+dI6XPbrXFTjuaKJlgnNl+egrHUGurPIAJIe
	 yXY2ssLC4m6AVNrTjzb0ZbI1nfHXgv7O4d2aPD4nqJzhQTKwP7haUVNemqyY2NNmQE
	 8+LVv4bDTf9geyLSUyUqnIDYZjYmOF2TB8jnicLhF7Mw7zpuVWeKCSpiPIQdbjWxx7
	 C3GRh9wInDWtA==
Date: Thu, 18 Jan 2024 08:42:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Yajun Deng <yajun.deng@linux.dev>, Huang Pei <huangpei@loongson.cn>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: fix crash when reserved memory is not added to
 memory
Message-ID: <ZajIQGtqUNWgBWkk@kernel.org>
References: <20240118061853.2652295-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118061853.2652295-1-yajun.deng@linux.dev>

(adding Huang Pei to verify this fixes the crash on loongarch)

On Thu, Jan 18, 2024 at 02:18:53PM +0800, Yajun Deng wrote:
> After commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()"),
> we set nid on all reserved pages based on memory region, but some reserved
> memory may not be added to memory on certain architectures. The nid is
> invalid.
> 
> Add the nid check, make sure the nid is valid by early_pfn_to_nid().
> 
> Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  mm/memblock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index abd92869874d..4dcb2ee35eca 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2176,6 +2176,9 @@ static void __init memmap_init_reserved_pages(void)
>  			start = region->base;
>  			end = start + region->size;
>  
> +			if (nid == NUMA_NO_NODE || nid >= MAX_NUMNODES)
> +				nid = early_pfn_to_nid(PFN_DOWN(start));
> +
>  			reserve_bootmem_region(start, end, nid);
>  		}
>  	}
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

