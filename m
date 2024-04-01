Return-Path: <linux-kernel+bounces-126771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4EF893C83
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C7B1C21466
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB17F446D5;
	Mon,  1 Apr 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knq7Zgm6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63246525;
	Mon,  1 Apr 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983756; cv=none; b=lTrDI/Zg72CYgbVkBubnzrnKACb07/1dLdi2UmSw8OJY/CP/MAZJ8L+lAUy43s4WeImgDnhTGH2RJ1uq871NB66KPcDoU9/+BdmRzQmACsQ6J2tNW/3sxQL1KbyY+AideDzPByGGaZCYNCw5lo9v6vzqRKuN6AB9oFCSRIsOTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983756; c=relaxed/simple;
	bh=XHGJn6TzTehov6tjSa7o3b57YxPm8TU+Uf8wPfAwNKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po57hWaF1GDAzpH2V1uAkHPUVTm3O5Rjt+LQkS3ASOGKueCjfCoGXHFJjFO7UMzCk6fqFVeoFy4/hyueUJvUoCaVCpWsLmVKJCDOnXlwW4Or3Fj+KKeOLJ38SyWiOsF0CtMKWlDUQGZS8AYlnz1uST6HVc1mSs6CANo03VgdrCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knq7Zgm6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711983754; x=1743519754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XHGJn6TzTehov6tjSa7o3b57YxPm8TU+Uf8wPfAwNKg=;
  b=knq7Zgm6TIlPv7KU2UTBA3n8o/LogkuYLIP9buO77UPFPuxK/qro8x7z
   MqMG/TTR51qoFZpo/cSZUOfaBdJW+7BMXimnG7MzBCdJHFCh3Kh8lw1Q3
   AkGnkCuA7v3pPMYXOqovsr0bojboBAcjePSlujmqYPpQczhmQqqk/4ui8
   nPEzBrDXBfbYXG44KUgZeBqzMDhkFx3H8hEH+ZMCuRvis9pJac5LyHFnv
   uECdJkDhiIqg6Hii0FGiuubzYFvxE5m83SgRtHw7Df/xJXBVLeY++1gJY
   AZMjxkijM0mk1DhBXYe9ERSQjL/A144YplCEcTiVYwb+WtI/Byov2YS2l
   Q==;
X-CSE-ConnectionGUID: Kg1PyfFOTgeC7bqJxynZxw==
X-CSE-MsgGUID: rFfrU9gjRCW6SzmzpL3c3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7302970"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="7302970"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 08:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="22428863"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 01 Apr 2024 08:02:30 -0700
Date: Mon, 1 Apr 2024 22:57:40 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH] fpga: dfl: afu: remove unused member pdata from struct
 dfl_afu
Message-ID: <ZgrLZCl1nPDMcq/i@yilunxu-OptiPlex-7050>
References: <20240328235417.7219-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328235417.7219-1-peter.colberg@intel.com>

On Thu, Mar 28, 2024 at 07:54:17PM -0400, Peter Colberg wrote:
> The member pdata was added to struct dfl_afu in commit 857a26222ff7
> ("fpga: dfl: afu: add afu sub feature support") and is set in function
> afu_dev_init() but otherwise never used.

Could you also help check if dfl_fme has the same issue?

Thanks,
Yilun

> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 2 --
>  drivers/fpga/dfl-afu.h      | 3 ---
>  2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index c0a75ca360d6..6b97c073849e 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -858,8 +858,6 @@ static int afu_dev_init(struct platform_device *pdev)
>  	if (!afu)
>  		return -ENOMEM;
>  
> -	afu->pdata = pdata;
> -
>  	mutex_lock(&pdata->lock);
>  	dfl_fpga_pdata_set_private(pdata, afu);
>  	afu_mmio_region_init(pdata);
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index 674e9772f0ea..7bef3e300aa2 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -67,7 +67,6 @@ struct dfl_afu_dma_region {
>   * @regions: the mmio region linked list of this afu feature device.
>   * @dma_regions: root of dma regions rb tree.
>   * @num_umsgs: num of umsgs.
> - * @pdata: afu platform device's pdata.
>   */
>  struct dfl_afu {
>  	u64 region_cur_offset;
> @@ -75,8 +74,6 @@ struct dfl_afu {
>  	u8 num_umsgs;
>  	struct list_head regions;
>  	struct rb_root dma_regions;
> -
> -	struct dfl_feature_platform_data *pdata;
>  };
>  
>  /* hold pdata->lock when call __afu_port_enable/disable */
> -- 
> 2.44.0
> 
> 

