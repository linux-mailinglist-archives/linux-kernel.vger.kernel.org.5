Return-Path: <linux-kernel+bounces-80101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AA3862AC4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E28281A99
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C39117730;
	Sun, 25 Feb 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re8r5oJN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F28175BC;
	Sun, 25 Feb 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708871270; cv=none; b=V/wvoRqQFmDx5AObb9c4qyzNQRqfO8R21AgaOr/u47+sYOtoZuX0Ab6cz8uhU++7nLImGzVMzUVC9LXEhOh1TQ6Whv3nRIbriyw4nG2OXdyaU9vJNRTy+wZVSukzQNm/8P9jtg0651Xj2BxIPUNFrlzbbeJM5f78ty9QVteWhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708871270; c=relaxed/simple;
	bh=FqXiRDMNp8tTGWD6g9YkejKEc8q+OEjl8zHNs3d6IoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+Znc4WrOrXb+TpUt4VmTXVoPwRTivwW5hJo9iFzd2QeaPn7QEFgGVnLvu9PCXqHEyyYHtP3fGXtzQ9+Bwzjki8J69v+XJ1zI9WQZn7Mt64+/SdRHKKL7XtOY2yUoUHHyA6kCgDlZFs58VJ0cxkn4BUBmTCIA5meTSCYf5hTTwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re8r5oJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF42C433F1;
	Sun, 25 Feb 2024 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708871270;
	bh=FqXiRDMNp8tTGWD6g9YkejKEc8q+OEjl8zHNs3d6IoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=re8r5oJNr4bsZl9Uw7G61ebplfEtdtt99hYivWytcHnU04kO99xj0WMHxrr6reaFv
	 nmDN0hWSpVR3FW+1A3imLl4aL7lI9OdFIWZPtsPVQnqcZj7eELmv7RbgONjjUeKeW8
	 oHNIA7iaFJErWJHuRbNk36FTkOw2KSA3ROxaY9dpMXjtfzs1v6HkU9BCdMt/cCLIXH
	 vcr2/C3NipA+0mWwJDzi83LhQl6qrR5e8vZ5Yh5fuJkbnOILEAdiqAY3ZdfTgeJveu
	 Bxgz2JkCa10NJrvF+vbUUh7WMNj+5n5mSBvLe4OBmWMmdTuDefB8qyQT9MOYpY57mv
	 eRdrY2HvYL8cw==
From: Jonathan Cameron <jic23@kernel.org>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	marek.vasut@gmail.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH v2 4/4] iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()
Date: Sun, 25 Feb 2024 14:27:14 +0000
Message-ID: <20240225142714.286440-5-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225142714.286440-1-jic23@kernel.org>
References: <20240225142714.286440-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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
2.44.0


