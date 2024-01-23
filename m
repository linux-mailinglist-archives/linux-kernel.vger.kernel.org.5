Return-Path: <linux-kernel+bounces-35695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40BD83953E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A98D2906F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228F80022;
	Tue, 23 Jan 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NmnmDc/D"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E147F7DC;
	Tue, 23 Jan 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028317; cv=none; b=c3Cr298QWxiHVHoIUEB3fuYd4xppwO8I8HpTVvVKt0ywEyfqRN2u87frysXJt1FtLRqt02C6gXODKPMnKtWhcGOibe5Wf3BghEQaVX9bHpfeepmh70wWLU0KsOC2kgGdXWOxCGIpXo+sAOkNF5EwNvK6Mq9yrteE56Yi90QLZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028317; c=relaxed/simple;
	bh=pKm6K3qlmS/hE0NSSbEJSQGcka7r+08244krdMyxaY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBgd1BSAhwcmSUUExKV0fsHmaUUc8QPQ98vxQ3PdJVOD+e8CkF74gYflPhlAkg184ADUF0Csx85tTrEo4xIRWChp/8KZXp5I9ZsgVpTgFODWbux3U3DvAkYlrxALpbXgvq67b5dnhc53rZhMNveT2B9fzKlFrShS4UCBoMo5hYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NmnmDc/D; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGilHP095275;
	Tue, 23 Jan 2024 10:44:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706028287;
	bh=Cq6GMsgXSjuAInYO12ihGfj7M9z8z7eyXvTjfe/OzM0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NmnmDc/DpHx4WzsmFPvkU2GJqmp0uvfBwhSGcsB8nurUq9nGOGbmaKA90daEp/UPL
	 BkaHWG55C1/uB//MFQIbdGR7TuOIrhQLu6KL9wlXn9ZYNffrkb1zmu0q/C6HWN7/iH
	 sr2fqbNI3ty86u7BGscQYEqSFnPaCiG9c9PzLAzw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGilKm127516
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:44:47 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:44:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:44:46 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGiiKH022038;
	Tue, 23 Jan 2024 10:44:46 -0600
From: Andrew Davis <afd@ti.com>
To: Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Karol Gugala
	<kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel
 Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Mark Brown
	<broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Lee
 Jones <lee@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 2/4] drivers/soc/litex: Use devm_register_restart_handler()
Date: Tue, 23 Jan 2024 10:44:41 -0600
Message-ID: <20240123164443.394642-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123164443.394642-1-afd@ti.com>
References: <20240123164443.394642-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use device life-cycle managed register function to simplify probe error
path and eliminate need for explicit remove function.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/soc/litex/litex_soc_ctrl.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index 10813299aa106..7a0096d93c73d 100644
--- a/drivers/soc/litex/litex_soc_ctrl.c
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -69,14 +69,11 @@ static int litex_check_csr_access(void __iomem *reg_addr)
 
 struct litex_soc_ctrl_device {
 	void __iomem *base;
-	struct notifier_block reset_nb;
 };
 
-static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
-			       void *cmd)
+static int litex_reset_handler(struct sys_off_data *data)
 {
-	struct litex_soc_ctrl_device *soc_ctrl_dev =
-		container_of(this, struct litex_soc_ctrl_device, reset_nb);
+	struct litex_soc_ctrl_device *soc_ctrl_dev = data->cb_data;
 
 	litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
 	return NOTIFY_DONE;
@@ -107,11 +104,9 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	platform_set_drvdata(pdev, soc_ctrl_dev);
-
-	soc_ctrl_dev->reset_nb.notifier_call = litex_reset_handler;
-	soc_ctrl_dev->reset_nb.priority = 128;
-	error = register_restart_handler(&soc_ctrl_dev->reset_nb);
+	error = devm_register_restart_handler(&pdev->dev,
+					      litex_reset_handler,
+					      soc_ctrl_dev);
 	if (error) {
 		dev_warn(&pdev->dev, "cannot register restart handler: %d\n",
 			 error);
@@ -120,20 +115,12 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void litex_soc_ctrl_remove(struct platform_device *pdev)
-{
-	struct litex_soc_ctrl_device *soc_ctrl_dev = platform_get_drvdata(pdev);
-
-	unregister_restart_handler(&soc_ctrl_dev->reset_nb);
-}
-
 static struct platform_driver litex_soc_ctrl_driver = {
 	.driver = {
 		.name = "litex-soc-controller",
 		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
 	},
 	.probe = litex_soc_ctrl_probe,
-	.remove_new = litex_soc_ctrl_remove,
 };
 
 module_platform_driver(litex_soc_ctrl_driver);
-- 
2.39.2


