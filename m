Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1DA760CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjGYIGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjGYIGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:06:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC64116;
        Tue, 25 Jul 2023 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690272397; x=1721808397;
  h=from:to:cc:subject:date:message-id;
  bh=nMTbfPgVcvacXEUWqJGCOueLTjOGIDiOh188sMtapls=;
  b=QXRten4v66Ez8U9ef1nDbRhFkJSmXU/4VaPhQE8pSZV3sK8oZTJfGQtM
   Y3KhpkEPbCWPX0F4/rk6sJAYUcLqrBrN4ZyQlycQAhhOmPTv1mEuU5qqZ
   vNfanIMaTuVPkS4EO0k6OUeMPfm8YniTmxv/rxmLOjZaJM9X6UZr1ijIp
   1E1f+czoi/BX4KG68qFy8p+xv7AHdhe6IHDTs9L9ejirUjh+VJlMXlVFO
   ylmWyhZu+cI544AgvqeC2IHz/4O5oRs9a0wKZqppX/tQqxLm5xYdqXDHS
   CoXNhkqp4AVwh0EcLuzqqAKq/hj6Cr0E+rvsiReXNyvAxBv5dUtH8Axv7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347258863"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="347258863"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="972570573"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972570573"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:06:25 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ee Wey Lim <ee.wey.lim@intel.com>
Subject: [PATCH 1/1] EDAC/igen6: Fix the issue of no error events
Date:   Tue, 25 Jul 2023 16:04:27 +0800
Message-Id: <20230725080427.23883-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current igen6_edac checks for pending errors before the registration
of the error handler. However, there is a possibility that the error
occurs during the registration process, leading to unhandled pending
errors and no future error events. This issue can be reproduced by
repeatedly injecting errors during the loading of the igen6_edac.

Fix this issue by moving the pending error handler after the registration
of the error handler, ensuring that no pending errors are left unhandled.

Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Reported-by: Ee Wey Lim <ee.wey.lim@intel.com>
Tested-by: Ee Wey Lim <ee.wey.lim@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 544dd19072ea..1a18693294db 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -27,7 +27,7 @@
 #include "edac_mc.h"
 #include "edac_module.h"
 
-#define IGEN6_REVISION	"v2.5"
+#define IGEN6_REVISION	"v2.5.1"
 
 #define EDAC_MOD_STR	"igen6_edac"
 #define IGEN6_NMI_NAME	"igen6_ibecc"
@@ -1216,9 +1216,6 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&ecclog_work, ecclog_work_cb);
 	init_irq_work(&ecclog_irq_work, ecclog_irq_work_cb);
 
-	/* Check if any pending errors before registering the NMI handler */
-	ecclog_handler();
-
 	rc = register_err_handler();
 	if (rc)
 		goto fail3;
@@ -1230,6 +1227,9 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto fail4;
 	}
 
+	/* Check if any pending errors before/during the registration of the error handler */
+	ecclog_handler();
+
 	igen6_debug_setup();
 	return 0;
 fail4:
-- 
2.17.1

