Return-Path: <linux-kernel+bounces-136958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2855489DA50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19A11F2164B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D92136E07;
	Tue,  9 Apr 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSnW82yC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8D1369B9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669220; cv=none; b=gUQ4kIyMrma1GLM2gUvwV0R12YNH+pFfaFU7eV4zFDeTNM772+D9SNHwgRil7H+pbR1VNI4UwbkHlXysZwWs8C34/AkJZaBkhW7+fHgYEf3YK62OJlB6oSjnUkkgZuu9i1IQR1w5B4FnTB4UG0mWCHWbq+OvF+vBuJIx1xKuGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669220; c=relaxed/simple;
	bh=bjUWsJGJ49GWkXT/l3XmkoDvoj1OV3m8mUAmjwQeaBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgW/AtrK8c9D6MzuqT0qtRndgsdhajRMKVrsbodKOLNiSzLkPbvIARw2dxRnkLtDmtzyRSyzxrld40SNeciQfxCKp4zXRRzBB2iOtmkQp81xBIfKRqgdYNZYxzG31knvTKVXVF/EAzxMfD5coK55jBS4pM7ny2IxHe3rQQAZBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSnW82yC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712669220; x=1744205220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bjUWsJGJ49GWkXT/l3XmkoDvoj1OV3m8mUAmjwQeaBE=;
  b=cSnW82yCEVr3WPi2kdXLBUaMDLmY2BsH+5tllYzTLAI1oFeBZUS6f0yE
   E8vsMgA9/agsmU59kD9aXI5NNzxvSfIyJWelWCCMSIq3nnPOwPRb5Ep5w
   RvDKCknVbfg7z3dvSg+tP/vY22APoYNie3hZnYRG2MjWtaJ3POKIy+ssB
   7YyYLHKFJF03DqbSMgKFD7LOxzM2hQRidFJcrfjWBkJYlfB7ZYaQdTDpf
   1dhHxFSJzpv8fNui3cfVkUpRp4W9OHt94ny3ReadopETfNfU50Zq0DNzh
   roOj3IFndBfUCTiiJrPQuZjaXw9M5h1Nztsjo+LmDkYS0ZmPVA4jetTB4
   g==;
X-CSE-ConnectionGUID: RhQXhN6dTi+geN4EQyKjaA==
X-CSE-MsgGUID: TjKnJg6ARCmFpMw1ChcqRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11776261"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11776261"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915399802"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915399802"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:26:55 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruBUy-00000002oWi-2L30;
	Tue, 09 Apr 2024 16:26:52 +0300
Date: Tue, 9 Apr 2024 16:26:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	shenghao-ding@ti.com, navada@ti.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v2 3/3] ALSA: hda/tas2781: Firmware load for tas2781
 driver for SPI
Message-ID: <ZhVCHJrjKDVOP5ji@smile.fi.intel.com>
References: <20240409024816.1180-1-baojun.xu@ti.com>
 <20240409024816.1180-4-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409024816.1180-4-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 10:48:15AM +0800, Baojun Xu wrote:
> Firmware download and parser lib for tas2781, it work for spi
> device with a single firmware binary file.

I believe this also can benefit from comments given against previous patches.

..

> +		im = &(calibration->dev_data);

Unneeded parentheses.

> +
> +		if (!im->dev_blks)
> +			continue;
> +
> +		for (blks = 0; blks < im->nr_blk; blks++) {
> +			block = &(im->dev_blks[blks]);
> +			if (!block)
> +				continue;
> +			kfree(block->data);
> +		}
> +		kfree(im->dev_blks);
> +	}
> +	kfree(tas_fmw->calibrations);
> +out:
> +	kfree(tas_fmw);

It may gain if you use cleanup.h from day 1.

> +}
> +
> +void tasdevice_spi_calbin_remove(void *context)
> +{
> +	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *) context;

Casting is not needed.

> +	struct tasdevice *tasdev;

> +	if (!tas_priv)
> +		return;

How is this not a dead code?

> +	tasdev = &(tas_priv->tasdevice);
> +	if (tasdev->cali_data_fmw) {
> +		tas2781_clear_calfirmware(tasdev->cali_data_fmw);
> +		tasdev->cali_data_fmw = NULL;
> +	}
> +}

..

> +void tasdevice_spi_config_info_remove(void *context)
> +{
> +	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *) context;
> +	struct tasdevice_rca *rca = &(tas_priv->rcabin);
> +	struct tasdevice_config_info **ci = rca->cfg_info;
> +	int i, j;
> +
> +	if (!ci)
> +		return;
> +	for (i = 0; i < rca->ncfgs; i++) {
> +		if (!ci[i])
> +			continue;
> +		if (ci[i]->blk_data) {
> +			for (j = 0; j < (int)ci[i]->real_nblocks; j++) {

Oh, explicit castings should be _rarely_ used. What's the problem with making j
to be the same type as real_nblocks?

> +				if (!ci[i]->blk_data[j])
> +					continue;
> +				kfree(ci[i]->blk_data[j]->regdata);
> +				kfree(ci[i]->blk_data[j]);
> +			}
> +			kfree(ci[i]->blk_data);
> +		}
> +		kfree(ci[i]);
> +	}
> +	kfree(ci);
> +}

..

> +	if (cfg_no >= 0
> +		&& (tas_priv->tasdevice.cur_conf != cfg_no)
> +		&& (cfg_info[rca_conf_no]->active_dev & 1)
> +		&& (tas_priv->tasdevice.is_loaderr == false)) {

This is unparsable. Please, use postfix style and proper indentation.

	if (foo &&
	    bar ...) {
		...stuff...;
	}

> +		status++;
> +		tas_priv->tasdevice.is_loading = true;
> +	} else {
> +		tas_priv->tasdevice.is_loading = false;
> +	}

..

> +	if (state == 0) {
> +		if (tas_priv->cur_prog < tas_fmw->nr_programs) {
> +			/*dsp mode or tuning mode*/
> +			profile_cfg_id = tas_priv->rcabin.profile_cfg_id;
> +			tasdevice_spi_select_tuningprm_cfg(tas_priv,
> +				tas_priv->cur_prog, tas_priv->cur_conf,
> +				profile_cfg_id);
> +		}
> +
> +		tasdevice_spi_select_cfg_blk(tas_priv, profile_cfg_id,
> +			TASDEVICE_BIN_BLK_PRE_POWER_UP);
> +	} else
> +		tasdevice_spi_select_cfg_blk(tas_priv, profile_cfg_id,
> +			TASDEVICE_BIN_BLK_PRE_SHUTDOWN);

Out of a sudden different style (no {} in 'else' branch). Try to be consistent
in style everywhere.

-- 
With Best Regards,
Andy Shevchenko



