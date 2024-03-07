Return-Path: <linux-kernel+bounces-95163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AA6874A1C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489FD1C22628
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ABC82D85;
	Thu,  7 Mar 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgW798Jw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD371A29A;
	Thu,  7 Mar 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801470; cv=none; b=Cmug0JkGqUvWBZwOxtTW5S2PyDMmjwLiiOEp+DRtCOW6Vrx0qZvDS2DQtNNweu2Dzw43JO4X7YN1Km33a4i81PWoSi//X0fw6KU0KN8qFtFnyVqWI9Lff3MY67tiEsGkV/eGoSyIEtaBaRPQKm/assA7HxyJpIzl1rWhL1QS7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801470; c=relaxed/simple;
	bh=yV/OikP6MH4jY26/Y82oK9+/dSYC2x7JTtfrU8Ax2hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch27jXre/en1zxSJR2dO/duN++j0Z37lhJWmcuvfMS+xT3yy0l9nE8dT6OBhl9nto68XEzRV3wwQoHJ4PGrrsxVu+rfQY/NHUOW/Qy9SMxY5WxmcAPBmPPfwLbLNCl+Gcf4pFXO2O/j1vZU9NLYgSGc8KKU5gta09PxL41gNhak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgW798Jw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709801469; x=1741337469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yV/OikP6MH4jY26/Y82oK9+/dSYC2x7JTtfrU8Ax2hs=;
  b=BgW798JwVtG7exnN1vYdl/tRE8EGyM68n6/RCNoz0tXayxDKQjDS9DAB
   OtJunieZtpP+V1QedRU0YXVAMHQ0h4VCNftermX3g6QGCNfjVbOW4yeMj
   2VA/MmdDzdVlVwHJZRcvcx+Mys1jqFdcEk4gMj9p7oqr+r742xGm7AM57
   ZGsD9ps2N6qfu8Z/sTLGAGcPX1YdeP8viTFCBaaHosjvo2+TjPoKFZ688
   LacG0/iclfYXfTXsH+Zw5c7WXG6hvJVJ93R0PjuPvbtUG34j2r2cJGvja
   6Cdnc9wVo4Wg+PYBsIfyydLmwdhXCu+31x8832a6X2MN7huRaXmXZwL28
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="21908202"
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="21908202"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="10201949"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:51:06 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5FA9B11F819;
	Thu,  7 Mar 2024 10:51:03 +0200 (EET)
Date: Thu, 7 Mar 2024 08:51:03 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ali Zahraee <ahzahraee@gmail.com>
Cc: bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
	gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] Documentation: media: remove documentation of obsolete
 struct members
Message-ID: <Zel_98N4G-zADEJw@kekkonen.localdomain>
References: <20240307084404.7796-1-ahzahraee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307084404.7796-1-ahzahraee@gmail.com>

Hi Ali,

Thanks for the patch.

On Thu, Mar 07, 2024 at 09:44:04AM +0100, Ali Zahraee wrote:
> These struct members were removed from the struct, but their
> documentation is still there, which causes warnings from sphinx during
> building of the docs.
> 
> Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>

These have been already removed by commit
dcef3ed5b0d79f89018e31d55cf09f2c2f81392b .

-- 
Kind regards,

Sakari Ailus

