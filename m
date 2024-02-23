Return-Path: <linux-kernel+bounces-78328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C2E8611F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2671F22AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374607CF21;
	Fri, 23 Feb 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evV+Boqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B717AE45;
	Fri, 23 Feb 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692696; cv=none; b=dMWC/8lZH5+gZsqMsKDLwuuNx38TDSuEMlkLb0iXSzhtgaVrPo84NFiyTXys4RMATGIanigySfqVRjFveZwh/fHbIefbADqTHbLJllItb2DH52YsmzHZJ3illaEPIAcduQvqY6K2UR9voeMtYHQaptRndtGwZLLVNAT2UVKFKGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692696; c=relaxed/simple;
	bh=1lJXy4uKYL7pJq5F8Vo9jDbbuH8lfKzhYgyljzDs/n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFlNLaCyB3COIPLPuLGAXJ0hs65J29khpahW2Z5UIigLtgKJUVKgceZURquxlexVGGL18mg1PK1kwkMz25+IvUKjObEDzNS4kkwAxDix+8rItBpRtwQP7kfnuLM15dSnU2uwCdAkb0ioWkMuHDvL8XZF/fMz0rDyUC3iHPrTgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evV+Boqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC6DC433F1;
	Fri, 23 Feb 2024 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708692696;
	bh=1lJXy4uKYL7pJq5F8Vo9jDbbuH8lfKzhYgyljzDs/n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evV+Boqp9I4YqNzKSjDSoquLBTJkguhMnylBUp+eSde9n7BkMk3q9Lg60i9e8XMX6
	 KnVD7vHyg/cySaCtEXVuP/bnIKdedXSHu565Z9tnXNSUs8YPe1xFIzRKuV5Lg0ZXQV
	 l5kazV2J2jYV5p1S+u6WGNhBVb5rBFr+fQm9xY0lkYDytbFklcGTP7cg/mrT3n3tmj
	 s3PjVAYReKFME7zw5SaGqKfCDkAiLyIE41BxO+3TiTxQhRYcsaiqUTsS88rk0XN1+O
	 AHCRTL2asQ7U5XUr+EIzkSF1syZ/XvtniJ/7iKjkLOcduxCRcGwgDdWDqckgm/Fjq3
	 7vD74+f1h5vkw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rdV1f-000000002l8-1Rm4;
	Fri, 23 Feb 2024 13:51:40 +0100
Date: Fri, 23 Feb 2024 13:51:39 +0100
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
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
Message-ID: <ZdiU2z8rzo542_Ih@hovoldconsulting.com>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <170868613914.4029284.5549880672870201262.b4-ty@linaro.org>
 <3c4246b6-431a-442e-8ace-3b0d0e67743f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c4246b6-431a-442e-8ace-3b0d0e67743f@linaro.org>

On Fri, Feb 23, 2024 at 12:03:10PM +0100, Neil Armstrong wrote:
> On 23/02/2024 12:02, Neil Armstrong wrote:
> > Hi,
> > 
> > On Sat, 17 Feb 2024 16:02:22 +0100, Johan Hovold wrote:
> >> Starting with 6.8-rc1 the internal display sometimes fails to come up on
> >> machines like the Lenovo ThinkPad X13s and the logs indicate that this
> >> is due to a regression in the DRM subsystem [1].
> >>
> >> This series fixes a race in the pmic_glink_altmode driver which was
> >> exposed / triggered by the transparent DRM bridges rework that went into
> >> 6.8-rc1 and that manifested itself as a bridge failing to attach and
> >> sometimes triggering a NULL-pointer dereference.
> >>
> >> [...]
> > 
> > Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)
> > 
> > [1/6] drm/bridge: aux-hpd: fix OF node leaks
> >        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9ee485bdda68d6d3f5728cbe3150eb9013d7d22b
> > [2/6] drm/bridge: aux-hpd: separate allocation and registration
> >        (no commit info)
> > [3/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
> >        (no commit info)
> > [4/6] soc: qcom: pmic_glink: Fix boot when QRTR=m
> >        (no commit info)
> > [5/6] phy: qcom-qmp-combo: fix drm bridge registration
> >        (no commit info)
> > [6/6] phy: qcom-qmp-combo: fix type-c switch registration
> >        (no commit info)
> > 
> 
> To clarify, I only applied patch 1 to drm-misc-fixes

Ok, but can you please not do that? :)

These patches should go in through the same tree to avoid conflicts.

I discussed this with Bjorn and Dmitry the other day and the conclusion
was that it was easiest to take all of these through DRM.

With Vinod acking the PHY patches, I believe you have what you need to
merge the whole series now?

Johan

