Return-Path: <linux-kernel+bounces-161941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2060A8B53A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68241F21CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49ED18C1F;
	Mon, 29 Apr 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXMfz7Gp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316817C8D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381270; cv=none; b=WGNnrcRMxm5vdq9YdTW7BBRYIBetbF+UHDYNKvNWCgiHL99BDQc3RWrOsNDUmRTo8Lc/jDWp4SX/nkvDObQ7vSqj0aiH0o2EarQyuLEjZ0mVd0RMTagCWFsTKm8h4jIS6zytZVTAlEyZGhQyPtpUhd0okKFBzs9+hQHwzRCijrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381270; c=relaxed/simple;
	bh=3bknnk4LrD1mdHceJ8bAPbqx4BAk8TNBu4OWYtRtEm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA6DF2+R48vcGFINbGxTAchG9qOC+O0rDDl0bIDC/F3su8f1whHpoEzfd0mm21EEIC29qea/ZiAhP2lUukjSzJZWlH0mVKjA69qKBf6SBNPSOPCh0Ua4o9X+XE4gUN5TORh8cC8ERkL9O9/WBXmlwY7V2O/7YOjf54AXJ+mQ48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXMfz7Gp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714381268; x=1745917268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3bknnk4LrD1mdHceJ8bAPbqx4BAk8TNBu4OWYtRtEm4=;
  b=RXMfz7Gp3T8pDX8LwshNnD8mSD45Ax5+TqSMNo59WqQUIKGohxxetU7B
   OpSvsaYwPVSbbI1eh9UpSgDZgIZQ5OURHNjcxj+JlEVOfDp0SzLgTviE0
   Dfym8+9ppuRgxWKq5GkU5lID8w3Mev9YlfwCObTr1Rxmpsz4zkXR2OllK
   oG6bI2SLGWY6mlvDgseq9iYMHzoKodTNI7S01x6XnF38YQHmXt2yLyISS
   jLqvVsS9HN1e8Uxh7X5fBcwjwq6j/GdYY3UbWjmApRLI9VLoPA/Qj1mL0
   P0Mp3Qgy9McWXkr0+zIZ3mKRDgZ75dcG1x1pPOGm9neRhiSstbzXSPIk5
   A==;
X-CSE-ConnectionGUID: TaG4o7LJQpuKBQfCl7FasQ==
X-CSE-MsgGUID: xLRWOd8fQmebXpirhCvLbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10251249"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10251249"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:01:03 -0700
X-CSE-ConnectionGUID: Rn3Odvd/Swuy90tipAcstw==
X-CSE-MsgGUID: ZPwZp9eTQ5CR4MBbzdxKKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="49266888"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:00:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1MsB-00000002GOa-0QRQ;
	Mon, 29 Apr 2024 12:00:31 +0300
Date: Mon, 29 Apr 2024 12:00:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	mimperial@lenovo.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	bard.liao@intel.com, yung-chuan.liao@linux.intel.com,
	kevin-lu@ti.com, cameron.berkenpas@gmail.com, tiwai@suse.de,
	baojun.xu@ti.com, soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v1] ALSA: ASoc/tas2781: fixed wrong loading calibrated
 data sequence
Message-ID: <Zi9hrs3G3i4dNtro@smile.fi.intel.com>
References: <20240427052858.265-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427052858.265-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Apr 27, 2024 at 01:28:57PM +0800, Shenghao Ding wrote:

In the Subject:  fixed --> Fix

> Calibrated data will be set to default after loading dsp config params,

DSP

> which will cause speaker protection work abnormally. Reload calibrated
> data after loading dsp config params.

DSP

..

> -// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
> +// Copyright (C) 2022 - 2024 Texas Instruments Incorporated

> -// Copyright 2023 Texas Instruments, Inc.
> +// Copyright 2023 - 2024 Texas Instruments, Inc.

Seems unrelated changes, but harmless.

..

> +						load_calib_data(tas_priv,
> +							&(cal->dev_data));

Why do you need parentheses for & (dereference) operator?

-- 
With Best Regards,
Andy Shevchenko



