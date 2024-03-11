Return-Path: <linux-kernel+bounces-99130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F18783C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CE31F21583
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A705D53390;
	Mon, 11 Mar 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUpYZYb+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6C53E14
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170708; cv=none; b=B8mnV73+M/SInpedOfEbT9QWcRqNQjwEAoTvp91ceSF86o0H0y+W38kwv9gU6yG5vjc4+sv6Ch3jdkGMX6tq1QyHST3wohxAYlctQGcgo+NjOe2JiDydF7D+noO/2WitImtvuAMek3jXqHRjWloV9KJ/SpwzAO2GEPMDmnGpFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170708; c=relaxed/simple;
	bh=PE1Bf4VbdQgAuWtq0+E7lFlpiUpbWAvzt5gpUklHuFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6r3fWga4Q+rjaWn81DLgGi1bl6ydZhgi4TGCB9h1cbA9bp32n1orbQNJdNnW7BkOwCso3Lm8LEvo2pdVWk43qOLVRM/VdCT3n32fenKK2UpzyE8yX7eInj46FmkXdhT8wic7Rd4Y7+5UOufee6NTCwe8bt1uTVJtX8bO7owstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUpYZYb+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710170707; x=1741706707;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PE1Bf4VbdQgAuWtq0+E7lFlpiUpbWAvzt5gpUklHuFw=;
  b=hUpYZYb+DeYhgeZqsPdKV/+J14n4+80ont388TgVigTYtCwvskBDT9hO
   2NGOIT8pR2PU+Rat+4s4cQqcwfa/lVbRasOpYTiSqziNhxIufWty3hhRi
   FYwJ4lkN42g+Q3+mOLSbnlzCXNPvucxaVlK+a/rdBrgwwClgE9mAqHwxt
   xfLtj3ZnSoT/MxmgsoVf6yQB4X5VUCpT1UurktXyF1fg4Tigc3l7I/t8q
   TBFOJpl3SRwtGQxHYFsY/l5EF4WFFif4owubXlyVcwMvJxGfVyJ/RlcxG
   RaBK5cBofhiteQObzcea9RJAhQy3TthTxovY697+9ewhs8J6Br0K7Gbuo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4953836"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="4953836"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 08:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11782707"
Received: from brianlap-mobl.amr.corp.intel.com (HELO [10.212.126.207]) ([10.212.126.207])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 08:25:05 -0700
Message-ID: <58c91c6d-b828-41fd-9001-a399cc2cab99@linux.intel.com>
Date: Mon, 11 Mar 2024 10:25:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v11] ASoc: tas2783: Add tas2783 codec
 driver
Content-Language: en-US
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
 "broonie@kernel.org" <broonie@kernel.org>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz"
 <perex@perex.cz>, "13916275206@139.com" <13916275206@139.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
 "bard.liao@intel.com" <bard.liao@intel.com>,
 "mengdong.lin@intel.com" <mengdong.lin@intel.com>,
 "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
 "Lu, Kevin" <kevin-lu@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "soyer@irl.hu" <soyer@irl.hu>, "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
 "Navada Kanyana, Mukund" <navada@ti.com>
References: <20240305132646.638-1-shenghao-ding@ti.com>
 <52752743-b4fc-44b3-96d8-21c8cfd2bc3c@linux.intel.com>
 <433f1e2469ec4f33b4c0a06d03775652@ti.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <433f1e2469ec4f33b4c0a06d03775652@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




>>> +			dev_sum == 0) {
>>> +			dev_dbg(tas_dev->dev, "No dev in calibrated data
>> V2.");
>>> +			return;
>>> +		}
>>> +		crc = crc32(~0, cali_data.data, 12 + dev_sum * 24) ^ ~0;
>>> +		if (crc == tmp_val[3 + dev_sum * 6]) {
>>> +			tas2783_apply_calibv2(tas_dev, tmp_val);
>>> +			dev_dbg(tas_dev->dev, "V2: %ptTs", &tmp_val[40]);
>>> +		} else {
>>> +			dev_dbg(tas_dev->dev,
>>> +				"V2: CRC 0x%08x not match 0x%08x\n",
>>> +				crc, tmp_val[41]);
>>> +		}
>>> +	} else {
>>> +		/* Calibrated Data V1 */
>>> +		/* 8 devs * 20 bytes calibrated data/dev + 4 bytes Timestamp
>> */
>>> +		crc = crc32(~0, cali_data.data, 164) ^ ~0;
>>> +		if (crc == tmp_val[41]) {
>>> +			/* Date and time of when calibration was done. */
>>> +			tas2783_apply_calibv1(tas_dev, tmp_val);
>>> +			dev_dbg(tas_dev->dev, "V1: %ptTs", &tmp_val[40]);
>>> +		} else {
>>> +			dev_dbg(tas_dev->dev,
>>> +				"V1: CRC 0x%08x not match 0x%08x\n",
>>> +				crc, tmp_val[41]);
>>> +		}
>>
>> The CRC check should be used to determine if the v1 or v2 should be used.
>> This is really broken IMHO, you could detect the wrong layout then flag that
>> the CRC is bad without even trying the other layout...
> 
> It seemed not easy to add an extra CRC in V1, especially for the old device in the end users.
> As you know, the V1 is stored in raw data. In order to take care of the
> old devices have been already in the end users, the V1 part has to keep here.

I was referreing to the existing CRC at the end...

 * V1:
 *	Calibrated Data of Dev 0(unique_id offset 0) (20 bytes)
 *	Calibrated Data of Dev 1(unique_id offset 1) (20 bytes)
 *	Calibrated Data of Dev 2(unique_id offset 2) (20 bytes)
 *	Calibrated Data of Dev 3(unique_id offset 3) (20 bytes)
 *	Calibrated Data of Dev 4(unique_id offset 4) (20 bytes)
 *	Calibrated Data of Dev 5(unique_id offset 5) (20 bytes)
 *	Calibrated Data of Dev 6(unique_id offset 6) (20 bytes)
 *	Calibrated Data of Dev 7(unique_id offset 7) (20 bytes)
 *	TimeStamp of Calibration (4 bytes)
 *	CRC (4 bytes) <<<< HERE
 *	Reserved (88 bytes)

Presumably the CRC covers all the data above, so you could first check
if the format is V1 or V2 by checking the CRC values, then check the
binary value as confirmation. You're doing the opposite comparison.

>>> +	}
>>> +}
>>> +
>>> +static void tasdevice_dspfw_ready(const struct firmware *fmw,
>>> +	void *context)
>>> +{
>>> +	struct tasdevice_priv *tas_dev =
>>> +		(struct tasdevice_priv *) context;
>>> +	struct tas2783_firmware_node *p;
>>> +	struct regmap *map = tas_dev->regmap;
>>> +	unsigned char *buf = NULL;
>>> +	int offset = 0, img_sz;
>>> +	int ret;
>>> +
>>> +	if (!fmw || !fmw->data) {
>>> +		dev_warn(tas_dev->dev,
>>> +			"%s: failed to read %s: work in bypass-dsp mode.\n",
>>> +			__func__, tas_dev->dspfw_binaryname);
>>> +		return;
>>> +	}
>>> +	buf = (unsigned char *)fmw->data;
>>> +
>>> +	img_sz = get_unaligned_le32(&buf[offset]);
>>> +	offset  += sizeof(img_sz);
>>> +	if (img_sz != fmw->size) {
>>> +		dev_warn(tas_dev->dev, "%s: size not matching, %d %u.",
>>> +			__func__, (int)fmw->size, img_sz);
>>> +		return;
>>> +	}
>>> +
>>> +	while (offset < img_sz) {
>>> +		p = (struct tas2783_firmware_node *)(buf + offset);
>>> +		if (p->length > 1) {
>>> +			ret = regmap_bulk_write(map, p->download_addr,
>>> +			buf + offset + sizeof(unsigned int) * 5, p->length);
>>> +		} else {
>>> +			ret = regmap_write(map, p->download_addr,
>>> +				*(buf + offset + sizeof(unsigned int) * 5));
>>> +		}
>>> +
>>> +		if (ret != 0) {
>>> +			dev_dbg(tas_dev->dev,
>>> +				"%s: load FW fail: %d, work in bypass.\n",
>>> +				__func__, ret);
>>> +			return;
>>> +		}
>>> +		offset += sizeof(unsigned int) * 5 + p->length;

>>> +		} else {
>>> +			/* Capture stream is the echo ref data for voice.
>>> +			 * Without playback, it can't be active.
>>
>> That makes case for [1] above.
>>
>> I also don't get the concept of 'active'. Even when the playback is muted, you
>> do want to provide a reference stream, don't you?
> When playback is muted, it will turn off echo ref.

What does 'turn off' mean?

This could be
a) the echo reference is made of zero-value samples but is transmitted
on the link
b) the echo reference is no longer transmitted and the stream is
disabled with a bank switch.

>>
>> Also don't we have a potential race condition, you set the 'pstream'
>> status for the playback but use it for capture. What tells you that this cannot
>> be executed concurrently?
> Capture in tas2783 can be unmute during playback is unmute.
> No playback, no capture.

I can't follow your answer.

What I was asking is whether we can have a case where tas_dev->pstream
can be tested while it's being set by another thread.

>>> +			 */
>>> +			if (tas_dev->pstream == true) {
>>> +				ret = regmap_update_bits(map,
>>> +					TAS2873_REG_PWR_CTRL,
>>> +					TAS2783_REG_AEF_MASK,
>>> +					TAS2783_REG_AEF_ACTIVE);
>>> +				if (ret) {
>>> +					dev_err(tas_dev->dev,
>>> +						"%s: AEF enable failed.\n",
>>> +						__func__);
>>> +					goto out;
>>> +				}
>>> +			} else {
>>> +				dev_err(tas_dev->dev,
>>> +					"%s: No playback, no AEF!",
>> __func__);
>>> +				ret = -EINVAL;
>>> +			}
>>> +		}
>>> +	}
>>> +out:
>>> +	if (ret)
>>> +		dev_err(tas_dev->dev, "Mute or unmute %d failed %d.\n",
>>> +			mute, ret);
>>> +
>>> +	return ret;
>>> +}
> 

