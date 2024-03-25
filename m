Return-Path: <linux-kernel+bounces-116973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A41388A5AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF97E1F374CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947B19457;
	Mon, 25 Mar 2024 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIUeoTB7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D43DABFD;
	Mon, 25 Mar 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368598; cv=none; b=i/jWKfA8mJYpcSkRI91BhmEj3BkeqSmZdJSxyu3+vF8EVcfPzCv/MVnV0IdKwCtmz0d3qDy2zaK8iScCfU98tcDXhrv+f8z0dObSTxQoY1Q+qTkMuyMLAMLXfsoZ3g65NXKONQ+3BlNJuciRdTc0p0WcytVjU/9Lg7/rCh3pb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368598; c=relaxed/simple;
	bh=W/cO6pxnCka0JOSlclAmBwBis0mca+rD5Q5XRSgDsDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HctzbQpigkiBSkQ6QGMlFXuRTtPDHE9JQKizojl7fnjpHuxIhqBBgpZstHnE7/IOvtxHFfEWEHKm/YW5Zr3fkvv5k9GYnvNv/yp6yVU34AXnfqb5D7vj7oX95C4wNaxsRmBy/+GbojHsira2JD5wD19cXcLVmCnnBUADs6vtIO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIUeoTB7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711368597; x=1742904597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/cO6pxnCka0JOSlclAmBwBis0mca+rD5Q5XRSgDsDQ=;
  b=CIUeoTB7n7KovOBcUy0ll+D1UZ5E25v9aaPGlLyrWNIJsizOPD0gFkdd
   c7dRoQ3red49CpxH6dYx6BpjsMqy/OU+o98GO1ZsP0dESYk6nd5qhzs9g
   NlnXgycMnr/QBdFvawsaYA9guX42/WchBkoUmfws/xRfHPZrLwZiEtS/O
   nvU4gcYVUWh2EoHw2a2VJmF744KdDae4BByGPz9k6kkXKhQ8y4pSWdZ/v
   LzwyYhk+LqVVBBksewVCvHBTTkaD7nOTiHhonHb3EcqL1fEJeUYniMezS
   dnn4rMHkE3TK20tYhDfiVvRH5f1h4F/A76/Y7EE6X4U+kobzHzk2FJdle
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17757423"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17757423"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070311"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070311"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:09:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 05F5713F; Mon, 25 Mar 2024 14:09:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] hwmon: (pmbus/mp2975) Replace home made version of __assign_bit()
Date: Mon, 25 Mar 2024 14:07:42 +0200
Message-ID: <20240325120952.3019767-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
References: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The newly introduced SWAP() macro is quite generic by naming, but
moreover it's a repetition of the existing __assign_bit().
With this applied, add a missing bits.h (via now required bitops.h).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/pmbus/mp2975.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 953c02a2aeb5..af118087c4ee 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2020 Nvidia Technologies Ltd.
  */
 
+#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -396,7 +397,7 @@ static int mp2973_write_word_data(struct i2c_client *client, int page,
 				  int reg, u16 word)
 {
 	u8 target, mask;
-	int ret;
+	long ret;
 
 	if (reg != PMBUS_SMBALERT_MASK)
 		return -ENODATA;
@@ -415,7 +416,6 @@ static int mp2973_write_word_data(struct i2c_client *client, int page,
  * Set/Clear 'bit' in 'ret' based on condition followed by define for each bit in SMBALERT_MASK.
  * Also bit 2 & 15 are reserved.
  */
-#define SWAP(val, mask, cond, bit) (((mask) & (cond)) ? ((val) & ~BIT(bit)) : ((val) | BIT(bit)))
 
 #define MP2973_TEMP_OT		0
 #define MP2973_VIN_UVLO		1
@@ -434,36 +434,35 @@ static int mp2973_write_word_data(struct i2c_client *client, int page,
 
 	switch (target) {
 	case PMBUS_STATUS_CML:
-		ret = SWAP(ret, mask, PB_CML_FAULT_INVALID_DATA, MP2973_INVALID_DATA);
-		ret = SWAP(ret, mask, PB_CML_FAULT_INVALID_COMMAND,  MP2973_INVALID_COMMAND);
-		ret = SWAP(ret, mask, PB_CML_FAULT_OTHER_COMM, MP2973_OTHER_COMM);
-		ret = SWAP(ret, mask, PB_CML_FAULT_PACKET_ERROR, MP2973_PACKET_ERROR);
+		__assign_bit(MP2973_INVALID_DATA, &ret, !(mask & PB_CML_FAULT_INVALID_DATA));
+		__assign_bit(MP2973_INVALID_COMMAND, &ret, !(mask & PB_CML_FAULT_INVALID_COMMAND));
+		__assign_bit(MP2973_OTHER_COMM, &ret, !(mask & PB_CML_FAULT_OTHER_COMM));
+		__assign_bit(MP2973_PACKET_ERROR, &ret, !(mask & PB_CML_FAULT_PACKET_ERROR));
 		break;
 	case PMBUS_STATUS_VOUT:
-		ret = SWAP(ret, mask, PB_VOLTAGE_UV_FAULT, MP2973_VOLTAGE_UV);
-		ret = SWAP(ret, mask, PB_VOLTAGE_OV_FAULT, MP2973_VOLTAGE_OV);
+		__assign_bit(MP2973_VOLTAGE_UV, &ret, !(mask & PB_VOLTAGE_UV_FAULT));
+		__assign_bit(MP2973_VOLTAGE_OV, &ret, !(mask & PB_VOLTAGE_OV_FAULT));
 		break;
 	case PMBUS_STATUS_IOUT:
-		ret = SWAP(ret, mask, PB_IOUT_OC_FAULT, MP2973_IOUT_OC);
-		ret = SWAP(ret, mask, PB_IOUT_OC_LV_FAULT, MP2973_IOUT_OC_LV);
+		__assign_bit(MP2973_IOUT_OC, &ret, !(mask & PB_IOUT_OC_FAULT));
+		__assign_bit(MP2973_IOUT_OC_LV, &ret, !(mask & PB_IOUT_OC_LV_FAULT));
 		break;
 	case PMBUS_STATUS_TEMPERATURE:
-		ret = SWAP(ret, mask, PB_TEMP_OT_FAULT, MP2973_TEMP_OT);
+		__assign_bit(MP2973_TEMP_OT, &ret, !(mask & PB_TEMP_OT_FAULT));
 		break;
 	/*
 	 * Map remaining bits to MFR specific to let the PMBUS core mask
 	 * those bits by default.
 	 */
 	case PMBUS_STATUS_MFR_SPECIFIC:
-		ret = SWAP(ret, mask, BIT(1), MP2973_VIN_UVLO);
-		ret = SWAP(ret, mask, BIT(3), MP2973_VIN_OVP);
-		ret = SWAP(ret, mask, BIT(4), MP2973_MTP_FAULT);
-		ret = SWAP(ret, mask, BIT(6), MP2973_MTP_BLK_TRIG);
+		__assign_bit(MP2973_VIN_UVLO, &ret, !(mask & BIT(1)));
+		__assign_bit(MP2973_VIN_OVP, &ret, !(mask & BIT(3)));
+		__assign_bit(MP2973_MTP_FAULT, &ret, !(mask & BIT(4)));
+		__assign_bit(MP2973_MTP_BLK_TRIG, &ret, !(mask & BIT(6)));
 		break;
 	default:
 		return 0;
 	}
-#undef SWAP
 
 	return pmbus_write_word_data(client, 0, PMBUS_SMBALERT_MASK, ret);
 }
-- 
2.43.0.rc1.1.gbec44491f096


