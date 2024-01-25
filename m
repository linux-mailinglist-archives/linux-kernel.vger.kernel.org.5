Return-Path: <linux-kernel+bounces-38870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02EC83C799
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38F71C233EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA0129A73;
	Thu, 25 Jan 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGsjEBlW"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30986143;
	Thu, 25 Jan 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199062; cv=none; b=vANzayhpyFTxyuGImUFE6TGnt64N6T6qMra2eHh53jfwW+jgSJ4Vgmh52rElOuR6UPV0h8ijvjzjjWEhhJgsVgNactvjIwrfmAiWX+WBr/V6PJs4Tg95s9Jqi0Hl59B5TNrQ3Ppk9HAK5HXl5gTy13fMWA/tXBnLhQhA0Kj8xIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199062; c=relaxed/simple;
	bh=erA6r6+8c+fMm7TjsfyuG2K4tmIEaj6481Pqbo/gIRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg61iM8gqKsw+CTvF5lHoLHfXibH18Zr7aoS7WUeo6eDJfnqjdN0hIWfFD7tglBpje6P/sbWKzdWrRZAmhtXgbAbW/CHx8Xip8/2XgHr9d7ZQN9W5xGy2eI3PNj05rLgE2f7dubEROXozwV0mkKFJQ/cvEPgfCImWvmVnSRuXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGsjEBlW; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706199061; x=1737735061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=erA6r6+8c+fMm7TjsfyuG2K4tmIEaj6481Pqbo/gIRU=;
  b=UGsjEBlWD4hml9v1xNgHY6As2IYorXSB3+lIQR3W+kRa11R4pd1DJ5vf
   MipegmtzJOh3uIqxEF0o5vDms+Mfq9yr6ndFMtpBIuqRMuWfmRB5a4hbo
   kuarqa/3HqtLOlQqu9UBAsw2CGJwpaiP42IEumBt5ZDvdZBiUnjzj1AgY
   Hrnkp7l/f8rYABkRBeUJSfbU13kFSTtuCNwRsdQuwc6/BZ5A+9aN4dxKT
   qzGykkX2Mmp6REN9ErBTWgDtVT51GkLdgdgfhFipHL1bQNBxYo8L5O2z9
   TV7gLxoyuUoMkNPy7wM+srX0bKPzNd7fk8ptabyMzAB56MEdGV/3cyJq/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="433358619"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="433358619"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736372656"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="736372656"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:10:52 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 775ED11FAD4;
	Thu, 25 Jan 2024 18:01:16 +0200 (EET)
Date: Thu, 25 Jan 2024 16:01:16 +0000
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
Subject: Re: [PATCH v3 2/2] media: i2c: Add GC08A3 image sensor driver
Message-ID: <ZbKFzGxXhU0TABHZ@kekkonen.localdomain>
References: <20240109022715.30278-1-zhi.mao@mediatek.com>
 <20240109022715.30278-3-zhi.mao@mediatek.com>
 <ZZ0dcTEqxjYCohac@kekkonen.localdomain>
 <42cf05ea80a2413aae588b762e67c3418b9514d4.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42cf05ea80a2413aae588b762e67c3418b9514d4.camel@mediatek.com>

Hi Zhi,

On Thu, Jan 25, 2024 at 02:24:52AM +0000, Zhi Mao (毛智) wrote:
> Hi Sakari
> 
> Thanks for your review code and comments.
> 
> On Tue, 2024-01-09 at 10:18 +0000, Sakari Ailus wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Hi Zhi,
> > 
> > Thanks for the update.
> > 
> > On Tue, Jan 09, 2024 at 10:27:15AM +0800, Zhi Mao wrote:
> > > Add a V4L2 sub-device driver for Galaxycore GC08A3 image sensor.
> > > 
> > > Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> > > ---
> > >  drivers/media/i2c/Kconfig  |   10 +
> > >  drivers/media/i2c/Makefile |    1 +
> > >  drivers/media/i2c/gc08a3.c | 1467
> > ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 1478 insertions(+)
> > >  create mode 100644 drivers/media/i2c/gc08a3.c
> > > 
> > > +for (i = 0; i < ARRAY_SIZE(link_freq_menu_items); i++) {
> > > +for (j = 0; j < bus_cfg.nr_of_link_frequencies; j++) {
> > > +if (link_freq_menu_items[i] ==
> > > +    bus_cfg.link_frequencies[j])
> > > +break;
> > > +}
> > > +
> > > +if (j == bus_cfg.nr_of_link_frequencies) {
> > > +dev_err(dev,
> > > +"no link frequency %lld supported, please check DT",
> > > +link_freq_menu_items[i]);
> > > +ret = -EINVAL;
> > > +goto done;
> > > +}
> > > +}
> > 
> > Please use v4l2_link_freq_to_bitmap() available here
> > <URL:
> > https://lore.kernel.org/linux-media/20240108151805.55584-2-sakari.ailus@linux.intel.com/T/#u>
> > ;.
> > We'll then merge both at the same time.
> > 
> 
> After got the latest linux kernel code base(tag: next-20240124), there
> seems to be not new API:v4l2_link_freq_to_bitmap() still.
> 
> Would you please let me know, how about the status about this API?

The patches are in my linuxtv.org tree's master branch now:

	https://git.linuxtv.org/sailus/media_tree.git/

-- 
Sakari Ailus

