Return-Path: <linux-kernel+bounces-77942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 828AE860D12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B07C1F298BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8AB18E2F;
	Fri, 23 Feb 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/GE7Ycn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700618E0E;
	Fri, 23 Feb 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677799; cv=none; b=GRRI1LTyQpwHPcGy3sEWluA+qoSUrInHGLA/CkRoZfMz6fobzKX9GO0ktqvqDOgqjC8lbh4UzxkRFDItBd8G5EXVFuHjPqPV/yQq1AS4cUXcMfvkdPwLYYp0Jsl6pBfb6FGKl8ucXS9kCXxu0cCe/o4WkCfqfDRDjCemnacDUWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677799; c=relaxed/simple;
	bh=IEeTlpxURy3/yxx9Pu6JpPyffFdM2y6Tfz9e7EtiqbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFuY9gaQk0tSluj6T/aAWGeVkxogCVMV7jV04vBj1PVeXN5hHayfHXydxGfv2PVrmDBApbMjDf3KnwlAJ9EH6kWzODEIUI987ZWfkpZE5p5KoTm4fERXr1YPgXAGtvaBZLED9HzDOGk5N8MgMEOFq8fJXNpK/eUSMPsLhEpFYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/GE7Ycn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708677797; x=1740213797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IEeTlpxURy3/yxx9Pu6JpPyffFdM2y6Tfz9e7EtiqbE=;
  b=a/GE7YcnnKw4ZAhiIvHWQXP9syXTouQtCTed7mT4SA8qkPG7yDOidaKz
   XfxNI2xDto6SX1qNJIzpRgte7P5HrZ7odfLQYOKBWNLUT/IVG+1o7w18A
   y10d+ZvQCK2H13kLU1shn5wzZbtIZzHU+xy5A0LyUuvBPpKqZMhoJbH6V
   Gc25UodTO/vV4yMbkBBc0YCN0jr0MIhbJztapa1Im8CryF+jQRivAOfM/
   QA1HARDnTWsHG5EPBfpTAJ7dKGqxU6YsR9Gdm/rFY3sKeDqFHZPRf8Usy
   TaojJ4y38xggtLB0Fe47skFeRLVpv5VL5wTxfuvP5YLusx3Vz1Sqo+05C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6767826"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6767826"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 00:43:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="43297602"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 00:43:14 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 13BF511F81D;
	Fri, 23 Feb 2024 10:43:11 +0200 (EET)
Date: Fri, 23 Feb 2024 08:43:11 +0000
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
Message-ID: <Zdhan1Gzi6GD5QfP@kekkonen.localdomain>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <87o7c9q27c.fsf@gmail.com>
 <ZdhULRi3w4E5tQgR@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdhULRi3w4E5tQgR@kekkonen.localdomain>

On Fri, Feb 23, 2024 at 08:15:41AM +0000, Sakari Ailus wrote:
> Hi Mikhail,
> 
> On Wed, Feb 21, 2024 at 06:02:15PM +0300, Mikhail Rudenko wrote:
> > 
> > Hi,
> > 
> > On 2023-12-18 at 20:40 +03, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:
> > 
> > > Hi,
> > >
> > > This series contains refactoring and new features implementation for
> > > the Omnivision OV4689 sensor driver. Specifically, patches 1, 2, 3, 5,
> > > 6, 10, 15, 16, 18, and 19 are refactorings, and are not supposed to
> > > introduce any functional change. Patches 4 and 7 perform migration to
> > > CCI helpers and subdevice active state respectively, and should not
> > > introduce any hardware- and/or user-visible change either. Patch 8
> > > fixes a possible race condition due to v4l2_async_register_subdev_sensor
> > > being called too early in ov4689_probe, and patch 9 migrates power
> > > management to PM autosuspend.
> > >
> > > Patches 11-14 expose more sensor controls to the userspace, such as
> > > (read-write) HBLANK, VFLIP/HFLIP, digital gain, and color
> > > balance. Patch 17 implements configurable analogue crop rectangle via
> > > .set_selection callback. And finally, patch 20 enables 2x2 binning
> > > option. It should be noted that publicly available sensor
> > > documentation is lacking description of many registers and their value
> > > ranges, so a lot of values had to be found by experimentation.
> > 
> > Gentle ping on this series. Anything I can do to help getting it
> > reviewed and merged? Maybe split patches 15-20 which implement cropping
> > and binning and change the driver away from register list based model
> > into a separate series? Anyone?
> 
> Oops, my bad. I'll review these shortly. I can already tell there's not
> much to do though.

Done.

-- 
Sakari Ailus

