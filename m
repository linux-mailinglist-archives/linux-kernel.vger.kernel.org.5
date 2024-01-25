Return-Path: <linux-kernel+bounces-38386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3404183BEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A196B25DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95A41CD25;
	Thu, 25 Jan 2024 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HV/nonW+"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB61CA85;
	Thu, 25 Jan 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178364; cv=none; b=B9teKNA/NOycEpHN67I8Dg615veC240Ph9TMda8fFO+uq/BHF0gJYMTMubueNuLYk+ovTOYuAoH3O3IQIqB4k+gt1y9ayW1rR9zveVoUPmy9jziVlyaWqYbNZ7PsgYDFVoHvUl2yHWIe4KbUiL+REqbr/AW4hPATOuKFZ5EB82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178364; c=relaxed/simple;
	bh=h64B4Jysj120NFVqsEz9rAYExohizXd5EBkLaCHZXzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdfeXsPvHB3xfZst/eeU3OFz61+bpd2B4CUQoTZ0DE2quJHC8aWd/d/Iy9+46ivWoKbwAHx6HFXM6xtC/Qo4/wvD1SAl05rsU9OFx8TFROZU/6DibJz27oEy98TslLwEzdpiPpYuHlNG36C4goC+X5HI8TbHCBFuCqKWNtLCuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HV/nonW+; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P7paSO014010;
	Thu, 25 Jan 2024 04:25:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=tgZbg7s/Xmp8FdDn7TgrjKWKHPIok2Iqw7axQOHNlMM=; b=
	HV/nonW+oGdI8zJSDjn7oq3fQO/T/ZU4xzzQcSrsSeUqLqTAwd7Gb5wHkTOX0n2X
	x0J2ta02xtBSZRcUZu2xleGX4Ub2GJRpcDvHJo2yJxIjnaWb3N081czQNpChNR4/
	jeepnr5dC0LoUS/CNRePZHyPC0cUPfICrtwtkkwEDo6dJEh/l2mqWbHlzLY8YVpH
	cQPhKExaccJgoCrfeT31dGZWfCt4gyDqPT2uQSpiQP8TukAHviZWJQzftRUsfVZI
	E/7Dx5d/CLKHqPcwDl31yf50R+VBwOPV8XTlKZgbXKC4nFm9PANayq0e/mmi7nFn
	G1WcS5pwwmMRgJSuN0/Z6Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9t2gh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 04:25:57 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 10:25:55 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 25 Jan 2024 10:25:55 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5DAD9820247;
	Thu, 25 Jan 2024 10:25:55 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 2/6] mfd: cs42l43: Tidy up header includes
Date: Thu, 25 Jan 2024 10:25:51 +0000
Message-ID: <20240125102555.2621736-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
References: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tn-o0PeWwAAjmCuXt3tXH5RH0hsorDEi
X-Proofpoint-ORIG-GUID: tn-o0PeWwAAjmCuXt3tXH5RH0hsorDEi
X-Proofpoint-Spam-Reason: safe

Use more forward declarations, move header guards to cover other
includes, and rely less on including headers through other headers.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Added pm.h and regmap.h back into mfd/cs42l43.h

Thanks,
Charles

 drivers/mfd/cs42l43-i2c.c   |  6 +++++-
 drivers/mfd/cs42l43-sdw.c   |  6 +++++-
 drivers/mfd/cs42l43.c       |  8 +++++++-
 drivers/mfd/cs42l43.h       | 10 ++++++----
 include/linux/mfd/cs42l43.h | 13 +++++++------
 5 files changed, 30 insertions(+), 13 deletions(-)

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
index eb4caf3938332..aded994b7046b 100644
--- a/drivers/mfd/cs42l43.h
+++ b/drivers/mfd/cs42l43.h
@@ -6,15 +6,17 @@
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
-#include <linux/mfd/cs42l43.h>
-#include <linux/pm.h>
-#include <linux/regmap.h>
-
 #ifndef CS42L43_CORE_INT_H
 #define CS42L43_CORE_INT_H
 
+#include <linux/pm.h>
+#include <linux/regmap.h>
+
 #define CS42L43_N_DEFAULTS 176
 
+struct cs42l43;
+struct device;
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


