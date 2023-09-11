Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B0779B068
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjIKUts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbjIKJFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:05:04 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F087CCC;
        Mon, 11 Sep 2023 02:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1694423100; x=1725959100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6HZ3ImJ0ubDWZx9vArQn3ZwdK51K1SOGtrY5KEqqUJM=;
  b=ODuC5x1Vu0vuj3tOhyODVfJVxxi84TZBu5sOjFtY7na4bGIYeXxXf1Zx
   13DCP2tdkETu6hwnjItlz97EZb24nmIULdr9yLP9Civn9taCi81t9fqbk
   xGerZWls8cOvVRB4+6kRwLo1HsJpZxHG8/qfgPz8cD5014lrU3mshDG7D
   k=;
X-IronPort-AV: E=Sophos;i="6.02,243,1688428800"; 
   d="scan'208";a="357793259"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 09:04:56 +0000
Received: from EX19D008EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id AA6D440DEF;
        Mon, 11 Sep 2023 09:04:54 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D008EUA003.ant.amazon.com (10.252.50.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 09:04:53 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 11 Sep 2023 09:04:52 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
        id 47D4C368A; Mon, 11 Sep 2023 09:04:52 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        <virtualization@lists.linux-foundation.org>
CC:     Maximilian Heyne <mheyne@amazon.de>, <stable@vger.kernel.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] virtio-mmio: fix memory leak of vm_dev
Date:   Mon, 11 Sep 2023 09:03:29 +0000
Message-ID: <20230911090328.40538-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent removal of vm_dev from devres its memory is only freed
via the callback virtio_mmio_release_dev. However, this only takes
effect after device_add is called by register_virtio_device. Until then
it's an unmanaged resource and must be explicitly freed on error exit.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Cc: <stable@vger.kernel.org>
Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
Resending this patch because the previous email wasn't delivered to lore.
Copied the reviewed-bys from 
https://lore.kernel.org/all/ZPn6KZpdPdG2LQqL@arm.com/ and
https://lore.kernel.org/all/1694137778.7008362-1-xuanzhuo@linux.alibaba.com/

 drivers/virtio/virtio_mmio.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 97760f611295..59892a31cf76 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -631,14 +631,17 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	spin_lock_init(&vm_dev->lock);
 
 	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(vm_dev->base))
-		return PTR_ERR(vm_dev->base);
+	if (IS_ERR(vm_dev->base)) {
+		rc = PTR_ERR(vm_dev->base);
+		goto free_vm_dev;
+	}
 
 	/* Check magic value */
 	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 
 	/* Check device version */
@@ -646,7 +649,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	if (vm_dev->version < 1 || vm_dev->version > 2) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto free_vm_dev;
 	}
 
 	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
@@ -655,7 +659,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
 		 * with no function. End probing now with no error reported.
 		 */
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_vm_dev;
 	}
 	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
@@ -685,6 +690,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		put_device(&vm_dev->vdev.dev);
 
 	return rc;
+
+free_vm_dev:
+	kfree(vm_dev);
+	return rc;
 }
 
 static int virtio_mmio_remove(struct platform_device *pdev)
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



