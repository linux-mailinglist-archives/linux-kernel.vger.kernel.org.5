Return-Path: <linux-kernel+bounces-78039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3758B860E45
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97CF281599
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B831D5E3A0;
	Fri, 23 Feb 2024 09:38:37 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8BE5D919;
	Fri, 23 Feb 2024 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681117; cv=none; b=rvKMg6zj2qtup40QJ884jz/Wom1PWYI0WLvW3mo8sk6AIEpK47tXnjT6nq7ZiCs/Ca8i5Ca6CrQa+Zy4TUMhUJux7qUzIXEEvfS2hO7+PZzGXIlHSQ4I8/M3cTxzDTlKdi9Jrcg/Er39N0yzhpnFnmCe7nqrqgYNtop4paQW9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681117; c=relaxed/simple;
	bh=6KBxbdjaQLnVhpeBHZmuCEbJu0n286hs7uzybtzFK9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOR7F4jy4o3jk4AAdSlIcrnB/lPWQkbdaXdd9d/xCUVt9dLozvrEwcUoUH09k8YISDHUdOPejhu5mgzeVxdaytamn36uh4wXH4ORsPZ4er//zYnNPRfL7f+UaLkCcW9M7/s7d1itZqDSpMxcmzB7Y7zjMemFlQqv22I6gsSymh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: 7TXusOSPAISdSuJO+w4Mq6rp4sSEpxbND80Mn+3udvAdfeXIUydZzqicgmnVvtksZVzLMd9295
 5ju6XQDBvqiA==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 23 Feb 2024 15:07:17 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jpanis@baylibre.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v2 09/14] misc: tps6594-esm: reversion check limited to TPS6594 family
Date: Fri, 23 Feb 2024 15:06:56 +0530
Message-Id: <20240223093701.66034-10-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223093701.66034-1-bhargav.r@ltts.com>
References: <20240223093701.66034-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reversion check is only applicable on TPS6594 family of PMICs.
Conditionally add that check if the chip_id is one of the PMIC in
the TPS6594 family.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/misc/tps6594-esm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/tps6594-esm.c b/drivers/misc/tps6594-esm.c
index b4d67a1a2..8ec5af9dc 100644
--- a/drivers/misc/tps6594-esm.c
+++ b/drivers/misc/tps6594-esm.c
@@ -45,13 +45,17 @@ static int tps6594_esm_probe(struct platform_device *pdev)
 	 * As a consequence, ESM can not be used on those PMIC.
 	 * Check the version and return an error in case of revision 1.
 	 */
-	ret = regmap_read(tps->regmap, TPS6594_REG_DEV_REV, &rev);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to read PMIC revision\n");
-	if (rev == TPS6594_DEV_REV_1)
-		return dev_err_probe(dev, -ENODEV,
-			      "ESM not supported for revision 1 PMIC\n");
+	if (tps->chip_id == TPS6594 ||
+	    tps->chip_id == TPS6593 ||
+	    tps->chip_id == LP8764) {
+		ret = regmap_read(tps->regmap, TPS6594_REG_DEV_REV, &rev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read PMIC revision\n");
+		if (rev == TPS6594_DEV_REV_1)
+			return dev_err_probe(dev, -ENODEV,
+				      "ESM not supported for revision 1 PMIC\n");
+	}
 
 	for (i = 0; i < pdev->num_resources; i++) {
 		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
-- 
2.25.1


