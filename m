Return-Path: <linux-kernel+bounces-61959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CE285192D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89691F21D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179253E47A;
	Mon, 12 Feb 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H/SZ7sbI"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86793D3A1;
	Mon, 12 Feb 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755329; cv=none; b=aL5sR7O+SVGjIXBTIiNDYgOa/yU0IW7q86y8+2XuZqQw/cnnhK+DpfeFLXSYs9XBVML7TUb/6XhjbZEqHGt8PVuC2GkFxaawpc0XwJJ91dx+jC7rdfdBNsqPK+iMMvmIRZuS6WctvMDIt09oQTiP5zGpWUj/U/5caaM4QaSRHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755329; c=relaxed/simple;
	bh=F6j/rd2uqE1cUyZDghMq6eHqquIs5sdJYRKTy0Bo8is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHOv1Uy9Nfk9oQrUCigLMhtGDvXzfCrqcDPJVipyaLuCz8yNKWUV0pabxQaayK037PKBTs0toBnMZfA/UK/xOX/dNuG0iqOJxHPA6FyijwDlOmBr9qTLFXnt18+tjaajsWpraTQg3QbkE08pGiV81pZhL4TxceR99TPp3QRBfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H/SZ7sbI; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSadb045193;
	Mon, 12 Feb 2024 10:28:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755316;
	bh=9UwPUx+fSL3rKTkctxFppsbeFk236+6n4WL7g1DOd5Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=H/SZ7sbIjF3f0d2pCXRXRcE1gqiSFH3sJ7VDWYej5cVWcGSZ0j9duBlwWbClBLx9E
	 4wdk7UquWUJ8x6R2UQE5QAZ9U9tapK/leEWi76TNb3wvuLWecH0oP+G3Idn4zBN9OS
	 +ytSakjCSxSpGX++wxeFacgFM9WzOC2OTf2tjdpE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGSaa5041911
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:36 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:35 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWR0090688;
	Mon, 12 Feb 2024 10:28:35 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Cristian Ciocaltea
	<cristian.ciocaltea@gmail.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-actions@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 04/19] power: reset: xgene-reboot: Use devm_register_sys_off_handler(RESTART)
Date: Mon, 12 Feb 2024 10:28:16 -0600
Message-ID: <20240212162831.67838-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212162831.67838-1-afd@ti.com>
References: <20240212162831.67838-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use device life-cycle managed register function to simplify probe.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/xgene-reboot.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index 6b545a83d8889..867162dfe7eae 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -24,15 +24,11 @@ struct xgene_reboot_context {
 	struct device *dev;
 	void __iomem *csr;
 	u32 mask;
-	struct notifier_block restart_handler;
 };
 
-static int xgene_restart_handler(struct notifier_block *this,
-				 unsigned long mode, void *cmd)
+static int xgene_restart_handler(struct sys_off_data *data)
 {
-	struct xgene_reboot_context *ctx =
-		container_of(this, struct xgene_reboot_context,
-			     restart_handler);
+	struct xgene_reboot_context *ctx = data->cb_data;
 
 	/* Issue the reboot */
 	writel(ctx->mask, ctx->csr);
@@ -64,9 +60,8 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 		ctx->mask = 0xFFFFFFFF;
 
 	ctx->dev = dev;
-	ctx->restart_handler.notifier_call = xgene_restart_handler;
-	ctx->restart_handler.priority = 128;
-	err = register_restart_handler(&ctx->restart_handler);
+	err = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART, 128,
+					    xgene_restart_handler, ctx);
 	if (err)
 		dev_err(dev, "cannot register restart handler (err=%d)\n", err);
 
-- 
2.39.2


