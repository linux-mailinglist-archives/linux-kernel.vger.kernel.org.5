Return-Path: <linux-kernel+bounces-146875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A08A6C39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAFD281DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5571112C48A;
	Tue, 16 Apr 2024 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSCuqPLY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D212BF25
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273981; cv=none; b=D57jh7iwe9rRDmwXVBGQX0fJquT4rv2NLIonC3n7/M55XRx2f0/rjN1KfZ8CXbI94v6eGnhppSbiWonTslq0rp0MtzH3JHC45QYjo+A/evZOCLypDLGWTK9G+oJQlN+gZSz3ygny3626BpmGtQs6x3/PVWVGPNfN9Hi7M2THLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273981; c=relaxed/simple;
	bh=5aYaNxw9B1Vv3UwdMBqympkbBecQ21r1beQW8ZZq2DY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UvcC2tvQyRVYcbBJGPGdGANlzNyyUWoFU731fJ3BTIpoK2KRR9l+TYSgMIVm4AqOX6DRlxPaErAeTIW6/avwhncOJrDdqi8CL/G4sUW/yc7B5T0+U6fHTXzeM2ipJqAtQK6USuDDYxUxi/GhlRELTjrtdDTEQIynsD9AZhppCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSCuqPLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1AEC113CE;
	Tue, 16 Apr 2024 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713273981;
	bh=5aYaNxw9B1Vv3UwdMBqympkbBecQ21r1beQW8ZZq2DY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PSCuqPLYUlXJ9auMKlyd6garhl7QXySTp9eWlrmke6rMcEA6bSOA3LfnUC8fU3VqT
	 GPEAto9Bkx2ZM8IF4P088l7kgOxqOuEnE+bNwHq16+/nePGty9YLofePGKDd43bcpO
	 Bdahh5f5bc2i5XhtB1GX7qB/5fIWniJK4aX8YVhPxOh79o/Ndhs+KiNH0z6N0lVh55
	 UybhBviVJQNPjuhuARdJgWkKgbX/9Zb/Cjx53bCtaBpu85N8j0GDbDman9uDJ9gcGd
	 f8z5m6GHPRuEB5wi/1ujlFHNpXNGf85z3SDlMxwvjeeef71W5otMCS9CA0mdfRu71H
	 ZR/8El87zWzzA==
From: Robert Foss <rfoss@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>,
 Nícolas F. R. A. Prado <nfraprado@collabora.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Jonas Karlman <jonas@kwiboo.se>, Maxime Ripard <mripard@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Adrien Grassein <adrien.grassein@gmail.com>, Vinay Simha BN <simhavcs@gmail.com>,
 Christopher Vollo <chris@renewoutreach.org>, Marijn Suijten <marijn.suijten@somainline.org>,
 Vinod Koul <vkoul@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, owen <qwt9588@gmail.com>,
 Marek Vasut <marex@denx.de>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, kernel@collabora.com, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415-anx7625-defer-log-no-dsi-host-v3-0-619a28148e5c@collabora.com>
References: <20240415-anx7625-defer-log-no-dsi-host-v3-0-619a28148e5c@collabora.com>
Subject: Re: [PATCH v3 0/9] drm: Switch from dev_err to dev_err_probe for missing DSI host error path
Message-Id: <171327397342.20734.17712631533739758920.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 15:26:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Mon, 15 Apr 2024 17:49:28 -0400, Nícolas F. R. A. Prado wrote:
> This series changes every occurrence of the following pattern:
> 
> 	dsi_host = of_find_mipi_dsi_host_by_node(dsi);
> 	if (!dsi_host) {
> 		dev_err(dev, "failed to find dsi host\n");
> 		return -EPROBE_DEFER;
> 	}
> 
> [...]

Applied, thanks!

[1/9] drm/bridge: anx7625: Don't log an error when DSI host can't be found
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ef4a9204d594
[2/9] drm/bridge: icn6211: Don't log an error when DSI host can't be found
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=275fafe58faa
[3/9] drm/bridge: lt8912b: Don't log an error when DSI host can't be found
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=b3b4695ff47c
[4/9] drm/bridge: lt9611: Don't log an error when DSI host can't be found
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=cd0a2c6a081f
[5/9] drm/bridge: lt9611uxc: Don't log an error when DSI host can't be found
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6d9e877cde7e
[6/9] drm/bridge: tc358775: Don't log an error when DSI host can't be found
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=272377aa0e3d
[7/9] drm/bridge: dpc3433: Don't log an error when DSI host can't be found
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=24f4f575214d
[8/9] drm/panel: novatek-nt35950: Don't log an error when DSI host can't be found
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=5ff5505b9a2d
[9/9] drm/panel: truly-nt35597: Don't log an error when DSI host can't be found
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c1e4d3a6de48



Rob


