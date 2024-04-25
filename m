Return-Path: <linux-kernel+bounces-159064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF3E8B28D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1888C283364
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E68F1514DE;
	Thu, 25 Apr 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3cZYF/4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31260381D9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072379; cv=none; b=TGRl8uKsXxYYIqH3u5+nLZcykfCktSwWO2u/L0QzNFM3lx8VKtYn+6ZgqKxEktVTFmIE4N4qEsSM5fZAoTGqKekUKVS10nMaX7py4chuRL9NtyVdfZG4QN9UpqAdzbd3U5CBL1vZeVf/ojswKm1TZEzGpusSnJdcAknZVhTiubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072379; c=relaxed/simple;
	bh=eQKDUIkbcqXJvPnx+i1N+rPtXZr4oQXNIGA0HlIQiyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSht4wjaX4dc/ce3koDwD4PgL6nt9QNq34u+W9HZlGAP2PAxVWt3GM5QqQXURyWgQ2ShEWzcFdxcUAo+IaRgIf6Rv3V/aheSaQdFiDlXaPalhQ9PuT8yOwce1eSleWpZpANbKKRBx5D8ifWpAcZ3kxgq9sHzxNc74ynC74rWDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3cZYF/4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714072378; x=1745608378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eQKDUIkbcqXJvPnx+i1N+rPtXZr4oQXNIGA0HlIQiyg=;
  b=D3cZYF/4cpIoPuHlxA/1xYooHvxn6Q7wJ7dCjpZDcwEwTUkmG+58FvmB
   d8pUjJskCk1pg7UmHCPVueuz+Y00q3Of8fvrcflkCguSyoTpN6VQkYGrQ
   ytubdQq0+Y8ecSPByP36ez7D9ycutKeOgYYC+ViACSayLqBeeeuVpOha4
   TA11ej7Bhi2Ot8lkyVz8AxsvqHbPkbUAFr5slj9UqogRb88p3aWDpReeS
   hBXeaKdhfCmK0mtd3FM9JJKtoI4vL9exPHkpPhu3sCQBKdYlVv9nihbZk
   1GRxrl9H77UVsozzjP698M9Eb7QOUMoTTZjHEVAad1GO7LNeAUj9RS1Yf
   Q==;
X-CSE-ConnectionGUID: QxywdN3wTu2XueyJ2LmpRA==
X-CSE-MsgGUID: y3qyjebXQwyrv0QUHb0PvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9947183"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9947183"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 12:12:57 -0700
X-CSE-ConnectionGUID: df/CsiBnRgmg2dLfU5Xx2g==
X-CSE-MsgGUID: eL3v1+bjRhWyfjtKO+H61w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="29819636"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 12:12:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s04WT-000000016tI-1sdd;
	Thu, 25 Apr 2024 22:12:45 +0300
Date: Thu, 25 Apr 2024 22:12:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
Message-ID: <ZiqrLfezhns4UycR@smile.fi.intel.com>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ce6a480d-80b3-46b0-a32d-26bc6480d02f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce6a480d-80b3-46b0-a32d-26bc6480d02f@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 02:53:22AM +0800, Sui Jingfeng wrote:
> On 2024/4/26 02:08, Sui Jingfeng wrote:

Are you speaking to yourself? I'm totally lost.

Please, if you want to give a constructive feedback, try to understand
the topic from different aspects and then clearly express it.

-- 
With Best Regards,
Andy Shevchenko



