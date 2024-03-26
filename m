Return-Path: <linux-kernel+bounces-119286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE888C6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF9630760A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802A13C811;
	Tue, 26 Mar 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMk/AkVj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352C13C691
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466226; cv=none; b=fKt51SHb16td17Punys98nZk6zgkn3zZtxCFvO2bfmQa1LvG+x0i7+wL6IJthPuYv+nKylNWCwH4r41mqYUZSScvjnP7lylwC0zwFcFLRdVzTHFLsfCHhWGWktQxgSptneAnuT9eZft3bnI9bjC9BV0wcfIfP/411BeaBxL9OQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466226; c=relaxed/simple;
	bh=ZT1SfWhlLJc5XYrpqY8N3fYap0APdfsWz+VsHuuXOi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCUWs3Vn4EwNu9KW3WHJFWKBQNiWwSNyOvbhCx+eG/WINxV4XwKXvjzOwvvnBgBIMVcVzecp6WYcJTok96cMIaD/QPurLjQwvSL43SpwFmN3b7ebeTAoAuLaM7MKdSsGlZFdw57ObVB6081jOMi0iNuGfzwalLQ5hOkXt2GyJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMk/AkVj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711466225; x=1743002225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZT1SfWhlLJc5XYrpqY8N3fYap0APdfsWz+VsHuuXOi0=;
  b=VMk/AkVjpTfN9dKmNd5UPQYSrZiRCK/UTum5YaJdaax96ajql2K8MkLX
   9V0Z0S543RW3QuaWXgemXsIE09kfI4jkmRp7oq1GJWp3ZuOCVVE/SbTYM
   COc3FapwoXivmAYecu7Krn9Cl/68RkHoV2qBNiNj7uDNdrv/mWRP8ITpn
   JuQnTivnegf2XabUKtzzkcgrw9F7H0IZdAhj9m5Mb1UBDAzTc2Kj2/3L6
   dbvXAPnDyrjcK4SZFwDLuAjBcCC/s8BH7fPdCqCEc6OWAPw8JMpGmiVcN
   sWDvE6q5BOwk7OBM+zfuYOfvWuGyq+3BwpUoc5ChP4yHAJeOvu8JbDOjk
   A==;
X-CSE-ConnectionGUID: 1cB2deImQT2r7slKljzxEQ==
X-CSE-MsgGUID: zoIfyu6ZRgSy4/P+NDhsMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6419082"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6419082"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914883064"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914883064"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:17:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp8Xp-0000000GKv0-46oo;
	Tue, 26 Mar 2024 17:16:57 +0200
Date: Tue, 26 Mar 2024 17:16:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Baojun Xu <baojun.xu@ti.com>, tiwai@suse.de, robh+dt@kernel.org,
	lgirdwood@gmail.com, perex@perex.cz, kevin-lu@ti.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v1 7/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Message-ID: <ZgLm6bIgyTNo-5dy@smile.fi.intel.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
 <20240326010905.2147-7-baojun.xu@ti.com>
 <a95c6ec2-d99a-41b4-add3-6ec5ef6d6830@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a95c6ec2-d99a-41b4-add3-6ec5ef6d6830@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 10:13:06AM -0500, Pierre-Louis Bossart wrote:


..

> memory leaks for each of those goto out;
> 
> You need to use different labels and free-up what was allocated before.

Good point, but better to just use cleanup.h from day 1, it makes this code
shrink even more.

..

> I'll stop the review here.

He-he :-)

-- 
With Best Regards,
Andy Shevchenko



