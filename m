Return-Path: <linux-kernel+bounces-115478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D358893FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517C01F24FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F68D157E6D;
	Mon, 25 Mar 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5ww0uxS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC31DCCAE;
	Sun, 24 Mar 2024 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320913; cv=none; b=aBAv1Rjj6AF6nL9V9KHnwwabiGnj6f6YyTdBvyrdeDkPH3Y1n7miMXR4iL0YRLK58T2jsnsIJtoegQSTuhdV/euiIEw5vYuY996mDaEqTxc4WrTvMc5f3Ve5De5X3GgJfzC47vIiedfcQuOQJZKCWqpKW6GjOI+9xHnnq6E2S3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320913; c=relaxed/simple;
	bh=kB9jl1qMMQaC+HGZkILpshVUAWry7MsqV7jwPaM+sUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+N/BnFBp+/MGrGe1bEbCUWcdEZZI7ESM+oc0u605fTfNaVlYMCdXCIXzijJPb3upQcvm9zEFsm3Iq2BlrCv6u/eDh9qEdFuvzKcdR2eP4PEDa9nDPrPQQJ0KNRYgIY73LbSaPedbtABeoTbdoaIn33OXfOH5iE46sjC8E7p1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5ww0uxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDDDC43394;
	Sun, 24 Mar 2024 22:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320912;
	bh=kB9jl1qMMQaC+HGZkILpshVUAWry7MsqV7jwPaM+sUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5ww0uxS1zdE8ZjSMHUtUMYb82E+kgtILpGyPl6m7NQRwL07PQ2/pM9TOjzyeQpyn
	 6eYvOZVcL7ogHytWB/YpwK6yFmlR6p2dY12CwJ2B4iVTME83wHQApJq11+Bm7dHHdt
	 BEMhZ0RjsSxDxMK0lZesh7jI9EFQjJliIWs6hzKvKAqGBIMgeGa7ZkjDJRugAJ+A0w
	 Yb+sOJuK4NTFNiN2TpYquFRiXtyLgcPH1BSRP8AtKvjX/+8JBWjA0/3YlJ5bVr83my
	 G2dPWqYZBj2B6gwFzA2AWkyvzbR658o01tsjf/Z/hPcr4q6ux2YTAnICfpEVUChbkL
	 vHESn8q1VVQZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 475/713] drm/panel: boe-tv101wum-nl6: make use of prepare_prev_first
Date: Sun, 24 Mar 2024 18:43:21 -0400
Message-ID: <20240324224720.1345309-476-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 42a7a16bedc991190310a02dd202e29cfac52525 ]

The panel on sc7180-trogdor-wormdingler and
sc7180-trogdor-quackingstick hasn't been coming up since commit
9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts
at modeset"). Let's add "prepare_prev_first" as has been done for many
other DSI panels.

Fixes: 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Link: https://lore.kernel.org/r/20240216123111.1.I71c103720909790e1ec5a3f5bd96b18ab7b596fa@changeid
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240216123111.1.I71c103720909790e1ec5a3f5bd96b18ab7b596fa@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index c4c0f08e92026..bc08814954f9b 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1871,6 +1871,8 @@ static int boe_panel_add(struct boe_panel *boe)
 
 	gpiod_set_value(boe->enable_gpio, 0);
 
+	boe->base.prepare_prev_first = true;
+
 	drm_panel_init(&boe->base, dev, &boe_panel_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
 	err = of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
-- 
2.43.0


