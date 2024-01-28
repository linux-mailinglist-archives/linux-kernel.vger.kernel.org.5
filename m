Return-Path: <linux-kernel+bounces-41989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD3683FA5F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD552837F2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3441C95;
	Sun, 28 Jan 2024 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgJ/eoZA"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D43C490;
	Sun, 28 Jan 2024 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481538; cv=none; b=JeL3t8UN+O9SZMXWi3cYzUB1MpkNdpsFexyz6XBXPbehMvJjvnKSTtAUSN3wJzilKA766OIJRwDLHLsOaFVrqf4QspoMHlBemuCS2GDsbIhO0bcpl2KQRVGecPxwAQhW3Wi6NfJSN13R2jKVzSt8GCXsPmcQ9OgbR8/YM5QDQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481538; c=relaxed/simple;
	bh=GTSrDPm031WIgYitoGY65msQ24Z7pEgy47RUrl7ovzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxJN+8HLT/ZjdZBBDFhqaaUn1Vpjr1+mBy0VAM6F8Z9tvO4qWO1psQyrumVwVcx7I4qrqIHanIUhsrlm0tqsJVLEPLNi8MFl5MgKgZS8wEuZtZR+XcSavGs53H0SZh7RBt2NQ33uAHmTjFUi2RXHHdfTIK7JoW7/XiYG2B5xAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgJ/eoZA; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706481537; x=1738017537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GTSrDPm031WIgYitoGY65msQ24Z7pEgy47RUrl7ovzM=;
  b=HgJ/eoZAfWv7g0MIycpTyXQ1XxUAm/avWyiRJuB0oKrjL5jXU1x9NFFz
   58/k+I7A8pzR7tu1jNIVdzkuoKw9j9CEAe9zKoFOXbWtdz7AeCDuwHxVf
   JyMJe9Y0BvZyvw0XviiAPsAQGYnt0q6Rykq35ctNkhbPwkr3PRQsJXtCW
   gK/BFCsxw9I8pKHl7vY3IkrjbTZkPuC28SjsBk87wFywFYLVyv2VvtDGM
   ncIADl0qtBJb38bY0TKq5W60e399D3/JyMhcNV7c0A4lB7l8lxe3Wyj+f
   2vALp2mnBZD2kd8yKfzzKs1QacYI1/MJfoTBa44y54b8WoQWJaraFtvvx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="433970817"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="433970817"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 14:38:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="29594299"
Received: from smyint-mobl1.amr.corp.intel.com (HELO [10.212.130.147]) ([10.212.130.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 14:38:55 -0800
Message-ID: <15c0d74c-70ea-4b1b-9ebb-66cc464e20eb@linux.intel.com>
Date: Sun, 28 Jan 2024 14:38:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] tsm: Add RTMRs to the configfs-tsm hierarchy
Content-Language: en-US
To: Samuel Ortiz <sameo@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Xing, Cedric" <cedric.xing@intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
 linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <20240128212532.2754325-3-sameo@rivosinc.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240128212532.2754325-3-sameo@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/28/24 1:25 PM, Samuel Ortiz wrote:
> RTMRs are defined and managed by their corresponding TSM provider. As
> such, they can be configured through the TSM configfs root.
>
> An additional `rtmrs` directory is added by default under the `tsm` one,
> where each supported RTMR can be configured:
>
> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
>
> An RTMR can not be extended nor read before its configured by assigning
> it an index. It is the TSM backend responsibility and choice to map that
> index to a hardware RTMR.
>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> ---
>  Documentation/ABI/testing/configfs-tsm |  11 ++
>  drivers/virt/coco/tsm.c                | 164 +++++++++++++++++++++++++
>  2 files changed, 175 insertions(+)
>
> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
> index dd24202b5ba5..590e103a9bcd 100644
> --- a/Documentation/ABI/testing/configfs-tsm
> +++ b/Documentation/ABI/testing/configfs-tsm
> @@ -80,3 +80,14 @@ Contact:	linux-coco@lists.linux.dev
>  Description:
>  		(RO) Indicates the minimum permissible value that can be written
>  		to @privlevel.
> +
> +What:		/sys/kernel/config/tsm/rtmrs/$name/index
> +Date:		January, 2024
> +KernelVersion:	v6.8
v6.9?
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) A Runtime Measurement Register (RTMR) hardware index.
> +                Once created under /sys/kernel/config/tsm/rtmrs/, an RTMR entry
> +                can be mapped to a hardware RTMR by writing into its index
> +                attribute. The TSM provider will then map the configfs entry to
> +                its corresponding hardware register.
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index 1a8c3c096120..bb9ed2d2accc 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -419,6 +419,108 @@ static const struct config_item_type tsm_reports_type = {
>  	.ct_group_ops = &tsm_report_group_ops,
>  };
>  
> +static ssize_t tsm_rtmr_index_store(struct config_item *cfg,
> +				    const char *buf, size_t len)
> +{
> +	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
> +	const struct tsm_ops *ops;
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +
> +	/* Index can only be configured once */
> +	if (is_rtmr_configured(rtmr_state))
> +		return -EBUSY;
> +
> +	/* Check that index stays within the TSM provided capabilities */
> +	ops = provider.ops;
> +	if (!ops)
> +		return -ENOTTY;
> +
> +	if (val > ops->capabilities.num_rtmrs - 1)
> +		return -EINVAL;
> +
> +	/* Check that this index is available */
> +	if (tsm_rtmrs->rtmrs[val])
> +		return -EINVAL;
> +
> +	rtmr_state->index = val;
> +	rtmr_state->alg = ops->capabilities.rtmrs[val].hash_alg;
> +
> +	tsm_rtmrs->rtmrs[val] = rtmr_state;
> +
> +	return len;
> +}
> +
> +static ssize_t tsm_rtmr_index_show(struct config_item *cfg,
> +				   char *buf)
> +{
> +	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
> +
> +	guard(rwsem_read)(&tsm_rwsem);
> +
> +	/* An RTMR is not available if it has not been configured */
> +	if (!is_rtmr_configured(rtmr_state))
> +		return -ENXIO;
> +
> +	return sysfs_emit(buf, "%u\n", rtmr_state->index);
> +}
> +CONFIGFS_ATTR(tsm_rtmr_, index);
> +
> +static struct configfs_attribute *tsm_rtmr_attrs[] = {
> +	&tsm_rtmr_attr_index,
> +	NULL,
> +};
> +
> +static void tsm_rtmr_item_release(struct config_item *cfg)
> +{
> +	struct tsm_rtmr_state *state = to_tsm_rtmr_state(cfg);
> +
> +	kfree(state);

I think you need to clear the index history as well?

> +}
> +
> +static struct configfs_item_operations tsm_rtmr_item_ops = {
> +	.release = tsm_rtmr_item_release,
> +};
> +
> +const struct config_item_type tsm_rtmr_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_attrs = tsm_rtmr_attrs,
> +	.ct_item_ops = &tsm_rtmr_item_ops,
> +};
> +
> +static struct config_item *tsm_rtmrs_make_item(struct config_group *group,
> +					       const char *name)
> +{
> +	struct tsm_rtmr_state *state;
> +
> +	guard(rwsem_read)(&tsm_rwsem);
> +	if (!(provider.ops && (provider.ops->capabilities.num_rtmrs > 0)))
> +		return ERR_PTR(-ENXIO);
> +
> +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +	state->index = U32_MAX;
> +
> +	config_item_init_type_name(&state->cfg, name, &tsm_rtmr_type);
> +	return &state->cfg;
> +}
> +
> +static struct configfs_group_operations tsm_rtmrs_group_ops = {
> +	.make_item = tsm_rtmrs_make_item,
> +};
> +
> +static const struct config_item_type tsm_rtmrs_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_group_ops = &tsm_rtmrs_group_ops,
> +};
> +
>  static const struct config_item_type tsm_root_group_type = {
>  	.ct_owner = THIS_MODULE,
>  };
> @@ -433,10 +535,48 @@ static struct configfs_subsystem tsm_configfs = {
>  	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
>  };
>  
> +static int tsm_rtmr_register(const struct tsm_ops *ops)
> +{
> +	struct config_group *rtmrs_group;
> +
> +	lockdep_assert_held_write(&tsm_rwsem);
> +
> +	if (!ops || !ops->capabilities.num_rtmrs)
> +		return 0;
> +
> +	if (ops->capabilities.num_rtmrs > TSM_MAX_RTMR)
> +		return -EINVAL;
> +
> +	tsm_rtmrs = kzalloc(sizeof(struct tsm_rtmrs_state), GFP_KERNEL);
> +	if (!tsm_rtmrs)
> +		return -ENOMEM;
> +
> +	tsm_rtmrs->rtmrs = kcalloc(ops->capabilities.num_rtmrs,
> +				   sizeof(struct tsm_rtmr_state *),
> +				   GFP_KERNEL);
> +	if (!tsm_rtmrs->rtmrs) {
> +		kfree(tsm_rtmrs);
> +		return -ENOMEM;
> +	}
> +
> +	rtmrs_group = configfs_register_default_group(&tsm_configfs.su_group, "rtmrs",
> +						      &tsm_rtmrs_type);
> +	if (IS_ERR(rtmrs_group)) {
> +		kfree(tsm_rtmrs->rtmrs);
> +		kfree(tsm_rtmrs);
> +		return PTR_ERR(rtmrs_group);
> +	}
> +
> +	tsm_rtmrs->group = rtmrs_group;
> +
> +	return 0;
> +}
> +
>  int tsm_register(const struct tsm_ops *ops, void *priv,
>  		 const struct config_item_type *type)
>  {
>  	const struct tsm_ops *conflict;
> +	int rc;
>  
>  	if (!type)
>  		type = &tsm_report_default_type;
> @@ -450,6 +590,10 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
>  		return -EBUSY;
>  	}
>  
> +	rc = tsm_rtmr_register(ops);
> +	if (rc < 0)
> +		return rc;
> +
>  	provider.ops = ops;
>  	provider.data = priv;
>  	provider.type = type;
> @@ -457,11 +601,31 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
>  }
>  EXPORT_SYMBOL_GPL(tsm_register);
>  
> +static int tsm_rtmr_unregister(const struct tsm_ops *ops)
> +{
> +	lockdep_assert_held_write(&tsm_rwsem);
> +
> +	if ((ops) && (ops->capabilities.num_rtmrs > 0)) {
This check is used in multiple places. May you can add a helper function
for it. is_valid_rtmr()?
> +		configfs_unregister_default_group(tsm_rtmrs->group);
> +		kfree(tsm_rtmrs->rtmrs);
> +		kfree(tsm_rtmrs);
> +	}
> +
> +	return 0;
> +}
> +
>  int tsm_unregister(const struct tsm_ops *ops)
>  {
> +	int rc;
> +
>  	guard(rwsem_write)(&tsm_rwsem);
>  	if (ops != provider.ops)
>  		return -EBUSY;
> +
> +	rc = tsm_rtmr_unregister(ops);
> +	if (rc < 0)
> +		return rc;
> +
>  	provider.ops = NULL;
>  	provider.data = NULL;
>  	provider.type = NULL;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


