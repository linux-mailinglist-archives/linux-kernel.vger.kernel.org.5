Return-Path: <linux-kernel+bounces-17055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B68247B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325D8286575
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49B328DBD;
	Thu,  4 Jan 2024 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="NvhAQ6ZO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE6288A7;
	Thu,  4 Jan 2024 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id 5C8881014EB;
	Thu,  4 Jan 2024 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1704389987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJWaZdp7vwDloIQ8UP6qzcfjDSiX0CaWYDKppc3KgpY=;
	b=NvhAQ6ZOI6M8JUzhvDf4RvVCKfWSYjD15qznp2SPDjcWdq7TsDIXYlReV3VWMVEo0J9X4K
	KYGG8+GjSnE/h0uO8GqdjFzcdlCjFeCiGem+5ZEljgUluVK42sghQ9yJnNEjJBnOmwdYyp
	ehIsdsN6oU73vmetAaSAL9BXpTTdd5Y=
Received: from frank-G5.. (fttx-pool-157.180.226.237.bambit.de [157.180.226.237])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 8391B1007EB;
	Thu,  4 Jan 2024 17:39:46 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: linux-mediatek@lists.infradead.org
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] clk: mediatek: add infracfg reset controller for mt7988
Date: Thu,  4 Jan 2024 18:39:30 +0100
Message-Id: <20240104173930.13907-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104173930.13907-1-linux@fw-web.de>
References: <20240104173930.13907-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 6d201640-91c2-4ac9-a649-d071cf765a5b

From: Frank Wunderlich <frank-w@public-files.de>

Infracfg can also operate as reset controller, add support for it.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/clk/mediatek/clk-mt7988-infracfg.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
index 8011ef278bea..1660a45349ff 100644
--- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
@@ -14,6 +14,9 @@
 #include "clk-gate.h"
 #include "clk-mux.h"
 #include <dt-bindings/clock/mediatek,mt7988-clk.h>
+#include <dt-bindings/reset/mediatek,mt7988-resets.h>
+
+#define	INFRA_RST_SET_OFFSET	0x80
 
 static DEFINE_SPINLOCK(mt7988_clk_lock);
 
@@ -249,12 +252,29 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA3(CLK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3", "sysaxi_sel", 31),
 };
 
+static u16 infra_rst_ofs[] = {
+	INFRA_RST_SET_OFFSET,
+};
+
+static u16 infra_idx_map[] = {
+	[MT7988_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 9,
+};
+
+static struct mtk_clk_rst_desc infra_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = infra_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infra_rst_ofs),
+	.rst_idx_map = infra_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(infra_idx_map),
+};
+
 static const struct mtk_clk_desc infra_desc = {
 	.clks = infra_clks,
 	.num_clks = ARRAY_SIZE(infra_clks),
 	.mux_clks = infra_muxes,
 	.num_mux_clks = ARRAY_SIZE(infra_muxes),
 	.clk_lock = &mt7988_clk_lock,
+	.rst_desc = &infra_rst_desc,
 };
 
 static const struct of_device_id of_match_clk_mt7988_infracfg[] = {
-- 
2.34.1


