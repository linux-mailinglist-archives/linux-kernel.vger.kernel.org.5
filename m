Return-Path: <linux-kernel+bounces-41358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65583EF8D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A901F22DAD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C82E40E;
	Sat, 27 Jan 2024 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5ToPuYY"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D61E539;
	Sat, 27 Jan 2024 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706381189; cv=none; b=fYeoEyoCT24F3CNzdKL1OhdD4I5pe6bWovytrb6T6DspwA2iRuta6bq3QadvZAOi4VfOWEeMEcbao2vae07SxlLyOZ1kOjrmR827vVjzg+88NpFcgNJI1z1vc/fBiLmILPSt3+aIxOupvpn15yLO69BgsB40XGQJrXXaCM+VSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706381189; c=relaxed/simple;
	bh=EYPyaz87RkOJljahQF8funE2XdsGXXg6gukJ+v+90GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6w2M1LxCpbjeYr4jWEAtQ/edM4MsQWR5++57xh8TOPIIXsahHkYx+Gw5ylgoCQRrwWE6/xIDVtI0N5CyO/0NFF8/fGDv3I/aOL9oDF1S7AUuPqjwDTtKHjRPLVfkVuLQk+MAp7w7fpV3db32xzl8L/5OjX9szsPNrmmL8sMhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5ToPuYY; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706381187; x=1737917187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EYPyaz87RkOJljahQF8funE2XdsGXXg6gukJ+v+90GA=;
  b=G5ToPuYYxcVxXz6dt/DHtNh8u+OppP0v6ZkV3L3wSubDGUyozIWTbadN
   4tW8MXFsBGS+hY7vjk5BFSuVleIiy88nlOi0QuTCemdsU4y2Jrw3q2Kpd
   4txMhKh+gP44vIu4ciUCoF/lGjFpIXfpwyfFUpbcrq0uj0+qXYwIfNzdE
   QuTr7aRMQ2dIB6soWSuAzgUF/ohTyGPqQFalsXlxlj5z6M9+AFQLGYagk
   4wwmLBisVqomIoaEqDjQFS9a4LgMuYy1aaYfpD2hLWpvn1FJ1zHq5LAei
   L38h+eiyXbd0Zt724yKGyXtpbWTcmtX0reCy1orQ45sDJkM04WH3trMAf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="466977459"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="466977459"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 10:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="910649621"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="910649621"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 10:46:16 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 4755F11FB1F;
	Sat, 27 Jan 2024 20:40:25 +0200 (EET)
Date: Sat, 27 Jan 2024 18:40:25 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
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
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 03/17] media: media-entity.h: Fix kerneldoc
Message-ID: <ZbVOGaw-8qU2QNle@kekkonen.localdomain>
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
 <20240126-gix-mtk-warnings-v1-3-eed7865fce18@chromium.org>
 <e6b72dff-911e-4923-9996-b3b7db36fb8e@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b72dff-911e-4923-9996-b3b7db36fb8e@infradead.org>

Hi Randy,

On Fri, Jan 26, 2024 at 05:51:06PM -0800, Randy Dunlap wrote:
> 
> 
> On 1/26/24 15:16, Ricardo Ribalda wrote:
> > The fields seems to be documented twice.
> > 
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/media/media-entity.h | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> > index 2b6cd343ee9e..c79176ed6299 100644
> > --- a/include/media/media-entity.h
> > +++ b/include/media/media-entity.h
> > @@ -337,10 +337,6 @@ enum media_entity_type {
> >   * @info.dev:	Contains device major and minor info.
> >   * @info.dev.major: device node major, if the device is a devnode.
> >   * @info.dev.minor: device node minor, if the device is a devnode.
> > - * @major:	Devnode major number (zero if not applicable). Kept just
> > - *		for backward compatibility.
> > - * @minor:	Devnode minor number (zero if not applicable). Kept just
> > - *		for backward compatibility.
> >   *
> >   * .. note::
> >   *
> > 
> 
> I'd say that this is correct based on
> https://patchwork.kernel.org/project/linux-media/patch/20231223050707.14091-1-rdunlap@infradead.org/
> 
> 
> Hans, can you please explain this message from you, on 2024-Jan-22, that
> I cannot find in the media patchwork:

It's in linuxtv.org Patchwork here
<URL:https://patchwork.linuxtv.org/project/linux-media/patch/20231223050707.14091-1-rdunlap@infradead.org/>
and also in the media stage tree (as indicated by the state) but not yet in
master AFAIU.

> 
> 
> Subject: [git:media_stage/master] media: media-entity.h: fix Excess kernel-doc description warnings
> 
> 
> 
> This is an automatic generated email to let you know that the following patch were queued:
> 
> Subject: media: media-entity.h: fix Excess kernel-doc description warnings
> Author:  Randy Dunlap <rdunlap@infradead.org>
> Date:    Fri Dec 22 21:07:07 2023 -0800
> 
> Remove the @major: and @minor: lines to prevent the kernel-doc warnings:
> 
> include/media/media-entity.h:376: warning: Excess struct member 'major' description in 'media_entity'
> include/media/media-entity.h:376: warning: Excess struct member 'minor' description in 'media_entity'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> 
>  include/media/media-entity.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> ---
> 
> diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> index 2b6cd343ee9e..c79176ed6299 100644
> --- a/include/media/media-entity.h
> +++ b/include/media/media-entity.h
> @@ -337,10 +337,6 @@ enum media_entity_type {
>   * @info.dev:	Contains device major and minor info.
>   * @info.dev.major: device node major, if the device is a devnode.
>   * @info.dev.minor: device node minor, if the device is a devnode.
> - * @major:	Devnode major number (zero if not applicable). Kept just
> - *		for backward compatibility.
> - * @minor:	Devnode minor number (zero if not applicable). Kept just
> - *		for backward compatibility.
>   *
>   * .. note::
>   *
> 
> 
> 
> Thanks.

-- 
Regards,

Sakari Ailus

