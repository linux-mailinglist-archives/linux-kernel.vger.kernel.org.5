Return-Path: <linux-kernel+bounces-60889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F86850AA4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208FF28129E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3432F5DF2E;
	Sun, 11 Feb 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVMFXNzn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242F5D46A;
	Sun, 11 Feb 2024 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673405; cv=none; b=KDg2Z//QDY9/TO/8MfFjPSNCG53TkVw2wQbmk9SSyp+sR0MoA5+NlZ49gRPl+9zziHjDhbZEJCyYkbZHIM8oWgYpVlQI+NQSVUTQQs+C52r1/SgHZyq3RXjYYloEyHYVBO6zjt1ODzWLR9OKRj0QakuEg0b8d4G1lgHJy49u6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673405; c=relaxed/simple;
	bh=pMJBOa3z0fl/XMAEMYjuMhiH5HgtDAMqKqBYE15+9TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pr7xTiG4sskfa2pVOdr5vshDbUlGNstzw3AT4WQVk1YAlnoGbyiR8PTR6TDpNW3WiGfcaKI1Vy/WLmQ/zxKD8oIQg5DVkRWEfhRmA2Y1gfnK90E1bTPhejdj3aHsFZWVdf4HoCD2yFEjQXimsEbek0pLfRI9LK0bCSZMno2NJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVMFXNzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE471C43394;
	Sun, 11 Feb 2024 17:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673404;
	bh=pMJBOa3z0fl/XMAEMYjuMhiH5HgtDAMqKqBYE15+9TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVMFXNznnTMFwhRkqT2qf1PAHTM0xymZuhBNMzxG50a6LSNU/8qZMwh0uKttmsAej
	 ulkNw5NStu0yHp6UD8qfDxR0TF2pDiMeeq150NRPiCebFtoZFsvwf8y3SDVbmp8OFE
	 sxvV/Ey5nkJWgDwyUq5h+gAtCUQPt18CNQwCLNKFYeE2Pxku8IF3XHYW50Catv3wId
	 W0DeF8+yQ4eC6/a02Pi9HZGSe4eVZKrpmTjr5/P7tAwTe5YemVUm6xbYreb8JHWAUK
	 xmbclT2ZETYfk5vFKZ8cC9hzofKN6FI1BrR0ghAW9nG3Ig8aYxsIilKrA9AqvBT6nW
	 lnmvi8Cw5QsAg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/8] iio: adc: fsl-imx25-gcq: Use for_each_available_child_node_scoped()
Date: Sun, 11 Feb 2024 17:42:32 +0000
Message-ID: <20240211174237.182947-5-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240211174237.182947-1-jic23@kernel.org>
References: <20240211174237.182947-1-jic23@kernel.org>
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

Child nodes should only ever have been considered if they were available
(either status is okay, or it is not defined).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 68c813de0605..1b0003230306 100644
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
+	for_each_available_child_of_node_scoped(np, child) {
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
2.43.1


