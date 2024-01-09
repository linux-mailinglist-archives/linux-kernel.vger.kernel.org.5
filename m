Return-Path: <linux-kernel+bounces-20766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B14568284F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508EBB24746
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0138DF4;
	Tue,  9 Jan 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ntb0L3yN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A937162;
	Tue,  9 Jan 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704799399; x=1736335399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nri6MxrFIMHTBgggJZSrCHzG3uLau0be+hNOOAXuPX8=;
  b=Ntb0L3yN9DgJ87TWBJsu/cymRrPNQJtHXbmRMRGtZkwm238ME0uE7ney
   7rHMdLDzvrjrYckg5JXFbGrS9k2OrBjCn2Oe8e44Hi69yfTOnMfG0KpgL
   YvWGDHa63BvrgkKxtsi4WwmCvIwqoxwmrTcy0PyyQHHiZhqB0tykjoeU6
   yt3UlPOTHKllAXtNW+5zrbzvDYZcpqP9l1SsIrRTefbr/mpL+Tqorthgi
   GNZmqydRyx9xSplilh6M4MR99V0AU8+muUINuid2/xV939V7alveAQwjl
   tGC9/ET7n/3KVGEUDeK+2En22eTNO3mhlvIsuCm2PfX8EV8YMQC+yrLA7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11515183"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="11515183"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 03:23:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="954987339"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="954987339"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 03:23:11 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B99CB11F913;
	Tue,  9 Jan 2024 13:23:08 +0200 (EET)
Date: Tue, 9 Jan 2024 11:23:08 +0000
From: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
To: Zhi Mao =?utf-8?B?KOavm+aZuik=?= <zhi.mao@mediatek.com>
Cc: "heiko@sntech.de" <heiko@sntech.de>,
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	Shengnan Wang =?utf-8?B?KOeOi+Wco+eUtyk=?= <shengnan.wang@mediatek.com>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	Yaya Chang =?utf-8?B?KOW8tembhea4hSk=?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"10572168@qq.com" <10572168@qq.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Message-ID: <ZZ0snE1r0BnFHWUh@kekkonen.localdomain>
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
 <20231207052016.25954-2-zhi.mao@mediatek.com>
 <ZXGtqwjYruBQVaUr@kekkonen.localdomain>
 <d6772a73b61911954b1f0f75325b82da53ad0877.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6772a73b61911954b1f0f75325b82da53ad0877.camel@mediatek.com>

Hi Zhi,

On Tue, Jan 09, 2024 at 10:41:15AM +0000, Zhi Mao (毛智) wrote:
> > > +static const char *const gc08a3_supply_name[] = {
> > > +"avdd",
> > > +"dvdd",
> > > +"dovdd",
> > > +};
> > > +
> > > +#define GC08A3_NUM_SUPPLIES ARRAY_SIZE(gc08a3_supply_name)
> > 
> > Please use ARRAY_SIZE(...) directly.
> > 
> [mtk]: About "ARRAY_SIZE", creating a macro with a descriptive name can
> improve readability of code, especially when it is used in multiple
> locations in codes. and it seems a common usage in sensor drivers. Can
> we keep this usage in gc08a3 driver?

It improves readability even more if you use ARRAY_SIZE() directly as then
it's easy to see you're dealing with a single array. GC08A3_NUM_SUPPLIES is
thus a useless definition.

..

> > > +static int gc08a3_g_mbus_config(struct v4l2_subdev *sd, unsigned
> > int pad,
> > > +struct v4l2_mbus_config *config)
> > > +{
> > > +config->type = V4L2_MBUS_CSI2_DPHY;
> > > +config->bus.mipi_csi2.num_data_lanes = 4;
> > > +config->bus.mipi_csi2.flags = 0;
> > > +return 0;
> > > +}
> > 
> > As you return a static configuration, there's no need to implement
> > g_mbus_config().
> > 
> [mtk]: we can not remove this function, because meidatek ISP driver
> will use this interface to get some information.

Please fix the Mediatek ISP driver in that case.

I'm also open to adding a V4L2 framework function to obtain the number of
lanes (and other configuration) for an upstream sub-device, either using
the local endpoint or g_mbus_config if the sub-device driver implements
that.

-- 
Regards,

Sakari Ailus

