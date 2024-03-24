Return-Path: <linux-kernel+bounces-114832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC4889264
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283BE1C2E18C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ABD13D634;
	Mon, 25 Mar 2024 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGjJIR+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C05176FD2;
	Sun, 24 Mar 2024 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323467; cv=none; b=HOFRpOab3QIA9F+t5YHM+xARN0HE9OLlmIX2SeSWkVPI+qwz9AVvzL1XdVpf79Y5zzGx/2+6+UORDxvMLXSMuDS6slb7fxB/Dgf0p2PSvPttc7k/+1lqzNy4CFfGpIPdQWU+yXKQ64UUJiVhBgFFNhSzGOYhpcBLZXCMxrWMbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323467; c=relaxed/simple;
	bh=J0fDjy152EtNO15ikgnXe/MOlRKpzLGtPE+LYyFXyj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTimVp3fxxzjdtHyhD3aSGW4CII/0PZYGqF6SN++S9ekSemAHJ3LKdvdxYmpgnfdhja4vWaX9sSqHtt6aYxZiH9AyY5xm96kQDXFNcs3W8QMQNb0UVFYDDb/kCU1zNR6fQWKcc+c5MVqiDZYQLMuOpcGuz8q+RKddErQEACJ7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGjJIR+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0767AC43390;
	Sun, 24 Mar 2024 23:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323465;
	bh=J0fDjy152EtNO15ikgnXe/MOlRKpzLGtPE+LYyFXyj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGjJIR+yy9aldWaPiy4iJPmJig3NTDYa6uO0n7n1taTSIHzWkYUb1nMyfJ5vZUotp
	 KHiH+DBeueUq/NGF48sjwqL75JqzK8W4Pu9D6sXDL0xggzWGEBi1UGmbV3BH2ERLxX
	 s3IIBeZwyQkgcq/hadhyE1LIDwHL+LPfPdFl6I0Uej893WiaW1WC3hAoaHWstos1zJ
	 9raEzO0cj6PDTHJ3kJ7ZUc24hVkr+gbr2a7MqSs/KNrTFHwewyDCPAai/o0+06u9yr
	 AVSrmwYuWaRQsNQaWOKBuK70BB/dHRn/lt1FVsqpuLUud3cIyyickPhf/IqIyt1ZHf
	 qzvOZ27EF8t1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 170/317] drm/rockchip: lvds: do not overwrite error code
Date: Sun, 24 Mar 2024 19:32:30 -0400
Message-ID: <20240324233458.1352854-171-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

[ Upstream commit 79b09453c4e369ca81cfb670d0136d089e3b92f0 ]

ret variable stores the return value of drm_of_find_panel_or_bridge
which can return error codes different from EPROBE_DEFER. Therefore,
let's just return that error code instead of forcing it to EPROBE_DEFER.

Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20231120-rk-lvds-defer-msg-v2-1-9c59a5779cf9@theobroma-systems.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 2550429df49fe..4cae30979a790 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -573,7 +573,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		goto err_put_port;
 	} else if (ret) {
 		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
-		ret = -EPROBE_DEFER;
 		goto err_put_port;
 	}
 	if (lvds->panel)
-- 
2.43.0


