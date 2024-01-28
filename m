Return-Path: <linux-kernel+bounces-41680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B13F83F64D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2CF1C21007
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F46733CD6;
	Sun, 28 Jan 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoKDwMYn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA473309E;
	Sun, 28 Jan 2024 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457980; cv=none; b=AAkQVW+YHTF/0zMMX71ZlH0FPEvJD3JXxePoFHVENFtEEW/sHiSTnJsUK9pdzv/RTSB1VXGuZboyci+pCvDZnuZnRhDA/5w5Zvr2PSqIewvBUi20vMQzjSLYHiphKjvk2tCKGK1DtFPs3mkncCkxdcN05f3LSZzxHNR86u+DvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457980; c=relaxed/simple;
	bh=3Y2fe3v8fv82hwf99UNXqMFEmGi13fJAOCRcMqRzjNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WobBNEGHV1IOr+g4gwaul/8IBQdZJoylYCvkIZy4IohsgZzUZTRRpHKfmU76nmKj4IG9bfEwwdV8B8dq5dPkePQ0XrfipblAGJEo0syNbVmgJFyhreId6JUFf4m+Q/SrbCou6H81+7k80h1zef8XWwPKW6c0KNXmZUs5SpfbZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoKDwMYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E4BC433C7;
	Sun, 28 Jan 2024 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706457980;
	bh=3Y2fe3v8fv82hwf99UNXqMFEmGi13fJAOCRcMqRzjNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoKDwMYnAXOfasnL3LeIKIDEOWP6iyLwq8T9d/vWS6mJbW9e0+clKEKjA5ABmYH69
	 77eaTotsqCzTnCeYZi+Xw1prbYTMHefffIafgAldZebhIP+UJKhIS8/4OY+Ujc5bzS
	 dy304O/kjet2Jo7yGKkV4bR74zCHfIw/shk/fsoJefmcY6NJwpNw0oz3JhwFOEDdwr
	 956TCOy7YdIWLpVWYMx3x3rrXsy7PNfo0pSuOCcyikmh0K6N5GAtzo66JNsF+IS1h7
	 5n0ms4sVAqt34SGwjHuDlm1brtUYDrAhRCob1k87BkSLnI+SfWVYX0ocKhMmvjJ+ua
	 JtCt8FTdUGfVA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 4/5] iio: adc: fsl-imx25-gcq: Use for_each_child_node_scoped()
Date: Sun, 28 Jan 2024 16:05:41 +0000
Message-ID: <20240128160542.178315-5-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128160542.178315-1-jic23@kernel.org>
References: <20240128160542.178315-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Using automated cleanup reduces chance of an reference count leak
and simplfies the code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Chances since v1: Use new for_each_child_node_scoped()
---
 drivers/iio/adc/fsl-imx25-gcq.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 68c813de0605..a32b5f68768e 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -199,7 +199,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			       struct mx25_gcq_priv *priv)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	struct device *dev = &pdev->dev;
 	int ret, i;
 
@@ -216,7 +215,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			     MX25_ADCQ_CFG_IN(i) |
 			     MX25_ADCQ_CFG_REFN_NGND2);
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		u32 reg;
 		u32 refp = MX25_ADCQ_CFG_REFP_INT;
 		u32 refn = MX25_ADCQ_CFG_REFN_NGND2;
@@ -224,14 +223,12 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 		ret = of_property_read_u32(child, "reg", &reg);
 		if (ret) {
 			dev_err(dev, "Failed to get reg property\n");
-			of_node_put(child);
 			return ret;
 		}
 
 		if (reg >= MX25_NUM_CFGS) {
 			dev_err(dev,
 				"reg value is greater than the number of available configuration registers\n");
-			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -243,10 +240,9 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 		case MX25_ADC_REFP_XP:
 		case MX25_ADC_REFP_YP:
 			ret = mx25_gcq_ext_regulator_setup(&pdev->dev, priv, refp);
-			if (ret) {
-				of_node_put(child);
+			if (ret)
 				return ret;
-			}
+
 			priv->channel_vref_mv[reg] =
 				regulator_get_voltage(priv->vref[refp]);
 			/* Conversion from uV to mV */
@@ -257,7 +253,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			break;
 		default:
 			dev_err(dev, "Invalid positive reference %d\n", refp);
-			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -270,12 +265,10 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 
 		if ((refp & MX25_ADCQ_CFG_REFP_MASK) != refp) {
 			dev_err(dev, "Invalid fsl,adc-refp property value\n");
-			of_node_put(child);
 			return -EINVAL;
 		}
 		if ((refn & MX25_ADCQ_CFG_REFN_MASK) != refn) {
 			dev_err(dev, "Invalid fsl,adc-refn property value\n");
-			of_node_put(child);
 			return -EINVAL;
 		}
 
-- 
2.43.0


