Return-Path: <linux-kernel+bounces-109402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BACB8818AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FA8283B64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336EF2E842;
	Wed, 20 Mar 2024 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7k4dr9G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDB12B7D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710966862; cv=none; b=dS0HglMKrGYP788dEKzP0u9SRnUPLWLIP7oi5+6SEERgOtZ+IREvmfw1YqV+jZDyyfLRCWafV+1gu+m+bDZU4RP7chdTsEL5KmNnWcD5crHdX4t3neZuwPDo9Zrlf5ywkXDT+oQbPJ93GXGSdiYB/EdB2kG8D7Y/eZaeKeA6438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710966862; c=relaxed/simple;
	bh=N+rUS2s44+0WKHa8pBBiEgErSjUurHrIcJg593v1E5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHmc8s1x4dR3XDX0RZLXnWb/eQMd56wrp0lpRKDvIwgfVHjlKkDXfdcztdWh+zgNV4lnxPXYnsRd00gzCryK24Cy0YVEv5UYQV5rRyvdlp7YUr7ESMydjLTmGW59PUhIGgqz2l6mSXZL7hrQFurL44QJpOrzkUG+qGIiaseLdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7k4dr9G; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710966861; x=1742502861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N+rUS2s44+0WKHa8pBBiEgErSjUurHrIcJg593v1E5o=;
  b=D7k4dr9GGKjCHu9VqZZ+3faiYL2XT6jXOJANcjbsgRUIE4BzvKcXpm+d
   jx5QnKm+9s1f/UctwJJDNrhaWyyV2VSl7n6u0V9R6hvGfF2d/t9jINHgY
   daot3JKuaZNpCyMB9cnDSE06FfehbezyJDk3/jZ1f654JPxdVR8NE3Tbi
   YDSQnnd2ngR0EsZ9KP9MTomBC54qLG9lbbnwnt7TR8N6zm7HNcejN3HH7
   tM4gj8Bm6TmCsx/UAru8srtn0MCTz5d7P+TgDVUZbcrtmi2akbrf2j0QU
   S9TBWtkxO8wakwp00yjc3pMXLc5lMONsRSegkW1d2nJ74a9l1ZS3RwfpF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5791761"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="5791761"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 13:34:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="914678220"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="914678220"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 13:34:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rn2db-0000000EgKN-11S6;
	Wed, 20 Mar 2024 22:34:15 +0200
Date: Wed, 20 Mar 2024 22:34:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: David Airlie <airlied@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/bridge: simple-bridge: Extend match support for
 non-DT based systems
Message-ID: <ZftIRz2gCiGcoPwj@smile.fi.intel.com>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-3-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122163220.110788-3-sui.jingfeng@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 23, 2024 at 12:32:17AM +0800, Sui Jingfeng wrote:
> Which is intended to be used on non-DT environment, where the simple-bridge
> platform device is created by either the display controller driver side or
> platform firmware subsystem. To avoid duplication and to keep consistent,
> we choose to reuse the OF match tables. Because the potentional user may
> not has a of_node attached, nor a ACPI match id. If this is the case,
> a software node string property can be provide to fill the niche.

..

> -	sbridge->info = of_device_get_match_data(&pdev->dev);
> +	if (pdev->dev.of_node)
> +		sbridge->info = of_device_get_match_data(&pdev->dev);
> +	else
> +		sbridge->info = simple_bridge_get_match_data(&pdev->dev);

This is wrong. Just use device_get_match_data() instead of of_ counter part.
The rest, if required, has to be addressed elsewhere.

So, formal NAK for the changes like above.

-- 
With Best Regards,
Andy Shevchenko



