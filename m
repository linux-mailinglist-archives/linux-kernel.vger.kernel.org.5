Return-Path: <linux-kernel+bounces-126576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB99F8939C8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600A01F21EDD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588B410A25;
	Mon,  1 Apr 2024 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPolHro1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3313101C5;
	Mon,  1 Apr 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965084; cv=none; b=jvV1Fzv8pG3P5d0hTZP192ds7a1feN7GqKJE3JiOZ1t+Q94Z5QJ1Z/Iwecqfy6eNssDzROb5OfS4jRDR97xiAuzToMCdp7M3tm8LJIle8yeTCwAUgjTuJ1N38lO3Uk9kFf2+7n7lNvbhN6gdfNuEQECC7RGOdScWpHv8eBYQIyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965084; c=relaxed/simple;
	bh=dws3mIL2bvlkyMP7eYP2wFCJCVIJfmJmMM9Iw67z8U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX2/KbL+5cI1xLG5nXFXE9s19sEPez6DW79OZUDRbgaRnCEdKiTlsNtAhA7LyBhY8dsjOqQutL7nUd0CK8HR62YdvEQDRKAr8lKSP5ZpdKdsgdfpnmyNJx7eYOG75Z51gt3fYc53mBjpvXkkEWxYizcQVjeO6uEsExWt1+rwP20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPolHro1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711965083; x=1743501083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dws3mIL2bvlkyMP7eYP2wFCJCVIJfmJmMM9Iw67z8U4=;
  b=LPolHro1Xe9fG52mdLE7vJq8B5XsWkQuK9233p4PJxAYc4A3NeaaUBbh
   Sn6d0cU5SUSQtBH36dh2pPVBrOEjkndrxgBW+nqR3Ve0CyU3Kt26ii6l1
   YDwF0ZLFuau9RYWVzr4uf0cvCJVnIWYrLudbOTUN4CuoXaBHQUZJ80GLu
   v4f82NW585y55RAFabBWzabvdtMU4G06zkHrKkWJWUFoB6KRLaPBAjyyt
   O04bXDr85tdY+i+qRaXmh6y6s52LW7x3X1stq0UV4bZrOTcTyZd0nR23w
   X5DaAMhZeFINCJTyejRyt+WqA+HwuraDBbQGqFlzyPjSkfwYQ2Ruthmit
   g==;
X-CSE-ConnectionGUID: MBxt0t4vQh2C2ObzNRgW4Q==
X-CSE-MsgGUID: RVaEiLyYQOKZegxpSjds7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="18527608"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="18527608"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 02:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="40829570"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 01 Apr 2024 02:51:18 -0700
Date: Mon, 1 Apr 2024 17:46:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Lee Jones <lee@kernel.org>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH] mfd: intel-m10-bmc: Change staging size to a variable
Message-ID: <ZgqCdfCSatazEkIj@yilunxu-OptiPlex-7050>
References: <20240328233559.6949-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328233559.6949-1-peter.colberg@intel.com>

On Thu, Mar 28, 2024 at 07:35:59PM -0400, Peter Colberg wrote:
> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> The size of the staging area in FLASH for FPGA updates is dependent on the
> size of the FPGA. Currently, the staging size is defined as a constant.
> Larger FPGAs are coming soon and it will soon be necessary to support

Soon? When? You cannot add some feature without a user case. If you do
have a use case, put the patch in the same patchset.

Thanks,
Yilun

> different sizes for the staging area. Add a new staging_size member to the
> csr_map structure to support a variable staging size.
> 
> The secure update driver does a sanity-check of the image size in
> comparison to the size of the staging area in FLASH. Change the
> staging size reference to a variable instead of a constant in order
> to more readily support future, larger FPGAs.
> 
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
>  drivers/mfd/intel-m10-bmc-pmci.c        | 1 +
>  drivers/mfd/intel-m10-bmc-spi.c         | 1 +
>  include/linux/mfd/intel-m10-bmc.h       | 1 +
>  4 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 89851b133709..7ac9f9f5af12 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -529,11 +529,12 @@ static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
>  					     const u8 *data, u32 size)
>  {
>  	struct m10bmc_sec *sec = fwl->dd_handle;
> +	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
>  	u32 ret;
>  
>  	sec->cancel_request = false;
>  
> -	if (!size || size > M10BMC_STAGING_SIZE)
> +	if (!size || size > csr_map->staging_size)
>  		return FW_UPLOAD_ERR_INVALID_SIZE;
>  
>  	if (sec->m10bmc->flash_bulk_ops)
> diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
> index 0392ef8b57d8..698c5933938b 100644
> --- a/drivers/mfd/intel-m10-bmc-pmci.c
> +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> @@ -370,6 +370,7 @@ static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
>  	.pr_reh_addr = M10BMC_N6000_PR_REH_ADDR,
>  	.pr_magic = M10BMC_N6000_PR_PROG_MAGIC,
>  	.rsu_update_counter = M10BMC_N6000_STAGING_FLASH_COUNT,
> +	.staging_size = M10BMC_STAGING_SIZE,
>  };
>  
>  static const struct intel_m10bmc_platform_info m10bmc_pmci_n6000 = {
> diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> index cbeb7de9e041..d64d28199df6 100644
> --- a/drivers/mfd/intel-m10-bmc-spi.c
> +++ b/drivers/mfd/intel-m10-bmc-spi.c
> @@ -109,6 +109,7 @@ static const struct m10bmc_csr_map m10bmc_n3000_csr_map = {
>  	.pr_reh_addr = M10BMC_N3000_PR_REH_ADDR,
>  	.pr_magic = M10BMC_N3000_PR_PROG_MAGIC,
>  	.rsu_update_counter = M10BMC_N3000_STAGING_FLASH_COUNT,
> +	.staging_size = M10BMC_STAGING_SIZE,
>  };
>  
>  static struct mfd_cell m10bmc_d5005_subdevs[] = {
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index ee66c9751003..988f1cd90032 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -205,6 +205,7 @@ struct m10bmc_csr_map {
>  	unsigned int pr_reh_addr;
>  	unsigned int pr_magic;
>  	unsigned int rsu_update_counter;
> +	unsigned int staging_size;
>  };
>  
>  /**
> -- 
> 2.44.0
> 
> 

