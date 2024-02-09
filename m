Return-Path: <linux-kernel+bounces-59507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1CF84F827
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E050B1F248E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445496DD1E;
	Fri,  9 Feb 2024 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQz4OuUE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734C2E3F9;
	Fri,  9 Feb 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491309; cv=none; b=a9WedBYxK14w11VU2pphpKgWu6pGnNvrrqSWNmHXWcYpacpKWG36s8uZ2CT7EpL+13g5ZYNZ/d+3zHCird3ni6qnE53CRhU1Aal4VOEdO9hNkH5koYqif/d3rBYhI16qJa2bkXds+ubmA646CIxAl3w+cB7C9VT4Jx32JJOFY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491309; c=relaxed/simple;
	bh=V6+AuvQ1+rkbReYjLH11hrXtd4MOrnvsLrprkOOCzZo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RPi/N8zYZ0S2ocKPHywrzGc32wDwj0Zhd5TTLMLFwhXGmzBfOL3ZeIEfurfQAcrh9yVxhhqaJSibELGxj6LG8eDDtTOixHPUK20ZZfo6nF2Atxjl7fEa88MBZJ5mw4JWGmcErIhy4qUh8zQ6YSbyWEtwulqs/NSBFiRjprI+7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQz4OuUE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707491308; x=1739027308;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=V6+AuvQ1+rkbReYjLH11hrXtd4MOrnvsLrprkOOCzZo=;
  b=iQz4OuUEZvC/pS3G5NW4GMV4Sa1Bc6BAW4wNH7J+k5Pj1XnTAMZRKX+0
   ng8artmOKR+51VHvUa9gDhGIn8w+Nafu4r34e/vNo9vaE7OyhIcyumrn0
   yjVb/4di1Ve+Pucx2sGsyS2/6xLTowJ4hjaX/P/rq+9sqOsfHbKW59aPo
   s77c8GtYXAXnmafJGCEDVwt+n09MarMjcfFu9sAz+/zpHPvzD4N6EcNIu
   E/PObrh5/mJx2I78UmfYeTy/RLG8WAAQL2xvNeo6E8crOUNCgmhIWiXM9
   Pbuu3S09Ua001HDOiTvbc7uIZr3HGstEQ8MDeHJxzWWoMOLMsWnaOVOB2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1595708"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1595708"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1956572"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.226])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:08:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Feb 2024 17:08:20 +0200 (EET)
To: Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Fix signed/unsigned
 mix-up
In-Reply-To: <366b8fc6f5d77c01f9e0e2ad25627df583729017.1707466888.git.shravankr@nvidia.com>
Message-ID: <54ff990c-00a8-1854-02c6-e22b088fa3e7@linux.intel.com>
References: <cover.1707466888.git.shravankr@nvidia.com> <366b8fc6f5d77c01f9e0e2ad25627df583729017.1707466888.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Feb 2024, Shravan Kumar Ramani wrote:

> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 110 ++++++++++++++------------
>  1 file changed, 58 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 71d919832e2a..e3f1ae772e43 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -99,8 +99,8 @@
>   */
>  struct mlxbf_pmc_attribute {
>  	struct device_attribute dev_attr;
> -	int index;
> -	int nr;
> +	unsigned int index;
> +	unsigned int nr;
>  };
>  
>  /**
> @@ -121,7 +121,7 @@ struct mlxbf_pmc_block_info {
>  	void __iomem *mmio_base;
>  	size_t blk_size;
>  	size_t counters;
> -	int type;
> +	unsigned int type;
>  	struct mlxbf_pmc_attribute *attr_counter;
>  	struct mlxbf_pmc_attribute *attr_event;
>  	struct mlxbf_pmc_attribute attr_event_list;
> @@ -169,7 +169,7 @@ struct mlxbf_pmc_context {
>   * @evt_name: Name of the event
>   */
>  struct mlxbf_pmc_events {
> -	int evt_num;
> +	u32 evt_num;
>  	char *evt_name;
>  };
>  
> @@ -959,7 +959,7 @@ static int mlxbf_pmc_write(void __iomem *addr, int command, u64 value)
>  }
>  
>  /* Check if the register offset is within the mapped region for the block */
> -static bool mlxbf_pmc_valid_range(int blk_num, u32 offset)
> +static bool mlxbf_pmc_valid_range(unsigned int blk_num, u32 offset)
>  {
>  	if ((offset >= 0) && !(offset % MLXBF_PMC_REG_SIZE) &&
>  	    (offset + MLXBF_PMC_REG_SIZE <= pmc->block[blk_num].blk_size))
> @@ -970,7 +970,7 @@ static bool mlxbf_pmc_valid_range(int blk_num, u32 offset)
>  
>  /* Get the event list corresponding to a certain block */
>  static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk,
> -							   int *size)
> +							   unsigned int *size)

Usually size_t is the type that is preferred for sizes of memory blocks 
(including this case where it's array size that is just memory block 
size divided by another).

-- 
 i.


