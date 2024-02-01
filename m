Return-Path: <linux-kernel+bounces-48706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9BD846001
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2F21C23F0C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3D84FA4;
	Thu,  1 Feb 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="eGCnhr4H"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750EA12FB0E;
	Thu,  1 Feb 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812370; cv=none; b=AhPwrmwi8I1XpFDi7NeoRDKbjZN3FFEglP9dyIuhgt46kWlV0LPoG6vrT1dusPcxW4THHxBBdEU6Ti5mm8QJVy2bp7qOmlSzn+0oMGWB9r4u435gbdcirrJrO73vQPAKUi8lSqMybMWLTw8qI3QJfh0UTHlIPTKokGZvHCRM7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812370; c=relaxed/simple;
	bh=wZ9VdrbqGguByilww7f+VjWtMoe0T6OV6lhMCQuXgL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/adhRr1z46Nn963iKPJ5rXx4rSA6t2l3WniaLQ2cJJbBq4xsybim4pNP0pwc5GDVzYpyk3bcl4e720cwLniG+0VxS+GGLqtqr8W+zxRtIghVr3BhL4Y50st978Hqhrb0wtR9OlSjJRi9u9rB4550gQk0OMnTsQUfa0eRAtsMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=eGCnhr4H; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout4.routing.net (Postfix) with ESMTP id B9F2A1007E6;
	Thu,  1 Feb 2024 18:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1706811857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jawm/pvTHWX0WYgxucSztSNdUiVaRemAzUoNvh+bK2k=;
	b=eGCnhr4HzH1KvYXRdshr8/vanq39eYij3BPDTAORTAZcoNqtCFZPijY9q47tbwMmLj9Dxy
	0tDwX1YB89ZRx6pnDJQHiIN5s7GAyBBDb9uh19MSPpdQnJCj+ZSxaWY+SLar+npGuRJVoM
	C+BtmDpofNko99cObq8sly+CbGratwo=
Received: from frank-G5.. (fttx-pool-217.61.148.248.bambit.de [217.61.148.248])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id D30CC40533;
	Thu,  1 Feb 2024 18:24:16 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 2/2] clk: mediatek: add infracfg reset controller for mt7988
Date: Thu,  1 Feb 2024 19:24:09 +0100
Message-Id: <20240201182409.39878-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201182409.39878-1-linux@fw-web.de>
References: <20240201182409.39878-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 55057060-11c3-4130-9e0b-b79a9f6df589

From: Frank Wunderlich <frank-w@public-files.de>

Infracfg can also operate as reset controller, add support for it.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v4: unchanged
v3:
- start with RST0 (LVTS is in RST1)
- rename reset offset to contain SOC to not collide with constants
  defined in reset.h
---
 drivers/clk/mediatek/clk-mt7988-infracfg.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
index 8011ef278bea..449041f8abbc 100644
--- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
@@ -14,6 +14,10 @@
 #include "clk-gate.h"
 #include "clk-mux.h"
 #include <dt-bindings/clock/mediatek,mt7988-clk.h>
+#include <dt-bindings/reset/mediatek,mt7988-resets.h>
+
+#define	MT7988_INFRA_RST0_SET_OFFSET	0x70
+#define	MT7988_INFRA_RST1_SET_OFFSET	0x80
 
 static DEFINE_SPINLOCK(mt7988_clk_lock);
 
@@ -249,12 +253,31 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA3(CLK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3", "sysaxi_sel", 31),
 };
 
+static u16 infra_rst_ofs[] = {
+	MT7988_INFRA_RST0_SET_OFFSET,
+	MT7988_INFRA_RST1_SET_OFFSET,
+};
+
+static u16 infra_idx_map[] = {
+	[MT7988_INFRA_RST0_PEXTP_MAC_SWRST] = 0 * RST_NR_PER_BANK + 6,
+	[MT7988_INFRA_RST1_THERM_CTRL_SWRST] = 1 * RST_NR_PER_BANK + 9,
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


