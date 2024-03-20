Return-Path: <linux-kernel+bounces-109401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6B8818A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A1B1F225EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717A224F2;
	Wed, 20 Mar 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UreEp/fw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736912B7D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710966752; cv=none; b=WZm5O7+GawfskcIgPYLEPLgZscTaH0t4FCP8uRmdBy5bnYGth3tR5AZA4gbDjGPp6ZJX0jj+qvNNbF5uQWnlROCXs7Br1KiFE1lWds6W79cMCnt9WI9MkQVjgdBsynrAX6ppTS2sVbXf9/cfSHwAm4zk0loOgnYjfA5AFGdlsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710966752; c=relaxed/simple;
	bh=I5Y39iE3LeKBqFbvJmR/QKXpE0W5iZdRKP3x2On8OL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1X8WUAKRA9KSWPC76l/ifZBck4L2WRsJqi48Vk7Vjsn59LNOOWyNBuhHVdWzG0oxhQ3ysSsM0W0DASkP5YbUQbNYH+XwxGfM3GrBN2BQE70emrS7iHCbVAuliOPwGIeAarQRDmm+yyK/KcWymhw4rGiXdSF0NagPlCEaVEPk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UreEp/fw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710966751; x=1742502751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I5Y39iE3LeKBqFbvJmR/QKXpE0W5iZdRKP3x2On8OL0=;
  b=UreEp/fwcXQIDNYcAwAtkN8EovTGsHa0F4zf1elLxpeoDEIeLT+Mfzps
   GsRLhAT4NLUJt9iJLVhFaTPxRsFYTDJ3yQQUAKqRivgJeoG9kF0zO7JB0
   kPVFofGWGy/7ZNXrWtG43KTHJryVIz48kkMVy01n0jOhqvENGfgPRySlB
   BzKbQJs4KLA9iP/We8798S20anjuhtlboNVuGVIshq/cE3MsXcf1JpnMB
   t81b+cuT9hMvZEPsfIfrkatD2+Tf89tVoGZEZC+mkwEwtYAAPKrO8pSJY
   CsJ7iH0lVYh7ttOZJoghQIydKGI8kbOyJm/zSsHesShUi1I31xedQwWY+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5791647"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="5791647"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 13:32:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="914678181"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="914678181"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 13:32:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rn2bo-0000000EgIt-3dvc;
	Wed, 20 Mar 2024 22:32:24 +0200
Date: Wed, 20 Mar 2024 22:32:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, David Airlie <airlied@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [PATCH 5/5] drm-bridge: display-connector: Switch to use fwnode
 API
Message-ID: <ZftH2ArlSkt4kX7M@smile.fi.intel.com>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-6-sui.jingfeng@linux.dev>
 <20240123012026.GC22880@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123012026.GC22880@pendragon.ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 23, 2024 at 03:20:26AM +0200, Laurent Pinchart wrote:
> On Tue, Jan 23, 2024 at 12:32:20AM +0800, Sui Jingfeng wrote:

..

> >  	conn->bridge.of_node = pdev->dev.of_node;
> > +	conn->bridge.fwnode = pdev->dev.fwnode;
> 
> This goes in the right direction. Let's address the other drivers and
> drop the OF-based calls in the same series :-)

+1. BUT, please use device_set_node() instead of both lines.

-- 
With Best Regards,
Andy Shevchenko



