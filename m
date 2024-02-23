Return-Path: <linux-kernel+bounces-77905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAAF860C01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE60284FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2230918027;
	Fri, 23 Feb 2024 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWtA+fVy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7A17583;
	Fri, 23 Feb 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676289; cv=none; b=qhIy2TabQzHQWQ/0C2g7Z01fNa7czT3WICixY6ebFZgUM1cwdg6xGuufR5WQciXmh2ZO7NCZNOSvrb6VcWbi0WQBAjRW+XtpvuO6JqFLdJVnYCTbfQ7VQFXpSE3PscaKmd0GGekUJ26feIw50RDFTD2XUqe6PvDlGyz1XIT0Sl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676289; c=relaxed/simple;
	bh=jy81sRFR9BWuKSDiQCUuu+4n552mgv58Sc77MFEwpZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caxQvUMfFu66YGsgCxb6ZR4/7AYNDTXnOhjle4UK5wr7qrpWBn4vX6sOlhBvbO7v1ynYr5QBQx8HZYHI/OYtd19nA6krzUBD0K6aNJCDQYuce9o2XJ3IyfVaRr2zPk5glI6wCWkaReJlylKoJ97Ny0xgLf8at8iFAvjNOaUIznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWtA+fVy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708676288; x=1740212288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jy81sRFR9BWuKSDiQCUuu+4n552mgv58Sc77MFEwpZQ=;
  b=nWtA+fVywrRUP8N63WEYditsEIbMhUhuLskWU93QIr1FjgoIkrUfDhcP
   AhsZ9T5S0p3cgrTd6hGKg86TvBaudsDlfI0D4yDV+SX9RqKrMTYga7GYt
   g0Tf/mEnxaCBQSV1kxNGShT8EI/lAFN+xjU+jTJ3bJYIDLtZxs5xpkxb/
   /mRQK28fuX0Jk7lDwMxIvOIiSYKPtgiNMhVSy4vFlFNJNSvwa0On9xzER
   RpZ5+S01dtDfxSrE7GuQ77JGfpZpVcRMkPtwcrTZB2txwzqg2MA4KoCTi
   spYxUWguQWW0nLolXbVsJrq9ansj6K2Exf8/yM1zuev5UG8A1NMWh5lOs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2842530"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2842530"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 00:15:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6241048"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 00:15:44 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2885F11F81D;
	Fri, 23 Feb 2024 10:15:41 +0200 (EET)
Date: Fri, 23 Feb 2024 08:15:41 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 00/20] Omnivision OV4689 refactoring and improvements
Message-ID: <ZdhULRi3w4E5tQgR@kekkonen.localdomain>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <87o7c9q27c.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7c9q27c.fsf@gmail.com>

Hi Mikhail,

On Wed, Feb 21, 2024 at 06:02:15PM +0300, Mikhail Rudenko wrote:
> 
> Hi,
> 
> On 2023-12-18 at 20:40 +03, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:
> 
> > Hi,
> >
> > This series contains refactoring and new features implementation for
> > the Omnivision OV4689 sensor driver. Specifically, patches 1, 2, 3, 5,
> > 6, 10, 15, 16, 18, and 19 are refactorings, and are not supposed to
> > introduce any functional change. Patches 4 and 7 perform migration to
> > CCI helpers and subdevice active state respectively, and should not
> > introduce any hardware- and/or user-visible change either. Patch 8
> > fixes a possible race condition due to v4l2_async_register_subdev_sensor
> > being called too early in ov4689_probe, and patch 9 migrates power
> > management to PM autosuspend.
> >
> > Patches 11-14 expose more sensor controls to the userspace, such as
> > (read-write) HBLANK, VFLIP/HFLIP, digital gain, and color
> > balance. Patch 17 implements configurable analogue crop rectangle via
> > .set_selection callback. And finally, patch 20 enables 2x2 binning
> > option. It should be noted that publicly available sensor
> > documentation is lacking description of many registers and their value
> > ranges, so a lot of values had to be found by experimentation.
> 
> Gentle ping on this series. Anything I can do to help getting it
> reviewed and merged? Maybe split patches 15-20 which implement cropping
> and binning and change the driver away from register list based model
> into a separate series? Anyone?

Oops, my bad. I'll review these shortly. I can already tell there's not
much to do though.

-- 
Regards,

Sakari Ailus

