Return-Path: <linux-kernel+bounces-113338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A22888386
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832001C23439
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70900197CA9;
	Sun, 24 Mar 2024 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8Wo+qON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40F197C8B;
	Sun, 24 Mar 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320139; cv=none; b=VWBlZHQv52zxPh5fkhxX2xxyHczd3ZlVKTJSjXarjiERPT0f5B3+D7IEO15Oc1kgUtegPX482LRbU4LNMQGk7ELA5yhezKGQX9v5MPDQnq72EJuE4hATd6QBa6YzVZgxG4Cum0UKZ6BHT0Tip692gDF0SQH2Me+EzlsH5JZNRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320139; c=relaxed/simple;
	bh=LWuvjGXmSIv+FW+AijAYZOvNO/xI0y8Az5kY4SNjsaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQtJeov8bX+n9s82Nc6HyHJA6qCOuxMIO9l07lyFaN1CYYHMi9bDQ8j8wk1L4QnbfTz/8LI/m7lUYlk6MWZcjVegzTPqDFRprUxm2tQd0XkhNE4YtYFkwzdxDFy3EtxwKcAKjUzEzBeru2zq6MZQp0y2z3p7QEdlv/SaSX4Jc2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8Wo+qON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A233BC43394;
	Sun, 24 Mar 2024 22:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320139;
	bh=LWuvjGXmSIv+FW+AijAYZOvNO/xI0y8Az5kY4SNjsaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8Wo+qONKqUMsUtVvpnzaEJsMiARCoKnNsuhwalMxlTJIdw3uBL3gTeYQPb60oeMf
	 alFzWrfaAl4qK77gjiA+i3j2fcagzHgFEC76IOaC8SJhiyAaW86v+sumxnmKDPPcYh
	 6jnKmRSXopbZn6u1Q7+vBvZaE32XKyxl5805uEXDM4J/krfW5A9JNzPVCxD3GBe11d
	 cowV9qKm+edpCR1xjPQFsDmU22lhGAXmVTsfE2gSx78IvFoSAC6v2AT7oCTMahOMqD
	 jzoq2dhg2IR6elv+7ARKwKGhH+fmdj66/2KRZiniBjaJcVXJToDHUcN+IY/uHUBwu5
	 Wd99BuN29gIcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 447/715] drm/mediatek: dsi: Fix DSI RGB666 formats and definitions
Date: Sun, 24 Mar 2024 18:30:26 -0400
Message-ID: <20240324223455.1342824-448-sashal@kernel.org>
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
index a2fdfc8ddb153..cd19885ee017f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -71,8 +71,8 @@
 #define DSI_PS_WC			0x3fff
 #define DSI_PS_SEL			(3 << 16)
 #define PACKED_PS_16BIT_RGB565		(0 << 16)
-#define LOOSELY_PS_18BIT_RGB666		(1 << 16)
-#define PACKED_PS_18BIT_RGB666		(2 << 16)
+#define PACKED_PS_18BIT_RGB666		(1 << 16)
+#define LOOSELY_PS_24BIT_RGB666		(2 << 16)
 #define PACKED_PS_24BIT_RGB888		(3 << 16)
 
 #define DSI_VSA_NL		0x20
@@ -369,10 +369,10 @@ static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
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
@@ -426,7 +426,7 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
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


