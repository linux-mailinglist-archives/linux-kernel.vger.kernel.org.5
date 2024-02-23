Return-Path: <linux-kernel+bounces-78543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51798614C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A31286171
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81A82866;
	Fri, 23 Feb 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsEpmCTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B825823C6;
	Fri, 23 Feb 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699924; cv=none; b=Kd4WLdA3cLqM8BBotInCmmidTPtxJgu6gHvi/PvGlOeUxwGKSy9MjRRX1FG/tJjYZhestRgTYDl4SITlk5zwIu821hJKRHuJdHAGsbd5IItySlqc2PDy9Rss1WAaHPmx69ubEtLzMVYtbVc60VYRIPpIAyC5SZKfMWsSljrJlrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699924; c=relaxed/simple;
	bh=tYi8l4Xs/hwU1yCY4ER0X47Mn9CHqguZeigHgYw6zvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsnYjQNRrSeFFFsC+D54Q2m1al7E5quVAp6uCP735NA9YtgE3HtfTNmGrlmMCyAEZq9PYJJjAib1Gd+7/B729FcUVuTk+7lScoe/Pg3X0jvSNsf0dyCIBNpYEStFCZA+6xvZd5vVlpJdPby5R4RV66k3W3iYbm8S3b1TKnmHIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsEpmCTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ACBC43390;
	Fri, 23 Feb 2024 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708699922;
	bh=tYi8l4Xs/hwU1yCY4ER0X47Mn9CHqguZeigHgYw6zvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsEpmCTqNjGuxlQ7d3WcRLlq7Ce/IYs6j3gtSffIyfwtrQq3MLBpLT8ueUTQDSBBE
	 e1+bN72SlDQdvZS3y9j5us/+43BkLacd7m/L4bJ2ygs06K3uKZg/zYyAr2ZosXH0Lr
	 qw9JAJYhV49kckh8u5AYBnxLPjPoEFlwNGmYMVk9s1bdyY3+maGXV6hnCHuhZVRGBc
	 NYfFyMLA4fBdgxbe9t6Y1paJmPlodVLvk/rWGLGLPiU6gbT3z7G08DKKK2riBhDKCI
	 zZ1rNClAhjjGSTQYbjnTS897sKSFPxJyyfRbpryUAZATD9G0tsc7ibJkyyIlZ43MSH
	 b4RE/xGlTvCCg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rdWuE-0000000053d-25Az;
	Fri, 23 Feb 2024 15:52:07 +0100
Date: Fri, 23 Feb 2024 15:52:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
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
Subject: Re: [PATCH 0/6] soc: qcom: pmic_glink_altmode: fix drm bridge
 use-after-free
Message-ID: <ZdixFo2EjUQDgeFh@hovoldconsulting.com>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <170868613914.4029284.5549880672870201262.b4-ty@linaro.org>
 <3c4246b6-431a-442e-8ace-3b0d0e67743f@linaro.org>
 <ZdiU2z8rzo542_Ih@hovoldconsulting.com>
 <d4049823-ad24-4426-887b-9c66cdd96318@linaro.org>
 <ZdiqAPPTn9SvsjL8@hovoldconsulting.com>
 <77715ecd-ddb9-450c-98bf-4fcade0e81c0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77715ecd-ddb9-450c-98bf-4fcade0e81c0@linaro.org>

On Fri, Feb 23, 2024 at 03:38:13PM +0100, Neil Armstrong wrote:
> On 23/02/2024 15:21, Johan Hovold wrote:

> > But it is *not* standalone as I tried to explain above.
> > 
> > So you have to drop it again as the later patches depend on it and
> > cannot be merged (through a different tree) without it.
> 
> drm-misc branches cannot be rebased, it must be reverted, but it can still be applied
> on drm-misc-next and I'll send a revert patch for drm-misc-fixes if needed, not a big deal.
> 
> > I thought you had all the acks you needed to take this through drm-misc,
> > but we can wait a bit more if necessary (and there's no rush to get the
> > first one in).
> 
> If you want it to be in v6.9, it's too late since the last drm-misc-next PR has been sent
> yesterday (https://cgit.freedesktop.org/drm/drm-misc/tag/?h=drm-misc-next-2024-02-22)
> 
> Please ping Thomas or Maxime, perhaps it's not too late since the drm-misc-next tree
> really closes on sunday.

I don't want this in 6.9, this is needed for *6.8* as this fixes a DRM
regression in 6.8-rc1 that breaks the display on machines like the X13s.

If you guys can't sort this out in time, then perhaps Bjorn can take
this through the Qualcomm tree instead (with DRM acks).

But again, this is fixing a severe *regression* in 6.8-rc1. It can not
wait for 6.9.

Johan

