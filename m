Return-Path: <linux-kernel+bounces-46200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2A8843C13
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B61C26763
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE8469979;
	Wed, 31 Jan 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqozsgSb"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2069D00;
	Wed, 31 Jan 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696389; cv=none; b=JWPruKJ/3DFhsuCnU3K2lALbB3Iu8/8uW4ZBGKL4WgCpb5+uaSvO7DUweBbNS18GwW2ThyDk5ybbEWqWPSpgosLfcEU6zk6hdyyz7ZKy2xkiR2ulCuFmr7OEu4y0PlWOjN1eBuoi2dp/5D5BrVEs2foHMJNh61bLShhsm1HKd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696389; c=relaxed/simple;
	bh=3oWq+GNr3tgQsR407ZFMHVQBed2EHuNUvnJY/ULjyhs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ksjpzokbowfiX0FhqIpjwMDDlzIGPoedYtaaotndWKqu4DibS7EnlqPNSH72gJlF9ix3l3AXfyHOpzyPx1knF7aHdVrahh6XiD/SIUjtSW1YA6GAnVX38ecIndTOIAC6H96tuPpQbDtruxedLKLfSClrVI8VARE5TcAPw5RwtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqozsgSb; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706696387; x=1738232387;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3oWq+GNr3tgQsR407ZFMHVQBed2EHuNUvnJY/ULjyhs=;
  b=FqozsgSbeknXEXWREdLHU62q7SFih6QKc4fBthSgglAH1u2gOrKvCgDW
   /cdGtzNqQV0a2qsKhyGdBXdJYCIpoTLskoUdRz7nwKTDGKWS6Iw4tams7
   JaLPLrr08oK+1qVlhJWCLaX0ukWktJYU33M9zaz2fHFZDjtulgol4UUsc
   LzUxkXUVUZAdTqjesA7I6A8ryDQHlaEDmepA0HY7l/53YjO1RaGChhKqB
   8jc8K6fKRTTL8zlaZmsa0Fj3OtGCLfKWBsOJzpaZ9fz/3VPdpu7Jgdgwv
   IJc4aZHPrnvrTSAag4QNzeSLt6wVu0fE32l05hUoPo6IIiqo7J7YqVECh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403182529"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="403182529"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822519740"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822519740"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.167])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:19:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 31 Jan 2024 12:19:38 +0200 (EET)
To: Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
In-Reply-To: <4fab3112d17a4bd2edbee66a8e77695943cbaf5a.1706607635.git.shravankr@nvidia.com>
Message-ID: <a28597c7-782a-69a3-90c5-13ef46c8ced1@linux.intel.com>
References: <cover.1706607635.git.shravankr@nvidia.com> <4fab3112d17a4bd2edbee66a8e77695943cbaf5a.1706607635.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Jan 2024, Shravan Kumar Ramani wrote:

> Add support for programming any counter to monitor the cycle count.
> Since counting of cycles using 32-bit ocunters would result in frequent
> wraparounds, add the ability to combine 2 adjacent 32-bit counters to
> form 1 64-bit counter.
> Both these features are supported by BlueField-3 PMC hardware, hence
> the required bit-fields are exposed by the driver via sysfs to allow
> the user to configure as needed.
> 
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 132 ++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index b1995ac268d7..906dfa96f783 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -88,6 +88,8 @@
>  #define MLXBF_PMC_CRSPACE_PERFMON_CTL(n) (n * MLXBF_PMC_CRSPACE_PERFMON_REG0_SZ)
>  #define MLXBF_PMC_CRSPACE_PERFMON_EN BIT(30)
>  #define MLXBF_PMC_CRSPACE_PERFMON_CLR BIT(28)
> +#define MLXBF_PMC_CRSPACE_PERFMON_UOC GENMASK(15, 0)
> +#define MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(n) (MLXBF_PMC_CRSPACE_PERFMON_CTL(n) + 0x4)
>  #define MLXBF_PMC_CRSPACE_PERFMON_VAL0(n) (MLXBF_PMC_CRSPACE_PERFMON_CTL(n) + 0xc)
>  
>  /**
> @@ -114,6 +116,8 @@ struct mlxbf_pmc_attribute {
>   * @attr_event: Attributes for "event" sysfs files
>   * @attr_event_list: Attributes for "event_list" sysfs files
>   * @attr_enable: Attributes for "enable" sysfs files
> + * @attr_use_odd_counter: Attributes for "use_odd_counter" sysfs files
> + * @attr_count_clock: Attributes for "count_clock" sysfs files
>   * @block_attr: All attributes needed for the block
>   * @block_attr_grp: Attribute group for the block
>   */
> @@ -126,6 +130,8 @@ struct mlxbf_pmc_block_info {
>  	struct mlxbf_pmc_attribute *attr_event;
>  	struct mlxbf_pmc_attribute attr_event_list;
>  	struct mlxbf_pmc_attribute attr_enable;
> +	struct mlxbf_pmc_attribute attr_use_odd_counter;
> +	struct mlxbf_pmc_attribute attr_count_clock;
>  	struct attribute *block_attr[MLXBF_PMC_MAX_ATTRS];
>  	struct attribute_group block_attr_grp;
>  };
> @@ -1759,6 +1765,101 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
>  	return count;
>  }
>  
> +/* Show function for "use_odd_counter" sysfs files - only for crspace */
> +static ssize_t mlxbf_pmc_use_odd_counter_show(struct device *dev,
> +					      struct device_attribute *attr, char *buf)
> +{
> +	struct mlxbf_pmc_attribute *attr_use_odd_counter = container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	int blk_num, value;
> +	uint32_t reg;
> +
> +	blk_num = attr_use_odd_counter->nr;
> +
> +	if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> +			MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
> +			&reg))
> +		return -EINVAL;
> +
> +	value = FIELD_GET(MLXBF_PMC_CRSPACE_PERFMON_UOC, reg);

Is this a signed field? If not, don't use int for value and change the %d 
-> %u too.

> +
> +	return sysfs_emit(buf, "%d\n", value);
> +}
> +
> +/* Store function for "use_odd_counter" sysfs files - only for crspace */
> +static ssize_t mlxbf_pmc_use_odd_counter_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t count)
> +{
> +	struct mlxbf_pmc_attribute *attr_use_odd_counter = container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	uint32_t uoc, reg;

uint32_t is not to be used as in-kernel type, use u32 in kernel.

> +	int err, blk_num;
> +
> +	blk_num = attr_use_odd_counter->nr;
> +
> +	err = kstrtoint(buf, 0, &uoc);

Hmm, uoc is unsigned but you use signed variant, kstrtouint() also 
available for you so better to use that.

> +	if (err < 0)
> +		return err;
> +
> +	err = mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> +		MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
> +		&reg);
> +	if (err)
> +		return -EINVAL;
> +
> +	reg &= ~MLXBF_PMC_CRSPACE_PERFMON_UOC;
> +	reg |= FIELD_PREP(MLXBF_PMC_CRSPACE_PERFMON_UOC, uoc);
> +
> +	mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> +		MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
> +		MLXBF_PMC_WRITE_REG_32, reg);
> +
> +	return count;
> +}
> +
> +/* Show function for "count_clock" sysfs files - only for crspace */
> +static ssize_t mlxbf_pmc_count_clock_show(struct device *dev,
> +					  struct device_attribute *attr, char *buf)
> +{
> +	struct mlxbf_pmc_attribute *attr_count_clock = container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	uint32_t reg;

u32

> +	int blk_num;
> +
> +	blk_num = attr_count_clock->nr;
> +
> +	if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> +			MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(pmc->block[blk_num].counters),
> +			&reg))
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%d\n", reg);

Use %u when printing unsigned values.

> +}
> +
> +/* Store function for "count_clock" sysfs files - only for crspace */
> +static ssize_t mlxbf_pmc_count_clock_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	struct mlxbf_pmc_attribute *attr_count_clock = container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	int err, blk_num;
> +	uint32_t reg;

u32

> +
> +	blk_num = attr_count_clock->nr;
> +
> +	err = kstrtoint(buf, 0, &reg);

kstrtouint()

> +	if (err < 0)
> +		return err;
> +
> +	mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> +		MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(pmc->block[blk_num].counters),
> +		MLXBF_PMC_WRITE_REG_32, reg);
> +
> +	return count;
> +}
> +
>  /* Populate attributes for blocks with counters to monitor performance */
>  static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
>  {
> @@ -1792,6 +1893,37 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
>  		attr = NULL;
>  	}
>  
> +	if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE) {
> +		/*
> +		 * Couple adjacent odd and even 32-bit counters to form 64-bit counters
> +		 * using "use_odd_counter" sysfs which has one bit per even counter.
> +		 */
> +		attr = &pmc->block[blk_num].attr_use_odd_counter;
> +		attr->dev_attr.attr.mode = 0644;
> +		attr->dev_attr.show = mlxbf_pmc_use_odd_counter_show;
> +		attr->dev_attr.store = mlxbf_pmc_use_odd_counter_store;
> +		attr->nr = blk_num;
> +		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
> +							  "use_odd_counter");

Why you need alloc for a constant string?

> +		if (!attr->dev_attr.attr.name)
> +			return -ENOMEM;
> +		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
> +		attr = NULL;
> +
> +		/* Program crspace counters to count clock cycles using "count_clock" sysfs */
> +		attr = &pmc->block[blk_num].attr_count_clock;
> +		attr->dev_attr.attr.mode = 0644;
> +		attr->dev_attr.show = mlxbf_pmc_count_clock_show;
> +		attr->dev_attr.store = mlxbf_pmc_count_clock_store;
> +		attr->nr = blk_num;
> +		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
> +							  "count_clock");

Why alloc?

> +		if (!attr->dev_attr.attr.name)
> +			return -ENOMEM;
> +		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
> +		attr = NULL;
> +	}
> +
>  	pmc->block[blk_num].attr_counter = devm_kcalloc(
>  		dev, pmc->block[blk_num].counters,
>  		sizeof(struct mlxbf_pmc_attribute), GFP_KERNEL);
> 

-- 
 i.


