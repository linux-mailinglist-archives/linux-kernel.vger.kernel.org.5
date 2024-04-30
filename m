Return-Path: <linux-kernel+bounces-163590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CADD48B6D62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0DF1C21E98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C679A1A0AE5;
	Tue, 30 Apr 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKaVu19Q"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71412883A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467018; cv=none; b=QMjKEsC4S8Z5QDGMO1sHxDZmfR9QemBJl6Z2kM1Sk3nG1JUVQS65m7posK93PROY03OAN5Z50KaJOJzfyDbpJRzhEfOV39VB6iqgWpYU54oNic+Zrni9W+H2wbglgR3a/lJIt78nDi39eYJtmU+DWwcvNRcYI9+FVXJhSDiFGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467018; c=relaxed/simple;
	bh=wPFKKVDsrPqDd+T/V+mKITht1vWLOHyocwhrp50aPA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdbfBA+ni05KeJ3/qD9xL5HHO5XSVpM6MHYrP+/zNyL+BR/2EExdiG+zSDQt9x42ldlijbKrT/t5XHZOIXR1jDrd2vMRk8jJz90x29vUFp2SIebADN+1icAoCo2BeB0fYRqBJZ7HXgMOBBRVfxEm8zcuX7syq73DbKpi55USEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKaVu19Q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ebso27045025e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714467015; x=1715071815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGFQI3/jkSXT/B0m8X2PcSHRlLdy4394SU1GEz5Fywc=;
        b=bKaVu19QRYS+LA8Vp3tauE3dBWOPer3uP0574+osReHi8UfMhlHesfc6DLYaqtBmiA
         1DiSWcPO4eHYvIZQJ4T3fZAv6jVB+fsvoIRX8UNcKhaxzB0V6XSJGrf9tg4K+xMdy23y
         fAi4hQX2QWFSb3gzK/6Cs9PmEgBxI/hSdmNWYEvf2no2asg5WaEHSnm8we/MRZfEyBsU
         5iaiUVH+S90R41fZLhLdaaVRfXkWgdNc3yowO6vFS9Go0gGzXFMjsoFD+Ms6xBHW7m/u
         RW8moZam2AZ3JTRE9v9T7eGowPcThHWyE80zTlqrWJI+4BOy3/zzuLdG6CUZ+WpisxWE
         6sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467015; x=1715071815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGFQI3/jkSXT/B0m8X2PcSHRlLdy4394SU1GEz5Fywc=;
        b=TTfO5ELJNOzG68SHEyoFhikX3R/HGUwmKm0jU5ybUv3Ie7dKRbUTAXTXTguXHt6JV+
         nuLADDCxigQ4alzq/ALguENqdJ9HERoD+NuyORka3DRaqXPxJ36dbj7NulHEtEKuq0mD
         Zn9DmOsXMP1vkjXFEgU2VKBiV2F/94mJiMPqJVHy8xoC79vO18+rXoNpHJ+lIyqtWu0x
         Weo1kJn+IVTi+TbETSDnZQHzHqZ7MENxMUnuDB/ZnVq0Pi6SFVxSJt9xPtL7f5jeNYjm
         6nghsPIbEor2mqdRAItnPqoje7MHJt/AqWV7I6Hwwe/6BmKrPkj9/wqAkownfzjVb3F+
         Tj/Q==
X-Gm-Message-State: AOJu0Yw7+Av4mcFvsz6BUIhB5GI3XCy2CL1Gg1RuXy1ZthhrPmZLhm9V
	dIR4WyMj5IKf616MIId7FdJTptRt47cfY0WfmH0Qpzeq0HMqHVhhnqHzDeDGVr+lBebA0ihSqGn
	Z
X-Google-Smtp-Source: AGHT+IGd6F69jmhJhXQnKkSPXEEw+uvKSuc88dsnLcQPHFJs0xoce4npf0oN2KGLMfSKT6aPtxsHYQ==
X-Received: by 2002:a05:600c:4f11:b0:419:87ab:f6db with SMTP id l17-20020a05600c4f1100b0041987abf6dbmr10027905wmq.23.1714467014810;
        Tue, 30 Apr 2024 01:50:14 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c1d9200b0041bab13cd60sm14590670wms.3.2024.04.30.01.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:50:13 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] slimbus: Convert to platform remove callback returning void
Date: Tue, 30 Apr 2024 09:50:06 +0100
Message-Id: <20240430085007.33607-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
References: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3655; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=NtRyxovsgrVmHg1Qgua7ounfumaZm+SHHi4WhEOBppw=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLC8WekchStwa9kuUmpz6if9Ogt09P2t1/6Fh pN/EvtmjVqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwvAAKCRB6of1ZxzRV N4tfB/9OIioNcRFORt7avq6dHqwi1GLwzbaPDmlBi0IXMTNe9paihsZrC97Iblgv2UO+mJUSUJo EwO/6WnRh9Lw/eLdnJrR8GJPzM3mSBq+n/Sl67ck5zwD8tW7nAcjVSq6iCdjSJuSKigvaZWXbTt 6+v3i0tHOG3dNtiTlzmTHZnfIvzgM5KXCjp1wGLwXu/SS83GqZJ+g8pz7zhHmuM+TBeL7qzg1g6 HXRCXJAFwu9BtoZ3e4pRPF03yNk8t7s/PYCkc06SwxWXGBXdVLQqKJmW+9l0hedLjL64p3gQghZ bzFzIcOi5k6jy67WPNXaMinDlHBI6tUR8Whfy3QBsqdXNQln
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert the slimbus drivers from always returning zero in the
remove callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c     |  5 ++---
 drivers/slimbus/qcom-ngd-ctrl.c | 11 ++++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 400b7b385a44..7d632fad1300 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -626,7 +626,7 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_slim_remove(struct platform_device *pdev)
+static void qcom_slim_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
 
@@ -635,7 +635,6 @@ static int qcom_slim_remove(struct platform_device *pdev)
 	clk_disable_unprepare(ctrl->rclk);
 	clk_disable_unprepare(ctrl->hclk);
 	destroy_workqueue(ctrl->rxwq);
-	return 0;
 }
 
 /*
@@ -721,7 +720,7 @@ static const struct of_device_id qcom_slim_dt_match[] = {
 
 static struct platform_driver qcom_slim_driver = {
 	.probe = qcom_slim_probe,
-	.remove = qcom_slim_remove,
+	.remove_new = qcom_slim_remove,
 	.driver	= {
 		.name = "qcom_slim_ctrl",
 		.of_match_table = qcom_slim_dt_match,
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ce28ac35b2b6..e0b21f0f79c1 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1678,14 +1678,12 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
+static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
 	platform_driver_unregister(&qcom_slim_ngd_driver);
-
-	return 0;
 }
 
-static int qcom_slim_ngd_remove(struct platform_device *pdev)
+static void qcom_slim_ngd_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
@@ -1700,7 +1698,6 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 
 	kfree(ctrl->ngd);
 	ctrl->ngd = NULL;
-	return 0;
 }
 
 static int __maybe_unused qcom_slim_ngd_runtime_idle(struct device *dev)
@@ -1743,7 +1740,7 @@ static const struct dev_pm_ops qcom_slim_ngd_dev_pm_ops = {
 
 static struct platform_driver qcom_slim_ngd_ctrl_driver = {
 	.probe = qcom_slim_ngd_ctrl_probe,
-	.remove = qcom_slim_ngd_ctrl_remove,
+	.remove_new = qcom_slim_ngd_ctrl_remove,
 	.driver	= {
 		.name = "qcom,slim-ngd-ctrl",
 		.of_match_table = qcom_slim_ngd_dt_match,
@@ -1752,7 +1749,7 @@ static struct platform_driver qcom_slim_ngd_ctrl_driver = {
 
 static struct platform_driver qcom_slim_ngd_driver = {
 	.probe = qcom_slim_ngd_probe,
-	.remove = qcom_slim_ngd_remove,
+	.remove_new = qcom_slim_ngd_remove,
 	.driver	= {
 		.name = QCOM_SLIM_NGD_DRV_NAME,
 		.pm = &qcom_slim_ngd_dev_pm_ops,
-- 
2.25.1


