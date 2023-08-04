Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67DF76F70C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjHDBlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHDBlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:41:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF7E7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691113308; x=1722649308;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RH9g7mHpO6m9E4HwA2pIuIm9DONOeF93GtlqloaWU0k=;
  b=Ol2Q4exBCBj7I6rAnjbDLThm4+ek7zTx/kmeYGwGkfl34+R/yD7mxJMI
   qA9RDnsIB/X+7Egz1QlsOZTrJ46rezvnUpcYsAl/s4+t63U4QGvBJJ8O2
   ZU7wEJ0osQ2HD7+3xYbTM5pI+sVysCgD1LpuOPoVMucRbxHu7QqgELhgq
   5lzd1Zr5KiVWXoXhdU8cme24s5XuqHNi3ze7CsJwVwvvNDr4zo59e2YOE
   33lsdcF58kMqs7nHp9Kq6lsqfybqabQ/kOwlYu/VE1A060A3Z+oIV/PMo
   e1G0YY2ufifikZIbLtGM0Wz4IkpgRB1dhQmsZPNIkofTIn0FNL8w7aPa8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="372788651"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="372788651"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 18:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="759350022"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="759350022"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2023 18:41:47 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, tien.sung.ang@intel.com,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH] drivers: firmware: stratix10-rsu: Fix max_retry counter value
Date:   Fri,  4 Aug 2023 09:35:17 +0800
Message-Id: <88b79f4cfe1c28e31b902d2f12b81e431b09e125.1691112823.git.kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Fix the max_retry value because the value is truncated at scnprintf format
specifier, with added hex symbol and newline.

Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
 drivers/firmware/stratix10-rsu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index e51c95f8d445..98ec39f6dae8 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -405,8 +405,7 @@ static ssize_t max_retry_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return scnprintf(buf, sizeof(priv->max_retry),
-			 "0x%08x\n", priv->max_retry);
+	return scnprintf(buf, PAGE_SIZE, "0x%08x\n", priv->max_retry);
 }
 
 static ssize_t dcmf0_show(struct device *dev,

base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
-- 
2.25.1

