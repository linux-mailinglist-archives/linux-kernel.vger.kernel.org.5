Return-Path: <linux-kernel+bounces-35697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D1F839545
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8132D1F2F4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE19811EC;
	Tue, 23 Jan 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aRu2NBH+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F548003D;
	Tue, 23 Jan 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028336; cv=none; b=TawQK+V3hpAxeegbL2M3t9IE+oLDgUuzVx/y+d+XvzQ3tc0sg705bGPRoICz7mPrM8qmaZ+nV7hOtuLuzJXq2920nqx17q1a+qE5mToZnHRTO3+L+VoF81aFnijTIGgUEX40FdLsqZUpk2ux3iDM9Vun5ex94FNSoAKBNEuOaDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028336; c=relaxed/simple;
	bh=8LjL26PYrPwCrvs/xSN0nyOOCGfpd558CyvkBVEVt2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJKRLYUWmd+pJ+edJtnNMI4ifMfT11Eh9q4VdK+fYOhqROC/3rL6RRhhqzTROo7pW/hp/OfpN/4jkNOEbhvbAPMDme5WRNqNyys1f7xhdLlGw7kGOVwM2ZU5LJpXI63kmgCm0e3GlmTPy58lv9BiyQjHapUaNVi6qNkkIp1ETPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aRu2NBH+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGimmf101836;
	Tue, 23 Jan 2024 10:44:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706028288;
	bh=6OrX3DPXnzALpnhReuLUjIJGvye7DyNGb/CoW91+Q9Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aRu2NBH+Jl34untySgYsJ01x94ByIoIEXYUbivOB09rHgr91C1x3H10BrGV/WTgaN
	 vjfxeS3UWpG+j6SPnK/fTdcYOgsuYivuoRPIM0QgP9VAbLKYoLj/kcFu0rTEg2BVEN
	 /LXH3crLEaSPXs1UEN0suP5rAaFW876Mhopb5Xdw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGimBu011494
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:44:48 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:44:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:44:48 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGiiKJ022038;
	Tue, 23 Jan 2024 10:44:47 -0600
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
Subject: [PATCH 4/4] firmware: ti_sci: Use devm_register_restart_handler()
Date: Tue, 23 Jan 2024 10:44:43 -0600
Message-ID: <20240123164443.394642-5-afd@ti.com>
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

Use device life-cycle managed register function to simplify probe.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/firmware/ti_sci.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 8b9a2556de16d..16501aa0b84cf 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -103,7 +103,6 @@ struct ti_sci_desc {
  */
 struct ti_sci_info {
 	struct device *dev;
-	struct notifier_block nb;
 	const struct ti_sci_desc *desc;
 	struct dentry *d;
 	void __iomem *debug_region;
@@ -122,7 +121,6 @@ struct ti_sci_info {
 
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
 #define handle_to_ti_sci_info(h) container_of(h, struct ti_sci_info, handle)
-#define reboot_to_ti_sci_info(n) container_of(n, struct ti_sci_info, nb)
 
 #ifdef CONFIG_DEBUG_FS
 
@@ -3254,10 +3252,9 @@ devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_ti_sci_get_resource);
 
-static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
-				void *cmd)
+static int tisci_reboot_handler(struct sys_off_data *data)
 {
-	struct ti_sci_info *info = reboot_to_ti_sci_info(nb);
+	struct ti_sci_info *info = data->cb_data;
 	const struct ti_sci_handle *handle = &info->handle;
 
 	ti_sci_cmd_core_reboot(handle);
@@ -3400,10 +3397,9 @@ static int ti_sci_probe(struct platform_device *pdev)
 	ti_sci_setup_ops(info);
 
 	if (reboot) {
-		info->nb.notifier_call = tisci_reboot_handler;
-		info->nb.priority = 128;
-
-		ret = register_restart_handler(&info->nb);
+		ret = devm_register_restart_handler(dev,
+						    tisci_reboot_handler,
+						    info);
 		if (ret) {
 			dev_err(dev, "reboot registration fail(%d)\n", ret);
 			goto out;
-- 
2.39.2


