Return-Path: <linux-kernel+bounces-102576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39787B424
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69B02842DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A60159B42;
	Wed, 13 Mar 2024 22:06:08 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABE59163;
	Wed, 13 Mar 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367567; cv=none; b=Zws3bRga2DnTwswtFvHsAv/6RRbXNFV6oaUV03+ad78KRYAIXD3qPdDOuHmML8QzmvpnQojCxMJUC9p7TuBfV1RuxpS2zBSX/DhmefbGG8X5vvy+CLsh/sQSoiTMShv/VrxVNsutdyq0tLGoftbUXrn/NnGFdAMfKMV8GVI0cq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367567; c=relaxed/simple;
	bh=RwVzF1CZDtSXuNTumUDSY351N/2l/elvBx5IVgBSTE0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GwC/k/lW5dEX0UemIMAP03yOvuImFQA3SphvInHvdr5WTXF8jIX/FQeeoRX2ZtgmNknW4oB2wH2hQ73r2UJ1VeVDmb2SF74h7Xr+VRVAeqF25h3oaI40ucTc8lDgnEGFXp/5fZo9rogSYW6NbMn0WONtBAqK4TSeeWeaJyk2lm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rkWjI-0003qS-1T;
	Wed, 13 Mar 2024 22:05:44 +0000
Date: Wed, 13 Mar 2024 22:05:37 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: mt7988-infracfg: fix clocks for 2nd PCIe port
Message-ID: <1da2506a51f970706bf4ec9509dd04e0471065e5.1710367453.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Due to what seems to be an undocumented oddity in MediaTek's MT7988
SoC design the CLK_INFRA_PCIE_PERI_26M_CK_P2 clock requires
CLK_INFRA_PCIE_PERI_26M_CK_P3 to be enabled.

This currently leads to PCIe port 2 not working in Linux.

Reflect the apparent relationship in the clk driver to make sure PCIe
port 2 of the MT7988 SoC works.

Fixes: 4b4719437d85f ("clk: mediatek: add drivers for MT7988 SoC")
Suggested-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/clk/mediatek/clk-mt7988-infracfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
index 449041f8abbc9..c8c023afe3e5a 100644
--- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
@@ -156,7 +156,7 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA0(CLK_INFRA_PCIE_PERI_26M_CK_P1, "infra_pcie_peri_ck_26m_ck_p1",
 		    "csw_infra_f26m_sel", 8),
 	GATE_INFRA0(CLK_INFRA_PCIE_PERI_26M_CK_P2, "infra_pcie_peri_ck_26m_ck_p2",
-		    "csw_infra_f26m_sel", 9),
+		    "infra_pcie_peri_ck_26m_ck_p3", 9),
 	GATE_INFRA0(CLK_INFRA_PCIE_PERI_26M_CK_P3, "infra_pcie_peri_ck_26m_ck_p3",
 		    "csw_infra_f26m_sel", 10),
 	/* INFRA1 */
-- 
2.44.0


