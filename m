Return-Path: <linux-kernel+bounces-75785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEAB85EEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBB31F22EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C1D17561;
	Thu, 22 Feb 2024 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYfgohSQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158F17548;
	Thu, 22 Feb 2024 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567605; cv=none; b=dDGlU0O4WVNeu9rVF5/qGhHX4YgkfmRqe9uyqmyfUP0RjsWdWTVJCrn1RDDMi/uFwLHkZBLS60ayhmR3Kin/vYWYH0zKRK9SrcSXF7CJhzcEFPkN+n0TMRYb7YaRentpF6zzxFoEUYv0yQB7AzGSN7Upi06Isg7UDvX+YtQFIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567605; c=relaxed/simple;
	bh=Ybci3+TcYCfWUtyyK9oMeVMAce0zLcjOP2WOB1QozRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNoHa+jCbAoSUpJRxrYbhXCSmwh6yXkMw8KyV0EUKHV78PCmkIiksicC1CpywHZKAUVsPvn0fDZwUMoLyW8/bub2Ej5K6KJYZmtjlqdX1bCja5k5kuBXD1D3fQtVY5dRNBdwH0IgXNDCPZe/grDGQYRDd7clxFP+uhCUujed2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYfgohSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A01CC433F1;
	Thu, 22 Feb 2024 02:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708567605;
	bh=Ybci3+TcYCfWUtyyK9oMeVMAce0zLcjOP2WOB1QozRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYfgohSQYfx5MuNjkVKbPMcSliwWc4XdYPqIUBvIvU4KT/boyIp106nCyVqD021Sd
	 njg8Y4SdVFb5APDaQCYE2FZLojpASoRlm7m+focW1sr1wY5c1CzFAEp1Ag2fBVoJrT
	 nzkinUd0UTlLcpG28vbMYlglF6egqdoraXipCtlKZ9oB0pbQR+DiuK2gfCFqa/iMVe
	 oKBs87RNBKE5mMumkZsCJzbM3ew6tSls7bY5/3Yt59MZZEj1Q2ukrajX2bvO7RUFH5
	 Vbx0/AuXX/AKEjWdBndtBOwymR7Hqck94bPygq4Jjs+1eidMFEX2QfAoI1iSTeXNyY
	 mxbTcAqfLSiKg==
Date: Wed, 21 Feb 2024 20:06:41 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/6] drm/bridge: aux-hpd: separate allocation and
 registration
Message-ID: <cyzl3m67daaijpwhcwx53tk7tgrvw4kxiz7cj6bhx5xxwh6fuj@u2l674nlp4th>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <20240217150228.5788-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217150228.5788-3-johan+linaro@kernel.org>

On Sat, Feb 17, 2024 at 04:02:24PM +0100, Johan Hovold wrote:
> diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
[..]
> +/**
> + * devm_drm_dp_hpd_bridge_add - register a HDP DisplayPort bridge

kernel-doc wants () after function names.

> + * @dev: struct device to tie registration lifetime to
> + * @adev: bridge auxiliary device to be registered
> + *
> + * Returns: zero on success or a negative errno

and "Return:" without the 's'.

This could however be done in a separate patch, as the file is already
wrong in this regard.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

