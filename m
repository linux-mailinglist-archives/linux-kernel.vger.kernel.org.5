Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25747E823C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjKJTHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjKJTHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:07:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D8B43F24;
        Fri, 10 Nov 2023 10:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699641006; x=1731177006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Ch616RIiwMbi+7TM0+OouYVFx4BrkmdvHXetfyjPF8=;
  b=XRpPg6QR9JSZWAJzqQFr/TPEOV1dwyAbwUUIYBxG4nN9c1dOBpCEJY5g
   gEz1YiL3kg4xPOF4wVLBQA16Zts4INzneWCKp+wrCaQVw1GcjrXGL7GtU
   bmXwpirMXg5O+BkUFuCZC+7aqoWTpSSa3DrSkWFQVoanhLngcUbtho+ff
   o+O4LiG+8T1H3yubegzT6SQpxlOfIbIY7bOSF9zBNBuvWlYhireDpEv9V
   IKFbtfQwd7vH1l6Za54rSj33XkDIL4aX94ygdsdbEVPUUBwgBxol6DYvM
   pvuJ/G6hUuPSaY1cQVk9Cuv9wfZV/PgdU1EOffYOqvX8ThmlCEx+S7l/F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="456715043"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="456715043"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 10:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="763808230"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="763808230"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Nov 2023 10:29:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AD3C1812; Fri, 10 Nov 2023 20:23:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 07/25] i2c: designware: Save pointer to semaphore callbacks instead of index
Date:   Fri, 10 Nov 2023 20:11:27 +0200
Message-ID: <20231110182304.3894319-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of saving index and do an additional level of referencing,
save just a pointer to the semaphore callbacks directly. It makes
code cleaner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-core.h    |  4 +++-
 drivers/i2c/busses/i2c-designware-platdrv.c | 12 ++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index a7f6f3eafad7..f8dd87cb0ae9 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -187,6 +187,8 @@ struct clk;
 struct device;
 struct reset_control;
 
+struct i2c_dw_semaphore_callbacks;
+
 /**
  * struct dw_i2c_dev - private i2c-designware data
  * @dev: driver model device node
@@ -291,7 +293,7 @@ struct dw_i2c_dev {
 	u16			hs_lcnt;
 	int			(*acquire_lock)(void);
 	void			(*release_lock)(void);
-	int			semaphore_idx;
+	const struct i2c_dw_semaphore_callbacks *semaphore_cb;
 	bool			shared_with_punit;
 	void			(*disable)(struct dw_i2c_dev *dev);
 	int			(*init)(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index cb954f11540e..4b5e58e1ce5b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -247,21 +247,18 @@ static void i2c_dw_remove_lock_support(void *data)
 {
 	struct dw_i2c_dev *dev = data;
 
-	if (dev->semaphore_idx < 0)
+	if (!dev->semaphore_cb)
 		return;
 
-	if (i2c_dw_semaphore_cb_table[dev->semaphore_idx].remove)
-		i2c_dw_semaphore_cb_table[dev->semaphore_idx].remove(dev);
+	if (dev->semaphore_cb->remove)
+		dev->semaphore_cb->remove(dev);
 }
 
 static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 {
 	const struct i2c_dw_semaphore_callbacks *ptr;
-	int i = 0;
 	int ret;
 
-	dev->semaphore_idx = -1;
-
 	for (ptr = i2c_dw_semaphore_cb_table; ptr->probe; ptr++) {
 		ret = ptr->probe(dev);
 		if (ret) {
@@ -273,11 +270,10 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 			if (ret != -ENODEV)
 				return ret;
 
-			i++;
 			continue;
 		}
 
-		dev->semaphore_idx = i;
+		dev->semaphore_cb = ptr;
 		break;
 	}
 
-- 
2.43.0.rc1.1.gbec44491f096

