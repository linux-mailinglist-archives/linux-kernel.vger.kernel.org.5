Return-Path: <linux-kernel+bounces-154528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684828ADD25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35FBB2224D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC2220DD2;
	Tue, 23 Apr 2024 05:32:43 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EA208A0;
	Tue, 23 Apr 2024 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713850363; cv=none; b=suar9OJ4/2HCxCbDfHPmlaj63/tyCizrNfieqojeJ2bNAWrv9qFHAOYkQPeSFtG91M6h22itvbIWrrG+BuddMLAJNlPCAnLujWIl09HowNYniqTyiUMSOc1zBgXv/vr5Fswatj646RZiKUOylJ9m8/ahQ2No0cc+zQJbZIShv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713850363; c=relaxed/simple;
	bh=+azLDfk/XeFroGKgVqni53cR/vzETd6dF45ytF23To8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VC7l6wwB0lN9wi9+bOrkGxDXXtsQWfvwS8xZGqFwYJJ5n2CXNgmMcgiExFleBOxY6OqcbrOfc1chQ3KP4/OVOeT9+nTZXeORJMaoVJuE9Ex3bs6cFfidQAel1JDoesQkWzKis3Qks1BHktx274eUdMSWBKS/l8x6+8AvsnM8cSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D33FA20081E;
	Tue, 23 Apr 2024 07:26:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B9532005F3;
	Tue, 23 Apr 2024 07:26:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 21EEC180222C;
	Tue, 23 Apr 2024 13:26:55 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: imx8mp: Use modern pm_ops
Date: Tue, 23 Apr 2024 13:08:37 +0800
Message-Id: <1713848917-13380-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Without CONFIG_PM, the driver warns about unused functions

./drivers/clk/imx/clk-imx8mp-audiomix.c:363:12: warning: 'clk_imx8mp_audiomix_runtime_resume' defined but not used [-Wunused-function]
  363 | static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./drivers/clk/imx/clk-imx8mp-audiomix.c:356:12: warning: 'clk_imx8mp_audiomix_runtime_suspend' defined but not used [-Wunused-function]
  356 | static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change the old SET_RUNTIME_PM_OPS()/SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()
helpers to their modern replacements that avoid the warning.

Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index 574a032309c1..e4231e9c8f05 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -368,10 +368,10 @@ static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops clk_imx8mp_audiomix_pm_ops = {
-	SET_RUNTIME_PM_OPS(clk_imx8mp_audiomix_runtime_suspend,
-			   clk_imx8mp_audiomix_runtime_resume, NULL)
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				      pm_runtime_force_resume)
+	RUNTIME_PM_OPS(clk_imx8mp_audiomix_runtime_suspend,
+		       clk_imx8mp_audiomix_runtime_resume, NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				  pm_runtime_force_resume)
 };
 
 static const struct of_device_id clk_imx8mp_audiomix_of_match[] = {
@@ -386,7 +386,7 @@ static struct platform_driver clk_imx8mp_audiomix_driver = {
 	.driver = {
 		.name = "imx8mp-audio-blk-ctrl",
 		.of_match_table = clk_imx8mp_audiomix_of_match,
-		.pm = &clk_imx8mp_audiomix_pm_ops,
+		.pm = pm_ptr(&clk_imx8mp_audiomix_pm_ops),
 	},
 };
 
-- 
2.34.1


