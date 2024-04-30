Return-Path: <linux-kernel+bounces-164034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF378B776C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E501C222B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857CA171E64;
	Tue, 30 Apr 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hazEBTw0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C41F171
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484664; cv=none; b=EuUQCvmRrGzi5BwK8q6PQpTLpYGipSWeBXIDMIrjgDs10NEambQrgrpF9QGUqaKsm316zWARIxIAHqgWE/Na0Q1HQQNBoZUziot4RMac99K9JBR64+USQ0agS3yyllKoc6pz8lD5kwi9VoKh+G38dr/Kqgb989mHveVLszmkvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484664; c=relaxed/simple;
	bh=2UDOlMajI8DsE4OHRS3aVKxvrNd40hazdzrDjFIsdXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocAXAkvkiaBJoHBb1DXFiFbvVx7Fv/BRT9+PbkY16uTVjbM9V3ma9b6Yg7K+vv4+xip4wpdjALfBRu3ZHhSTN4RaPGfF9SxkjvqCzvkIfbsOsGFvct/SZn9HBuvNkKE337HLZN9r9ZYqHBv4xvQ/BEUjSpmXulLJwq4IuDKRKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hazEBTw0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714484663; x=1746020663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2UDOlMajI8DsE4OHRS3aVKxvrNd40hazdzrDjFIsdXE=;
  b=hazEBTw0Xj03UmOxK29NmBwp7LwtT7u4KWfRTpL9RPw86hMJfid1z//d
   HBPerge/l4MvTQc19FOPundMDiU76IT1c+voIJ9JYrYcFmcV1aCoj8jo1
   Bg8EOwFvBK8MulH1jz+9paA9Qy+oBIR/iygYveyHv+oNDHbfUYrkTPuy8
   g3d8UV+I+aZjKYNsqFYpor8s2phg20qIHceZLM2eq4gz+/4lkSzuflCvC
   ECTKMPSpmxgJ6BcZ5DjdB6H5nSwC5IFm1qqVRY5o+FPrRkQVKt7tdGDku
   St0cpeIGCkxMHN1QkB+tpOL8pwWlJvqpKB/1RFan8CWMf5w+QXusEyAGT
   A==;
X-CSE-ConnectionGUID: GFzE5b74SzqR1kIKlnosYg==
X-CSE-MsgGUID: BUhLa8qhSpOwjE4Yze/Qjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10729733"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10729733"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 06:44:22 -0700
X-CSE-ConnectionGUID: mgmnKKShQMG9iua9PfZIfQ==
X-CSE-MsgGUID: spqYxkyUQHScc8boV0HzRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26964803"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 06:44:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1nmI-00000002g1m-0sDM;
	Tue, 30 Apr 2024 16:44:14 +0300
Date: Tue, 30 Apr 2024 16:44:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	shenghao-ding@ti.com, navada@ti.com, 13916275206@139.com,
	v-po@ti.com, niranjan.hy@ti.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v4 1/3] ALSA: hda/tas2781: Add tas2781 hda driver based
 on SPI
Message-ID: <ZjD1rSJDXugxtDy2@smile.fi.intel.com>
References: <20240430072544.1877-1-baojun.xu@ti.com>
 <20240430072544.1877-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430072544.1877-2-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 30, 2024 at 03:25:42PM +0800, Baojun Xu wrote:
> Integrate tas2781 hda spi driver configs for HP (Varcolac).
> Every tas2781 SPI node was added by serial-multi-instantie.c as a SPI device.
> The code support Realtek as the primary codec.

..

> +		{"TIAS2781", },

Is this for real? I mean you really abused ACPI specifications to get this into
the real products on the market?! If so, never do this again.

_This_ one is non-conforming abuse of ACPI specification and has not to be here
at all. But, if the above is the case, provide the models of the devices and
the excerpt of the DSDT where this broken ID happen, also add a big comment
explaining how comes this happened and that you promise to never happen this
again.

..

> +	{ "TIAS2781", (unsigned long)&tas2781_hda },

Ditto.

..

> +config SND_HDA_SCODEC_TAS2781_SPI
> +	tristate "Build TAS2781 HD-audio side codec support for SPI Bus"
> +	depends on SPI_MASTER
> +	depends on ACPI

No compile test?

> +	depends on EFI
> +	depends on SND_SOC
> +	select CRC32_SARWATE
> +	help
> +	  Say Y or M here to include TAS2781 SPI HD-audio side codec support
> +	  in snd-hda-intel driver, such as ALC287.

-- 
With Best Regards,
Andy Shevchenko



