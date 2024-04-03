Return-Path: <linux-kernel+bounces-129489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1A2896B88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3992428F23A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3A135417;
	Wed,  3 Apr 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGWrFOWb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E60137903
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138699; cv=none; b=iwdl/WG8DNFIkla4Xxl3PC8+H4HbLwiyjprtPcm+onMCxQwMgnn2C9AdHxOaQsccv9NuFBga0aMOCDzgb2I1wVACDzoeZGHWZLVdnnaK6CfB18sCBjTUfyvcKHIje2fWyqgTBzTp725VhiUMNeSDqpE5TQEes+mVd0muSzz9z+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138699; c=relaxed/simple;
	bh=Y7WN2tYAYpmCgOP1gQPKV9jeKqkz0Te+qM3j90UOY1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1kHK9xwcZkQJCxlPECZzz5ohK3m5XiZFX6o6Mzlz+VuYmhR7GJHlb63uQy4U7Nl5LKIdmWf+CwiRLd1glCsShwBh7hY/QD/byEcI2fzSeHOLs7Wsyvfo/4zIeVC2B8Q0RlSQg7LUTZlWPYHMdLIk/3zGWBDeYCRZzwOvixloGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGWrFOWb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712138698; x=1743674698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y7WN2tYAYpmCgOP1gQPKV9jeKqkz0Te+qM3j90UOY1g=;
  b=jGWrFOWbq9GlnbLaZx4a5DmcOSk6PQHsXLWRaz/dDdam/aIXny97YnQ/
   5Q0ObyJMa3jBNIPexv3X9WfEagu5JMm0ksxkAXxcf53bWLFqgfW/Fg4YZ
   f/nmxRnjJo+ZkgRc8Md5IrQ70ba+1j7wlzozkrUHKX4T59W+KDc2TyW9X
   lgpHnocBKGEykY7SxI3xP59TeHYr5aKFDlf0LMnVfp2yXOTOQDGAnyGq9
   5gVhQSQlYUSheeZbdSH3tD2i5WHOigfI3jRAiOrdammMksvfKD6qeqRLb
   pwjVwI/z116hqQP11uE5qFQhyg2AaCGh1tQRNndfCh8Iu9avra1WQ6fBX
   Q==;
X-CSE-ConnectionGUID: akVAuESrQK2VrLTv3ZzFeg==
X-CSE-MsgGUID: BFW7YwQUQwehjv4UNpA3tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7485602"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7485602"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915177205"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915177205"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:04:53 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrxUA-000000015H8-1gdE;
	Wed, 03 Apr 2024 13:04:50 +0300
Date: Wed, 3 Apr 2024 13:04:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com, tiwai@suse.de,
	baojun.xu@ti.com, soyer@irl.hu, Baojun.Xu@fpt.com, navada@ti.com,
	v-po@ti.com
Subject: Re: [PATCH v1] ALSA: hda/tas2781: correct the register for pow
 calibrated data
Message-ID: <Zg0pwtuQ9gfeXwxd@smile.fi.intel.com>
References: <20240402231300.362-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402231300.362-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 07:12:59AM +0800, Shenghao Ding wrote:
> fixed tas2781 calibrated data - pow was written into a wrong register.

fixed --> Fix

Fixes tag?

> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

..

> +		0x17, 0x18, 0x18, 0x13, 0x18
> +		0x74, 0x0c, 0x14, 0x70, 0x7c

While at it, can you add a trailing comma?
It will help in case of extending this in the future.

-- 
With Best Regards,
Andy Shevchenko



