Return-Path: <linux-kernel+bounces-41681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9C183F650
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3703F283C5D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6463C062;
	Sun, 28 Jan 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb8xytLv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5F28E34;
	Sun, 28 Jan 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457985; cv=none; b=Jp7J8iq4fXtsJJhZHZPTf1JFLEqpcx5Cqdb2gYOlzTdyLHu8F03ZdfjiwnyxNz5GpA25BbaDWk7/niOl8jHqfsntFDLNYWAoEbgJ/boxdC7gNV8f3KV223ackPiOrrchzpQAYulkn1tVIGpeV6tsaZ4bCgJxhLAm/wSYbpSnbDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457985; c=relaxed/simple;
	bh=1d3N3oj+o7FIeyj++LcsGEScXmNohMCbxRK9XhQWY9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/2TyL49gUc7WxTXoPEVepToNaIdOrsDisWtonggTBB5CCRo0dbkz2Pfm6CySkMYY3vLrZ9rGM4s7vhtDARqP/WM0JgJg0J6abqaWRNOMrtlz+Vgbw2DRJ7/1eWjMmYK++WEEdGbriPMqW+95qRDSL3EZ76W7265BGKSJ6MnTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb8xytLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EACC43394;
	Sun, 28 Jan 2024 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706457984;
	bh=1d3N3oj+o7FIeyj++LcsGEScXmNohMCbxRK9XhQWY9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mb8xytLv7+VHXwdF1NOZ1m7ib7wmEvQMUJKkae2rJI0C/BmkBtJKEPsiWq87Xcred
	 vIt6Tx4p6rq1CqeAbyDTWD7qBZjWZrk+dAL1TIYNUMKo/YBOgqfCZX6Vl1BRRUcrOR
	 +ZWsRSr3Lj/Fj9u16OqVZ6uH7gEsaMXcI4Fh2zMawk6wMity95YKMG+7w2NLgu442i
	 0rTYcvxEE16hraQ2qK4ytJdCes6u94HmZwBabiVd8AdasC5sY2hfnbJOK4gPc/Wp2U
	 sthtsxonLrE4kKfjEVQiull8qt4anmvf/l4s6+mzU9L03T8WhCgX113WExAco1flKA
	 D/ZY/dCHrFwpg==
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
Subject: [RFC PATCH 5/5] iio: adc: rcar-gyroadc: use for_each_child_node_scoped()
Date: Sun, 28 Jan 2024 16:05:42 +0000
Message-ID: <20240128160542.178315-6-jic23@kernel.org>
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

Using automated cleanup to replace of_node_put() handling allows for
a simplfied flow by enabling direct returns on errors.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rcar-gyroadc.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index d524f2e8e927..6d9d286cb5df 100644
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
+	for_each_child_of_node_scoped(np, child) {
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
2.43.0


