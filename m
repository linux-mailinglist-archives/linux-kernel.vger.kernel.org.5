Return-Path: <linux-kernel+bounces-115128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D587388931E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134EA1C2E396
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EED22FF8D8;
	Mon, 25 Mar 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxJPRFop"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4E181CEE;
	Sun, 24 Mar 2024 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324126; cv=none; b=TVIQ3i7LuEYKP6+asWE+a5DoTo/IPEaCl/05r/0BP7DYiewz9g5OCdHZw0vJFRfrQXeiJGsKISt8PykpfvK8gGgjV1ija3uZ/FqjWRwqDb9OTGW8J1aq4JQv5gS5sckSvDTufpdffYC887v2iooPxpEGR9Y/jHMxl+1Ngwij248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324126; c=relaxed/simple;
	bh=ZwoDu9NJw8zKoFbb6Bko5Csdq349fZXE97KwHAXSHU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vnpp0vDr+ZS0P/a7jS1Oy7q/GOgZylqaTKi940MPyH3FqK8m3jgB9wGGV50iW7d59MLbgMmXSdUGe0PZo0BkL4ENLP6BdQqEC78lCwhkNLF6Ol/BGL8MwOwuXkCoi3zNYpdOwI9VPKKNycKhUYUenmfXrh5sR3DFm+YwdFybiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxJPRFop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A55BC433C7;
	Sun, 24 Mar 2024 23:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324125;
	bh=ZwoDu9NJw8zKoFbb6Bko5Csdq349fZXE97KwHAXSHU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxJPRFop57awjhExFgBB25DvMuofhjHTCJOx35Huv8t99VSgy2qAAge0W+8zxaQhM
	 mVwNvZzLyggiTAZl0epTrHFrRyu6s33Ke2v5gXJKYrgqSGZDcIGknqeFeC5nL7EceD
	 QgdtL4LBQspaV+eKgYFdGXLl7WFgAefu92wUhJlzY6u7De5IKgpBdyLmLReDqLLVw5
	 9cP1sLcXA3jQd8w9NDCJJRcUG3ssTATViN/+Pqa4XG/1+Sj+MVXYUsZVk2f5DihvJG
	 DZf64sAAUdM/SgeQftQzkTuO6KaGsFzSm4xRYA+18Jsj2At8yiI/rsWB2VLTsOPPBH
	 R7QV68VwDLniQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 122/183] drm/mediatek: dsi: Fix DSI RGB666 formats and definitions
Date: Sun, 24 Mar 2024 19:45:35 -0400
Message-ID: <20240324234638.1355609-123-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit fae6f815505301b92d9113764f4d76d0bfe45607 ]

The register bits definitions for RGB666 formats are wrong in multiple
ways: first, in the DSI_PS_SEL bits region, the Packed 18-bits RGB666
format is selected with bit 1, while the Loosely Packed one is bit 2,
and second - the definition name "LOOSELY_PS_18BIT_RGB666" is wrong
because the loosely packed format is 24 bits instead!

Either way, functions mtk_dsi_ps_control_vact() and mtk_dsi_ps_control()
do not even agree on the DSI_PS_SEL bit to set in DSI_PSCTRL: one sets
loosely packed (24) on RGB666, the other sets packed (18), and the other
way around for RGB666_PACKED.

Fixing this entire stack of issues is done in one go:
 - Use the correct bit for the Loosely Packed RGB666 definition
 - Rename LOOSELY_PS_18BIT_RGB666 to LOOSELY_PS_24BIT_RGB666
 - Change ps_bpp_mode in mtk_dsi_ps_control_vact() to set:
    - Loosely Packed, 24-bits for MIPI_DSI_FMT_RGB666
    - Packed, 18-bits for MIPI_DSI_FMT_RGB666_PACKED

Fixes: 2e54c14e310f ("drm/mediatek: Add DSI sub driver")
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20240215085316.56835-3-angelogioacchino.delregno@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index e82705a33acfd..9af900076dee4 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -64,8 +64,8 @@
 #define DSI_PS_WC			0x3fff
 #define DSI_PS_SEL			(3 << 16)
 #define PACKED_PS_16BIT_RGB565		(0 << 16)
-#define LOOSELY_PS_18BIT_RGB666		(1 << 16)
-#define PACKED_PS_18BIT_RGB666		(2 << 16)
+#define PACKED_PS_18BIT_RGB666		(1 << 16)
+#define LOOSELY_PS_24BIT_RGB666		(2 << 16)
 #define PACKED_PS_24BIT_RGB888		(3 << 16)
 
 #define DSI_VSA_NL		0x20
@@ -321,10 +321,10 @@ static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
 		ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
+		ps_bpp_mode |= LOOSELY_PS_24BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-		ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
+		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB565:
 		ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
@@ -375,7 +375,7 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
 		dsi_tmp_buf_bpp = 3;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		tmp_reg = LOOSELY_PS_18BIT_RGB666;
+		tmp_reg = LOOSELY_PS_24BIT_RGB666;
 		dsi_tmp_buf_bpp = 3;
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-- 
2.43.0


