Return-Path: <linux-kernel+bounces-66449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F15855CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2A01F27B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38EE1B80F;
	Thu, 15 Feb 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B3FPVJBT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB551802B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987209; cv=none; b=NYuqfHx9FXyjrYp1GYmF1bN4xmzP+XCfh7oBojVJckWIy4D6C956CpyreZQ3Uqlcbyz6poJnOUA4/0QFb32FNFEBawKOsXgJQbU76JoRqM+9Ldwkwp07tPyx+BR+n05Y/v6GCpbvSTYl30eK2auYdTjSKLiDun90fVMbDN8GnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987209; c=relaxed/simple;
	bh=2zkji/ritVm9wuEz/banneCsWweoQ6s31HP8aLRF9xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJ980bI2mejthXyFHlejaVX+hKNUNhuyR2Ek9ogqYHRVGwcTkXo8srYM4PUzYi9uTdrtr3gXC9ffDgBPBMIyHhsaBLgXBjZfuBtEDpsXcqJylHQqsdfZOvTuntiJc7l7znxA7X2hlmSIsiWO3ZBueSit9Fcal+Keni3/xPgu6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B3FPVJBT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707987206;
	bh=2zkji/ritVm9wuEz/banneCsWweoQ6s31HP8aLRF9xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3FPVJBTawSqDJcWvLw3Q8kBp2OJipJE9pJrhvYWXDAVyXNw/KezuIWCgwtSQ7ZH6
	 4hAzH9bVJ250wXNp0pWYGMxmi6SferqVOVNitib53vZKrjPzZSMBrZ72zE4I1ji/rH
	 AG5Inyi1ay/fNhKqDSM3e+CGXsdHKRwQq0bPwFb52jdyfBLdIC+w7oD+JEUV3jyPkB
	 wE4SotuZP2J+wE/pP2vff941VT6ToKR3bVNsQkFjfky5soMr9tHvyU6vGjcrpJ2saR
	 d1v+gU8fIvnmWRn9ysVsxZLhtgY3FTv5RU47BvznyDda4+trjaHMIwKXQolVbEEVRF
	 W1ij0e325/AQg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 235D737820AD;
	Thu, 15 Feb 2024 08:53:25 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: fshao@chromium.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	Alexandre Mergnat <amergnat@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v6 5/9] drm/mediatek: dsi: Replace open-coded instance of HZ_PER_MHZ
Date: Thu, 15 Feb 2024 09:53:12 +0100
Message-ID: <20240215085316.56835-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215085316.56835-1-angelogioacchino.delregno@collabora.com>
References: <20240215085316.56835-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mtk_dsi_phy_timconfig(), we're dividing the `data_rate` variable,
expressed in Hz to retrieve a value in MHz: instead of open-coding,
use the HZ_PER_MHZ definition, available in linux/units.h.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index a330bb94c44a..52758cab0abf 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -13,6 +13,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 
 #include <video/mipi_display.h>
 #include <video/videomode.h>
@@ -238,7 +239,7 @@ static void mtk_dsi_mask(struct mtk_dsi *dsi, u32 offset, u32 mask, u32 data)
 static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
 {
 	u32 timcon0, timcon1, timcon2, timcon3;
-	u32 data_rate_mhz = DIV_ROUND_UP(dsi->data_rate, 1000000);
+	u32 data_rate_mhz = DIV_ROUND_UP(dsi->data_rate, HZ_PER_MHZ);
 	struct mtk_phy_timing *timing = &dsi->phy_timing;
 
 	timing->lpx = (60 * data_rate_mhz / (8 * 1000)) + 1;
-- 
2.43.0


