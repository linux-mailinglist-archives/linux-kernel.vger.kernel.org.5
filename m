Return-Path: <linux-kernel+bounces-52938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D7E849E95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87306288489
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584A32C89;
	Mon,  5 Feb 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSKqBAGJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0192E635;
	Mon,  5 Feb 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147577; cv=none; b=GlsZ3RzGHimavFg5EzmyFpA+XoZc/c29Vu8P+ZeHj3cTN6AcPOEpNEBwvVnFJXDvWQxZoGrG3O8v0NpczRgCJAZcs5m2IVW1bppjacMXPqoJHnPIb19v0xY7xdZmjP1iR0BDMA4lA34lB3+hbszKQAV69TE1PRnaAH/GZdhP20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147577; c=relaxed/simple;
	bh=Rv8CV7EZj9twbDgExrfO0rqgaNqI6EazAjEyAvqafJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xh4EnYX4vxwkOzHcOCSa/3NPxB52LR2vDjF4Wl5GmTKP1mscvN1OPvJYzWqnoMhfYpmMj37ldO31sXnI5JBKSQfgshLw0+QgWcu0vYeTeFTyXrZwfqzhPI0MdZdrYdmc6sEFQohLEVoeQfrcNitw7E3oxoz5/9ad9wgfGwiSvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSKqBAGJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707147576; x=1738683576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rv8CV7EZj9twbDgExrfO0rqgaNqI6EazAjEyAvqafJ0=;
  b=XSKqBAGJZV6zCROXf4SDEQcqsTtwpA4TTPxY7wz0KD+8uzebasq4Aj4o
   oXxj2RXl/09ECfITYIvn9S3ONr6ilAHGzo2DgZoiK5ITnR77fkI69oqH/
   zMor1LsRfhMykBfZLosG0M9Che+6asbvLInZEIj/T85hhnNwCjMbnuBDR
   EHNrNQBUAwQsk330orzkM3I6iE93gR/+bFrv6BGc0v7oRILYrENq7KVLz
   ne2tr3sTbapsBQkpgFZNTkh87yKnoGb37Llp/lWVFGVyFAuupXg5dOQIe
   9Nz0whGdTbGjAoeo4BCIk5ayPm/RWk8rLjR8GOMPEkMRNDwnK6bphM1m2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="17966630"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="17966630"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 07:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="31830670"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 07:39:25 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B935D11FADC;
	Mon,  5 Feb 2024 12:53:10 +0200 (EET)
Date: Mon, 5 Feb 2024 10:53:10 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Bin Liu <bin.liu@mediatek.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 17/17] linux: v4l2-vp9.h: Fix kerneldoc
Message-ID: <ZcC-FjF5pJUKz9Ir@kekkonen.localdomain>
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
 <20240126-gix-mtk-warnings-v1-17-eed7865fce18@chromium.org>
 <ZbTTb-SdK-EubGdc@valkosipuli.retiisi.eu>
 <201ae1d1-1e03-40e2-9cc4-49df70abb8da@xs4all.nl>
 <8f3bab1f-8697-40c0-91f2-de934b4b9ddb@infradead.org>
 <e565f8bd-19d2-4574-8c6d-5573733a8185@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e565f8bd-19d2-4574-8c6d-5573733a8185@xs4all.nl>

Hi Hans,

On Mon, Feb 05, 2024 at 11:44:13AM +0100, Hans Verkuil wrote:
> On 05/02/2024 11:39, Randy Dunlap wrote:
> > 
> > 
> > On 2/5/24 02:29, Hans Verkuil wrote:
> >> On 27/01/2024 10:57, Sakari Ailus wrote:
> >>> Hi Ricardo,
> >>>
> >>> On Fri, Jan 26, 2024 at 11:16:16PM +0000, Ricardo Ribalda wrote:
> >>>> Kerneldoc cannot understand arrays defined like
> >>>> v4l2_frame_symbol_counts.
> >>>>
> >>>> Adding an asterisk to the name does do the trick.
> >>>>
> >>>> Disable the kerneldoc notation for now, it is already ignored:
> >>>> https://docs.kernel.org/search.html?q=v4l2_vp9_frame_symbol_counts
> >>>
> >>> Wouldn't it be nicer to fix kerneldoc instead? It might not be difficult at
> >>> all.
> >>>
> >>> Feel free to, but I can also give it a try.
> >>>
> >>
> >> It would be nice to have this fixed in kerneldoc itself. I'm holding this
> >> patch back for two weeks to see if someone wants to work on kerneldoc.
> >>
> >> If not, then I'll take this anyway to fix the noise in our build.
> >>
> >> Note that while this header is indeed ignored in the documentation, that
> >> is really more a bug and it would be nice to actually include this header
> >> somewhere in our documentation. So fixing these kerneldoc warnings one way
> >> or another is something that we should do.
> >>
> > 
> > It's just waiting for Jon to apply it: (from Sakari)
> > 
> > https://lore.kernel.org/all/20240131084934.191226-1-sakari.ailus@linux.intel.com/
> 
> Ah, that patch was CCed to me but not to linux-media, and I only searched linux-media
> for it so I missed it. Good news that this is fixed in the right place.

My bad, somehow I missed linux-media from the distribution. :-(

> 
> I marked this 17/17 patch as Obsoleted in patchwork.

Thank you!

-- 
Regards,

Sakari Ailus

