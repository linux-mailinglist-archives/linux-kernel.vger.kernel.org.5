Return-Path: <linux-kernel+bounces-76851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0CF85FD99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F6A1C25C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02BB150983;
	Thu, 22 Feb 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWJbfB7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB212FF8D;
	Thu, 22 Feb 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617969; cv=none; b=EpYJi6TrSVZHXzwkXmDoJao1P4vJWjZB+lZ5CkCaVxwUCvwWXYUOt1f9K1NqnARYpC8JOJSfABmpFs/MTOLaddK43yuvsCpgT4UMS7pdgXhUmdptM/yJBrcii7447/JaCmIwFGV53DRejd+DnWTVlnHOxA7/3Qoj0DnbFITjQwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617969; c=relaxed/simple;
	bh=C+TptrLEyKVQZgqziz2FhHnXNxbrMuek3GwWVcpvIo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7IFTidofMy3EsQ7pe4zj8LcQBwJGa0MxjXjEijMi6nYdn0Ab1fQCTptNZ9tCzyfEgwsgyJrRv3hMcfClxeCLwZjIQkdx0SAYWdlK13R/5Sh8819N3YhCWcIwEpCWVvz+/j6akE0Of9+e+QYuv8EYmmVkFrIxBahQLjqHPFKxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWJbfB7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8F2C433F1;
	Thu, 22 Feb 2024 16:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708617968;
	bh=C+TptrLEyKVQZgqziz2FhHnXNxbrMuek3GwWVcpvIo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWJbfB7iIrJzA5wgM//VQpK+Eg1Jl7jsjd4SEzbxStIlH2+3ip1yzmyPSHymB5rIP
	 +kuPH04cJMfNIEEuP8KlSRti8JVt9Q1OQ9+RCo5Q9bLhbBmhXKKx2VNjyDHEsPbBbK
	 txObfjquCti+EIcWW907dO1EI2N0f0pR6lZPMso9UMv/vXM84tR6cV66jS+yrMXDSc
	 8+pkoyUMMrMhNi298AylQnGdWqe7h7vQly7yRH6YyKSy2fZiubV7K+QbbHmfavTyza
	 fKszN2T/ofej2aQ5sp9beXBRSLahj63YnaDP2IIUwJMH/YOkGHj2yPLuL2IiNgV98j
	 r05Ygwua981+A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rdBaM-0000000087I-3fOL;
	Thu, 22 Feb 2024 17:06:10 +0100
Date: Thu, 22 Feb 2024 17:06:10 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/6] drm/bridge: aux-hpd: separate allocation and
 registration
Message-ID: <Zddw8uhFwcwILhK0@hovoldconsulting.com>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <20240217150228.5788-3-johan+linaro@kernel.org>
 <cyzl3m67daaijpwhcwx53tk7tgrvw4kxiz7cj6bhx5xxwh6fuj@u2l674nlp4th>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cyzl3m67daaijpwhcwx53tk7tgrvw4kxiz7cj6bhx5xxwh6fuj@u2l674nlp4th>

On Wed, Feb 21, 2024 at 08:06:41PM -0600, Bjorn Andersson wrote:
> On Sat, Feb 17, 2024 at 04:02:24PM +0100, Johan Hovold wrote:
> > diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> [..]
> > +/**
> > + * devm_drm_dp_hpd_bridge_add - register a HDP DisplayPort bridge
> 
> kernel-doc wants () after function names.

I don't think that's required for the symbol name here even if some
subsystems (drivers) use it.

> > + * @dev: struct device to tie registration lifetime to
> > + * @adev: bridge auxiliary device to be registered
> > + *
> > + * Returns: zero on success or a negative errno
> 
> and "Return:" without the 's'.

This was a mistake however. Perhaps whoever applies this can drop it, or
I can send a v2.

Side note: Looks like there are more instances with an 's' than without
under driver/gpu/drm...

> This could however be done in a separate patch, as the file is already
> wrong in this regard.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Thanks for reviewing.

Johan

