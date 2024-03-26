Return-Path: <linux-kernel+bounces-119257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA188C639
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF1E0B21F56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AE913C81E;
	Tue, 26 Mar 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnWfzzmV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346B13C813
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465429; cv=none; b=FtVN/k8Y8+nvfc5pvNgEpFjYjkiykWgn8WaHlFJvOuxr2vWSzRIAo3ZZw/ZRJeZ4MskMfQ5oJP9YK0M1Nt1Phu8KnqnkOVwMANSJEKa+6kqPRxdlzm0/dLKeyUew2BO9uMRws95iPBpsDcQiscTdP0zBnDbGIM1NqwG2T/n4wJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465429; c=relaxed/simple;
	bh=salEnXficVUZmNY6rXQXrXxSmht6F3pTk6zHx4Io0ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZirNuSPa24qFDiOJm2Wr+foZQ79w1f9hHfSIQynXSbhje1v2YiDol1Cenojsw6fX0gk3AE1jvqEk3AbBglXDaBZ8QAAhIQ03AsKtWC23kbPxQyHTYHZEB3Qr+xELTW96ECnhQUfOKYl8IIzPvdZjKgdDmP5dPU4u0YX2RgbeGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnWfzzmV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711465428; x=1743001428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=salEnXficVUZmNY6rXQXrXxSmht6F3pTk6zHx4Io0ZE=;
  b=nnWfzzmVsGMGoH/EfuYUvGyw16idT+NnsNrTrk+mFdF/JJhoVEo6BnT8
   UhAq67yEEmIB4V4mF6uz1/8VAT1xWoylnuTrA1ZTCnv7aV2uqhpmhFuIP
   Q72ee1+wEL3KnWxgbI6s9E2dgZOlx7Ez1sIEgBHrILeKkYY0lxBzAmNPh
   MrVfLly/5PB+/+24xnw8IRAwO31D/4x+9obfBPnV5Yx4IcTLd5TIZDrVw
   WrpoH6wnkYxDwzYeMHtCWCldxmRbtM3T4bz2yL+q/39iwxLoB3ZH1h79f
   rjTSgGFV0bVelvL1UfEmbhjE+qVN2GLEAVk9X6IyaCRvbFHtp2v2d5/G1
   Q==;
X-CSE-ConnectionGUID: A5fARztNSmmtBfW1jz9EcQ==
X-CSE-MsgGUID: 6G9sqXeUSYupxz65uYfRNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6416819"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6416819"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914882723"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914882723"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:03:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp8Kz-0000000GKlS-114A;
	Tue, 26 Mar 2024 17:03:41 +0200
Date: Tue, 26 Mar 2024 17:03:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v1 4/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Message-ID: <ZgLjzci1MpHOYsI_@smile.fi.intel.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
 <20240326010905.2147-4-baojun.xu@ti.com>
 <ZgLjZElcF-2uBbtz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgLjZElcF-2uBbtz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 05:01:56PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 09:09:01AM +0800, Baojun Xu wrote:

..

> > +obj-$(CONFIG_SND_HDA_SCODEC_TAS2781_SPI) += snd-hda-scodec-tas2781-spi.o
> 
> File not found.
> 
> I believe you should fold patches 3&4&5

Instead of '5' I meant "all after 5th".

-- 
With Best Regards,
Andy Shevchenko



