Return-Path: <linux-kernel+bounces-119254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8076F88C632
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC281F2138A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D813C81C;
	Tue, 26 Mar 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTOGM/Vb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF8013C3F4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465325; cv=none; b=kgu53op9gTbHzJgzbz+MT0deEy0/YTJZtL236bQdCHZ2sEeKv93dzohdIKl4ZOsSxjGeuqwYYLoLd6yee3JEgUti8QmO+/RMNNlDsfZVt3ELixPsk43mNpydtBAJwbsZIFS9rXbdeatEV1WsDMNi+QoQqbBeXkWNivpcsCX6dz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465325; c=relaxed/simple;
	bh=mt0ToVCugUi6oKxd1necFZMybb2ozw3PPcCpHtg8BkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZP3abI6286w3PqlfPI5B12qFVqyvkS4LKhW7ktaRbusa44Lch3Vtg5iKRyQL08Bf5M6TTj/FL93VsPmMsiiqMYKrS7Z3/1lgSiMiUxURzqAyilFZ22opaVhfMo2d0nV4KWVY0wbEkhFBvYh6BG25xxfibzSGoZ2HnVlQG4y5c6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTOGM/Vb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711465324; x=1743001324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mt0ToVCugUi6oKxd1necFZMybb2ozw3PPcCpHtg8BkY=;
  b=GTOGM/VbPkDfj1uvMn7GXjA8XkeR8ienyKkNu+fyLshHC3ESc39ylDfS
   TlG61Vv+7kYsszTp1LZlmMtTB4PRO1ENKG71my2ApkksAEoZIaafri74H
   hf6IqgKGm37Vo4vTYrtdLAYmw5oqHgvwxaKwEeGHTd8PiZZ3/p+JQiQBj
   GBHyz50E7ygnatEhl0ppqvZChiphawHPK+IwDZPPpqR4gggvCJqZ9vEYM
   kk5Z+1Ox6ZVFfybhrtl0b74eygwGJ4B2yLXECQ4rXxMGbXdSe9kV+ZQyf
   PYmy0nAW1QwE7KJUVYidAi0RGM75MFgVgHyXEo1ATUdzpWKVl3NZNKxXJ
   Q==;
X-CSE-ConnectionGUID: y9gt/BMjRZWp54CbGax0lQ==
X-CSE-MsgGUID: LHtZKM+4QaODs/1V93LPPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6415937"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6415937"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914882688"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914882688"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:01:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp8JI-0000000GKjp-2BnH;
	Tue, 26 Mar 2024 17:01:56 +0200
Date: Tue, 26 Mar 2024 17:01:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v1 4/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Message-ID: <ZgLjZElcF-2uBbtz@smile.fi.intel.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
 <20240326010905.2147-4-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326010905.2147-4-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 09:09:01AM +0800, Baojun Xu wrote:
> Add tas2781 spi driver files.

..

> +obj-$(CONFIG_SND_HDA_SCODEC_TAS2781_SPI) += snd-hda-scodec-tas2781-spi.o

File not found.

I believe you should fold patches 3&4&5

-- 
With Best Regards,
Andy Shevchenko



