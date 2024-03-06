Return-Path: <linux-kernel+bounces-93381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC92C872EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4870C289F68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCB54F616;
	Wed,  6 Mar 2024 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJzwl3aD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FDC3FE31
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709706285; cv=none; b=sPwKOYKoKTRrkoS9fM8yp2/1nWnaQWuwBcpZqEoY1+3UPxNBfcgRzJOQVgHZs1v1pXZrLLEgtzZ7pDnX0FYa0L9Rc8uo+M3dc6QBo/HRmr4cni7/vDUDCnyJzTnTy+Ob4qY7y2EESo7WMnKyqaPXF6Ivg18VczOxn137N9G7VsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709706285; c=relaxed/simple;
	bh=Ul9xyIM/xyWLYImXlcZ+ekHRz3h/sTxONmN5nrLAWX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+/jXXEGtqdXkKse/PGdneCoiT5qdxao+TAhwaKnlZeflqukskJAfOtZoAUbzD1lLaxYWntxMy+dTqJQfQFbwjVXwKRLhqcICHC/74tPB+kHVEyNM1lV+EG9ClYzR/DrB4vyhgkhTSk0ZluB2pQ/e4LBqkfW0FeP8xSVNngChDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJzwl3aD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90084C433F1;
	Wed,  6 Mar 2024 06:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709706284;
	bh=Ul9xyIM/xyWLYImXlcZ+ekHRz3h/sTxONmN5nrLAWX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJzwl3aDmw2R/PvwbEBvPZ3u+NLY0fqRSSGQgKs2InVezXhX/9DQWsIrHIhu6BbPu
	 lgBAiYFIW15YCX3uOOubXQRSCklHU0tR1/Wnu1iyHq5KnLswQs0CahMqIfxtbisXtq
	 o+T42dG+q7+R2aeWH0os80Ht3TAr1gN7h+7a4H9djzp65CmezNaMO/BHAz0PwmAW7E
	 7n/IBVf10MWU7PGd5fTqa+TdvYH8Xr+kr8N8PPUfHnmMCXFCxS3kLQE06IWLreXIeE
	 z2km+RVZaY98fb9Wc0TVXUnk09iQW67QBULk7oHkE0cuQRikKMqfSIuqO8YrFtBMGh
	 NjwIRRPzm4buw==
Date: Wed, 6 Mar 2024 08:23:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>, Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Muchun Song <muchun.song@linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 04/10] mm/x86: Replace pgd_large() with pgd_leaf()
Message-ID: <ZegL9nbKpWe3GM0_@kernel.org>
References: <20240305043750.93762-1-peterx@redhat.com>
 <20240305043750.93762-5-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305043750.93762-5-peterx@redhat.com>

On Tue, Mar 05, 2024 at 12:37:44PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> pgd_leaf() is a global API while pgd_large() is not.  Always use
> the global pgd_leaf(), then drop pgd_large().
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/x86/include/asm/pgtable.h | 4 ++--
>  arch/x86/mm/pti.c              | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 69ed0ea0641b..d6e993a5659f 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1418,8 +1418,8 @@ static inline bool pgdp_maps_userspace(void *__ptr)
>  	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
>  }
>  
> -#define pgd_leaf	pgd_large
> -static inline int pgd_large(pgd_t pgd) { return 0; }
> +#define pgd_leaf	pgd_leaf
> +static inline int pgd_leaf(pgd_t pgd) { return 0; }
>  
>  #ifdef CONFIG_PAGE_TABLE_ISOLATION
>  /*
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index dc0a81f5f60e..c17aab24c1b3 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -185,7 +185,7 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
>  
>  		set_pgd(pgd, __pgd(_KERNPG_TABLE | __pa(new_p4d_page)));
>  	}
> -	BUILD_BUG_ON(pgd_large(*pgd) != 0);
> +	BUILD_BUG_ON(pgd_leaf(*pgd) != 0);
>  
>  	return p4d_offset(pgd, address);
>  }
> -- 
> 2.44.0
> 
> 

-- 
Sincerely yours,
Mike.

