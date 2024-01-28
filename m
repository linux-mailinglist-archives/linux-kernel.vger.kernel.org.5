Return-Path: <linux-kernel+bounces-41666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4483F61B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D861C2215B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C8828DD7;
	Sun, 28 Jan 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOpWzM1P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60028DB3;
	Sun, 28 Jan 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706455662; cv=none; b=PRH1klLmodOerJFJCgm0k+8ieFlaebhSLTGmnyO64/w4a/Da0nZZ0r7jrjOo7z1SwYUsmbBlOcBhGNbV+iffDn8skwZYjPq1o7xhYsnuqgBGE/gBstYIq4eR1UTOuOSfMB8nFQGC1yoExaWBiqA0cIK7bzQc8N/vUJiIga/CQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706455662; c=relaxed/simple;
	bh=d3z0pGTHHXR91QTi8Hqm6CnadlCg2Xx2yCHKcRt/Th0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9gluJ0bJtdjmoISg+6mHf5tW2JCuzWq/QPj3TQ6L5Zdqa4mcV67AQtuExxuokbXMZ2cG+TSxRV66x+HhlmjZRIg7E0S/lm/cMWx/mubQV0KkzOY+12L9wzm4ER9/mk4UsFNZ4rRLFvQeBQepdVddRxdzXmR9IILuShmOEPQzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOpWzM1P; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706455661; x=1737991661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d3z0pGTHHXR91QTi8Hqm6CnadlCg2Xx2yCHKcRt/Th0=;
  b=GOpWzM1PkQTwE1ur6r0G3bBrFdv76Rd97wE1reTpN0G+hHDr/1mxAzUx
   YaehvL1Rfei64MSO9TiFU+ZMjhaFaUXUDY/yptooF2JNvVNn+42gb9v9f
   QMvZBdCoZFtFq8IGhzd5Z2BlRt638mnGipl6+wXh1GbGu6j7gw1B0ym9N
   I/CpkIuiswjxHRmu3FdIeqvvQa9SZ72CEGJY8XtjHBkrXExTMpkuQZa3K
   td7ytunq7iZJbHqaOkWpyceGxo8QAkWzmz3SfAHcIQ9z5VGUIHBm5jwze
   KUxGjSVrAADVQP4K7z0IorCo6PrNPHT53WcOTuAyG60SV76xbhaJI5TUN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10168668"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10168668"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:27:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="787594329"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787594329"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:27:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU702-0000000HUO7-0UBE;
	Sun, 28 Jan 2024 17:23:10 +0200
Date: Sun, 28 Jan 2024 17:23:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org, kevin-lu@ti.com, baojun.xu@ti.com,
	devicetree@vger.kernel.org, v-po@ti.com, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	13916275206@139.com, mohit.chawla@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, soyer@irl.hu, jkhuang3@ti.com,
	tiwai@suse.de, pdjuandi@ti.com, j-mcpherson@ti.com, navada@ti.com
Subject: Re: [PATCH v2 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
Message-ID: <ZbZxXTkomTvldqXW@smile.fi.intel.com>
References: <20240126035855.1785-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126035855.1785-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jan 26, 2024 at 11:58:51AM +0800, Shenghao Ding wrote:
> PCM6240 driver implements a flexible and configurable setting for register
> and filter coefficients, to one, two or even multiple PCM6240 Family Audio
> chips.

Same comments applied as per previous version, please read my email and address
them.

-- 
With Best Regards,
Andy Shevchenko



