Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090E0753640
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjGNJRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjGNJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:17:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA4B211C;
        Fri, 14 Jul 2023 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689326268; x=1720862268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dTgIUvDYhlnavXOxaZLL1p9dKAgNDGlalBZILcSqRs=;
  b=BhhCLTE1MFAnNbrfcS+QIW5/jHf9m0AXXqASs9f9rEIqw9QLVLJYhDaI
   NwsLQTbAv5CnqZSE8OXJTvCxmI/UlZ67orZOXJLWPmO/wqywZG8iA3mvV
   GL5yS4WGnIPrbI5/R0Kr9FqSor1TVHxJTUS8R9Co9VuWkvEy7poq04Mnu
   tw8Awp9aVpxqRGe1NBBB8aRq8UUlJomhtz/S3UL+UidGDsO5o2+qKzy1x
   ceCbb1lWtx2XAbf5AYXBhhMBzwTiO70hg7b8KQXQ04kie1l2VyGzZw8nw
   NLqjRzYhRJ+shTCOM/Z1TpxjZ/k/AkO17v/CJM9XB5JigajgiUvXpVEv4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362897874"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="362897874"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 02:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812357261"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="812357261"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 02:17:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AB94A3E3; Fri, 14 Jul 2023 12:17:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 4/4] spi: Use struct_size() helper
Date:   Fri, 14 Jul 2023 12:17:48 +0300
Message-Id: <20230714091748.89681-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230714091748.89681-1-andriy.shevchenko@linux.intel.com>
References: <20230714091748.89681-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/process/deprecated.rst suggests to use flexible array
members to provide a way to declare having a dynamically sized set of
trailing elements in a structure.This makes code robust agains bunch of
the issues described in the documentation, main of which is about the
correctness of the sizeof() calculation for this data structure.

Due to above, prefer struct_size() over open-coded versions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 04daf61dfd3f..7f8b478fdeb3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -13,6 +13,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kthread.h>
 #include <linux/mod_devicetable.h>
+#include <linux/overflow.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/u64_stats_sync.h>
@@ -1085,6 +1086,8 @@ struct spi_transfer {
  * @state: for use by whichever driver currently owns the message
  * @resources: for resource management when the SPI message is processed
  * @prepared: spi_prepare_message was called for the this message
+ * @t: for use with spi_message_alloc() when message and transfers have
+ *	been allocated together
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1139,6 +1142,9 @@ struct spi_message {
 
 	/* List of spi_res resources when the SPI message is processed */
 	struct list_head        resources;
+
+	/* For embedding transfers into the memory of the message */
+	struct spi_transfer	t[];
 };
 
 static inline void spi_message_init_no_memset(struct spi_message *m)
@@ -1199,16 +1205,13 @@ static inline struct spi_message *spi_message_alloc(unsigned ntrans, gfp_t flags
 {
 	struct spi_message *m;
 
-	m = kzalloc(sizeof(struct spi_message)
-			+ ntrans * sizeof(struct spi_transfer),
-			flags);
+	m = kzalloc(struct_size(m, t, ntrans), flags);
 	if (m) {
 		unsigned i;
-		struct spi_transfer *t = (struct spi_transfer *)(m + 1);
 
 		spi_message_init_no_memset(m);
-		for (i = 0; i < ntrans; i++, t++)
-			spi_message_add_tail(t, m);
+		for (i = 0; i < ntrans; i++)
+			spi_message_add_tail(&m->t[i], m);
 	}
 	return m;
 }
-- 
2.40.0.1.gaa8946217a0b

