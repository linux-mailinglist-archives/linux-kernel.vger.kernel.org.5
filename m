Return-Path: <linux-kernel+bounces-25642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8C782D3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF331C2100A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C28D2563;
	Mon, 15 Jan 2024 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqQ4D7QE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AC23BE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705297952; x=1736833952;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uATe+e5CjpkVcqztHy4wZ6l46M5a/EeuYW06h1yi6oU=;
  b=JqQ4D7QEX8VhXwvqH3nLmXiTxDe44rjBP8Aj2nPVuevpZzih2LLglv4R
   GsgORbT3kVbjlKhsaAYG2TOEOsZIDchT3ZI2ppHu2jcfA8nGJ1NGFNXu6
   ONsxuBhzanbqQGyyKbPiIyr14LAciR9NuiPM3+/2OAXhKICP9n/MXq7ol
   VTGo0jVw6pmSJjFQBEB+kbLp9AVuia3zFKRQtAgZ3IogRVJVFIJa1bMCp
   YYAIyyhWLyCXNT4Lf6lc48RMWdgF6vdKs9Iamk+RsAcioK1D1gvaKlwin
   ImKIIaPiUwjJ5V9xbOuApYKnLObbMXSKdYNzFsQC2y8U+5Z6aqgr3e2UV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13019427"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="13019427"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 21:52:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1114837426"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="1114837426"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 21:52:28 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Yang Shi <shy828301@gmail.com>
Cc: oliver.sang@intel.com,  riel@surriel.com,  fengwei.yin@intel.com,
  willy@infradead.org,  cl@linux.com,  akpm@linux-foundation.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: mmap: no need to call khugepaged_enter_vma()
 for stack
In-Reply-To: <20231221065943.2803551-1-shy828301@gmail.com> (Yang Shi's
	message of "Wed, 20 Dec 2023 22:59:42 -0800")
References: <20231221065943.2803551-1-shy828301@gmail.com>
Date: Mon, 15 Jan 2024 13:50:30 +0800
Message-ID: <877ckb16xl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Yang Shi <shy828301@gmail.com> writes:

> From: Yang Shi <yang@os.amperecomputing.com>
>
> We avoid allocating THP for temporary stack, even tnough
                                                    ~~~~~~
                                                    though?

--
Best Regards,
Huang, Ying

> khugepaged_enter_vma() is called for stack VMAs, it actualy returns
> false.  So no need to call it in the first place at all.
>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  mm/mmap.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b78e83d351d2..2ff79b1d1564 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2046,7 +2046,6 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  		}
>  	}
>  	anon_vma_unlock_write(vma->anon_vma);
> -	khugepaged_enter_vma(vma, vma->vm_flags);
>  	mas_destroy(&mas);
>  	validate_mm(mm);
>  	return error;
> @@ -2140,7 +2139,6 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  		}
>  	}
>  	anon_vma_unlock_write(vma->anon_vma);
> -	khugepaged_enter_vma(vma, vma->vm_flags);
>  	mas_destroy(&mas);
>  	validate_mm(mm);
>  	return error;

