Return-Path: <linux-kernel+bounces-135547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C089C75B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2001B22507
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89709140E40;
	Mon,  8 Apr 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QxOxCU5m"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA213F421
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587573; cv=none; b=PN8hr66Tk5AKGeCaxyS0ppwkeOC9PnVm/WohNWu+NsswhQmOYYuxGS23ZnoS4XQc+B2i8Tu96srbFUZtCIKyTJ2AIPKBoyKfV9VfcthgxhifK6HUMr6X6Nx54FjsxS39mk7cvnYhUD+D3hs0rslxuks3npLuaLepKmr8g3gbeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587573; c=relaxed/simple;
	bh=tZ0ChOigTyFhTPj1fd2ZmPp9Kwbgmu3k0ib7CAj7Tp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXIqppREVCVUeGLzPFly3kpn+4KiatGLIBlezsEujumxRSIcEWwYqiHuOsEj3wX8J+9Wt3bShSKHJ+QJo933nOuNAaRC1D80tk5hwNyhTvfKrU5Z9SDAlBR2U2X5JbOxa48NcBxQfEDMaCbnbqdWJKN2t6DBaspL5jPCew0pBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QxOxCU5m; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385mlL5032409;
	Mon, 8 Apr 2024 09:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=d7MUA8YSpTzS81JUQMKOMK4CDGrnk/tQ/v/lenBUBCk=; b=
	QxOxCU5mXQ/Sr4NSFx4rZK9ktRtixHbupWGVfGRlxje6WEXQDAYjtmLEzWdn3sXP
	Hiv2D8/b25Dw9wnvnLoYOWi3HvRDaYzQy5X1+4acT+Xc+ApwIQWv8gLSlY5ZGeEN
	Q4a85Z288jWGPdetZVGaKpNkPFwLZI0lEZWd4O09lUqWjdnEs/2abnFqH6gjgUPP
	C+4G3NKskVf92EtHB6J2bp1loVo8vH3vhl5zm1QbLTTYbxwovAiBcDfLqZASLkB+
	jmXI/MAGu3Ku7XOpeoGarBHrLNUNb4KNTE4JKHHJRLgXIOVnTN6x0hYXU+Nm8ijm
	3w0t8s6z/sK8ujRazr4YVg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp7-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:07 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C0575820270;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 08/11] regmap: kunit: Use a KUnit action to call regmap_exit()
Date: Mon, 8 Apr 2024 15:45:57 +0100
Message-ID: <20240408144600.230848-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408144600.230848-1-rf@opensource.cirrus.com>
References: <20240408144600.230848-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5taDHWMjp2rNNV40v52FNkFvVmpNCBat
X-Proofpoint-GUID: 5taDHWMjp2rNNV40v52FNkFvVmpNCBat
X-Proofpoint-Spam-Reason: safe

Registert a KUnit action handler to call regmap_exit() when a test
terminates. This ensures that regmap_exit() will be called if a test
function returns early or aborts.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-kunit.c | 62 ++++--------------------------
 1 file changed, 7 insertions(+), 55 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 1b34f92b1aaf..e21028cbddc3 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -5,11 +5,14 @@
 // Copyright 2023 Arm Ltd
 
 #include <kunit/device.h>
+#include <kunit/resource.h>
 #include <kunit/test.h>
 #include "internal.h"
 
 #define BLOCK_TEST_SIZE 12
 
+KUNIT_DEFINE_ACTION_WRAPPER(regmap_exit_action, regmap_exit, struct regmap *);
+
 struct regmap_test_priv {
 	struct device *dev;
 };
@@ -190,6 +193,8 @@ static struct regmap *gen_regmap(struct kunit *test,
 	if (IS_ERR(ret)) {
 		kfree(buf);
 		kfree(*data);
+	} else {
+		kunit_add_action(test, regmap_exit_action, ret);
 	}
 
 	return ret;
@@ -226,8 +231,6 @@ static void basic_read_write(struct kunit *test)
 
 	/* If using a cache the cache satisfied the read */
 	KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[0]);
-
-	regmap_exit(map);
 }
 
 static void bulk_write(struct kunit *test)
@@ -261,8 +264,6 @@ static void bulk_write(struct kunit *test)
 	/* If using a cache the cache satisfied the read */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
-
-	regmap_exit(map);
 }
 
 static void bulk_read(struct kunit *test)
@@ -292,8 +293,6 @@ static void bulk_read(struct kunit *test)
 	/* If using a cache the cache satisfied the read */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
-
-	regmap_exit(map);
 }
 
 static void write_readonly(struct kunit *test)
@@ -325,8 +324,6 @@ static void write_readonly(struct kunit *test)
 	/* Did that match what we see on the device? */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		KUNIT_EXPECT_EQ(test, i != 5, data->written[i]);
-
-	regmap_exit(map);
 }
 
 static void read_writeonly(struct kunit *test)
@@ -363,8 +360,6 @@ static void read_writeonly(struct kunit *test)
 
 	/* Did we trigger a hardware access? */
 	KUNIT_EXPECT_FALSE(test, data->read[5]);
-
-	regmap_exit(map);
 }
 
 static void reg_defaults(struct kunit *test)
@@ -471,8 +466,6 @@ static void register_patch(struct kunit *test)
 			break;
 		}
 	}
-
-	regmap_exit(map);
 }
 
 static void stride(struct kunit *test)
@@ -512,8 +505,6 @@ static void stride(struct kunit *test)
 			KUNIT_EXPECT_TRUE(test, data->written[i]);
 		}
 	}
-
-	regmap_exit(map);
 }
 
 static struct regmap_range_cfg test_range = {
@@ -612,8 +603,6 @@ static void basic_ranges(struct kunit *test)
 		KUNIT_EXPECT_FALSE(test, data->read[i]);
 		KUNIT_EXPECT_FALSE(test, data->written[i]);
 	}
-
-	regmap_exit(map);
 }
 
 /* Try to stress dynamic creation of cache data structures */
@@ -665,8 +654,6 @@ static void stress_insert(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, rval, vals[i]);
 		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
 	}
-
-	regmap_exit(map);
 }
 
 static void cache_bypass(struct kunit *test)
@@ -702,8 +689,6 @@ static void cache_bypass(struct kunit *test)
 	regcache_cache_bypass(map, false);
 	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, param->from_reg, &rval));
 	KUNIT_EXPECT_EQ(test, val, rval);
-
-	regmap_exit(map);
 }
 
 static void cache_sync_marked_dirty(struct kunit *test)
@@ -739,8 +724,6 @@ static void cache_sync_marked_dirty(struct kunit *test)
 	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], val, sizeof(val));
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		KUNIT_EXPECT_EQ(test, true, data->written[param->from_reg + i]);
-
-	regmap_exit(map);
 }
 
 static void cache_sync_after_cache_only(struct kunit *test)
@@ -790,8 +773,6 @@ static void cache_sync_after_cache_only(struct kunit *test)
 	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], val, sizeof(val));
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		KUNIT_EXPECT_TRUE(test, data->written[param->from_reg + i]);
-
-	regmap_exit(map);
 }
 
 static void cache_sync_defaults_marked_dirty(struct kunit *test)
@@ -841,8 +822,6 @@ static void cache_sync_defaults_marked_dirty(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		KUNIT_EXPECT_FALSE(test, data->written[param->from_reg + i]);
-
-	regmap_exit(map);
 }
 
 static void cache_sync_default_after_cache_only(struct kunit *test)
@@ -890,8 +869,6 @@ static void cache_sync_default_after_cache_only(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 	KUNIT_EXPECT_TRUE(test, data->written[param->from_reg + 2]);
 	KUNIT_EXPECT_EQ(test, data->vals[param->from_reg + 2], orig_val);
-
-	regmap_exit(map);
 }
 
 static void cache_sync_readonly(struct kunit *test)
@@ -930,8 +907,6 @@ static void cache_sync_readonly(struct kunit *test)
 	/* Did that match what we see on the device? */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		KUNIT_EXPECT_EQ(test, i != 5, data->written[param->from_reg + i]);
-
-	regmap_exit(map);
 }
 
 static void cache_sync_patch(struct kunit *test)
@@ -990,8 +965,6 @@ static void cache_sync_patch(struct kunit *test)
 			break;
 		}
 	}
-
-	regmap_exit(map);
 }
 
 static void cache_drop(struct kunit *test)
@@ -1032,8 +1005,6 @@ static void cache_drop(struct kunit *test)
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		KUNIT_EXPECT_EQ(test, data->read[param->from_reg + i], i >= 3 && i <= 5);
 	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], rval, sizeof(rval));
-
-	regmap_exit(map);
 }
 
 static void cache_drop_all_and_sync_marked_dirty(struct kunit *test)
@@ -1075,8 +1046,6 @@ static void cache_drop_all_and_sync_marked_dirty(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 	for (i = 0; i <= config.max_register; i++)
 		KUNIT_EXPECT_FALSE(test, data->written[i]);
-
-	regmap_exit(map);
 }
 
 static void cache_drop_all_and_sync_no_defaults(struct kunit *test)
@@ -1119,8 +1088,6 @@ static void cache_drop_all_and_sync_no_defaults(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 	for (i = 0; i <= config.max_register; i++)
 		KUNIT_EXPECT_FALSE(test, data->written[i]);
-
-	regmap_exit(map);
 }
 
 static void cache_drop_all_and_sync_has_defaults(struct kunit *test)
@@ -1164,8 +1131,6 @@ static void cache_drop_all_and_sync_has_defaults(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 	for (i = 0; i <= config.max_register; i++)
 		KUNIT_EXPECT_FALSE(test, data->written[i]);
-
-	regmap_exit(map);
 }
 
 static void cache_present(struct kunit *test)
@@ -1202,8 +1167,6 @@ static void cache_present(struct kunit *test)
 	/* Now everything should be cached */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		KUNIT_ASSERT_TRUE(test, regcache_reg_cached(map, param->from_reg + i));
-
-	regmap_exit(map);
 }
 
 /* Check that caching the window register works with sync */
@@ -1350,6 +1313,8 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 	if (IS_ERR(ret)) {
 		kfree(buf);
 		kfree(*data);
+	} else {
+		kunit_add_action(test, regmap_exit_action, ret);
 	}
 
 	return ret;
@@ -1375,8 +1340,6 @@ static void raw_read_defaults_single(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &rval));
 		KUNIT_EXPECT_EQ(test, config.reg_defaults[i].def, rval);
 	}
-
-	regmap_exit(map);
 }
 
 static void raw_read_defaults(struct kunit *test)
@@ -1414,7 +1377,6 @@ static void raw_read_defaults(struct kunit *test)
 	}
 
 	kfree(rval);
-	regmap_exit(map);
 }
 
 static void raw_write_read_single(struct kunit *test)
@@ -1438,8 +1400,6 @@ static void raw_write_read_single(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 0, val));
 	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &rval));
 	KUNIT_EXPECT_EQ(test, val, rval);
-
-	regmap_exit(map);
 }
 
 static void raw_write(struct kunit *test)
@@ -1489,8 +1449,6 @@ static void raw_write(struct kunit *test)
 
 	/* The values should appear in the "hardware" */
 	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], val, sizeof(val));
-
-	regmap_exit(map);
 }
 
 static bool reg_zero(struct device *dev, unsigned int reg)
@@ -1548,8 +1506,6 @@ static void raw_noinc_write(struct kunit *test)
 	/* Make sure we didn't touch the register after the noinc register */
 	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 1, &val));
 	KUNIT_ASSERT_EQ(test, val_test, val);
-
-	regmap_exit(map);
 }
 
 static void raw_sync(struct kunit *test)
@@ -1625,8 +1581,6 @@ static void raw_sync(struct kunit *test)
 
 	/* The values should now appear in the "hardware" */
 	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], &val[0], sizeof(val));
-
-	regmap_exit(map);
 }
 
 static void raw_ranges(struct kunit *test)
@@ -1689,8 +1643,6 @@ static void raw_ranges(struct kunit *test)
 		KUNIT_EXPECT_FALSE(test, data->read[i]);
 		KUNIT_EXPECT_FALSE(test, data->written[i]);
 	}
-
-	regmap_exit(map);
 }
 
 static struct kunit_case regmap_test_cases[] = {
-- 
2.39.2


