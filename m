Return-Path: <linux-kernel+bounces-58555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01984E7FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27291F2D72D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3438A23769;
	Thu,  8 Feb 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vtq9+HgR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6EB1BF3D;
	Thu,  8 Feb 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418074; cv=none; b=Cbn7to2fOhBJhhfrANast4g1GeO4GvEMxJ9D9Gm7dgrEiDAvndoVEQRJmCKUvh1qi4i8N7PmZz5+letuRerRENN66siFAKGkyux9lqPwQZxzy5fPPMDCd0CcxjhJfNoiW984rIzuqyXs6SGdOauMUFoXuXmwb1bYmMxTa015r+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418074; c=relaxed/simple;
	bh=T3vb+jr3/jxIvGpmzS29XAGMcNYik+deK0DgE3lOQZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JLAczxYZMkU7yg30Ennwqscvd/jrktbz1pwQpbE0Ty3WANC1U5xohZii84z7tAM6OV2yW0oYdirPNP8UakG4pxCucX+k3sNGudQ/ItH7jpsBqQoyY4v3iME+prYSZKsA+7h0un5MYjfeEiPfUINg5TSqJVNC6eVS+DhXwwZcbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vtq9+HgR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418073; x=1738954073;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T3vb+jr3/jxIvGpmzS29XAGMcNYik+deK0DgE3lOQZk=;
  b=Vtq9+HgRFTM4NlluOYhWP5irbpXExkQcscEVumILyDybfgPRNv32plDS
   a00D4ODbBp+6VECBBd8Oz8U1rO2Un9iGg2TNDbl2RJGg5nqM6LTbQvFmA
   MgiU3hQ6t52ap8kTK3fTRRFY+nh0XaPTEik/C9h0mJvoFRJ9TkYH0fopE
   oqQhWzaVpvbWjp1rcJVRmUGZD8lKQFz6AgASnrf+nWqaYMmqSMHCkNf/I
   YZXc9zg5gY1LcDx6wecf3nctzzHrYgL3Jhcch5syb3aaiXA5Vili4iwBq
   b3JPNVEnm5XbeEObSSxxztirMIHYrv6DwlUibEqs1pxxTrN0wJ4n/yiar
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1178989"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1178989"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:47:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910468884"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910468884"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:47:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY9Qq-00000002xOK-1Q3A;
	Thu, 08 Feb 2024 20:47:32 +0200
Date: Thu, 8 Feb 2024 20:47:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	robh+dt@kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 1/5] iio: adc: ad7192: Use device api
Message-ID: <ZcUhxCSPMhclLu-j@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Subject should be:

  iio: adc: ad7192: Use device property APIs

On Thu, Feb 08, 2024 at 07:24:55PM +0200, Alisa-Dariana Roman wrote:
> Replace of.h and corresponding functions with preferred device specific
> functions.
> 
> Also replace of_device_get_match_data() with
> spi_get_device_match_data().

..

>  #include <linux/err.h>
>  #include <linux/sched.h>
>  #include <linux/delay.h>
> -#include <linux/of.h>

Actually this has to be replaced by property.h (placed somewhere before
slab.h).

-- 
With Best Regards,
Andy Shevchenko



