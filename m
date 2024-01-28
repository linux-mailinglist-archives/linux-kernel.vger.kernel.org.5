Return-Path: <linux-kernel+bounces-41991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F283FA63
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7DA1F21511
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A1141C7A;
	Sun, 28 Jan 2024 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R28DCYJb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4A341BE;
	Sun, 28 Jan 2024 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481847; cv=none; b=Og6ltZ52fQli6c8c6OXcFZFE6n5ofolLTLiozV/vNOIMHbAy9oXyaSq1tdnVGVCMawgdD3KvWZYYbtIYynCHCFQdcFvF1UaC0TUs3JOwNMZz/bBDurSL8eiaiGS79+BYQHilAmEazRMHd8841DGt7xJldWYmFq/+NieNA/P3FU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481847; c=relaxed/simple;
	bh=ry3Pg0gR7A8dvWHi1I9jwv4x9sME26VfWKPl0cIii1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orirXHZdhrhpamk39Rlf0ymxfMzcxZ3U/8DqZ1zlZ3jJrBZAQbzZVfGwU5YtG/7gvLtdJSbJlv7aLRBp0xPS7vEuS5Rf31dJFXaBLn0yv6VwdfEx8BiEkpFeSmP6crXij+gbmfRCOVW4OoU1q7NJIIz+wSVAbnfe3lgiYL4gFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R28DCYJb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706481845; x=1738017845;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ry3Pg0gR7A8dvWHi1I9jwv4x9sME26VfWKPl0cIii1M=;
  b=R28DCYJbLE+jiHWXkDRiUAOuBAw5ckY/kZirexpAFSEsMQy+wr3jEfRP
   75vB5LNAhWpaFxrQ00kBMFxZ2gRKcq5FUWduRZbbaVwjSX844/ZS6x1iL
   gL2xEGkSsBZt5bc1cxnad8Nl6j3D5Tg3oKmGhgoyOyBY6MYL3qD6GQomy
   KZaKrmyJ+Mu2053hmQRosiXdS2B4eO8hNHl8p9d8g90OAW88KCnH8rIDy
   ULOWSfiSJtMT9KeAOUrwDkmpIRRpTpaP1iDAMsIzFIZaXKQkVKt1iaUEp
   x0uUyxGhR/alScdxxc+/3ZQ7vm6HQNwBCNvl/93fQGJHcmX3mb26l3Tut
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2673821"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="2673821"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 14:44:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="737202916"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="737202916"
Received: from smyint-mobl1.amr.corp.intel.com (HELO [10.212.130.147]) ([10.212.130.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 14:44:03 -0800
Message-ID: <0c396883-6eb7-4ee9-955b-42e365a737cf@linux.intel.com>
Date: Sun, 28 Jan 2024 14:44:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/4] tsm: Map RTMRs to TCG TPM PCRs
Content-Language: en-US
To: Samuel Ortiz <sameo@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Xing, Cedric" <cedric.xing@intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
 linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <20240128212532.2754325-4-sameo@rivosinc.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240128212532.2754325-4-sameo@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/28/24 1:25 PM, Samuel Ortiz wrote:
> Many user space and internal kernel subsystems (e.g. the Linux IMA)
> expect a Root of Trust for Storage (RTS) that allows for extending
> and reading measurement registers that are compatible with the TCG TPM
> PCRs layout, e.g. a TPM. In order to allow those components to
> alternatively use a platform TSM as their RTS, a TVM could map the
> available RTMRs to one or more TCG TPM PCRs. Once configured, those PCR
> to RTMR mappings give the kernel TSM layer all the necessary information
> to be a RTS for e.g. the Linux IMA or any other components that expects
> a TCG compliant TPM PCRs layout.

Why expose the mapping to user space? IMO, the goal should be
to let user space application work without any changes. So we should
try to hide this conversion in kernel and let userspace code to use
PCR as usual.

>
> TPM PCR mappings are statically configured through the TSM provider
> capabilities. A TSM backend defines its number of RTMRs, and for each
> one of them can define a bitmask of TCG TPM PCR it maps to. As they are
> TSM backend specific, those mappings are to some extend architecture
> specific. Each architecture is free to decide and choose how it builds
> it, e.g. by requesting an EFI firmware when it supports the EFI_CC
> protocol.
>
> The tsm-configfs rtmrs/<rtmrN>tcg_map describes these static mappings.
>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> ---
>  Documentation/ABI/testing/configfs-tsm | 14 +++++
>  drivers/virt/coco/tsm.c                | 74 ++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>
> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
> index 590e103a9bcd..5d20a872475e 100644
> --- a/Documentation/ABI/testing/configfs-tsm
> +++ b/Documentation/ABI/testing/configfs-tsm
> @@ -91,3 +91,17 @@ Description:
>                  can be mapped to a hardware RTMR by writing into its index
>                  attribute. The TSM provider will then map the configfs entry to
>                  its corresponding hardware register.
> +
> +What:		/sys/kernel/config/tsm/rtmrs/$name/tcg_map
> +Date:		January, 2024
> +KernelVersion:	v6.8
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) A representation of the architecturally defined mapping
> +		between this RTMR and one or more TCG TPM PCRs [1]. When using
> +		a TSM as Root of Trust for Storage (RTS), TCG TPM PCRs
> +		associated semantics and indexes can be used when RTMRs are
> +		logically mapped to TPM PCRs.
> +
> +		[1]: TCG PC Client Specific Platform Firmware Profile Specification
> +		https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index bb9ed2d2accc..d03cf5173bc9 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -419,6 +419,46 @@ static const struct config_item_type tsm_reports_type = {
>  	.ct_group_ops = &tsm_report_group_ops,
>  };
>  
> +static int tsm_rtmr_build_tcg_map(const struct tsm_provider *tsm,
> +				const struct tsm_rtmr_state *rtmr_state,
> +				u32 rtmr_idx)
> +{
> +	const struct tsm_ops *ops;
> +	unsigned long pcr_mask;
> +	int i;
> +
> +	lockdep_assert_held_write(&tsm_rwsem);
> +
> +	ops = tsm->ops;
> +	if (!ops)
> +		return -ENOTTY;
> +
> +	if (!ops->capabilities.rtmrs)
> +		return -ENXIO;
> +
> +	pcr_mask = ops->capabilities.rtmrs[rtmr_idx].tcg_pcr_mask;
> +
> +	/* Check that the PCR mask is valid  */
> +	for (i = 0; i < TPM2_PLATFORM_PCR; i++) {
> +		if (!(pcr_mask & BIT(i)))
> +			continue;
> +
> +		/* If another RTMR maps to this PCR, the mask is discarded */
> +		if (tsm_rtmrs->tcg_map[i] &&
> +			tsm_rtmrs->tcg_map[i] != rtmr_state)
> +			return -EBUSY;
> +	}
> +
> +	for (i = 0; i < TPM2_PLATFORM_PCR; i++) {
> +		if (!(pcr_mask & BIT(i)))
> +			continue;
> +
> +		tsm_rtmrs->tcg_map[i] = rtmr_state;
> +	}
> +
> +	return 0;
> +}
> +
>  static ssize_t tsm_rtmr_index_store(struct config_item *cfg,
>  				    const char *buf, size_t len)
>  {
> @@ -449,6 +489,10 @@ static ssize_t tsm_rtmr_index_store(struct config_item *cfg,
>  	if (tsm_rtmrs->rtmrs[val])
>  		return -EINVAL;
>  
> +	rc = tsm_rtmr_build_tcg_map(&provider, rtmr_state, val);
> +	if (rc)
> +		return rc;
> +
>  	rtmr_state->index = val;
>  	rtmr_state->alg = ops->capabilities.rtmrs[val].hash_alg;
>  
> @@ -472,8 +516,38 @@ static ssize_t tsm_rtmr_index_show(struct config_item *cfg,
>  }
>  CONFIGFS_ATTR(tsm_rtmr_, index);
>  
> +static ssize_t tsm_rtmr_tcg_map_show(struct config_item *cfg,
> +				     char *buf)
> +{
> +	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
> +	unsigned int nr_pcrs = ARRAY_SIZE(tsm_rtmrs->tcg_map), i;
> +	unsigned long *pcr_mask;
> +	ssize_t len;
> +
> +	/* Build a bitmap mask of all PCRs that this RTMR covers */
> +	pcr_mask = bitmap_zalloc(nr_pcrs, GFP_KERNEL);
> +	if (!pcr_mask)
> +		return -ENOMEM;
> +
> +	guard(rwsem_read)(&tsm_rwsem);
> +	for (i = 0; i < nr_pcrs; i++) {
> +		if (tsm_rtmrs->tcg_map[i] != rtmr_state)
> +			continue;
> +
> +		__set_bit(i, pcr_mask);
> +	}
> +
> +	len = bitmap_print_list_to_buf(buf, pcr_mask, nr_pcrs, 0,
> +				       nr_pcrs * 3 /* 2 ASCII digits and one comma */);
> +	bitmap_free(pcr_mask);
> +
> +	return len;
> +}
> +CONFIGFS_ATTR_RO(tsm_rtmr_, tcg_map);
> +
>  static struct configfs_attribute *tsm_rtmr_attrs[] = {
>  	&tsm_rtmr_attr_index,
> +	&tsm_rtmr_attr_tcg_map,
>  	NULL,
>  };
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


