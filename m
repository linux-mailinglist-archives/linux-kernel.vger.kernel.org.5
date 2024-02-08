Return-Path: <linux-kernel+bounces-58402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F282784E610
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DD9B25B9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F568562C;
	Thu,  8 Feb 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fiop7LMw"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546C182D80;
	Thu,  8 Feb 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411876; cv=none; b=bEuf9AQi9jp4kCLV7HGbhSGuCgcFh1RP9fSpwA8ZzuRdKtluDOuzaqGElDGbdKMdMHL1Q5Wlia6Vq/VKvEwvniGVdhpb5RjZen3e1qxLDNPgp2B4FxtiDmHKBtTDvRT/bY3IgAfqxN71QopS1SWJzq4Yq2RCRtKYrb3OFW1xc4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411876; c=relaxed/simple;
	bh=/wWLg9daNT6pfazjCLsyzkG8hTMGV8b457Vt9N+MIYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCxnsE943dKSIacltnMuVg0BXNPln6hWC54upo8twnoTnT9QFizJemuJPfmbAb9dyBl5gDZ+8v/N1tPUnmrXV1krgRQ2L2N5iTZHGfyj/VxmrKSY3JwP+REqlXzO46cNZ2LfZI9quy/CtiMJoTP2u7B4uelJ6YssE9VgGigY3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fiop7LMw; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418H4Iqe018156;
	Thu, 8 Feb 2024 11:04:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411858;
	bh=cEd9h6ts7ZA9SmxTtqXrV1X3OAdroJfb+pEHlYKYQq0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fiop7LMw7ffBSbbCssLAJojFB0aFGS+AO1EE2WSOkNsqY81lfdFJP/XnCbJYce+ws
	 Ona5r0f37PR4xu4kwARLKAo+t7Jbrq/m0okEVguRpw0UcwXk7UE4/wjncjZ6t578Mb
	 8T5jFSlJE7HW/OHLMOBLcTfb5YMWgWDX2CZhm3SA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418H4IKM023356
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 11:04:18 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 11:04:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 11:04:18 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418H4B6B091006;
	Thu, 8 Feb 2024 11:04:17 -0600
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
Subject: [PATCH v3 09/19] power: reset: rmobile-reset: Use devm_platform_ioremap_resource() helper
Date: Thu, 8 Feb 2024 11:04:00 -0600
Message-ID: <20240208170410.67975-10-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208170410.67975-1-afd@ti.com>
References: <20240208170410.67975-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use device life-cycle managed ioremap function to simplify probe and
exit paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/rmobile-reset.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/rmobile-reset.c b/drivers/power/reset/rmobile-reset.c
index 5df9b41c68c79..29c17ed2d4de9 100644
--- a/drivers/power/reset/rmobile-reset.c
+++ b/drivers/power/reset/rmobile-reset.c
@@ -41,28 +41,23 @@ static int rmobile_reset_probe(struct platform_device *pdev)
 {
 	int error;
 
-	sysc_base2 = of_iomap(pdev->dev.of_node, 1);
-	if (!sysc_base2)
-		return -ENODEV;
+	sysc_base2 = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sysc_base2))
+		return PTR_ERR(sysc_base2);
 
 	error = register_restart_handler(&rmobile_reset_nb);
 	if (error) {
 		dev_err(&pdev->dev,
 			"cannot register restart handler (err=%d)\n", error);
-		goto fail_unmap;
+		return error;
 	}
 
 	return 0;
-
-fail_unmap:
-	iounmap(sysc_base2);
-	return error;
 }
 
 static void rmobile_reset_remove(struct platform_device *pdev)
 {
 	unregister_restart_handler(&rmobile_reset_nb);
-	iounmap(sysc_base2);
 }
 
 static const struct of_device_id rmobile_reset_of_match[] = {
-- 
2.39.2


