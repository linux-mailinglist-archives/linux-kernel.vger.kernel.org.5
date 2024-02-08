Return-Path: <linux-kernel+bounces-58378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C648784E570
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A9AB25D84
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA3B7FBB7;
	Thu,  8 Feb 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D0Jgklj4"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE917EF16;
	Thu,  8 Feb 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411084; cv=none; b=oe1y3spIXWknpdtkHwWifoI0fAdufHJdGdAk/Det7o4IBvDdb4AHTkBY/LoNMWvo4065phOE/sbDCf5cazKDZ48/RJ0Uo6MD/ghl8XCFsZKW67IGeP6cUwaGQsELXSMYoTLOCmjouOjGW0KeKJtQAmRDRYm3IxrvcjbIDC5r9Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411084; c=relaxed/simple;
	bh=gjSKd6uTc8kBAKclYk3S89l34EyVOwSZa1YaZh1NZPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzbeScrRSExUH4EOt4hwqXKN+ozlqSSAjsYIg2PO9xnYHO8j77/KVClXFGMBksDEPUeW7nkynUwwN1mVoBGAT8Pe9M4ts3tk+sNqZ76RpQnPYXIz0k8Ae/M3QeE9CGqyf4oEPlqzWYBgVgfwcx1ZuXka9lDAQET9juXGmA+IJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D0Jgklj4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418GpHrd012029;
	Thu, 8 Feb 2024 10:51:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411077;
	bh=xCGFMX89R1mGJW8/Y6A+fGzHuBoxs28i4x77PmX5znQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=D0Jgklj4yGloL1h3M4KVZTz9AMrS/ihpMI4+HTJcBfZt7CB76YcKrqZ7tQw3Dp5gY
	 WxdGg47uWuZ0f2yI65vcmgTqYIMKqmcKoEalqvp5fi6aDllMvP/cj+LbvOZ9rIXAac
	 u3RcOTtbnMCRvipPJVzEJam/0OIifgxU2+a7nNBs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418GpHjQ041144
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 10:51:17 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 10:51:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 10:51:17 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418GpFwF063394;
	Thu, 8 Feb 2024 10:51:16 -0600
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>
CC: <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 4/4] hwspinlock: omap: Use index to get hwspinlock pointer
Date: Thu, 8 Feb 2024 10:51:14 -0600
Message-ID: <20240208165114.63148-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208165114.63148-1-afd@ti.com>
References: <20240208165114.63148-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

For loops with multiple initializers and increments are hard to read
and reason about, simplify this by using the looping index to index
into the hwspinlock array.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index fe73da80018b1..27b47b8623c09 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -75,7 +75,6 @@ static const struct hwspinlock_ops omap_hwspinlock_ops = {
 static int omap_hwspinlock_probe(struct platform_device *pdev)
 {
 	struct hwspinlock_device *bank;
-	struct hwspinlock *hwlock;
 	void __iomem *io_base;
 	int num_locks, i, ret;
 	/* Only a single hwspinlock block device is supported */
@@ -117,8 +116,8 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	if (!bank)
 		return -ENOMEM;
 
-	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
-		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
+	for (i = 0; i < num_locks; i++)
+		bank->lock[i].priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
 
 	return devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
 						base_id, num_locks);
-- 
2.39.2


