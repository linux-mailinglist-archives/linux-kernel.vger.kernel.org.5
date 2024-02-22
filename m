Return-Path: <linux-kernel+bounces-76415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B985F70C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EFA1F24250
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A234776E;
	Thu, 22 Feb 2024 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="chrMIB7d"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4E3FB27;
	Thu, 22 Feb 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601607; cv=none; b=ejzlw6zrufrQQMexCS0Ok2d8Yl9k/K/dR83qFG/9t4XPA3IDWzD4t5dCQM4renyqq3+FfuJz/c8y3lYkxQS0LitT1xwPf1DwTUniQY7POmbKA5fVPsGEZLKiBicXg6my3qNr4PXS9n9SUoAR10zoryYaZpMHav+c3Koa57CUmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601607; c=relaxed/simple;
	bh=awIpiB7+rPodbBNyQqhDBuuBw28/P0JB2hHzrKB5VA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t39wjWHcZQ5zpm+aPAMdEjv//S3tb22ebY97ghoLHruBBP/lFBDG6zqg9uhXtpuAsTLzAyiFMdr2QZyXWAk1sG3Juv+RB+kiIa/2MzPjHZ9ppGVw76sM09uxHs3Mi75xh1g1yEQbvZn16niZZLdI3a50GkIzWlQvilf5hUq+v2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=chrMIB7d; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXB5o059128;
	Thu, 22 Feb 2024 05:33:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601591;
	bh=/i192URWf1TmsQf1cjCbx2z4wkXH+kCVVw7/yDHFIIc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=chrMIB7dp3IKQEymdm3CWvDJVVSoZfG0hEMJxegDDTlwcQIjaP9MYC+lvDwnKIXm3
	 A6gIdV5pStPsmzC3yVWiVwOXS4PGwQYdaE90KeZ4qXFiJm/vFBuhIPp0oKmvaROS8F
	 zCxOSKZZNyaYBx5lNzl1N5olUB+ut9SfHQ0HZp18=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXBJP059184
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:11 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:10 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBX9Xf090998;
	Thu, 22 Feb 2024 05:33:10 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:19 +0530
Subject: [PATCH RFC 03/21] media: cadence: csi2rx: Support runtime PM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-3-1837ed916eeb@ti.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Changhuang
 Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3486; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=gL2KFHtJC4ZaxiomDu0d9bCTf1l/780KtEZpDitoGVM=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDcRZ3wPVgXir6vjlfdPfIq2tLGr5W8ntgai
 IjeS9CnSIaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw3AAKCRBD3pH5JJpx
 RWSID/4y9uUWJ4VVRhH5Z8m4Ax0uHMLG/1DV4f6Oxvy5YHjlLCbnQYES2t7Sfi6MITcec60nqbL
 3wz1HnCS5iNsOSATsfm3PtjfWdC32y+4DNCbYPWVg5VnA2wYMiqhhYlYdzFsBSbR1HPxXXo9PgP
 sHIEhIm/B3/H13dFjZg3wK9Rgw4HjX6e4s/bomaNSwB/+G/Jys56hvE5Oadcl9aCbJRWP1ohZcq
 DasQ03br2FebIWUmNI+BrNAh1J3PtxWc8E6SsgzXvhoeUT8FAuDUSzEKMrGr4JSkHz1beqxsFQa
 pGqhzBnn1omCZN+r1Zg5B5Bm+kwt2UTOcDwcstIQxEzgzqw7r7w2LQotTsoXyDfN3Z76r5Nj0za
 xpRtOIbwYy5PwTViofUWXqpstad7HyjS6LwQKjr8nvWy8IuvAe8psCWKHrNpWPvCLTM65s7nIWI
 1jB4jfhlUvwexFUmXobQAizia8vHPkJnqjuW1lId0AtVfzuiBye5ZhzvJMBeGpxBHgXVsLcGhQs
 aCHqOdt659HM59/2CYf6Di3YzGvIY8lnX2/wwguCkSDlSCdoNlmPhHTDXTJzV6dKH3+3C6aaLbr
 X+0a6hxbJnbV7nriu2W/667n+zscIl4/SuCdtippfyskWfombECI3AsbC2Nkucd8UHxWFdFjBRn
 c3CcUeLsp/1Nyqw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Jayshri Pawar <jpawar@cadence.com>

Use runtime power management hooks to save power when CSI-RX is not in
use. Also stop/start any in-progress streams, which might happen during
a system suspend/resume cycle.

Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Co-developed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 43 +++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 75e602c1d762..e19993ed351c 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -370,6 +370,12 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
 	int ret = 0;
 
+	if (enable) {
+		ret = pm_runtime_resume_and_get(csi2rx->dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	mutex_lock(&csi2rx->lock);
 
 	if (enable) {
@@ -379,8 +385,10 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 		 */
 		if (!csi2rx->count) {
 			ret = csi2rx_start(csi2rx);
-			if (ret)
+			if (ret) {
+				pm_runtime_put(csi2rx->dev);
 				goto out;
+			}
 		}
 
 		csi2rx->count++;
@@ -392,6 +400,8 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 		 */
 		if (!csi2rx->count)
 			csi2rx_stop(csi2rx);
+
+		pm_runtime_put(csi2rx->dev);
 	}
 
 out:
@@ -665,6 +675,29 @@ static int csi2rx_parse_dt(struct csi2rx_priv *csi2rx)
 	return ret;
 }
 
+static int csi2rx_suspend(struct device *dev)
+{
+	struct csi2rx_priv *csi2rx = dev_get_drvdata(dev);
+
+	mutex_lock(&csi2rx->lock);
+	if (csi2rx->count)
+		csi2rx_stop(csi2rx);
+	mutex_unlock(&csi2rx->lock);
+
+	return 0;
+}
+
+static int csi2rx_resume(struct device *dev)
+{
+	struct csi2rx_priv *csi2rx = dev_get_drvdata(dev);
+
+	mutex_lock(&csi2rx->lock);
+	if (csi2rx->count)
+		csi2rx_start(csi2rx);
+	mutex_unlock(&csi2rx->lock);
+	return 0;
+}
+
 static int csi2rx_probe(struct platform_device *pdev)
 {
 	struct csi2rx_priv *csi2rx;
@@ -711,6 +744,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup;
 
+	pm_runtime_enable(csi2rx->dev);
 	ret = v4l2_async_register_subdev(&csi2rx->subdev);
 	if (ret < 0)
 		goto err_free_state;
@@ -725,6 +759,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 
 err_free_state:
 	v4l2_subdev_cleanup(&csi2rx->subdev);
+	pm_runtime_disable(csi2rx->dev);
 err_cleanup:
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
@@ -743,9 +778,14 @@ static void csi2rx_remove(struct platform_device *pdev)
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
 	v4l2_subdev_cleanup(&csi2rx->subdev);
 	media_entity_cleanup(&csi2rx->subdev.entity);
+	pm_runtime_disable(csi2rx->dev);
 	kfree(csi2rx);
 }
 
+static const struct dev_pm_ops csi2rx_pm_ops = {
+	SET_RUNTIME_PM_OPS(csi2rx_suspend, csi2rx_resume, NULL)
+};
+
 static const struct of_device_id csi2rx_of_table[] = {
 	{ .compatible = "starfive,jh7110-csi2rx" },
 	{ .compatible = "cdns,csi2rx" },
@@ -760,6 +800,7 @@ static struct platform_driver csi2rx_driver = {
 	.driver	= {
 		.name		= "cdns-csi2rx",
 		.of_match_table	= csi2rx_of_table,
+		.pm		= &csi2rx_pm_ops,
 	},
 };
 module_platform_driver(csi2rx_driver);

-- 
2.43.0


