Return-Path: <linux-kernel+bounces-60890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC64850AA7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA2C1C215D1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBE05DF35;
	Sun, 11 Feb 2024 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6JB8Lsa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADBA5E3AF;
	Sun, 11 Feb 2024 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673409; cv=none; b=D3nnasuC+7pHxiFfZmf+koHs8tUYVQACQ8mGQ5GIhigd3NZd4aXe/DpKoino/RM8xVoFkrkRzqGtBao5W74Xy8d7yJWrvOZH2p/tvwrWIIlhiovxf04wODIxDTYowt/OToWwiJr6NlN8gK5Xd5Sjw3hDnd3ZxYqabunZ8RYylbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673409; c=relaxed/simple;
	bh=wN0leKygyGGEcV5J2AcNqnFx2iI5WbKZIEWRuroojKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CA2uF1PEWCWU1F0HTju6smASHYyLz5DUpjGywLefCeHLFkVmtUVqyCtKw8dH1/0GsdzIducJeLnhfgB7yfpHaRHZdnVwujQ9aMFZF/RWNtLpTc4L9u/tniEo1vNCweKw+oh6TkbGk81xIFmFESL2FoJT5WLwAsd2sr9/PIj2Fb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6JB8Lsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837F5C433C7;
	Sun, 11 Feb 2024 17:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673409;
	bh=wN0leKygyGGEcV5J2AcNqnFx2iI5WbKZIEWRuroojKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6JB8LsaAUSXkJFJHZG1xyAfSxLIAYPo3qlV+tAxOQ1UZqKIHDPIIuHqGNzTvvmnH
	 OgCYG5YsIZA8Lfw/5Zr64SQ8BEKEpstcrDKq3UnVw7HcS277MVjWb4zlLz+rxzyZE8
	 +aZM73JONaqjIh4l0RJLdgxbXVDwAncyLnB0SuDzK0bBTT3ID3Lo8zd99XKSetxhA7
	 IMRN7QWZIPLfnvnSLuAKyAo3Aw6+GH02HgWtlvGlp1tAUzOg1gX8j8jt3Ml0LkAAri
	 9wARM5lHXoDB3YEfeiOktQL4Lw/YAKfGep8jo4EP4HP+Nc6i6m1zvgs5OgZMRsN5J/
	 B/ezXcEPZrstQ==
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
Subject: [PATCH 5/8] iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()
Date: Sun, 11 Feb 2024 17:42:33 +0000
Message-ID: <20240211174237.182947-6-jic23@kernel.org>
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
2.43.1


