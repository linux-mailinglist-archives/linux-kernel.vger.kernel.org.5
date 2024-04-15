Return-Path: <linux-kernel+bounces-144564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD68A47CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56C82838DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AECCD2FA;
	Mon, 15 Apr 2024 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsNOK2YV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531B6112;
	Mon, 15 Apr 2024 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161341; cv=none; b=ZZpEIZzZKBD/dbS71V7SGcYJb9F8uMIzEc39VZAUMFMxiGeO4W0qDX1bACTPGB5bGVeebTYJCzBoP9Ak6CpKerbNYmfrnVNGw5OrE9EIrKVPXxOPqJLvZAjnT+MCgCaxUvRZ8mzlfiTIARxIPtUt+8FEsIzYlzSbqjkq8e8Jdd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161341; c=relaxed/simple;
	bh=e9ABONc1WXl3FPnYnjI6Nc2vONxLJsw3QN/efR/K9Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1wMSjzZyVLPJrIMn16lwqvWBV55wjhN2dDt/sJoJVhzu/BnEwRksO17IHPN0mVLcMeXI2ZQe35vLRP40alQ07nJB2IeI9H0QI16Uyht8ucGwZ4zpJq3qwaQxTafAOE363uU4yxJMw2Vts2mPg65nWl+QwL5k0pgExQVjwb+2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsNOK2YV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713161341; x=1744697341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e9ABONc1WXl3FPnYnjI6Nc2vONxLJsw3QN/efR/K9Z4=;
  b=lsNOK2YVjAXPYsic1+l74ZwQ81Pqt9AtwhC7p2bt4t+LmDEUuHaEJn11
   +quwPrGuXlJ8xdK2kcbELpgM/VoW2Wpwlv7vx8BvPHQ07extBL0pabjM4
   vr+5s0q6bfeY++mpJbPKjKv5Vx1IB87PUiRpg+Q/B1QLzW8XMfQMlaN6B
   atSMfGmlxCps6ZZ0ycQ6XEdfapQjnV1mLEcaSZUbP2ETok4aYu6dbpKJx
   Hi/cw/3ILs1nRfY9wMEeWhFxI2KzBXHYD2p39cR0SzVpZyTFywFdLOG23
   NRHmR+j5TmABhd2HMIfu2P0GNFgjL0Z8lpaOSrQWDLiQda24BgtyywNWd
   w==;
X-CSE-ConnectionGUID: FbPC424GQrufTFL9PErpzQ==
X-CSE-MsgGUID: CODdiGc1QmaYWcEniw/bQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19956085"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19956085"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:08:58 -0700
X-CSE-ConnectionGUID: zsGB3klfRvCpiAEsXsh+HA==
X-CSE-MsgGUID: JECtCCC/R4KJZDpgsYrYWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="45077498"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:08:55 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 1109711F8AF;
	Mon, 15 Apr 2024 09:08:53 +0300 (EEST)
Date: Mon, 15 Apr 2024 06:08:53 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v4 17/20] media: i2c: ov4689: Configurable analogue crop
Message-ID: <ZhzEdXz-R2I6nZXf@kekkonen.localdomain>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
 <20240402164552.19171-18-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402164552.19171-18-mike.rudenko@gmail.com>

Hi Mikhail,

On Tue, Apr 02, 2024 at 07:45:48PM +0300, Mikhail Rudenko wrote:
> Implement configurable analogue crop via .set_selection call.
> ov4689_init_cfg is modified to initialize default subdev selection.
> Offsets are aligned to 2 to preserve Bayer order, selection width is
> aligned to 4 and height to 2 to meet hardware requirements.
> 
> Experimentally discovered values of the cropping-related registers and
> vfifo_read_start for various output sizes are used. Default BLC anchor
> positions are used for the default analogue crop, scaling down
> proportionally for the smaller crop sizes.
> 
> When analogue crop is adjusted, several consequential actions take
> place: the output format is reset, exposure/vblank/hblank control
> ranges and default values are adjusted accordingly. Additionally,
> ov4689_set_ctrl utilizes pad crop instead of cur_mode width and
> height for HTS and VTS calculation. Also, ov4689_enum_frame_sizes is
> modified to report crop size as available frame size.

We're amidst of a change to the APIs touching sensors with the the
introduction of the internal pads.
<URL:https://lore.kernel.org/linux-media/20240313072516.241106-1-sakari.ailus@linux.intel.com/T/#t>.

I'd therefore postpone this bit so it would align with the new practices
(also subject to change in the metadata set).

The rest of the patches would seem more or less ready for merging to me.

-- 
Kind regards,

Sakari Ailus

