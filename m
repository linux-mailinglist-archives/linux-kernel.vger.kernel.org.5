Return-Path: <linux-kernel+bounces-65052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470AF85472E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048512840E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74E1643A;
	Wed, 14 Feb 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hox9PoyA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836517543;
	Wed, 14 Feb 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906811; cv=none; b=MR24gySduKDv3xfxSLPCs1iUEm3jaD2xVBJBED0JWZVYUTrGjdY9g4SG8nHl37iumF6zNa7/8Dq3FF1g0PMrjxrda+EgbX5UFy4oTRfk5jCzI5CH5DOzFfzjcG5Rl7jlVKJV5ivDt/1P0p9b3UI4NYtKslR9CJPB25f1oSGwbyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906811; c=relaxed/simple;
	bh=mFfgmz4+wXh0UjEUmA4Dg2GD0XWAvkVAjB6kDsPql70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axo5eGkH7WkyCoG7TsOj5blOh3xhMFKXb81Up4zRIJDYlrER9QorXN+Q3k2Xmf6WJnjWrrU/xTaG28aEPvjuHtnTD4r2TBGpqeRyA+Xpv5A0FZIy7uRLQnLreunoru1yZcnNizB/yHIleRfsdiKQFL992JmkNYVmvPnGwAHG53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hox9PoyA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707906810; x=1739442810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mFfgmz4+wXh0UjEUmA4Dg2GD0XWAvkVAjB6kDsPql70=;
  b=hox9PoyArnTWZ/HJblzFcSSC/xxAefGsN7Ff1ceyVuxE6vCbJxesfTrL
   SjgPQh44BIQlT2h4I0mnfre4aj8QSlDECm5nb9jKUB6rG3jv+/Q79I3fF
   MwwWNaHwdA3eSSsIzqoKkVHGDybPBfF9iwvg2JkEvychYK2H5wtBhQs+1
   6v3ERDAXCL5QPCOMIyPixJwEyDL/sFgrMAATnv4BDkCKjBwd4Q5vYTIvk
   Yd0b7X6THAI2HTWyJL4/P9cfJfUIXcHxKV3twwb6s2vLFr5BWStVXCdlJ
   Xg9kp5cuTCLi1Zu0fzjwgpksuo5kK5Q+GVVT3RGsnrS7k/TqvzwrPNmXH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1813393"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1813393"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 02:33:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3316050"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 02:33:26 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5501A11F86A;
	Wed, 14 Feb 2024 12:33:23 +0200 (EET)
Date: Wed, 14 Feb 2024 10:33:23 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: v4l: marvell: select CONFIG_V4L2_ASYNC where
 needed
Message-ID: <ZcyW8zn14iIbn45X@kekkonen.localdomain>
References: <20240213095555.454392-1-arnd@kernel.org>
 <24cbf7b2-a091-440e-92cc-5c9828d52260@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24cbf7b2-a091-440e-92cc-5c9828d52260@xs4all.nl>

Hi Hans, Arnd,

On Wed, Feb 14, 2024 at 11:24:41AM +0100, Hans Verkuil wrote:
> Arnd, Sakari,
> 
> Is this something that needs to go to v6.8? Or just v6.9?
> 
> Do we need a Fixes tag?

The patch seems to be related to this:
<URL:https://lore.kernel.org/oe-kbuild-all/202402130955.f6uxzdCA-lkp@intel.com/>.

So most likely yes, and Cc: stable, too.

> 
> Regards,
> 
> 	Hans
> 
> On 13/02/2024 10:55, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Drivers that call v4l2_async_nf_init() need to select the corresponding
> > Kconfig symbol:
> > 
> > ERROR: modpost: "v4l2_async_nf_init" [drivers/media/platform/marvell/cafe_ccic.ko] undefined!
> > ERROR: modpost: "__v4l2_async_nf_add_i2c" [drivers/media/platform/marvell/cafe_ccic.ko] undefined!
> > ERROR: modpost: "v4l2_async_nf_unregister" [drivers/media/platform/marvell/mcam-core.ko] undefined!
> > ERROR: modpost: "v4l2_async_nf_init" [drivers/media/platform/marvell/mmp_camera.ko] undefined!
> > ERROR: modpost: "__v4l2_async_nf_add_fwnode_remote" [drivers/media/platform/marvell/mmp_camera.ko] undefined!
> > 
> > I checked all v4l2 drivers to see if anything else has the same
> > bug, but these two appear to be the only ones.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/media/platform/marvell/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/media/platform/marvell/Kconfig b/drivers/media/platform/marvell/Kconfig
> > index d6499ffe30e8..d31f4730f2a3 100644
> > --- a/drivers/media/platform/marvell/Kconfig
> > +++ b/drivers/media/platform/marvell/Kconfig
> > @@ -7,6 +7,7 @@ config VIDEO_CAFE_CCIC
> >  	depends on V4L_PLATFORM_DRIVERS
> >  	depends on PCI && I2C && VIDEO_DEV
> >  	depends on COMMON_CLK
> > +	select V4L2_ASYNC
> >  	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
> >  	select VIDEOBUF2_VMALLOC
> >  	select VIDEOBUF2_DMA_CONTIG
> > @@ -24,6 +25,7 @@ config VIDEO_MMP_CAMERA
> >  	depends on COMMON_CLK
> >  	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
> >  	select I2C_GPIO
> > +	select V4L2_ASYNC
> >  	select VIDEOBUF2_VMALLOC
> >  	select VIDEOBUF2_DMA_CONTIG
> >  	select VIDEOBUF2_DMA_SG
> 

-- 
Regards,

Sakari Ailus

