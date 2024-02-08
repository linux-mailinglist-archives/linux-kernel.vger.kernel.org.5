Return-Path: <linux-kernel+bounces-58381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B5384E57A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C45B2746C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2447EF18;
	Thu,  8 Feb 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W94LrZvj"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F83823D4;
	Thu,  8 Feb 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411091; cv=none; b=TjhXLwIikWIIOm32lTwbgGq5WqkvSklFdPHfeFBW7+2pnnKmtK+/M4bMPDH7woPZUuk3RB7dq8qNiZfDmVGR0CMDM2vtSKLwzEZ1xf1mmlmasZSUiSASi5gZYEL9sb+w51FEayV4RaWYyRIN+oYT3GCf9tDsD8EhYvQ5IZ/ol0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411091; c=relaxed/simple;
	bh=/bgoFQj8jLPHiXib2qrTtT2gzomVqVTRO7+L5T8TMP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5WcDMLZN4fIDxKBYhMtM4CrY5QlXJzfilb61jFDUqwHhHvauxlbfpSjBbbgWFVYDN4cjugMOwqrZbVdJLdoPb2Mby2Pjn0gjd+qt+Gh17OAQSGNeqtTQFaZZ1RQejhyNmJWmneGf+vQeTT7LAFJ/wDpQNJi7Ey6JfW9UnP0+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W94LrZvj; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418GpGZl048968;
	Thu, 8 Feb 2024 10:51:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411076;
	bh=XgXkhbX2RXhlkR64jmiumGzBiNiAvpSx9IeblZh65dQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=W94LrZvjxTwSugcfGEB7lJIzvj3Bj+caEnV2WbbOxhPLfGdEoI4twDuwW+MfzkQTn
	 aNo+xk/SxMNxvSH76Atll2dieR1/ByTTdamKH2ng0ip5mpdrqIKochZrOxoXeKOHUi
	 ajxjXv5ATEo/riafph9Awy3GDxxI80btQc8hbzwQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418GpGMv028648
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 10:51:16 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 10:51:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 10:51:16 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418GpFwD063394;
	Thu, 8 Feb 2024 10:51:16 -0600
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>
CC: <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/4] hwspinlock: omap: Use devm_pm_runtime_enable() helper
Date: Thu, 8 Feb 2024 10:51:12 -0600
Message-ID: <20240208165114.63148-2-afd@ti.com>
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

This disables runtime PM on module exit automatically for us, currently
we manually disable runtime PM which can be error-prone if not done
in the right order or missed in some exit path. This also allows us
to simplify the probe exit path and remove callbacks. Do that here.

While here, as we can now return right after registering our hwspinlock,
simply return directly and remove the extra debug message.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes for v2:
 - Return directly from register as suggested on v1
 - Clarify commit message

 drivers/hwspinlock/omap_hwspinlock.c | 33 +++++++---------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index cca55143d24d4..3bd3ffab92100 100644
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
@@ -104,41 +104,26 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
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
 
 	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
 		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
 
-	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
+	return hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
 						base_id, num_locks);
-	if (ret)
-		goto runtime_err;
-
-	dev_dbg(&pdev->dev, "Registered %d locks with HwSpinlock core\n",
-		num_locks);
-
-	return 0;
-
-runtime_err:
-	pm_runtime_disable(&pdev->dev);
-	return ret;
 }
 
 static void omap_hwspinlock_remove(struct platform_device *pdev)
@@ -151,8 +136,6 @@ static void omap_hwspinlock_remove(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
 		return;
 	}
-
-	pm_runtime_disable(&pdev->dev);
 }
 
 static const struct of_device_id omap_hwspinlock_of_match[] = {
-- 
2.39.2


