Return-Path: <linux-kernel+bounces-54732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903D084B2FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46BC1C23818
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE82612880E;
	Tue,  6 Feb 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0qV76Vj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E295B1EA;
	Tue,  6 Feb 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217431; cv=none; b=HfhEogdSMwHsSU2wPS1l468LzjZ4AisacVfT4NNSbn+7Wphrs9vrYtUDpqDT5rkk6OvKQlMoKCT3Vq2tTZ72N0uxwInMt6qZ2JJxz0otIy4iqKqi/hyG+vwM8Q0t0UHkHf+W4dNLKixdVDGlFZp1oqLClA6YzEf1Rweu+woxgmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217431; c=relaxed/simple;
	bh=VDZI9GR+MjScwGlyAoSnr1aqhIicNI9j7CxPC7/DK/s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yuex9Nvz+SKAovnTgC+83SQ8VclWglbJfFZ4Iz6UgZ0wR0mx+CkkVY+RZbe8IfjEqw44fbw/wGmI2A9zKolQ2LLflFZgs7F90TzpvtZrLeDtTD7lNCjRuJOHZRu31T9l8QwHWq7k0Nmb8dinY0sQAUwl4tj8nTa+UdMy/u5aUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0qV76Vj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707217429; x=1738753429;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VDZI9GR+MjScwGlyAoSnr1aqhIicNI9j7CxPC7/DK/s=;
  b=M0qV76VjdTK6B2Ds26LNBdOo0X1yiOjmQus9Rc5CHI6YCs/rJYcSxgcS
   GsOOLwxQfQh/xkmfax53vaWVN30+00DoM4GJmu/WVFnnSxHkkfevhfj0C
   r4rAR1KtUmF0ONWDPVagNQXeaB5u7I2DnDgz91FLruKcx09utFXTNUat3
   9bev5/9NncIw5R/VZ+uIfEDc6jQZYfVi8DuZTkMr5W0KAsNpLKGD9LiBq
   +Knu2I9OSUj+3zX5GFvZ57RMAU2RM+MTeM8HyrFSjynv45vFBTZfrycIn
   mwGbU8IioT0CtroCGLJhd359uBlu/VbImnIFnZ1meSoINWr7tnyjz3sxf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="609591"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="609591"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5590505"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:03:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Feb 2024 13:03:42 +0200 (EET)
To: Vishnu Sankar <vishnuocv@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, vsankar@lenovo.com, 
    Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH] Fix to correct wrong temp reporting on some ThinkPads
In-Reply-To: <20240131180757.35044-1-vishnuocv@gmail.com>
Message-ID: <901e1fb0-1e42-7bf7-113d-3d0bbb62f4da@linux.intel.com>
References: <20240131180757.35044-1-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 1 Feb 2024, Vishnu Sankar wrote:

> Added non-standard thermal register support for some ThinkPads.
> 
> Some of the Thinkpads use a non-standard ECFW which uses different
> thermal register addresses.
> This is a Fix to correct the wrong temperature reporting on
> those systems.
> 
> Tested on Lenovo Thinkpad L13 Yoga Gen2
> 
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 132 ++++++++++++++++++++-------
>  1 file changed, 97 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index c4895e9bc714..a4631196513f 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -6126,12 +6126,15 @@ enum thermal_access_mode {
>  	TPACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
>  	TPACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
>  	TPACPI_THERMAL_TPEC_8,		/* Use ACPI EC regs, 8 sensors */
> +	TPACPI_THERMAL_TPEC_12,		/* Use ACPI EC regs, 12 sensors */
>  	TPACPI_THERMAL_TPEC_16,		/* Use ACPI EC regs, 16 sensors */
>  };
>  
>  enum { /* TPACPI_THERMAL_TPEC_* */
>  	TP_EC_THERMAL_TMP0 = 0x78,	/* ACPI EC regs TMP 0..7 */
>  	TP_EC_THERMAL_TMP8 = 0xC0,	/* ACPI EC regs TMP 8..15 */
> +	TP_EC_THERMAL_TMP0_NS = 0xA8,	/* ACPI EC Non-Standard regs TMP 0..7 */
> +	TP_EC_THERMAL_TMP8_NS = 0xB8,	/* ACPI EC Non-standard regs TMP 8..11 */
>  	TP_EC_FUNCREV      = 0xEF,      /* ACPI EC Functional revision */
>  	TP_EC_THERMAL_TMP_NA = -128,	/* ACPI EC sensor not available */
>  
> @@ -6144,8 +6147,22 @@ struct ibm_thermal_sensors_struct {
>  	s32 temp[TPACPI_MAX_THERMAL_SENSORS];
>  };
>  
> +static const struct tpacpi_quirk thermal_quirk_table[] __initconst = {
> +	/* Non-standard address for thermal registers on some ThinkPads */
> +	TPACPI_Q_LNV3('R', '1', 'F', true),	/* L13 Yoga Gen 2 */
> +	TPACPI_Q_LNV3('N', '2', 'U', true),	/* X13 Yoga Gen 2*/
> +	TPACPI_Q_LNV3('R', '0', 'R', true),	/* L380 */
> +	TPACPI_Q_LNV3('R', '1', '5', true),	/* L13 Yoga Gen 1*/
> +	TPACPI_Q_LNV3('R', '1', '0', true),	/* L390 */
> +	TPACPI_Q_LNV3('N', '2', 'L', true),	/* X13 Yoga Gen 1*/
> +	TPACPI_Q_LNV3('R', '0', 'T', true),	/* 11e Gen5 GL*/
> +	TPACPI_Q_LNV3('R', '1', 'D', true),	/* 11e Gen5 GL-R*/
> +	TPACPI_Q_LNV3('R', '0', 'V', true),	/* 11e Gen5 KL-Y*/
> +};
> +
>  static enum thermal_access_mode thermal_read_mode;
>  static bool thermal_use_labels;
> +static bool thermal_with_ns_address;	/*Non-standard thermal reg address*/
>  
>  /* idx is zero-based */
>  static int thermal_get_sensor(int idx, s32 *value)
> @@ -6154,7 +6171,7 @@ static int thermal_get_sensor(int idx, s32 *value)
>  	s8 tmp;
>  	char tmpi[5];
>  
> -	t = TP_EC_THERMAL_TMP0;
> +	t = thermal_with_ns_address ? TP_EC_THERMAL_TMP0_NS : TP_EC_THERMAL_TMP0;
>  
>  	switch (thermal_read_mode) {
>  #if TPACPI_MAX_THERMAL_SENSORS >= 16
> @@ -6174,6 +6191,21 @@ static int thermal_get_sensor(int idx, s32 *value)
>  		}
>  		break;
>  
> +	/* The Non-standard EC uses 12 Thermal areas */
> +	case TPACPI_THERMAL_TPEC_12:
> +		if (idx <= 11) {
> +			if (idx <= 7) {
> +				if (!acpi_ec_read(TP_EC_THERMAL_TMP0_NS + idx, &tmp))
> +					return -EIO;
> +			} else {
> +				if (!acpi_ec_read(TP_EC_THERMAL_TMP8_NS + (idx - 8), &tmp))
> +					return -EIO;
> +			}
> +			*value = tmp * 1000;
> +			return 0;
> +		}
> +		break;

A code reader would be served much better if this convoluted logic is 
simplied to:

	case TPACPI_THERMAL_TPEC_12:
		if (idx >= 12)
			return -EINVAL;

		if (idx <= 7)
			ec_offset = TP_EC_THERMAL_TMP0_NS + idx;
		else
			ec_offset = TP_EC_THERMAL_TMP8_NS + (idx - 8);

		if (!acpi_ec_read(ec_offset, &tmp))
			return -EIO;

		*value = tmp * 1000;
		return 0;

I know it's different from the pre-existing style but to me this reads 
much better.

> +
>  	case TPACPI_THERMAL_ACPI_UPDT:
>  		if (idx <= 7) {
>  			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
> @@ -6219,6 +6251,8 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
>  
>  	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
>  		n = 16;
> +	else if (thermal_read_mode == TPACPI_THERMAL_TPEC_12)
> +		n = 12;
>  
>  	for (i = 0 ; i < n; i++) {
>  		res = thermal_get_sensor(i, &s->temp[i]);
> @@ -6317,18 +6351,36 @@ static struct attribute *thermal_temp_input_attr[] = {
>  	NULL
>  };
>  
> +#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> +
>  static umode_t thermal_attr_is_visible(struct kobject *kobj,
>  				       struct attribute *attr, int n)
>  {
> -	if (thermal_read_mode == TPACPI_THERMAL_NONE)
> +	struct device_attribute *dev_attr = to_dev_attr(attr);
> +	struct sensor_device_attribute *sensor_attr =
> +					to_sensor_dev_attr(dev_attr);
> +
> +	int idx = sensor_attr->index;
> +
> +	switch (thermal_read_mode) {
> +	case TPACPI_THERMAL_NONE:
>  		return 0;
>  
> -	if (attr == THERMAL_ATTRS(8) || attr == THERMAL_ATTRS(9) ||
> -	    attr == THERMAL_ATTRS(10) || attr == THERMAL_ATTRS(11) ||
> -	    attr == THERMAL_ATTRS(12) || attr == THERMAL_ATTRS(13) ||
> -	    attr == THERMAL_ATTRS(14) || attr == THERMAL_ATTRS(15)) {
> -		if (thermal_read_mode != TPACPI_THERMAL_TPEC_16)
> +	case TPACPI_THERMAL_ACPI_TMP07:
> +	case TPACPI_THERMAL_ACPI_UPDT:
> +	case TPACPI_THERMAL_TPEC_8:
> +		if (idx >= 8)
> +			return 0;
> +		break;
> +
> +	case TPACPI_THERMAL_TPEC_12:
> +		if (idx >= 12)
>  			return 0;
> +		break;
> +
> +	default:
> +		break;
> +
>  	}
>  
>  	return attr->mode;
> @@ -6398,40 +6450,50 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
>  		if (!acpi_ec_read(TP_EC_FUNCREV, &ver))
>  			pr_warn("Thinkpad ACPI EC unable to access EC version\n");
>  
> -		ta1 = ta2 = 0;
> -		for (i = 0; i < 8; i++) {
> -			if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
> -				ta1 |= t;
> -			} else {
> -				ta1 = 0;
> -				break;
> -			}
> -			if (ver < 3) {
> -				if (acpi_ec_read(TP_EC_THERMAL_TMP8 + i, &t)) {
> -					ta2 |= t;
> +		/* Quirks to check non-standard EC */
> +		thermal_with_ns_address = tpacpi_check_quirks(thermal_quirk_table,
> +							ARRAY_SIZE(thermal_quirk_table));
> +
> +		/* Support for Thinkpads with non-standard address */
> +		if (thermal_with_ns_address) {
> +			pr_info("ECFW with non-standard thermal registers found\n");
> +			thermal_read_mode = TPACPI_THERMAL_TPEC_12;
> +		} else {
> +			ta1 = ta2 = 0;
> +			for (i = 0; i < 8; i++) {
> +				if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
> +					ta1 |= t;
>  				} else {
>  					ta1 = 0;
>  					break;
>  				}
> +				if (ver < 3) {
> +					if (acpi_ec_read(TP_EC_THERMAL_TMP8 + i, &t)) {
> +						ta2 |= t;
> +					} else {
> +						ta1 = 0;
> +						break;
> +					}
> +				}
>  			}
> -		}
> -		if (ta1 == 0) {
> -			/* This is sheer paranoia, but we handle it anyway */
> -			if (acpi_tmp7) {
> -				pr_err("ThinkPad ACPI EC access misbehaving, falling back to ACPI TMPx access mode\n");
> -				thermal_read_mode = TPACPI_THERMAL_ACPI_TMP07;
> -			} else {
> -				pr_err("ThinkPad ACPI EC access misbehaving, disabling thermal sensors access\n");
> -				thermal_read_mode = TPACPI_THERMAL_NONE;
> -			}
> -		} else {
> -			if (ver >= 3) {
> -				thermal_read_mode = TPACPI_THERMAL_TPEC_8;
> -				thermal_use_labels = true;
> +			if (ta1 == 0) {
> +				/* This is sheer paranoia, but we handle it anyway */
> +				if (acpi_tmp7) {
> +					pr_err("ThinkPad ACPI EC access misbehaving, falling back to ACPI TMPx access mode\n");
> +					thermal_read_mode = TPACPI_THERMAL_ACPI_TMP07;
> +				} else {
> +					pr_err("ThinkPad ACPI EC access misbehaving, disabling thermal sensors access\n");
> +					thermal_read_mode = TPACPI_THERMAL_NONE;
> +				}
>  			} else {
> -				thermal_read_mode =
> -					(ta2 != 0) ?
> -					TPACPI_THERMAL_TPEC_16 : TPACPI_THERMAL_TPEC_8;
> +				if (ver >= 3) {
> +					thermal_read_mode = TPACPI_THERMAL_TPEC_8;
> +					thermal_use_labels = true;
> +				} else {
> +					thermal_read_mode =
> +						(ta2 != 0) ?
> +						TPACPI_THERMAL_TPEC_16 : TPACPI_THERMAL_TPEC_8;
> +				}

This entire thermal read mode detection should be refactored into 
thermal_detect_read_mode() helper (in a separate patch before this one). 
The helper would mitigate the current runaway indentation problem because 
the helper function can return its decision mid-function so the code after 
that return does not need an else block reducing the indentation level.

>  			}
>  		}
>  	} else if (acpi_tmp7) {
> 

-- 
 i.


