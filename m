Return-Path: <linux-kernel+bounces-146937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3768A6D39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F17A287043
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0246512C7FA;
	Tue, 16 Apr 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uh97x9WI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438112838C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276145; cv=none; b=VOx4yQp0xOC0mN1p6Z0Z92y529wX+MCa2OVYDaWki8yj3bzlQmUx2Y+eBFTkIwYPawlm7zTfXs/HiZVtYSg9SGbvvUCXGSso1UJUDdGbRpxWGf3p9t9qDfRoMwmOnU/nUV7lNYWuaWDbhPWYxMkPyi5VIXwgQ1LIJIzx8DTAFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276145; c=relaxed/simple;
	bh=aq4WULx4oU8PWVFDbyE/q2y5CCkeP+pW40hjR/O5U5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H49sMVkjZLJcNKjRoDJu7tP2OHgrWoOxbr2BtWsG1xhdKSVsVX/MtL0KhOFv3lgt3JRZKhFd6JXQ7S81u1LtMZlUKwUhZLUv89ikCVfDHXSTh5OIZesgO/RNnETqbvjtDlShfARF6bmbm/0SohoejltrEreAo9mXD/6irtx8OzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uh97x9WI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713276141; x=1744812141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aq4WULx4oU8PWVFDbyE/q2y5CCkeP+pW40hjR/O5U5U=;
  b=Uh97x9WIl++ht0zyMbTpQPbvj36eY5TMOV4i/MwDNNfrIfvAwtZNCJt4
   YuH/OZ4me1n830KU1n/pcTJgyGOahYSiXMtVjZIBxS/hNiYjyP+6moK3c
   AS85KTWkxzXjwaRSH3RJ9KgmOvjAg4YPq0yqsO0E+jQduq5HOF1ksa0EL
   L4aC/vXt1FLJBeln9E2z4zab4z34Go+pMKSD4VrH/CrKhY3oLuxiUL/hL
   Vf7Ri28rjUFiAZt7RtJT8OmMtSz7zKw70oqI4K1gu4rGFgmOQ4izt43TT
   Vs60JduCY24xDvVHs5e8QcTdL9GXj2Tu3ZY143xDyftcxsc7ocl7AbRfS
   g==;
X-CSE-ConnectionGUID: zkCGrFwqRt+OfZIlxB58lA==
X-CSE-MsgGUID: 4h46HzEZTKiQ23ntU18uhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="31194925"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="31194925"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:02:20 -0700
X-CSE-ConnectionGUID: icVMWAgLTwW81gHbqyIMKg==
X-CSE-MsgGUID: WApQUCbISDWHDcL4/0VG6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22744751"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:02:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwjO1-00000004iJI-0sDY;
	Tue, 16 Apr 2024 17:02:13 +0300
Date: Tue, 16 Apr 2024 17:02:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"Lu, Kevin" <kevin-lu@ti.com>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"soyer@irl.hu" <soyer@irl.hu>,
	"13916275206@139.com" <13916275206@139.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 1/3] ALSA: hda/tas2781: Modification
 for add tas2781 driver for SPI
Message-ID: <Zh6E5PzTfxawXVbT@smile.fi.intel.com>
References: <20240409024816.1180-1-baojun.xu@ti.com>
 <20240409024816.1180-2-baojun.xu@ti.com>
 <ZhU8fCOLOlu4azGL@smile.fi.intel.com>
 <9287a3c1a2384cacad92652fdd1cac2e@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9287a3c1a2384cacad92652fdd1cac2e@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 07:45:21AM +0000, Xu, Baojun wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: 09 April 2024 21:02
> > On Tue, Apr 09, 2024 at 10: 48: 13AM +0800, Baojun Xu wrote:
> > On Tue, Apr 09, 2024 at 10:48:13AM +0800, Baojun Xu wrote:

..

> > > @@ -39,6 +39,7 @@ snd-hda-scodec-cs35l56-spi-objs :=  cs35l56_hda_spi.o
> > >  snd-hda-cs-dsp-ctls-objs :=          hda_cs_dsp_ctl.o
> > >  snd-hda-scodec-component-objs :=     hda_component.o
> > >  snd-hda-scodec-tas2781-i2c-objs :=   tas2781_hda_i2c.o
> > > +snd-hda-scodec-tas2781-spi-objs :=   tas2781_hda_spi.o tas2781_spi_fwlib.o
> > 
> > Actually these 'objs' has to be 'y', can you fix it in the prerequisite patch?
> 
> Do you mean set CONFIG_SND_HDA_SCODEC_TAS2781_SPI=y in .config?

No. I mean the Kconfig syntax in use. -objs is for user space tools. Kernel
code should use -y in this case.

> It's m now.
> 
> > Also wondering why fwlib is only a requirement for SPI. How does I²C work?
> 
> Because in I2C mode, one probed device driver will support all devices,
> firmware binary is only one file, include all of devices.
> But in SPI mode, multi driver probed, so we use single firmware binary for
> every spi device.

But does I²C version still need the firmware? Can't the FW handling be factored
out to a single module for both?

-- 
With Best Regards,
Andy Shevchenko



