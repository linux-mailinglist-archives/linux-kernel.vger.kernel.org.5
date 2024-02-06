Return-Path: <linux-kernel+bounces-55364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDDA84BBC4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E61C2302A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7CD79F2;
	Tue,  6 Feb 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZs7lM0t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A5BA2E;
	Tue,  6 Feb 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240274; cv=none; b=jzctsRwz22OJ9u8gpXn+OB8JrYEePfI5VxwAQ+P73T4pn0S3FrRN0BvKZPw9Bx1Xc7L31a86RIpt8+k/4qACUOt6GiLH6hQzwu/nfhPecIeUaJMCUMQSf8N/EAFpCbaMecgrfeVU/Rbcu0jVK+bc8hTO8Pbe5Hr/6i3dG+8qTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240274; c=relaxed/simple;
	bh=wAg2XzjSRB4HySKux0MOo0sKez9PEk6oPi3dGKpYWMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzIRyiQfqN879TeNxfUxtzTwUKxVcnrOhvPXXWjVa2Lt1HUwXN2BnHd+vZGt5WxAWrDRVV2QnJB6k7LG4Yt5C3f4j5hEfQ7LaEntMP0eFh/FOYq2ADhL39XEylvQJjjHwsFBQSsOLXddcV1MhHsX74sGERTKwvk2yVX+1bZqXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZs7lM0t; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707240273; x=1738776273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wAg2XzjSRB4HySKux0MOo0sKez9PEk6oPi3dGKpYWMw=;
  b=JZs7lM0tG/tkCYUQqxJtzNKuvNz67anVEz7F3FacpI8m+b1cdf3nMLEQ
   ziFVE25Z1ZkfNkVo7SU36liSGnhhuC6AkaGliIYJ5yfaKBHXSYsG/fADf
   T6jjUqbtvaiQkLeORjd0zKhvXCyh8ieFXC/UE25YYxapsNbW6ooEdI1nO
   3R0/K8Ycx0r75jsurTsI2PxgO3LfWHo8eMasoKA5wFHyT7byGtk8NUqyO
   UnQtEF4sbXOGd5fJg4PV1rBMaSlcJxSEeVKtwjpMzaSSFPsu+Gd+gLvQR
   N3OcoFOejp+lJBVjX8BN0UVGjBnZgTghSuo9UGg68lzltOaIHFk6R7hYR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="950367"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="950367"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 09:24:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5678237"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.99]) ([10.246.113.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 09:24:31 -0800
Message-ID: <5d75bea5-3dbd-44d4-9604-6710ddd84002@intel.com>
Date: Tue, 6 Feb 2024 10:24:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v3] cxl/region: Use cond_guard() in show_targetN()
Content-Language: en-US
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>
References: <20240206121301.7225-1-fabio.maria.de.francesco@linux.intel.com>
 <20240206121301.7225-3-fabio.maria.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240206121301.7225-3-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/24 5:13 AM, Fabio M. De Francesco wrote:
> Use cond_guard() in show_target() to not open code an up_read() in an 'out'
> block. If the down_read_interruptible() fails, the statement passed to the
> second argument of cond_guard() returns -EINTR.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0f05692bfec3..eb5c36462c0a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -666,28 +666,20 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled;
> -	int rc;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> +	cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
>  
>  	if (pos >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
>  			p->interleave_ways);
> -		rc = -ENXIO;
> -		goto out;
> +		return -ENXIO;
>  	}
>  
>  	cxled = p->targets[pos];
>  	if (!cxled)
> -		rc = sysfs_emit(buf, "\n");
> -	else
> -		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
> -out:
> -	up_read(&cxl_region_rwsem);
> +		return sysfs_emit(buf, "\n");
>  
> -	return rc;
> +	return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
>  }
>  
>  static int match_free_decoder(struct device *dev, void *data)

