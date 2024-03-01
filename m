Return-Path: <linux-kernel+bounces-88389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E23E86E0EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89451F222DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41656EB4D;
	Fri,  1 Mar 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA08poAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0FA6E608;
	Fri,  1 Mar 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295125; cv=none; b=aSM4qmbC76H+HY8uHRDtha1famysZn5ThrV2waEBIrZ0mVn34OZRDq94vH7iV+BTkf1TWbhU88JtxVyJvmhHpipzdJ4/Kqeh6GT7CUAux7odj+qePT6B5jgmD/k7Puh3ZdJuF5YuwY+Xy0A2H9UF63knCI4V42RSj3Fr/FWZL+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295125; c=relaxed/simple;
	bh=6E5qCAMa5baRaHUWMvXXQI+RrvNsgn7wLP4NhDm0xqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnqTBA6TCuOXGjHtchRE4r9Pkjy7V8GT3kk7LXYlWEMvN9+Cy1gAWLS4TpunlqBgi9e3rWJEKb617CTbJw8o8I9s+bUncCC90c/2r49a6YU6wftDuUDcA+aEW7xfmcm0gXPDblkmZ4rXANQ7TqurhOPE9qvB3AYbKQ96Qcfjas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA08poAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE13C43390;
	Fri,  1 Mar 2024 12:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709295124;
	bh=6E5qCAMa5baRaHUWMvXXQI+RrvNsgn7wLP4NhDm0xqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oA08poAphN0lZAIQQq2SGgzG3xggzAQadZkfPaCm/Hu8g9cM/T4l3JdOqaYOkxWl9
	 vrqvj9vAvv+3MFp1p5/mtabU/57iOutCJziDcrIJYbMln3emj+hQUeVjpTN3lw8hyd
	 DqYNXY7Pe42dfO9kjTSsy2TNv872hwWtUKuvBqgMrvoFQL5290xX0k5fd2/PUkajDW
	 NhqU/v8Z7ZXb4qhzyA220yicASsbi5YThFJqVW8YgUPMv/mzc7ZUkuLBxas48Pldb6
	 +hMe7ue4KokCYLS8ArfwOI4F6fZ2+SCQUof3riITI7VglYH26eAgQ10sqxPfzjIpPj
	 rPBGFlAlB3Q2Q==
Date: Fri, 1 Mar 2024 13:12:02 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v7 21/36] drm/connector: hdmi: Add Broadcast RGB property
Message-ID: <20240301-loyal-cornflower-oxpecker-83ed59@houat>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-21-8f4af575fce2@kernel.org>
 <20240229194726.GB166694@toolbox>
 <20240301-light-impressive-grasshopper-adabeb@houat>
 <20240301112941.GE166694@toolbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240301112941.GE166694@toolbox>

On Fri, Mar 01, 2024 at 12:29:41PM +0100, Sebastian Wick wrote:
> On Fri, Mar 01, 2024 at 11:30:56AM +0100, Maxime Ripard wrote:
> > On Thu, Feb 29, 2024 at 08:47:26PM +0100, Sebastian Wick wrote:
> > > > @@ -1708,6 +1731,39 @@ EXPORT_SYMBOL(drm_connector_attach_dp_subcon=
nector_property);
> > > >  /**
> > > >   * DOC: HDMI connector properties
> > > >   *
> > > > + * Broadcast RGB (HDMI specific)
> > > > + *      Indicates the Quantization Range (Full vs Limited) used. T=
he color
> > > > + *      processing pipeline will be adjusted to match the value of=
 the
> > > > + *      property, and the Infoframes will be generated and sent ac=
cordingly.
> > > > + *
> > > > + *      This property is only relevant if the HDMI output format i=
s RGB. If
> > > > + *      it's one of the YCbCr variant, it will be ignored and the =
output will
> > > > + *      use a limited quantization range.
> > >=20
> > > Uh, maybe just say that the quantization range is selected automatica=
lly
> > > in case a YCbCr output format is in use. I'm not sure every YCbCr
> > > variant requires limited and even if it does, new formats could change
> > > this.
> >=20
> > I documented what i915 is doing:
> > https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/i915/dis=
play/intel_hdmi.c#L2143
>=20
> Sure, this is one valid strategy for the automatic behavior of YCbCr.
> Drivers could also always send an InfoFrame to ensure full range where
> possible. The point here is that this property shall not affect YCbCr
> output formats!
>=20
> Maybe it's even better to say "driver specific" instead of "automatic".

Honestly, I'm not sure what you want from me here. Ville and you
insisted on the previous version to document what i915 is doing and to
follow whatever the behaviour was, and that we shouldn't spend time
improving the property. Fine, I did that.

But now, you want me to ... improve the property?

Maxime

