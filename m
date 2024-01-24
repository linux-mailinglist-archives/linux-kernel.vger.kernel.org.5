Return-Path: <linux-kernel+bounces-37224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5615C83ACFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCBAB2AA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325E7C085;
	Wed, 24 Jan 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="R3u9vIWX"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154C7A707;
	Wed, 24 Jan 2024 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109160; cv=none; b=ITYLpX9efdsozkCa4bZ1uEACT6SyWg6uvGGj9liwU2O8TOQmLrt1XhLWfkdJkj4dRWC6aNaYShjhdLOIbCwpGJh01ItIeaOeywUyN/tqrQy3QlaYw2K9hNSHWRn3QDYcz3P2JMqD9ZU+lPZRV55d50HbFvBO06BopVtqDRgF4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109160; c=relaxed/simple;
	bh=pk9SStOkm9HtYlm53RC4FWe7ynG+SM2C/0oSSEXRu/A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DQyaJ2qypMtn1wN1dyEi6hCXhOmItp0rEQ6aiHrTgp4V7f64AroIrWd1w9pZDSd6GIS25Vn6y6YNBSyT065xJi5FqNq3D+GBnWIAqFdPDSQUfsRNCieEpbrxQ055vFyjAzo6GbJ8wNyXh3tkS+FJ8cRrDfFQmsdXAibfIvIjKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=R3u9vIWX; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O7L4cv000450;
	Wed, 24 Jan 2024 09:12:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=s
	34WAcFS7YmLudj+Nc5iYgo1xcAFqjeqgfAxqyK01rU=; b=R3u9vIWXl/AMzsBrx
	F+g39TK/Htc+WQkKqRk0mH93zMTxvFff082Gk7JFsmT2Kw5a8gCPQ6qqH88Qt32j
	0qCN6wo/o2xSPUZN7wz1nsQjBr9BgimjdvV72q3QHaiWa7jsle1Qbq8Uty8kRoyN
	cuwLuVVNJTtjVBA9QqQNAcNO97ofR0OXcPjOA7DzLk5bsJwTXQ1XOd9CxntFwOcm
	AEfkLr0nQ7Ipl4jp/p6Q4xh0uxuuceHsKAwRENkkpnsNnT+QHP9u1vBEzesH8jWq
	otFK9nQswhUSjyhuAGYw46LRT/BzXUveaozihSen1gP93KqWHxRDZmpAAfTJdTLE
	b8qFQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmfhgxx7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 09:12:25 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:12:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 15:12:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 29F52820246;
	Wed, 24 Jan 2024 15:12:22 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH 1/6] mfd: cs42l43: Tidy up header includes
Date: Wed, 24 Jan 2024 15:12:17 +0000
Message-ID: <20240124151222.1448570-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AozGL7WfIKeRKsB6yIVyXAejrXDCfbYL
X-Proofpoint-GUID: AozGL7WfIKeRKsB6yIVyXAejrXDCfbYL
X-Proofpoint-Spam-Reason: safe

Use more forward declarations, move header guards to cover other
includes, and rely less on including headers through other headers.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43-i2c.c   |  6 +++++-
 drivers/mfd/cs42l43-sdw.c   |  6 +++++-
 drivers/mfd/cs42l43.c       |  8 +++++++-
 drivers/mfd/cs42l43.h       |  9 +++++----
 include/linux/mfd/cs42l43.h | 13 +++++++------
 5 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/cs42l43-i2c.c b/drivers/mfd/cs42l43-i2c.c
index 4922211680c96..7162274a0b551 100644
--- a/drivers/mfd/cs42l43-i2c.c
+++ b/drivers/mfd/cs42l43-i2c.c
@@ -6,11 +6,15 @@
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
+#include <linux/array_size.h>
 #include <linux/err.h>
-#include <linux/errno.h>
 #include <linux/i2c.h>
+#include <linux/mfd/cs42l43.h>
 #include <linux/mfd/cs42l43-regs.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
 
 #include "cs42l43.h"
 
diff --git a/drivers/mfd/cs42l43-sdw.c b/drivers/mfd/cs42l43-sdw.c
index 1d85bbf8cdd5d..d6962a5a35f65 100644
--- a/drivers/mfd/cs42l43-sdw.c
+++ b/drivers/mfd/cs42l43-sdw.c
@@ -6,11 +6,15 @@
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
+#include <linux/array_size.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/errno.h>
+#include <linux/mfd/cs42l43.h>
 #include <linux/mfd/cs42l43-regs.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw_type.h>
diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 7b6d07cbe6fc6..4e2bc5ad244a5 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -6,18 +6,24 @@
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
+#include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/build_bug.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/err.h>
-#include <linux/errno.h>
 #include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
 #include <linux/jiffies.h>
 #include <linux/mfd/core.h>
+#include <linux/mfd/cs42l43.h>
 #include <linux/mfd/cs42l43-regs.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/soundwire/sdw.h>
+#include <linux/types.h>
 
 #include "cs42l43.h"
 
diff --git a/drivers/mfd/cs42l43.h b/drivers/mfd/cs42l43.h
index eb4caf3938332..70129db9f916e 100644
--- a/drivers/mfd/cs42l43.h
+++ b/drivers/mfd/cs42l43.h
@@ -6,15 +6,16 @@
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
-#include <linux/mfd/cs42l43.h>
-#include <linux/pm.h>
-#include <linux/regmap.h>
-
 #ifndef CS42L43_CORE_INT_H
 #define CS42L43_CORE_INT_H
 
 #define CS42L43_N_DEFAULTS 176
 
+struct cs42l43;
+struct dev_pm_ops;
+struct device;
+struct reg_default;
+
 extern const struct dev_pm_ops cs42l43_pm_ops;
 extern const struct reg_default cs42l43_reg_default[CS42L43_N_DEFAULTS];
 
diff --git a/include/linux/mfd/cs42l43.h b/include/linux/mfd/cs42l43.h
index cf8263aab41bd..2239d8585e785 100644
--- a/include/linux/mfd/cs42l43.h
+++ b/include/linux/mfd/cs42l43.h
@@ -6,20 +6,21 @@
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
+#ifndef CS42L43_CORE_EXT_H
+#define CS42L43_CORE_EXT_H
+
 #include <linux/completion.h>
-#include <linux/device.h>
-#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-#include <linux/soundwire/sdw.h>
 #include <linux/workqueue.h>
 
-#ifndef CS42L43_CORE_EXT_H
-#define CS42L43_CORE_EXT_H
-
 #define CS42L43_N_SUPPLIES		3
 
+struct device;
+struct gpio_desc;
+struct sdw_slave;
+
 enum cs42l43_irq_numbers {
 	CS42L43_PLL_LOST_LOCK,
 	CS42L43_PLL_READY,
-- 
2.30.2


