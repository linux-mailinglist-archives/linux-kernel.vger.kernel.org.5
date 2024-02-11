Return-Path: <linux-kernel+bounces-60940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69611850B65
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A500B225BB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5135F494;
	Sun, 11 Feb 2024 20:15:40 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF15EE96
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682540; cv=none; b=Tb4eK3ZHwgsN4VmZb7cUee/BAVWWfNGdBKxRiuD2eLB1BlH2vMT60vS87/exDFBQ0akq6CyroGuJmeEartPhL5rb6IV/09C/wt3c7icxtNEXQUej5wu4jvTo+lT4kgxkln27IWgiUXa5WncyBhZxmggooAGXrIKV1tam7h190yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682540; c=relaxed/simple;
	bh=z8WXcKJKVkJaLkn3KQjBR/J4AwDXnhP2TVi4sMS42i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOhdVq31dyHamuZsNV5gw+I9MhcDWIxeLFxelLeBvLQlbFIFUlwGBDM+IYNDUQ1gvJ543pHbKuG74Gnfmod7JxHDEIDgSVLJLO/Mlqrg32+Z1R448Ghq+FOA0Cf2z4tJ6ykL7sxYAcT/n6+xQYvmOweC1+KReYNfWAG/kbQt+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 4d855663-c91a-11ee-abf4-005056bdd08f;
	Sun, 11 Feb 2024 22:15:30 +0200 (EET)
From: andy.shevchenko@gmail.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marius Hoch <mail@mariushoch.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/3] iio: st_sensors: lsm9ds0: Use dev_err_probe() everywhere
Date: Sun, 11 Feb 2024 22:14:32 +0200
Message-ID: <20240211201526.1518165-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211201526.1518165-1-andy.shevchenko@gmail.com>
References: <20240211201526.1518165-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_err_probe() everywhere where it is appropriate.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
index e887b45cdbcd..7b9dc849f010 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -25,10 +25,9 @@ static int st_lsm9ds0_probe_accel(struct st_lsm9ds0 *lsm9ds0, struct regmap *reg
 	struct st_sensor_data *data;
 
 	settings = st_accel_get_settings(lsm9ds0->name);
-	if (!settings) {
-		dev_err(dev, "device name %s not recognized.\n", lsm9ds0->name);
-		return -ENODEV;
-	}
+	if (!settings)
+		return dev_err_probe(dev, -ENODEV, "device name %s not recognized.\n",
+				     lsm9ds0->name);
 
 	lsm9ds0->accel = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!lsm9ds0->accel)
@@ -51,10 +50,9 @@ static int st_lsm9ds0_probe_magn(struct st_lsm9ds0 *lsm9ds0, struct regmap *regm
 	struct st_sensor_data *data;
 
 	settings = st_magn_get_settings(lsm9ds0->name);
-	if (!settings) {
-		dev_err(dev, "device name %s not recognized.\n", lsm9ds0->name);
-		return -ENODEV;
-	}
+	if (!settings)
+		return dev_err_probe(dev, -ENODEV, "device name %s not recognized.\n",
+				     lsm9ds0->name);
 
 	lsm9ds0->magn = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!lsm9ds0->magn)
@@ -80,8 +78,7 @@ int st_lsm9ds0_probe(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "unable to enable Vdd supply\n");
+		return dev_err_probe(dev, ret, "unable to enable Vdd supply\n");
 
 	/* Setup accelerometer device */
 	ret = st_lsm9ds0_probe_accel(lsm9ds0, regmap);
-- 
2.43.0


