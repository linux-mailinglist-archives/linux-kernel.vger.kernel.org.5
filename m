Return-Path: <linux-kernel+bounces-58377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8DA84E56F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B0B1F23032
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E408C7F7FC;
	Thu,  8 Feb 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xp6zcSk2"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBF2033E;
	Thu,  8 Feb 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411084; cv=none; b=pVdloxg7W3vsk9k9l11G2WQYp6+6kYBoNqyTXzIpDYpfTxZKLzNfVOGmGIbkAIB1on/iWTqCJBd0L86i6oNq3LY5lE2xM3bOEsd/weK0FjtdJGLwgDewcAx0pp6QsnaX7DW5kscyTCfojkOwiCmU8nWevI8ism7kLlW6ceG5Pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411084; c=relaxed/simple;
	bh=SzcvmT0u+d+mOegkatFJAAaI6odzW0ax7/YjwwvrAw4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hKpZAalIwsefhQCA+SkC/fCcL/jhrhD/MYvI1Z832j8dnej9Dt/iBeTUwcOAmhO2r8vLzezp8NGOzszNN9hHxWZgt4ecRI2/Qfm0uIJtlKQAqntNXt28c/HeuE4f9NmGCuo+O0o3IOSYKdi97dPU3Mr4kLRP5+6L6AjUFKMo5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xp6zcSk2; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418GpGIe012008;
	Thu, 8 Feb 2024 10:51:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411076;
	bh=7eJWi6eNYuFYPK/LARry4zNJsatwYYOpsn8tijlRXkA=;
	h=From:To:CC:Subject:Date;
	b=xp6zcSk287TfpQJP+nHMwWIh4Bv6U2ezCzrOkuJ7UZOpTzq49YQtgDct55SFYcdsO
	 0VbF8vVxkwcFbt3dPuYmsUh1YykJwLToTG+i5JoUFVxoVYm4fTQaLgV7WwaSHL6YGk
	 uZO5asrzq/2jkriG7FMB7o1ELy8TG83XD5XL3s4E=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418GpGfk041134
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 10:51:16 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 10:51:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 10:51:15 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418GpFwC063394;
	Thu, 8 Feb 2024 10:51:15 -0600
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>
CC: <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/4] hwspinlock: omap: Remove unneeded check for OF node
Date: Thu, 8 Feb 2024 10:51:11 -0600
Message-ID: <20240208165114.63148-1-afd@ti.com>
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


