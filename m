Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4AA7CB6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjJPXZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjJPXZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:25:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FF4AB;
        Mon, 16 Oct 2023 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697498711; x=1729034711;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=2kt/w8eLDaIGJ2Mfx4T93ceuXqMWzs0ZvRIowymZZI4=;
  b=kJcwAwU1yEk2ZEX6e37ML+TGiWs/CrToHk9cInVx5nhDowqI2ZyVS5U/
   9GE2SqZ0J4uIWMQrajrb9f28+KfhtLRs1Ws3SDr40gBxCyUNX5CtY/+91
   3WqDWouWNSYxQ89rWVEA8NMn70/NA+R7BvAxdbtz58WrWIfr9epEauJrf
   mBFdmhn7JW11m4MSLgdDBbV6aTo6AQfUW34GIhMmo4ek9tDskNMNPIr/H
   eOHMR+r3nhPyMLeDsVOMFe/w2PTVhk2sbJxZ8uHLHe92jjHEHW/Ean8Ea
   fGtqxSCMfB68WIcsortDMF8n3YDH8NXDI88u5+lrfClkE0Cn8gtOMw9Un
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="449883618"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="449883618"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 16:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785272747"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="785272747"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.116.49])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 16:25:06 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 16 Oct 2023 16:25:05 -0700
Subject: [PATCH] cxl/pmu: Ensure put_device on pmu devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-pmu-unregister-fix-v1-1-1e2eb2fa3c69@intel.com>
X-B4-Tracking: v=1; b=H4sIAFDGLWUC/x2NSw6DMAwFr4K8rqUkfAS9SsXCUANekCIbUCXE3
 Zt0OXozehcYq7DBs7hA+RSTT0zgHwWMC8WZUd6JIbhQeucb3NYDj6g8i+2sOMkXy6quWteFhuo
 WUjiQMQ5KcVxyulI287ApJ///9urv+wcmG22VfQAAAA==
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697498705; l=2312;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=2kt/w8eLDaIGJ2Mfx4T93ceuXqMWzs0ZvRIowymZZI4=;
 b=ZbH7jLiNUobqr1IrrnANR3rfxB/qSnGuvnewZCwggnPrrU6/tcb2hA9yFTi5Xa+L5cLud8znB
 th3Ce1ic6OoCmI8lYoP0sw6U4ypy2qGtZdeBeelJioqUjIDemTcoxdd
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following kmemleaks were detected when removing the cxl module
stack:

unreferenced object 0xffff88822616b800 (size 1024):
...
  backtrace:
    [<00000000bedc6f83>] kmalloc_trace+0x26/0x90
    [<00000000448d1afc>] devm_cxl_pmu_add+0x3a/0x110 [cxl_core]
    [<00000000ca3bfe16>] 0xffffffffa105213b
    [<00000000ba7f78dc>] local_pci_probe+0x41/0x90
    [<000000005bb027ac>] pci_device_probe+0xb0/0x1c0
...
unreferenced object 0xffff8882260abcc0 (size 16):
...
  hex dump (first 16 bytes):
    70 6d 75 5f 6d 65 6d 30 2e 30 00 26 82 88 ff ff  pmu_mem0.0.&....
  backtrace:
...
    [<00000000152b5e98>] dev_set_name+0x43/0x50
    [<00000000c228798b>] devm_cxl_pmu_add+0x102/0x110 [cxl_core]
    [<00000000ca3bfe16>] 0xffffffffa105213b
    [<00000000ba7f78dc>] local_pci_probe+0x41/0x90
    [<000000005bb027ac>] pci_device_probe+0xb0/0x1c0
...
unreferenced object 0xffff8882272af200 (size 256):
...
  backtrace:
    [<00000000bedc6f83>] kmalloc_trace+0x26/0x90
    [<00000000a14d1813>] device_add+0x4ea/0x890
    [<00000000a3f07b47>] devm_cxl_pmu_add+0xbe/0x110 [cxl_core]
    [<00000000ca3bfe16>] 0xffffffffa105213b
    [<00000000ba7f78dc>] local_pci_probe+0x41/0x90
    [<000000005bb027ac>] pci_device_probe+0xb0/0x1c0
...

devm_cxl_pmu_add() correctly registers a device remove function but it
only calls device_del() which is only part of device unregistration.

Properly call device_unregister() to free up the memory associated with
the device.

Fixes: 1ad3f701c399 ("cxl/pci: Find and register CXL PMU devices")
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pmu.c b/drivers/cxl/core/pmu.c
index 7684c843e5a5..5d8e06b0ba6e 100644
--- a/drivers/cxl/core/pmu.c
+++ b/drivers/cxl/core/pmu.c
@@ -23,7 +23,7 @@ const struct device_type cxl_pmu_type = {
 
 static void remove_dev(void *dev)
 {
-	device_del(dev);
+	device_unregister(dev);
 }
 
 int devm_cxl_pmu_add(struct device *parent, struct cxl_pmu_regs *regs,

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231016-pmu-unregister-fix-345480926a58

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

