Return-Path: <linux-kernel+bounces-107724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD188800C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9E11C21F87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D827657BA;
	Tue, 19 Mar 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCBrQRex"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C062818
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862529; cv=none; b=WE7gXNmTbOB8c8BFM2Sx+X0Qzm5kcWzi8+quTWoxZkTiuG85NqnrBCEebdUDVGXZSCcxjCP/4IsZLtNZnv3wWHlfYR5Akqlvh9bFf5yNnyc1YVymgoU+1IvZepxSN2kY6SduaGJEoo6mPtfkmHms+jqtHdXpzjLYc/IE6blRjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862529; c=relaxed/simple;
	bh=4jp40Xof18diM6c7MgxIyUriMqgrk7eSdZm+iU5lWEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyDuckEZO5jVoBroXxOjloS2x1yRNX/eRyv0YKfFcK0jLVuQzA3w5FUU7XnuLxLbTHtXQiGW3yzhqwpNjmBFJkb8nuQbL8cxi4LCLuuBxQFHQJqqUZqljOLOyEhor4plGwEN5ncaIEuwK7JMpsvsS3sLsis0EsObE4lYv7XKBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCBrQRex; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710862528; x=1742398528;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4jp40Xof18diM6c7MgxIyUriMqgrk7eSdZm+iU5lWEA=;
  b=UCBrQRexhN0gDB2sKHK2sVbs4i9gJwSWk20Jva/v0sdYix4nG8gzEC0B
   yHQsg3Ygdeymlk/W783lrmSVMbaT5GIscQm8kxD3TlOsewZzzLs9mFviI
   Hiimjmr+pqI8SCcGwi3MZH3e1Rg3eo9ooexWvrnJaSTW4VsXa0UNfJU2p
   n9Dhds1uE0J5+u1HwyKDWKBfI9wrh5oN6hIfhuWpqPQkfg6WkBoZM3v+M
   wiLYYQgVBvvhPvY+YmrcCY9mwpbBjKLR3KTUekYDGns54zSC2nNdylKl2
   BJikzzb8AxRRSq89YAmCHDEk2IyOvvjudtPF0FpuSnmPXmV6jy3tCnjkC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5607712"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5607712"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 08:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="18304219"
Received: from akiruban-mobl.amr.corp.intel.com (HELO [10.213.182.233]) ([10.213.182.233])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 08:35:25 -0700
Message-ID: <34f404cd-a12d-4ffa-9398-72de3be244b3@linux.intel.com>
Date: Tue, 19 Mar 2024 10:35:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] ASoc: tas2783: Add tas2783 codec driver
Content-Language: en-US
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 13916275206@139.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
 bard.liao@intel.com, mengdong.lin@intel.com,
 yung-chuan.liao@linux.intel.com, kevin-lu@ti.com, tiwai@suse.de,
 baojun.xu@ti.com, soyer@irl.hu, Baojun.Xu@fpt.com, navada@ti.com
References: <20240319135811.186-1-shenghao-ding@ti.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240319135811.186-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> +static bool tas2783_readable_register(struct device *dev,
> +	unsigned int reg)
> +{
> +	switch (reg) {
> +	/* Page 0 */
> +	case 0x8000 ... 0x807F:
> +		return true;
> +	default:
> +		return false;

so only the registers in 0x8000..807F are readable. That's the usual
non-SDCA vendor-specific areas ...


> +static const struct regmap_config tasdevice_regmap = {
> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.readable_reg = tas2783_readable_register,
> +	.volatile_reg = tas2783_volatile_register,
> +	.max_register = 0x44ffffff,

... but here you show support for a much larger register set in SDCA space.

I am having a hard-time believing that none of these SDCA registers are
readable?

> +static void tas2783_calibration(struct tasdevice_priv *tas_dev)
> +{
> +	efi_guid_t efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc,
> +			0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
> +	static efi_char16_t efi_name[] = L"CALI_DATA";
> +	struct calibration_data cali_data;
> +	unsigned int *tmp_val;
> +	unsigned int crc;
> +	efi_status_t status;
> +
> +	cali_data.total_sz = 0;
> +
> +	status = efi.get_variable(efi_name, &efi_guid, NULL,
> +		&cali_data.total_sz, NULL);
> +	if (status == EFI_BUFFER_TOO_SMALL
> +		&& cali_data.total_sz < TAS2783_MAX_CALIDATA_SIZE) {
> +		status = efi.get_variable(efi_name, &efi_guid, NULL,
> +			&cali_data.total_sz,
> +			cali_data.data);
> +		dev_dbg(tas_dev->dev, "%s: cali get %lx bytes result:%ld\n",
> +			__func__, cali_data.total_sz, status);
> +	}
> +	if (status != 0) {
> +		/* Failed got calibration data from EFI. */
> +		dev_dbg(tas_dev->dev, "No calibration data in UEFI.");
> +		return;
> +	}
> +
> +	tmp_val = (unsigned int *)cali_data.data;
> +
> +	/* Check Calibrated Data V1 */
> +	crc = crc32(~0, cali_data.data, TAS2783_CALIDATAV1_BYTE_SIZE) ^ ~0;
> +	if (crc == tmp_val[TAS2783_CALIDATAV1_CRC32_INDX]) {
> +		/* Date and time of when calibration was done. */
> +		tas2783_apply_calibv1(tas_dev, tmp_val);
> +		dev_dbg(tas_dev->dev, "V1: %ptTs",

Is this really needed/helpful?

> +			&tmp_val[TAS2783_CALIDATAV1_TIMESTAMP_INDX]);
> +		return;
> +	}
> +
> +	/* Check Calibrated Data V2 */
> +	if (tmp_val[0] == 2783) {
> +		const struct calibdatav2_info calib_info = {
> +			.number_of_devices = tmp_val[1],
> +			.crc32_indx = 3 + tmp_val[1] * 6,
> +			.byt_sz = 12 + tmp_val[1] * 24,
> +			.cali_data = &tmp_val[3]
> +		};
> +
> +		if (calib_info.number_of_devices > TAS2783_MAX_DEV_NUM ||
> +			calib_info.number_of_devices == 0) {
> +			dev_dbg(tas_dev->dev, "No dev in calibrated data V2.");

the log is not aligned with the first condition where you have too many
devices.

It's not clear why it's not an error.

> +			return;
> +		}
> +		crc = crc32(~0, cali_data.data, calib_info.byt_sz)
> +			^ ~0;
> +		if (crc == tmp_val[calib_info.crc32_indx]) {
> +			tas2783_apply_calibv2(tas_dev, &calib_info);
> +			dev_dbg(tas_dev->dev, "V2: %ptTs",

same, is this needed?
> +				&tmp_val[TAS2783_CALIDATAV2_TIMESTAMP_INDX]);
> +		} else {
> +			dev_dbg(tas_dev->dev,
> +				"V2: CRC 0x%08x not match 0x%08x\n",
> +				crc, tmp_val[calib_info.crc32_indx]);

is this not an error?

> +		}
> +	} else {
> +		dev_err(tas_dev->dev, "Non-2783 chip\n");
> +	}
> +}

the error level seem inconsistent and it's not clear why errors are ignored?


