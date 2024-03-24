Return-Path: <linux-kernel+bounces-113336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5764888382
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9D4B23992
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65274197570;
	Sun, 24 Mar 2024 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfGrQG3m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B80197556;
	Sun, 24 Mar 2024 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320137; cv=none; b=agsOjmLTXSginK74OnnpKVOceYj/vdsrcRbnMsrB13s3amvmu8QlbZgChbVYnEkMSChfwEjspNb3KtH9l9zCQYgIArhsrUHdnrY6L1m7EU4xV+kIP+TNcW3FS7JYZ8yors8qmAKQKo5ebnHCZXrl2kNsVyMARCmhbAVDZwgcJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320137; c=relaxed/simple;
	bh=4Pifb5AJvYoo9hicW30zaoIO+NIJr687Z2Bg2EdtRUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+pGyWBbi+L+7xnSocgwW3qU6260wilnmsxCC/gbqqLk1gOZf1oC+MpoEyCkiJH99m82ciW7lqu3zEcxrMvLzA2sm+gNAFe8DrANaytIKwR/pzcVX5nt/YP4ODYs9vXKPTK9/8RaaJqd4AFQHnw/6DOD9LL0J7nona+lu0fgf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfGrQG3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE65C43399;
	Sun, 24 Mar 2024 22:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320137;
	bh=4Pifb5AJvYoo9hicW30zaoIO+NIJr687Z2Bg2EdtRUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rfGrQG3mZdiZe9tXItxDLhe8nUQAwafDSPZxTz+AGnyTsrdRByn4cYil56/etmMTR
	 hk8IuWDsrJzGl+W2UEITNOUuPcldUpu+L7CzQbLX48WXVU+feGYZf1HlZ67CD62mfT
	 YtETyvtXYRIzIN9bA2gwz+pq24xjnrTugah2vBTyLNCqUDWGyhNQryjcZnXdkO7vuf
	 r5Zk2fE0sd4xCwmq+itEFGeAwoiFI/Wl32IAA9/MAdXWoyVPAh4GHCchSAR1j01X8F
	 tA/3enm4VaQfZT5oo11n31dvkPNZGIlMBTBsszfHbgVTxV1ctHci7+ParIFjwkGFem
	 5Vbff0RgorqyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 445/715] drm/panel: boe-tv101wum-nl6: make use of prepare_prev_first
Date: Sun, 24 Mar 2024 18:30:24 -0400
Message-ID: <20240324223455.1342824-446-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 4945a1e787eb3..0ffe8f8c01de8 100644
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


