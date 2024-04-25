Return-Path: <linux-kernel+bounces-158765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D58B24A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38BD1C21559
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43C14B089;
	Thu, 25 Apr 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEIKu4Eo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42714D716;
	Thu, 25 Apr 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057499; cv=none; b=KidPL0Y0MdhQv7/j3TOv1yaPqT/z9NaB3qYnxD/P4JXk/1Orp1vAGaPEZgZ4o9Eh2N9/N5XNzy/Qw+79Qlq3nCHmBDoE3frgFdNkCV6FP+6ympsjK+AZHzx8MerVjhg+wjg7arxIK17vAADSXRDnfp0pfPcjNex6kOcj/9l37F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057499; c=relaxed/simple;
	bh=Ebs59IXexhzqLXqVggapRFuVaAJDANXqVUimkFuzG2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz2cF3J2PW1d8+25wmziIgcRnLrE/Wi9wJxMgBnM5NGuY/C/vdBeuLHxi3Gs35jrGNMfnFmHCDgMQ955jnmSAz2QnV24zmAHoG14UKFeSL5GjqP3BGMotijzW0qf9C95WjNJaT46xGjKCqBJDyiF7Z5CNpNcqMcePM+dF2FqLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEIKu4Eo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714057498; x=1745593498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ebs59IXexhzqLXqVggapRFuVaAJDANXqVUimkFuzG2I=;
  b=EEIKu4Eov+xtIbAUMByelqaVYNn+95PMWNES9FukOmIkv+aqXHLM1oZg
   LYYrHfzOY3jw2jDDKplEcE/RmKmg7k11ZXe0J6Eam1RAPhqrE3KvTKiPw
   TvTthpFUdFl82fMrlpKsnEmFUNK60dPskG8WbKZnB092yi3sLHVdniK3X
   7kmRtpOEXAEeAeOyEJ4vTlMoXSmMKfpCHqlzpNUwLGffX0r7e1TcaWcia
   eclWTk7DoijBxl1+3BaAv9RdeNOxUl7dc703Oj3D9TsUR32i1Pggs67d2
   M3L0yVZRP7VPyltvEBnIbp3beft1kkwYbOxWgImB4X+gVKcyEy97GoZ0F
   w==;
X-CSE-ConnectionGUID: mBdWe2olSQCQ9A6FP5FMZA==
X-CSE-MsgGUID: wmL8M6AqTxeWSq7KjSwxjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="27206832"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="27206832"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 08:04:57 -0700
X-CSE-ConnectionGUID: dj7BiCPeTHSZbsuGpPWT7A==
X-CSE-MsgGUID: JTzKIusPSDCIclQtHdW4rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29887001"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 08:04:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s00eY-000000012AE-3W0q;
	Thu, 25 Apr 2024 18:04:50 +0300
Date: Thu, 25 Apr 2024 18:04:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
	David Lechner <dlechner@baylibre.com>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drm/ili9341: Remove the duplicative driver
Message-ID: <ZipxEk9Lpff1kB7b@smile.fi.intel.com>
References: <20240425124208.2255265-1-andriy.shevchenko@linux.intel.com>
 <20240425-perky-myrtle-gorilla-e1e24f@penduick>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425-perky-myrtle-gorilla-e1e24f@penduick>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 04:58:06PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Apr 25, 2024 at 03:42:07PM +0300, Andy Shevchenko wrote:
> > First of all, the driver was introduced when it was already
> > two drivers available for Ilitek 9341 panels.
> > 
> > Second, the most recent (fourth!) driver has incorporated this one
> > and hence, when enabled, it covers the provided functionality.
> > 
> > Taking into account the above, remove duplicative driver and make
> > maintenance and support eaiser for everybody.
> > 
> > Also see discussion [1] for details about Ilitek 9341 duplication
> > code.
> > 
> > Link: https://lore.kernel.org/r/ZXM9pG-53V4S8E2H@smile.fi.intel.com [1]
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I think it should be the other way around and we should remove the
> mipi-dbi handling from panel/panel-ilitek-ili9341.c

Then please do it! I whining already for a few years about this.

> It's basically two drivers glued together for no particular reason and
> handling two very different use cases which just adds more complexity
> than it needs to.
> 
> And it's the only driver doing so afaik, so it's definitely not "least
> surprise" compliant.

-- 
With Best Regards,
Andy Shevchenko



