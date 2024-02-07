Return-Path: <linux-kernel+bounces-56773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E729684CEF6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1267F1C20AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71C28062A;
	Wed,  7 Feb 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y56SWPo0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96401E48F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323769; cv=none; b=S/aX34lpqT8BNAjAmQQqfnTI7clfI2QyrEeWz7fuuenHsug1m8sXrXSrT5dRQ9V3OB97ovlskUOhFNzIjVjLU5ReFHRyYNA3LD3JJYRn26lVeVRdwL2pvbhhCBj/6EUWVEVdAYY/GU4+wPQgrSycTtPWN5kNUbJBm06RN611WO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323769; c=relaxed/simple;
	bh=VoywwgjLXTwUOhSbbLxontbmbKuuFTrPOSRwdOlJD3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNUvjMpqLGirmeRNngcs0vw0RebFWvUCvZKw9NQDUNMwl1jb6vSt275BpWJHteru7Fto9nxUGzav1jtVvJVL46k+qoghLhM2NqT1dcvoNtjd5vTR2g8BLxJLb1An6QkoDS9nxCQn21ugkDMgY5zTY9tVHgWd8A0TWL9Rtn5DBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y56SWPo0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707323765; x=1738859765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VoywwgjLXTwUOhSbbLxontbmbKuuFTrPOSRwdOlJD3g=;
  b=Y56SWPo0ZKQCCGz/g+f+LRv5sAgXvUVFTecKv+yqypVVNuEkd25kT+9q
   b5qdfLeUAOal4+t3oV950nLQ7O//+LwZJm4sgOMXPHrjwhN4k1mOYfjhf
   ziXsH8ZmlSP3YCp4mYCLvKEJlpV1M/2RmWjraIrKb0USmZjwhGYq2USMJ
   +3KEfZL9eavUUqgiL1iSn8sJMpHMO1fVbPalSIL/mn1csiitCyUllb+CE
   MYe4eX/ohfh3T2XI9Hlc0Vem+XHOTSZ92IIYCH/SQazkRAfdQd/jWecIz
   uMeaKZjmUGcPihBXuMZ8U0W1tvx1kjPs2/ik+wWaVszNJ52pLwuOvuDtE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12384561"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="12384561"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:36:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="910038493"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="910038493"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:35:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXktw-00000002eqb-1cXu;
	Wed, 07 Feb 2024 18:35:56 +0200
Date: Wed, 7 Feb 2024 18:35:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	bard.liao@intel.com, mengdong.lin@intel.com,
	yung-chuan.liao@linux.intel.com, baojun.xu@ti.com, kevin-lu@ti.com,
	navada@ti.com, tiwai@suse.de, soyer@irl.hu
Subject: Re: [PATCH v7] ASoc: tas2783: Add tas2783 codec driver
Message-ID: <ZcOxbA_plPDqN3YA@smile.fi.intel.com>
References: <20240207054743.1504-1-shenghao-ding@ti.com>
 <ZcOWZlXu1fL_haFU@smile.fi.intel.com>
 <ZcOiCFlqsnyAEgl3@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOiCFlqsnyAEgl3@finisterre.sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 07, 2024 at 03:30:16PM +0000, Mark Brown wrote:
> On Wed, Feb 07, 2024 at 04:40:38PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 07, 2024 at 01:47:42PM +0800, Shenghao Ding wrote:

..

> > > +	.max_register = 0x44ffffff,
> 
> > I'm always wondering how this can work in debugfs when one tries to dump all
> > registers...
> 
> regmap will filter out non-readable registers from what it shows in
> debugfs so sparse regmaps will end up much smaller than they might look.
> The debugfs code also has support for seeking into the output (since
> each register is a fixed size) so we'll only actually render whatever is
> being read in an individual read().

Thanks, good to know.

..


> > > +static const struct dev_pm_ops tas2783_sdca_pm = {
> > > +	SET_SYSTEM_SLEEP_PM_OPS(tas2783_sdca_dev_suspend,
> > > +		tas2783_sdca_dev_resume)
> > > +	SET_RUNTIME_PM_OPS(tas2783_sdca_dev_suspend,
> > > +		tas2783_sdca_dev_resume, NULL)
> > > +};
> 
> > Use new PM macros.
> 
> ...which are?

SYSTEM_SLEEP_PM_OPS()
RUNTIME_PM_OPS()

and pm_ptr() in the .driver.pm assignment.


-- 
With Best Regards,
Andy Shevchenko



