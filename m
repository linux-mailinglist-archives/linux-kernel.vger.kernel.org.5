Return-Path: <linux-kernel+bounces-20787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50E382853C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F76286B36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC6937167;
	Tue,  9 Jan 2024 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1SxpyZZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7036B1B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704800461; x=1736336461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AoPRblfBYSSpxI4NW0UoohG5awkc5/gNHCwPgvymxJ0=;
  b=m1SxpyZZ//mAVpPeNxSy2D5FFs5MlhJ5KAlsEwFJu93gDMOdYGRGaahT
   +fNAAsEhjvjgIGVL89UdNqiR4tq5ch7oh2vRlKYvbxcfo3+d1GdhSFe2o
   /DMsFcb7GxvKqiyUg+3GfMg6xjcjHLToHoGebd/YVSl2u3iEKKHHVtyF1
   5m8s8+o0czCvZyfjhZI6inYNsM/FdnO3dbPK1iqePFXKz5J/Bam0zD+ye
   D/INmEfj14m3+th+kjG6OpHGeCfUvlkQFvDy4AN8Uw+IKOkOxL9cddgwv
   9Ta6kcXSyRPS8TmcG5ox20Q9WGD1f47Yanos5q5G8HMVBFEKI2orPOuzy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4946118"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="4946118"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 03:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="757957217"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="757957217"
Received: from arunjose-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.37])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 03:40:58 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id F2CA710A4E9; Tue,  9 Jan 2024 14:40:54 +0300 (+03)
Date: Tue, 9 Jan 2024 14:40:54 +0300
From: kirill.shutemov@linux.intel.com
To: Jun Miao <jun.miao@intel.com>
Cc: dave.hansen@linux.intel.com, x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Optimize try_accept_memory() to reduce 1GB page
 accepted failed times
Message-ID: <20240109114054.s2mzvhp2dgbihcvy@box.shutemov.name>
References: <20240109054824.9023-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240109054824.9023-1-jun.miao@intel.com>

On Tue, Jan 09, 2024 at 01:48:24PM +0800, Jun Miao wrote:
> Since the current TDX module ABI spec TDG.MEM.PAGE.ACCEPT Leaf show:
> "Level of the Secure EPT leaf entry that maps the private page to be
> accepted: either 0 (4KB) or 1 (2MB)".

Well, that's true that current implementation supports only 4k and 2M, but
note reference to "Secure EPT level" table. This as well as size of the
field suggests that it can be extended to more page levels.

> There is not 1G page accept dynamically, if every time try to accept 1G
> size but always fail, then cost more time from two cases:
> 	- When size < 1G, judge failed return 0
> 	- Really TDCALL<ACCEPT_PAGE> 1G failed when size >= 1G
> So skip the 1G and optimize it to 2M directly to save time.

Do you actually see issued TDCALL for 1G pages? It shouldn't be the case.

Kernel accepts memory in MAX_ORDER chunks -- 4MiB a time. try_accept_one()
will fail on alignment check 511 times of 512 and on len check for the
one. I expected these checks to be within noise compared to TDCALL.

I don't oppose the patch in principal, but let's establish facts first.

> 
> Run the eatmemory with different memories to get the cost time as follow:
> 	[root@td-guest ~]# ./eatmemory 8G
> 	Currently total memory: 100169027584
> 	Currently avail memory: 99901911040
> 	Eating 8589934592 bytes in chunks of 1024...
> 
> 	  Start time：1704699207487 ms
> 	  End time：1704699222966 ms
> 	  Cost time: 15479 ms
>   #
>   # Compare with/without this optimization
>   #
>   # Hardware: ArcherCity Sapphire Rapids 128cores
>   # Test eatmemory: https://github.com/jmiao2018/eatmemory.git
>   # Detail test log link: https://github.com/jmiao2018/eatmemory/blob/master/log-tdx.txt
>   #
>   # Accept Memeory Sizes      Before(ms)       After(ms)      Trigger 1G Failed Times      Reduce Time%
>   # ....................      ..........       .........      .......................	   .............
>   #
> 		  1G                3414         3402                        751824        -12(-0.035%)
> 		  2G                3853         3804                       1015126       -349(-0.128%)
> 		  4G                7773         7561                       1557834       -212(-0.281%)
> 		  8G               15479        15173                       2633686       -306(-0.201%)
>   		 16G               31527        30379                       4785649      -1148(-0.378%)
>   		 32G               65058        63723                       9087686      -1335(-0.209%)
> 		 64G              133379       128354                      17693366      -5025(-0.391%)
> 
> Co-developed-by: Zhiquan Li <zhiquan1.li@intel.com>
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> ---
>  arch/x86/coco/tdx/tdx-shared.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
> index 1655aa56a0a5..1694b7eba93b 100644
> --- a/arch/x86/coco/tdx/tdx-shared.c
> +++ b/arch/x86/coco/tdx/tdx-shared.c
> @@ -18,7 +18,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
>  	 * Pass the page physical address to the TDX module to accept the
>  	 * pending, private page.
>  	 *
> -	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
> +	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M.
>  	 */
>  	switch (pg_level) {
>  	case PG_LEVEL_4K:
> @@ -27,9 +27,6 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
>  	case PG_LEVEL_2M:
>  		page_size = TDX_PS_2M;
>  		break;
> -	case PG_LEVEL_1G:
> -		page_size = TDX_PS_1G;
> -		break;
>  	default:
>  		return 0;
>  	}
> @@ -55,11 +52,14 @@ bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
>  		 * Try larger accepts first. It gives chance to VMM to keep
>  		 * 1G/2M Secure EPT entries where possible and speeds up
>  		 * process by cutting number of hypercalls (if successful).
> -		 */
> +		 * Since per current TDX spec, only support for adding 4KB or
> +		 * 2MB page dynamically.
> +		 * /
>  
> -		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
> -		if (!accept_size)
> +		if (IS_ALIGNED(start, PMD_SIZE) && len >= PMD_SIZE)

You duplicate checks inside try_to_accept_on().

>  			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
> +
> +		/* The 4KB page case or accept 2MB page failed case. */
>  		if (!accept_size)
>  			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
>  		if (!accept_size)
> -- 
> 2.32.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

