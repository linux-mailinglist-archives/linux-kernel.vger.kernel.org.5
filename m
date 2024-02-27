Return-Path: <linux-kernel+bounces-83601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 406F8869C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B071C22761
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637311487D5;
	Tue, 27 Feb 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kgak8rgL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F81482FA;
	Tue, 27 Feb 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051366; cv=none; b=RVIl4XrmZ2J/YbSPIq6iVr7wZlIoojFX4X1RiQFs/Q96qbQTvmYHG+VTpCfBg3+Y3av5eEOfEnJwkdWuS52nAsF4apZrW/bluKJ/OBxtYlU4Ijt8tW/fJkhrwhymcgqXyb310xf4vgmX/t+Z0sI2ycRrDDrtbD2NeA3ogZNI5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051366; c=relaxed/simple;
	bh=1+st7Vsl9nppqGUn+eFiygHcZ/ILhnmpv5MjcmPXPmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEnzX9pDkl1nHaYshD3LhX+ym3+pmzl/I1WyqoRUimF+Teq1ydJQhfjEXBSOky12JuNPiKu9GM4CNdzU6j167CS9jCiQr0huopGhhCjgXCbygpQI9ng/cM+jHelXIRqsLWrvpc1p1JPXTVas4iTdd8RlEvVdDF4HJoDQI4/K2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kgak8rgL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709051365; x=1740587365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1+st7Vsl9nppqGUn+eFiygHcZ/ILhnmpv5MjcmPXPmU=;
  b=Kgak8rgL/bYlwGffYfvkfBOQXDJuiYKyLAn2Y+95cfQAaZYDcGewy8nJ
   L5//GhjSChPRRxWtx4dSZ24wfUouwKkXjtkG3q02QKimpWohb8AEPwPBy
   THygfD6IOT3OoPViydr4RHPdOgy7HNyjJamACAeqfWV9HN1252U2cGpXS
   gtOEZdAeKpA1OwCYMNp8cYlaHJ0fbV9GuJltdszDv12zzVjcQlOGmEPyT
   vdVxDxhoPm0wh0ivjzY/PaQvRML0S0RT2SOe/tsSNSJcwdFYopDIpn5wh
   ddtHmllDBccVqYUfVEq78yLONsPaPOoSKcgEpphdN9xzRsw5wqmR1+dgy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14040462"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14040462"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="44608181"
Received: from pbackus-mobl1.amr.corp.intel.com (HELO [10.246.114.227]) ([10.246.114.227])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:29:23 -0800
Message-ID: <b9966efa-8efe-4de7-b962-a6edcf2f6904@intel.com>
Date: Tue, 27 Feb 2024 09:29:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dax: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: chengming.zhou@linux.dev, dan.j.williams@intel.com,
 vishal.l.verma@intel.com
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, Xiongwei.Song@windriver.com,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240224134728.829289-1-chengming.zhou@linux.dev>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240224134728.829289-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/24 6:47 AM, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Can you please provide a Link tag to the lore post that indicates SLAB_MEM_SPREAD flag is now a no-op?
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  drivers/dax/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 54e528779877..cff0a15b7236 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -547,7 +547,7 @@ static int dax_fs_init(void)
>  
>  	dax_cache = kmem_cache_create("dax_cache", sizeof(struct dax_device), 0,
>  			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
> -			 SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +			 SLAB_ACCOUNT),
>  			init_once);
>  	if (!dax_cache)
>  		return -ENOMEM;

