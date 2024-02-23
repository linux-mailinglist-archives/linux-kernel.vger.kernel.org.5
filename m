Return-Path: <linux-kernel+bounces-78277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A98861123
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC221F246E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD07B3EE;
	Fri, 23 Feb 2024 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWE+qH8Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5EF7AE49;
	Fri, 23 Feb 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690189; cv=none; b=mHk4XwgCrLbTDEMrx1SC4bEKTSZPjJKcVaa+uTkuUeXJaD/Lnm3d2rmAKtB5gF+Ilv9OTmllN8TrjhCYS4IftWT3oaXhz1uVdOWcnYUeYKxnjmszLHNTyJJTgJ3Fu/xdM3iqL73+117R9GmR1At8HPA4lv/D+cWyjfvgZqwkWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690189; c=relaxed/simple;
	bh=DAU55Q2sfD8L3ZH3fwKz/mmSeLuRFjA+iaKnPasZfYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UztSSxD4bxb69FHGik/8nXET18tWCAXpHSP41oxRTAA8NqISBdU30rBmz0EUarwXtFXE5AluoxiEq3yLqaubex9rSJ9KteYKnoRFHl/u1HaV/ZhSOPulm7PWOvpCHd7UYW29Ha1UY4SLE9G46RKFah1GPsPpuA9PecJZFM346n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWE+qH8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA89C433F1;
	Fri, 23 Feb 2024 12:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690189;
	bh=DAU55Q2sfD8L3ZH3fwKz/mmSeLuRFjA+iaKnPasZfYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWE+qH8Zq+UtXRLfYmyuV3u+IKp/btik1e/z0NcFAKsg2JFdaO+l5UWXmWONEYLds
	 uLpa08T9BkqJUn2j4hpCvA+SIS573tWcOmBKJqjuQwgDE/E6Q47UjoNbXT2rpw20qo
	 7fUqXMddP2LVweCKCfIgSXQk1Ka671n7VX8tk8thBXNe74TFl5p1/4AVMz8lg9HD6p
	 lBIYZVzJkwWQxX5lovIMJ+xSadmHDq1uIdelyPrGCCl7fid1vWrktyF86toFZTIOYw
	 X5OMymD0SIeOPhIaqSbiiFEAEKdvwmnu24v0ozwuZm9AnXcHsOkKPa5nltacZN7V5L
	 exhG1FobcrI5w==
Date: Fri, 23 Feb 2024 17:39:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
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
	linux-phy@lists.infradead.org, stable@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 5/6] phy: qcom-qmp-combo: fix drm bridge registration
Message-ID: <ZdiLCYKCujs4DgKV@matsya>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <20240217150228.5788-6-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217150228.5788-6-johan+linaro@kernel.org>

On 17-02-24, 16:02, Johan Hovold wrote:
> Due to a long-standing issue in driver core, drivers may not probe defer
> after having registered child devices to avoid triggering a probe
> deferral loop (see fbc35b45f9f6 ("Add documentation on meaning of
> -EPROBE_DEFER")).
> 
> This could potentially also trigger a bug in the DRM bridge
> implementation which does not expect bridges to go away even if device
> links may avoid triggering this (when enabled).
> 
> Move registration of the DRM aux bridge to after looking up clocks and
> other resources.
> 
> Note that PHY creation can in theory also trigger a probe deferral when
> a 'phy' supply is used. This does not seem to affect the QMP PHY driver
> but the PHY subsystem should be reworked to address this (i.e. by
> separating initialisation and registration of the PHY).

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

