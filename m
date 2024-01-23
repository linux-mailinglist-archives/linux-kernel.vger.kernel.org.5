Return-Path: <linux-kernel+bounces-35618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF28839423
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F5A1F23DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1416162802;
	Tue, 23 Jan 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iDoxRWUk"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C791A6169A;
	Tue, 23 Jan 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025864; cv=none; b=F/Y5xwZvYYpOh3gHd0GUJlbPPMoroIOUau4Pqxxr12ShVr6M1clvG0QbEBD8qY3xZF+JO18MJXmhYKluFDnEQeenLMK6kz3HltDSGjJ3K37XSe/Jax/JyeSBSJfNgiIUxra18QlnSkzVvjYrzBfQqm9J5xTlbDtssJWtx3m1R00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025864; c=relaxed/simple;
	bh=ugWBVGHl9LGTKMjFFmofYncOafJxq6iGlCz4U58LStA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eugjlQaeSmqVo0DBjnQuaBth+gqF5wAVqJzIC1I50NSBItxDXLhjuOg0hbrubT16go/24j8CrzxmOeLZwsUp5PXS5/2PBPft7k6xrM1aV3JdFvFKOvbdwY7Hhtth0a3hV/phm4cm72WSdPpGEWkcEP6NTkz36P89O60FMUpM0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iDoxRWUk; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NG46ib087269;
	Tue, 23 Jan 2024 10:04:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706025846;
	bh=yOuisTLklSBvGzcrtbUbmPkWFz54wDZElaDy3BQHTAo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iDoxRWUkiuUGYIELKgqIfeERq9Djy8IRnDP6Rcs0GgL0oXM9k6OiO6ItGmiUMtf8v
	 Nw03Po783QOYg31Lch8NCHKtVJ1UxfD/2hCmc4iU91feY5P/XPFqkgpnjJK7twuLCn
	 j7BPzZcyCjSAugOxTs/FPSxF3z8bABV317zoGhSA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NG46xS030496
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:04:06 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:04:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:04:06 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NG45hd078075;
	Tue, 23 Jan 2024 10:04:06 -0600
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>
CC: <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/4] hwspinlock: omap: Use devm_pm_runtime_enable() helper
Date: Tue, 23 Jan 2024 10:04:03 -0600
Message-ID: <20240123160405.360437-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123160405.360437-1-afd@ti.com>
References: <20240123160405.360437-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This disables runtime PM on module exit, allowing us to simplify
the probe exit path and remove callbacks. Do that here.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index cca55143d24d4..2f18ea6c05e3f 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -89,10 +89,10 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	 * make sure the module is enabled and clocked before reading
 	 * the module SYSSTATUS register
 	 */
-	pm_runtime_enable(&pdev->dev);
+	devm_pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
-		goto runtime_err;
+		return ret;
 
 	/* Determine number of locks */
 	i = readl(io_base + SYSSTATUS_OFFSET);
@@ -104,22 +104,18 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	 */
 	ret = pm_runtime_put(&pdev->dev);
 	if (ret < 0)
-		goto runtime_err;
+		return ret;
 
 	/* one of the four lsb's must be set, and nothing else */
-	if (hweight_long(i & 0xf) != 1 || i > 8) {
-		ret = -EINVAL;
-		goto runtime_err;
-	}
+	if (hweight_long(i & 0xf) != 1 || i > 8)
+		return -EINVAL;
 
 	num_locks = i * 32; /* actual number of locks in this device */
 
 	bank = devm_kzalloc(&pdev->dev, struct_size(bank, lock, num_locks),
 			    GFP_KERNEL);
-	if (!bank) {
-		ret = -ENOMEM;
-		goto runtime_err;
-	}
+	if (!bank)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, bank);
 
@@ -129,16 +125,12 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
 						base_id, num_locks);
 	if (ret)
-		goto runtime_err;
+		return ret;
 
 	dev_dbg(&pdev->dev, "Registered %d locks with HwSpinlock core\n",
 		num_locks);
 
 	return 0;
-
-runtime_err:
-	pm_runtime_disable(&pdev->dev);
-	return ret;
 }
 
 static void omap_hwspinlock_remove(struct platform_device *pdev)
@@ -151,8 +143,6 @@ static void omap_hwspinlock_remove(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
 		return;
 	}
-
-	pm_runtime_disable(&pdev->dev);
 }
 
 static const struct of_device_id omap_hwspinlock_of_match[] = {
-- 
2.39.2


