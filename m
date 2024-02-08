Return-Path: <linux-kernel+bounces-57724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02B784DCBD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E4282C14
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA686BB4F;
	Thu,  8 Feb 2024 09:21:21 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6106A71B21
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384081; cv=none; b=lLHediNsdlF8Ml51kSIIYcIxdBnr8T8XRhhuk0d5+3axO0dMp9qW2DW673ak19o205o6pxUrb4mVZytvPGazuqEHSqI9Q4iRApWhFjbeU6oZVnr7a+JVrhL3BNFCv+ciXdjrnJW4Y+S+6tnSAIt6kBqyHsr6f7hm4h+temGNro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384081; c=relaxed/simple;
	bh=6KBxbdjaQLnVhpeBHZmuCEbJu0n286hs7uzybtzFK9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNwOnmls02DYbkmUGNbiiyv0LBFtLmcQ0Y2Xt1KqjERpehaVftgiAKkY/Gz96hoKFyAf/5y+Pp+OtnSSwSrkZgK/7NhPgscSTgTVvuU9UlTPPZbTp4mrsd/zOuuHi2oH9ZOB8L24FPns85KyWUUbfKIwqAYKGICv5bvDM6zkGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: cpNfb3ZsQAjM4Sd0jB+YJRSe2/lAN9CzXemENI9SJsiL2REuAd4om2RpzL3DbIJh6/dMIENpm7
 yt3wPhZMbgog==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 08 Feb 2024 14:51:13 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v1 08/13] misc: tps6594-esm: reversion check limited to TPS6594 family
Date: Thu,  8 Feb 2024 14:50:57 +0530
Message-Id: <20240208092059.1207134-2-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208092059.1207134-1-bhargav.r@ltts.com>
References: <20240208092059.1207134-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reversion check is only applicable on TPS6594 family of PMICs.
Conditionally add that check if the chip_id is one of the PMIC in
the TPS6594 family.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/misc/tps6594-esm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/tps6594-esm.c b/drivers/misc/tps6594-esm.c
index b4d67a1a2..8ec5af9dc 100644
--- a/drivers/misc/tps6594-esm.c
+++ b/drivers/misc/tps6594-esm.c
@@ -45,13 +45,17 @@ static int tps6594_esm_probe(struct platform_device *pdev)
 	 * As a consequence, ESM can not be used on those PMIC.
 	 * Check the version and return an error in case of revision 1.
 	 */
-	ret = regmap_read(tps->regmap, TPS6594_REG_DEV_REV, &rev);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to read PMIC revision\n");
-	if (rev == TPS6594_DEV_REV_1)
-		return dev_err_probe(dev, -ENODEV,
-			      "ESM not supported for revision 1 PMIC\n");
+	if (tps->chip_id == TPS6594 ||
+	    tps->chip_id == TPS6593 ||
+	    tps->chip_id == LP8764) {
+		ret = regmap_read(tps->regmap, TPS6594_REG_DEV_REV, &rev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read PMIC revision\n");
+		if (rev == TPS6594_DEV_REV_1)
+			return dev_err_probe(dev, -ENODEV,
+				      "ESM not supported for revision 1 PMIC\n");
+	}
 
 	for (i = 0; i < pdev->num_resources; i++) {
 		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
-- 
2.25.1


