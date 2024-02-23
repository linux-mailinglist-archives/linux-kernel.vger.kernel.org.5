Return-Path: <linux-kernel+bounces-78321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660ED8611DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC6EB25CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FC07CF02;
	Fri, 23 Feb 2024 12:46:37 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735A7BB01;
	Fri, 23 Feb 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692396; cv=none; b=CtlMPqDxniu3hfA6K9AvS+EGFmuh2QhXtUXGf5uq0OFCZWAp8I6kvSFqOMrpGjq94sxC51N5q47h4BkRUcbN1S3pdL+BuxhXjb+dQLapaUvCaVQrpdrq1GMYdowWThDcr+eHVqdU/Mipx8BVbLSG46jdvgwcfq8OYOC6c1AvvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692396; c=relaxed/simple;
	bh=uwvaZI11bdMokSgb+i0nBIM711O1DzkCOL2KDkr/QbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1xUJmqIkMb4XftmDMtN6IDL17LUuA2W+2PCvgAAdUMNJGfcA3umfmDxIro4ThII5BXN9YhP6Rk/NoZrAmP2auUTHVPTGomd6bvjaqnfQEZhqgApJ9K6SebDAbDu8NSdrOTPk9JGtt7/idp5cBRDiiGqNWKvNA2b48Qp758MEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Th8ms30Ljz6K8qJ;
	Fri, 23 Feb 2024 20:42:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 57DD3141144;
	Fri, 23 Feb 2024 20:46:32 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 12:46:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>, Frank Rowand
	<frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>
CC: Peter Zijlstra <peterz@infradead.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <marek.vasut@gmail.com>
Subject: [PATCH v2 4/4] iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()
Date: Fri, 23 Feb 2024 12:44:32 +0000
Message-ID: <20240223124432.26443-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223124432.26443-1-Jonathan.Cameron@huawei.com>
References: <20240223124432.26443-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Using automated cleanup to replace of_node_put() handling allows for
a simplfied flow by enabling direct returns on errors.

Non available child nodes should never have been considered; that
is ones where status != okay and was defined.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rcar-gyroadc.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index d524f2e8e927..15a21d2860e7 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -318,7 +318,6 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 	struct rcar_gyroadc *priv = iio_priv(indio_dev);
 	struct device *dev = priv->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
 	struct regulator *vref;
 	unsigned int reg;
 	unsigned int adcmode = -1, childmode;
@@ -326,7 +325,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 	unsigned int num_channels;
 	int ret, first = 1;
 
-	for_each_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		of_id = of_match_node(rcar_gyroadc_child_match, child);
 		if (!of_id) {
 			dev_err(dev, "Ignoring unsupported ADC \"%pOFn\".",
@@ -352,7 +351,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
 			break;
 		default:
-			goto err_e_inval;
+			return -EINVAL;
 		}
 
 		/*
@@ -369,7 +368,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 				dev_err(dev,
 					"Failed to get child reg property of ADC \"%pOFn\".\n",
 					child);
-				goto err_of_node_put;
+				return ret;
 			}
 
 			/* Channel number is too high. */
@@ -377,7 +376,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 				dev_err(dev,
 					"Only %i channels supported with %pOFn, but reg = <%i>.\n",
 					num_channels, child, reg);
-				goto err_e_inval;
+				return -EINVAL;
 			}
 		}
 
@@ -386,7 +385,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			dev_err(dev,
 				"Channel %i uses different ADC mode than the rest.\n",
 				reg);
-			goto err_e_inval;
+			return -EINVAL;
 		}
 
 		/* Channel is valid, grab the regulator. */
@@ -396,8 +395,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 		if (IS_ERR(vref)) {
 			dev_dbg(dev, "Channel %i 'vref' supply not connected.\n",
 				reg);
-			ret = PTR_ERR(vref);
-			goto err_of_node_put;
+			return PTR_ERR(vref);
 		}
 
 		priv->vref[reg] = vref;
@@ -422,7 +420,6 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 		 * we can stop parsing here.
 		 */
 		if (childmode == RCAR_GYROADC_MODE_SELECT_1_MB88101A) {
-			of_node_put(child);
 			break;
 		}
 	}
@@ -433,12 +430,6 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 	}
 
 	return 0;
-
-err_e_inval:
-	ret = -EINVAL;
-err_of_node_put:
-	of_node_put(child);
-	return ret;
 }
 
 static void rcar_gyroadc_deinit_supplies(struct iio_dev *indio_dev)
-- 
2.39.2


