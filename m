Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F200D7BFECE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjJJOLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJJOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:11:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4579FA7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696947106; x=1728483106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2VBQXVArfIBgHPpUcs1zlQhsNpmKngH8nu0wk1tf7IE=;
  b=E1zVf4tqyawx63DGJ/6zR3z2nyHb8/WtxjTki3wB7IFd1UIvyzLu625H
   bB2+Zz5/a3BtBht2QfTsVSX74/v4BPxrnNH86enU7tfy9b1SF9E41m/3Y
   ciiU/RxIqbPLZwhkx7HKuhVFsp5sbEZG5Le5O75wMZyb1EzTBftkAedCS
   q4boTpv5nhH21GQnwCjLTf9WV/H8maMnFzg3vl2YuCxu5ENuTsxfPTacg
   9tpyYZRa3ToqshT2T+B6FGjUhJUJopiaD/KlIWNin5oCbCcNPIfdbGmlf
   GaQnO0W7h50JI4KDjIFzqX3wzfIiDo4fDJxoElS2lTssod0umu2IutJJa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387241769"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="387241769"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1084802382"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1084802382"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2023 07:11:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 49F5B35A; Tue, 10 Oct 2023 17:11:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dipen Patel <dipenp@nvidia.com>, timestamp@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] hte: Use kasprintf() instead of fixed buffer formatting
Date:   Tue, 10 Oct 2023 17:11:23 +0300
Message-Id: <20231010141123.3909596-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability and maintainability by replacing a hardcoded string
allocation and formatting by the use of the kasprintf() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hte/hte.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
index 1fd8d2d4528b..23a6eeb8c506 100644
--- a/drivers/hte/hte.c
+++ b/drivers/hte/hte.c
@@ -17,8 +17,6 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 
-#define HTE_TS_NAME_LEN		10
-
 /* Global list of the HTE devices */
 static DEFINE_SPINLOCK(hte_lock);
 static LIST_HEAD(hte_devices);
@@ -389,13 +387,10 @@ static int __hte_req_ts(struct hte_ts_desc *desc, hte_ts_cb_t cb,
 
 	atomic_inc(&gdev->ts_req);
 
-	ei->line_name = NULL;
-	if (!desc->attr.name) {
-		ei->line_name = kzalloc(HTE_TS_NAME_LEN, GFP_KERNEL);
-		if (ei->line_name)
-			scnprintf(ei->line_name, HTE_TS_NAME_LEN, "ts_%u",
-				  desc->attr.line_id);
-	}
+	if (desc->attr.name)
+		ei->line_name = NULL;
+	else
+		ei->line_name = kasprintf(GFP_KERNEL, "ts_%u", desc->attr.line_id);
 
 	hte_ts_dbgfs_init(desc->attr.name == NULL ?
 			  ei->line_name : desc->attr.name, ei);
-- 
2.40.0.1.gaa8946217a0b

