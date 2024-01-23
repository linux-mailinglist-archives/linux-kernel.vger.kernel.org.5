Return-Path: <linux-kernel+bounces-35619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1D5839427
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CD61C21166
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290C462818;
	Tue, 23 Jan 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OI+YrjUv"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4506169F;
	Tue, 23 Jan 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025865; cv=none; b=VKolAi7crAr6VNkDR7UZ0FzS2fQTTqnavlTMRiVn0Qxm7UJosXhsn7Hy73/qIxU4686VlXCyGQW90/rf9yPrz1IJ9SO8yJNBbYmWwHs0erpFjuBENnAKgEJqM2Y+XKoDYL8s0V6MLz0U0cuQtj0286PbT2U/mcF53N68y82z++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025865; c=relaxed/simple;
	bh=SzcvmT0u+d+mOegkatFJAAaI6odzW0ax7/YjwwvrAw4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pbs0T5+6bs6vt7D581aPCbfC8H0wy3uoHjVUWj08mat5GlPY6WKf050yx09aDT77+Zi2NEoGp9NMrkHmT0zwr42vixwxHuvYfuFWsSQecetM+WQ/JhdJLHTH/iHpFt0OPvAbsPu6wKCCtOgw1poAgeOjbQWnU6QOG8TjU6iBQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OI+YrjUv; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NG46U4043257;
	Tue, 23 Jan 2024 10:04:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706025846;
	bh=7eJWi6eNYuFYPK/LARry4zNJsatwYYOpsn8tijlRXkA=;
	h=From:To:CC:Subject:Date;
	b=OI+YrjUv5WYUCDslzs6sXfbg6aDesNYlN7W5gsuI558QH9TjZ36o1AxDLEmDiwwY/
	 JNp/A9iYpTxGv/KqH0ptAImVsLpZzo+1TN5WwRyX2fE2zDhNNsORzK02iQXaCZphlZ
	 Wr2vpEb/XNvn6sXm+CfHcyLOuFhBaYXu2c4DPjJM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NG46j6087256
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:04:06 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:04:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:04:06 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NG45hc078075;
	Tue, 23 Jan 2024 10:04:05 -0600
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>
CC: <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/4] hwspinlock: omap: Remove unneeded check for OF node
Date: Tue, 23 Jan 2024 10:04:02 -0600
Message-ID: <20240123160405.360437-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

We do not use the OF node anymore, nor does it matter how
we got to probe, so remove the check for of_node.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index a9fd9ca45f2a8..cca55143d24d4 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -74,7 +74,6 @@ static const struct hwspinlock_ops omap_hwspinlock_ops = {
 
 static int omap_hwspinlock_probe(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
 	struct hwspinlock_device *bank;
 	struct hwspinlock *hwlock;
 	void __iomem *io_base;
@@ -82,9 +81,6 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	/* Only a single hwspinlock block device is supported */
 	int base_id = 0;
 
-	if (!node)
-		return -ENODEV;
-
 	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
-- 
2.39.2


