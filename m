Return-Path: <linux-kernel+bounces-83313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA98691BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994F128F457
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E08C13B78E;
	Tue, 27 Feb 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCWgK8nC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6DD13B2A9;
	Tue, 27 Feb 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040423; cv=none; b=nUXwBj177d0xgRsKpbVpdKgzNtD8Vr9HWGfABGdUsxUt3hUc3GUZyKnkl5XaMcyNzPQtGGXAMuzVv/DjZbVUdjv/MGf0VJynEkARmmid+myLJ0VaAnF/02RN1Cn9zIQiRPZtGy3YNun+zXjp6j8HZq7P6+9C5LZXnILwMdCCRoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040423; c=relaxed/simple;
	bh=yYxg/i0g4KAnPdT2UJlvna1xTvMCnP9hCbmuoj80UwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsrilDFPPDPT/FIAlz4+mXW03AjjOxYVjixp5pNpU11MdL6s4yT/GMAQV/iR9ogrVc6buwFBQ7QAEGRn/IU9Ev+/yaRpfSyTi15jnwrhA2dTi1wnriKW34B3Pf+9jkM/xUaXcEx/Px97WXuH6kWAAfEcdakZ9/EwZc93kuFkg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCWgK8nC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709040423; x=1740576423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yYxg/i0g4KAnPdT2UJlvna1xTvMCnP9hCbmuoj80UwA=;
  b=ZCWgK8nCXuePHi0NFc8UXT0onrfVWoLJVUvzBcJJsq0kxU1M9OvnFo00
   ze4RFePYxBQYpZpJVTyrKcFPo0jtVoV/+TjlPLTIPZjJMRheNVub0SoQh
   ztGtcquomAWDd5fPZFdiKDLLbX468dFRQppF49xQe/evG8Pf2pyvxn9ty
   VdSh0DhWfLLBpP3LamMDwct23kNQ74WNqwIQwJp0NnkxCD41LkL7NfkwO
   vXobss1lM7V9qTSonQIASt79RKAeaPqOv0Yk73US+AtXJea0ZzNJ4PtDV
   JN/jldqNAPIbSdPq9UeJNF77HUxkRmQzfQDrUPk48kQ1weSplK1mjTkk4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3507308"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3507308"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:27:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="38075100"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:26:55 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 031C511F855;
	Tue, 27 Feb 2024 15:26:52 +0200 (EET)
Date: Tue, 27 Feb 2024 13:26:51 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Zhi Mao <zhi.mao@mediatek.com>, mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	laurent.pinchart@ideasonboard.com, shengnan.wang@mediatek.com,
	yaya.chang@mediatek.com, 10572168@qq.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	yunkec@chromium.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	jacopo.mondi@ideasonboard.com, hverkuil-cisco@xs4all.nl,
	heiko@sntech.de, jernej.skrabec@gmail.com, macromorgan@hotmail.com,
	linus.walleij@linaro.org, hdegoede@redhat.com,
	tomi.valkeinen@ideasonboard.com, gerald.loacker@wolfvision.net,
	bingbu.cao@intel.com, dan.scally@ideasonboard.com,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
Message-ID: <Zd3jG2HC3mR0dQR3@kekkonen.localdomain>
References: <20240227013221.21512-1-zhi.mao@mediatek.com>
 <20240227013221.21512-3-zhi.mao@mediatek.com>
 <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com>

Hi Andy,

On Tue, Feb 27, 2024 at 02:46:54PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 27, 2024 at 3:33 AM Zhi Mao <zhi.mao@mediatek.com> wrote:
> >
> > Add a V4L2 sub-device driver for Galaxycore GC08A3 image sensor.
> 
> ...
> 
> > +/*
> > + * gc08a3.c - gc08a3 sensor driver
> 
> Drop the filename from the file, it's impractical (esp. if the file
> will be renamed for some reason in the future).
> 
> > + *
> > + * Copyright 2023 MediaTek

You could update the year.

..

> 
> > +       endpoint =
> > +               fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> > +                                               FWNODE_GRAPH_ENDPOINT_NEXT);
> > +       if (!endpoint) {
> 
> Strictly speaking dev_fwnode(dev) might be NULL or an error pointer. I
> dunno how the graph is implemented there and if it's possible to get
> an error pointer out of it. At least this probably needs to be aligned
> there at some point.

This is fine---the fwnode API returns errors (for functions that can) for
NULL or error pointer fwnodes.

The patches are in my tree already, please post a patch on top of this that
I can squash.

-- 
Regards,

Sakari Ailus

