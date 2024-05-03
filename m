Return-Path: <linux-kernel+bounces-167874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB978BB097
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC8A1C2098B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5860E15533F;
	Fri,  3 May 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjUicAQh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B1155310
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752660; cv=none; b=LPyLdIY1Yh5e2Imyb9HHfdr9SsgQ3RmYj3yAOq2m1Jsm1qLScp5KCM6Khjc8XKnIQB/R8xcWQQwAICKxKNjhAxEiqwEAA5kTN4fYrnPRZg9XrJx8XtLhqqU+OnYQPZAVZ1zz3cZt0UoC5pvZ8/I0Xs2EudV7q7n37USxSA/PSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752660; c=relaxed/simple;
	bh=Z5b0CqouN93JJsmB9TzKqVvmhGRgsFIWRgcvB8hrs3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SS1oQqoSVQfRzdQXzZn5nCMsSjKkcpc2oL1+PFPc+uQC0F6D7aoe6Yrc1MoMijG7W1yYcYuwkWgTyeIa8RRuc7rbMe3hJjSAB1tnTAyIBbKTN9aAiaahhecGxskrcFeSJV4iLfiuOhO2QnweGNdDXIH8qvC18YiS2kDxoHNMotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjUicAQh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714752658; x=1746288658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z5b0CqouN93JJsmB9TzKqVvmhGRgsFIWRgcvB8hrs3A=;
  b=fjUicAQhQhqU9EPYzc4sW2im111Cvq03LaWhnJigz9dgTlnSsmkpps//
   FY9dqcyzCs501a+fP2xDTQVb3CLm3aI00yzXpO2Fr3x8Z7EQW2+R0QrSa
   j2Mo0X2ApL5AWgVib8G95yHLTs/2aJvPMwgc6D6CVjhGyMjTJrjxneFNT
   PbycrEDrk50cwBPujcaj7vsSPOOBWhMdtr/xu2Wh694NkotBiVoOAiN3O
   T301Hsz+k4cMbdUMi8YsbtLSDTwxUtEsbNQPqrvc/Sk9Lso+JN6oiKbd2
   bcnxbmJXMGOYmadwUQIVL0vMmCZbQDqiPn6CEmCqx1GAjbeqMKArdfFkj
   A==;
X-CSE-ConnectionGUID: xYeJiTKlQWWOE+HJ7ZKIKw==
X-CSE-MsgGUID: HfLCb7Q0Qw6q2Jw/OpVFtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14383701"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="14383701"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 09:10:57 -0700
X-CSE-ConnectionGUID: Z48Gzqo8Re2XNqqnJ3hTUg==
X-CSE-MsgGUID: B7hFfWUnTGyD/a5oWFEKtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27517165"
Received: from unknown (HELO [10.125.109.193]) ([10.125.109.193])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 09:10:56 -0700
Message-ID: <e3c945b6-910e-451b-8a0f-4b97525f85b4@linux.intel.com>
Date: Fri, 3 May 2024 09:10:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] x86/sev: Take advantage of configfs visibility
 support in TSM
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/24/24 8:58 AM, Tom Lendacky wrote:
> The TSM attestation report support provides multiple configfs attribute
> types (both for standard and binary attributes) to allow for additional
> attributes to be displayed for SNP as compared to TDX. With the ability
> to hide attributes via configfs, consoldate the multiple attribute groups
> into a single standard attribute group and a single binary attribute
> group. Modify the TDX support to hide the attributes that were previously
> "hidden" as a result of registering the selective attribute groups.
>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---


Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/virt/coco/sev-guest/sev-guest.c |  3 +-
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 29 ++++++++-
>  drivers/virt/coco/tsm.c                 | 82 ++++++++++++-------------
>  include/linux/tsm.h                     | 41 ++++++++++---
>  4 files changed, 102 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 2abb51bd034f..ec3d894cfe31 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -23,6 +23,7 @@
>  #include <linux/sockptr.h>
>  #include <linux/cleanup.h>
>  #include <linux/uuid.h>
> +#include <linux/configfs.h>
>  #include <uapi/linux/sev-guest.h>
>  #include <uapi/linux/psp-sev.h>
>  
> @@ -975,7 +976,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>  	/* Set the privlevel_floor attribute based on the vmpck_id */
>  	sev_tsm_ops.privlevel_floor = vmpck_id;
>  
> -	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
> +	ret = tsm_register(&sev_tsm_ops, snp_dev);
>  	if (ret)
>  		goto e_free_cert_data;
>  
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 1253bf76b570..964af57f345c 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -17,6 +17,7 @@
>  #include <linux/delay.h>
>  #include <linux/tsm.h>
>  #include <linux/sizes.h>
> +#include <linux/configfs.h>
>  
>  #include <uapi/linux/tdx-guest.h>
>  
> @@ -249,6 +250,30 @@ static int tdx_report_new(struct tsm_report *report, void *data)
>  	return ret;
>  }
>  
> +static bool tdx_report_attr_visible(struct config_item *item,
> +				    struct configfs_attribute *attr, int n)
> +{
> +	switch (n) {
> +	case TSM_REPORT_GENERATION:
> +	case TSM_REPORT_PROVIDER:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool tdx_report_bin_attr_visible(struct config_item *item,
> +					struct configfs_bin_attribute *attr, int n)
> +{
> +	switch (n) {
> +	case TSM_REPORT_INBLOB:
> +	case TSM_REPORT_OUTBLOB:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
>  {
> @@ -281,6 +306,8 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>  static const struct tsm_ops tdx_tsm_ops = {
>  	.name = KBUILD_MODNAME,
>  	.report_new = tdx_report_new,
> +	.report_attr_visible = tdx_report_attr_visible,
> +	.report_bin_attr_visible = tdx_report_bin_attr_visible,
>  };
>  
>  static int __init tdx_guest_init(void)
> @@ -301,7 +328,7 @@ static int __init tdx_guest_init(void)
>  		goto free_misc;
>  	}
>  
> -	ret = tsm_register(&tdx_tsm_ops, NULL, NULL);
> +	ret = tsm_register(&tdx_tsm_ops, NULL);
>  	if (ret)
>  		goto free_quote;
>  
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index d1c2db83a8ca..dedb4f582630 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -14,7 +14,6 @@
>  
>  static struct tsm_provider {
>  	const struct tsm_ops *ops;
> -	const struct config_item_type *type;
>  	void *data;
>  } provider;
>  static DECLARE_RWSEM(tsm_rwsem);
> @@ -252,34 +251,18 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
>  }
>  CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
>  
> -#define TSM_DEFAULT_ATTRS() \
> -	&tsm_report_attr_generation, \
> -	&tsm_report_attr_provider
> -
>  static struct configfs_attribute *tsm_report_attrs[] = {
> -	TSM_DEFAULT_ATTRS(),
> +	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
> +	[TSM_REPORT_PROVIDER] = &tsm_report_attr_provider,
> +	[TSM_REPORT_PRIVLEVEL] = &tsm_report_attr_privlevel,
> +	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
>  	NULL,
>  };
>  
> -static struct configfs_attribute *tsm_report_extra_attrs[] = {
> -	TSM_DEFAULT_ATTRS(),
> -	&tsm_report_attr_privlevel,
> -	&tsm_report_attr_privlevel_floor,
> -	NULL,
> -};
> -
> -#define TSM_DEFAULT_BIN_ATTRS() \
> -	&tsm_report_attr_inblob, \
> -	&tsm_report_attr_outblob
> -
>  static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
> -	TSM_DEFAULT_BIN_ATTRS(),
> -	NULL,
> -};
> -
> -static struct configfs_bin_attribute *tsm_report_bin_extra_attrs[] = {
> -	TSM_DEFAULT_BIN_ATTRS(),
> -	&tsm_report_attr_auxblob,
> +	[TSM_REPORT_INBLOB] = &tsm_report_attr_inblob,
> +	[TSM_REPORT_OUTBLOB] = &tsm_report_attr_outblob,
> +	[TSM_REPORT_AUXBLOB] = &tsm_report_attr_auxblob,
>  	NULL,
>  };
>  
> @@ -297,21 +280,12 @@ static struct configfs_item_operations tsm_report_item_ops = {
>  	.release = tsm_report_item_release,
>  };
>  
> -const struct config_item_type tsm_report_default_type = {
> +static const struct config_item_type tsm_report_type = {
>  	.ct_owner = THIS_MODULE,
>  	.ct_bin_attrs = tsm_report_bin_attrs,
>  	.ct_attrs = tsm_report_attrs,
>  	.ct_item_ops = &tsm_report_item_ops,
>  };
> -EXPORT_SYMBOL_GPL(tsm_report_default_type);
> -
> -const struct config_item_type tsm_report_extra_type = {
> -	.ct_owner = THIS_MODULE,
> -	.ct_bin_attrs = tsm_report_bin_extra_attrs,
> -	.ct_attrs = tsm_report_extra_attrs,
> -	.ct_item_ops = &tsm_report_item_ops,
> -};
> -EXPORT_SYMBOL_GPL(tsm_report_extra_type);
>  
>  static struct config_item *tsm_report_make_item(struct config_group *group,
>  						const char *name)
> @@ -326,12 +300,40 @@ static struct config_item *tsm_report_make_item(struct config_group *group,
>  	if (!state)
>  		return ERR_PTR(-ENOMEM);
>  
> -	config_item_init_type_name(&state->cfg, name, provider.type);
> +	config_item_init_type_name(&state->cfg, name, &tsm_report_type);
>  	return &state->cfg;
>  }
>  
> +static bool tsm_report_is_visible(struct config_item *item,
> +				  struct configfs_attribute *attr, int n)
> +{
> +	guard(rwsem_read)(&tsm_rwsem);
> +	if (!provider.ops)
> +		return false;
> +
> +	if (!provider.ops->report_attr_visible)
> +		return true;
> +
> +	return provider.ops->report_attr_visible(item, attr, n);
> +}
> +
> +static bool tsm_report_is_bin_visible(struct config_item *item,
> +				      struct configfs_bin_attribute *attr, int n)
> +{
> +	guard(rwsem_read)(&tsm_rwsem);
> +	if (!provider.ops)
> +		return false;
> +
> +	if (!provider.ops->report_bin_attr_visible)
> +		return true;
> +
> +	return provider.ops->report_bin_attr_visible(item, attr, n);
> +}
> +
>  static struct configfs_group_operations tsm_report_group_ops = {
>  	.make_item = tsm_report_make_item,
> +	.is_visible = tsm_report_is_visible,
> +	.is_bin_visible = tsm_report_is_bin_visible,
>  };
>  
>  static const struct config_item_type tsm_reports_type = {
> @@ -353,16 +355,10 @@ static struct configfs_subsystem tsm_configfs = {
>  	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
>  };
>  
> -int tsm_register(const struct tsm_ops *ops, void *priv,
> -		 const struct config_item_type *type)
> +int tsm_register(const struct tsm_ops *ops, void *priv)
>  {
>  	const struct tsm_ops *conflict;
>  
> -	if (!type)
> -		type = &tsm_report_default_type;
> -	if (!(type == &tsm_report_default_type || type == &tsm_report_extra_type))
> -		return -EINVAL;
> -
>  	guard(rwsem_write)(&tsm_rwsem);
>  	conflict = provider.ops;
>  	if (conflict) {
> @@ -372,7 +368,6 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
>  
>  	provider.ops = ops;
>  	provider.data = priv;
> -	provider.type = type;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tsm_register);
> @@ -384,7 +379,6 @@ int tsm_unregister(const struct tsm_ops *ops)
>  		return -EBUSY;
>  	provider.ops = NULL;
>  	provider.data = NULL;
> -	provider.type = NULL;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 50c5769657d8..fa19291a9854 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/sizes.h>
>  #include <linux/types.h>
> +#include <linux/configfs.h>
>  
>  #define TSM_INBLOB_MAX 64
>  #define TSM_OUTBLOB_MAX SZ_32K
> @@ -42,12 +43,40 @@ struct tsm_report {
>  	u8 *auxblob;
>  };
>  
> +/**
> + * enum tsm_attr_index - index used to reference report attributes
> + * @TSM_REPORT_GENERATION: index of the report generation number attribute
> + * @TSM_REPORT_PROVIDER: index of the provider name attribute
> + * @TSM_REPORT_PRIVLEVEL: index of the desired privilege level attribute
> + * @TSM_REPORT_PRIVLEVEL_FLOOR: index of the minimum allowed privileg level attribute
> + */
> +enum tsm_attr_index {
> +	TSM_REPORT_GENERATION,
> +	TSM_REPORT_PROVIDER,
> +	TSM_REPORT_PRIVLEVEL,
> +	TSM_REPORT_PRIVLEVEL_FLOOR,
> +};
> +
> +/**
> + * enum tsm_bin_attr_index - index used to reference binary report attributes
> + * @TSM_REPORT_INBLOB: index of the binary report input attribute
> + * @TSM_REPORT_OUTBLOB: index of the binary report output attribute
> + * @TSM_REPORT_AUXBLOB: index of the binary auxiliary data attribute
> + */
> +enum tsm_bin_attr_index {
> +	TSM_REPORT_INBLOB,
> +	TSM_REPORT_OUTBLOB,
> +	TSM_REPORT_AUXBLOB,
> +};
> +
>  /**
>   * struct tsm_ops - attributes and operations for tsm instances
>   * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
>   * @privlevel_floor: convey base privlevel for nested scenarios
>   * @report_new: Populate @report with the report blob and auxblob
>   * (optional), return 0 on successful population, or -errno otherwise
> + * @report_attr_visible: show or hide a report attribute entry
> + * @report_bin_attr_visible: show or hide a report binary attribute entry
>   *
>   * Implementation specific ops, only one is expected to be registered at
>   * a time i.e. only one of "sev-guest", "tdx-guest", etc.
> @@ -56,14 +85,12 @@ struct tsm_ops {
>  	const char *name;
>  	unsigned int privlevel_floor;
>  	int (*report_new)(struct tsm_report *report, void *data);
> +	bool (*report_attr_visible)(struct config_item *item,
> +				    struct configfs_attribute *attr, int n);
> +	bool (*report_bin_attr_visible)(struct config_item *item,
> +					struct configfs_bin_attribute *attr, int n);
>  };
>  
> -extern const struct config_item_type tsm_report_default_type;
> -
> -/* publish @privlevel, @privlevel_floor, and @auxblob attributes */
> -extern const struct config_item_type tsm_report_extra_type;
> -
> -int tsm_register(const struct tsm_ops *ops, void *priv,
> -		 const struct config_item_type *type);
> +int tsm_register(const struct tsm_ops *ops, void *priv);
>  int tsm_unregister(const struct tsm_ops *ops);
>  #endif /* __TSM_H */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


