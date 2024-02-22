Return-Path: <linux-kernel+bounces-77146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F00B8601A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6A9B2523B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5403140E46;
	Thu, 22 Feb 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wcme3Ygr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61414037B;
	Thu, 22 Feb 2024 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626604; cv=none; b=Bqyp7M91t62yOo0IJYqYZQQg+tKG3XhuTlK9YvWJLFiNgF1FQzCiyVkj9XrYJRcECpGFeeH2iZJ3jId/FjqlMr5y25eJDABxdssA5WqsNyuMZz3DYWQXOXUY12bgt+wPlGFwhmzoUwM50kt0TT1PmIkdDvciEG09Yvj+oliDjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626604; c=relaxed/simple;
	bh=oIzPtj+CyOLKn0NcTVtqH16JXPUfqFE5Kv4atxAP9t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ittAHO5NVaJBqUQ+nPCMJ60deyLucE7hmemLGb+WT972aSCpEiDlukIr9Csmc7xdeM2M9+23GK62qpUt1lvla5KjQfOzaWcoJWrhp5HP/XjAwEuBELEgxza5HAgT6E8ezisp1Msod8z+4+/6X/cenhKmFWWBXotMJMN0AdhktqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wcme3Ygr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708626602; x=1740162602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oIzPtj+CyOLKn0NcTVtqH16JXPUfqFE5Kv4atxAP9t4=;
  b=Wcme3YgrjQerpnZZyNZP6vs4EfmCyOUX7FbfRey3tYjIizFPETWF7wAB
   /n+MGB5cfBfAVGqoGnFjYVj7O4+FGj91ZozgXAWiE9p1Ai6qupwUbX29l
   TlJH8NAemBB1uwRmCX31m/a/wE2SHMJcVqpocgvpDBqXdw7yfjaKQa9Qm
   lIV637Efm4ga8/c357v840R7DUu+pnGrw2d5833hmEsV+OXAty9wq2zwh
   LPrbza+jrvBuUWVZkSJFtGT2FzovRQSIEOU70GRNAuMS/7ZAkgLQK5EtH
   uXtfVRshy4YSR91rX9okIOjkUkMcjf6v3FO9uasvIqQPnMxSh4xhuki5v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6697550"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6697550"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:30:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5552642"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.114.198]) ([10.246.114.198])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:29:59 -0800
Message-ID: <9cc1ccfa-5ddc-46d6-93ff-dab952191207@intel.com>
Date: Thu, 22 Feb 2024 11:29:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Clean up a debug printk
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <3d3d969d-651d-4e9d-a892-900876a60ab5@moroto.mountain>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3d3d969d-651d-4e9d-a892-900876a60ab5@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/21/24 11:14 PM, Dan Carpenter wrote:
> Smatch complains that %pa is for phys_addr_t types and "size" is a u64.
> 
>     drivers/cxl/core/hdm.c:521 cxl_dpa_alloc() error: '%pa' expects
>     argument of type 'phys_addr_t*', argument 4 has type 'ullong*
> 
> Looking at this, to me it seems more useful to print the sizes as
> decimal instead of hex.  Let's do that.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..0b1843631b26 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -518,9 +518,9 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	}
>  
>  	if (size > avail) {
> -		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> +		dev_dbg(dev, "%llu exceeds available %s capacity: %llu\n", size,
>  			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> -			&avail);
> +			(u64)avail);
>  		rc = -ENOSPC;
>  		goto out;
>  	}

