Return-Path: <linux-kernel+bounces-59500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB084F80C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD6B1C212D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B246D1CB;
	Fri,  9 Feb 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Emqn5i7E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A56374CC;
	Fri,  9 Feb 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490808; cv=none; b=f3LTZaAHtIkPdPlvmQVnBzIsf316QTi95uypFMp0DBnjdb65T4KY96nQ12p5v3ZhdvruOXZK2eRC7o6z6TU4wKU3eWuvQ0j+o0WscdIUliK0pS7ZZSNPsJvDVQe/GtSmcUS+aBTukUShmcnI+PxemkKD8gcIfssE3ZLfRpxSPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490808; c=relaxed/simple;
	bh=TKruBJIwFASA/sqJRVaYjjQ7bhehm8QNQf9+1Z6gp7w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gLF1/Nvc7HXITYgCoxwiNzx0mZOFW54xsAuglgW+bvqarevS72jXA/LB7dm+UeRzQYi2XEp6jup227cHOC+iaik4jjQKna41nckofD8Avmiauag/VbAmQzTVP2Lm+z68iBkEd5c2yo0FZQlkFu5LuJFrGAiQcxBa1Dm3JxJ3BXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Emqn5i7E; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707490807; x=1739026807;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TKruBJIwFASA/sqJRVaYjjQ7bhehm8QNQf9+1Z6gp7w=;
  b=Emqn5i7EojHuTvdwdB/Add9+Llx5nFqK2mlyJhWZi3rVcuX7RegdTftf
   WI6IM/YP49y3l8Ehln3AOZBq9p9DV/2DzSKFI9itZHXKkpJnj8/aqx/Tg
   dKu9d8ZeV8dse6U4gZgXsx7dfZUYu/1oT69vjJoAyB7vGw6zFry+n/fSY
   2nCsbSZWK269aDth7/GETsxKscrNxailK6rgOHiA+PE1JiUxKQdaY7OXi
   48wv9rIKTh82HMpZEEMw2Oot6BNQWtDGk+EefqFNFx7U9agRD18LxSUWn
   LUdYH4NIXoL7hrjhaT4QEUqhQM7etB/q7vSR2JxYG/jBSHr2znbwVpGVy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1574488"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1574488"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:00:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1991493"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.226])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:00:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Feb 2024 16:59:59 +0200 (EET)
To: Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] platform/mellanox: mlxbf-pmc: Replace uintN_t
 with kernel-style types
In-Reply-To: <73cd5e838695f8e20b022a523dcade108685350b.1707466888.git.shravankr@nvidia.com>
Message-ID: <6905cf50-3314-2b3c-9bbf-eeb8000f0b54@linux.intel.com>
References: <cover.1707466888.git.shravankr@nvidia.com> <73cd5e838695f8e20b022a523dcade108685350b.1707466888.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Feb 2024, Shravan Kumar Ramani wrote:

Hi,

You need to provice commit description here too. The shortlog on subject 
line is not enough.

> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 121 +++++++++++++-------------
>  1 file changed, 59 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index b1995ac268d7..71d919832e2a 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -149,17 +149,17 @@ struct mlxbf_pmc_block_info {
>   */
>  struct mlxbf_pmc_context {
>  	struct platform_device *pdev;
> -	uint32_t total_blocks;
> -	uint32_t tile_count;
> -	uint8_t llt_enable;
> -	uint8_t mss_enable;
> -	uint32_t group_num;
> +	u32 total_blocks;
> +	u32 tile_count;
> +	u8 llt_enable;
> +	u8 mss_enable;
> +	u32 group_num;
>  	struct device *hwmon_dev;
>  	const char *block_name[MLXBF_PMC_MAX_BLOCKS];
>  	struct mlxbf_pmc_block_info block[MLXBF_PMC_MAX_BLOCKS];
>  	const struct attribute_group *groups[MLXBF_PMC_MAX_BLOCKS];
>  	bool svc_sreg_support;
> -	uint32_t sreg_tbl_perf;
> +	u32 sreg_tbl_perf;
>  	unsigned int event_set;
>  };
>  
> @@ -865,8 +865,8 @@ static struct mlxbf_pmc_context *pmc;
>  static const char *mlxbf_pmc_svc_uuid_str = "89c036b4-e7d7-11e6-8797-001aca00bfc4";
>  
>  /* Calls an SMC to access a performance register */
> -static int mlxbf_pmc_secure_read(void __iomem *addr, uint32_t command,
> -				 uint64_t *result)
> +static int mlxbf_pmc_secure_read(void __iomem *addr, u32 command,
> +				 u64 *result)

Please remove unnecessary newlines too such as this one from the function 
arguments.

Other than those two things, this one looked fine. Thanks for doing this.


-- 
 i.


