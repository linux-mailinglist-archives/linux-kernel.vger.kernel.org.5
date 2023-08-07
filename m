Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ECB7726F5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjHGOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjHGODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:03:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCA63ABE;
        Mon,  7 Aug 2023 07:02:58 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377E2mg4094662;
        Mon, 7 Aug 2023 09:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691416968;
        bh=AgbQDfGfdzuWvDzkkcxAemP/8XRwP7vbhe7oAQMiZfk=;
        h=From:To:CC:Subject:Date;
        b=uKXIq4ucw8Lh6f3LZJFTPnsxiyzZytCKCwnnavv7NfYWvnBCIQRFJvCNuC/NnZ+7K
         j5EMG7suKLnsofsl77hdF0rhu1KdcBWnlXDlhXqXX4dBtO1jnAqUZX80vimxCp3mic
         AEFZdsp35SAnkHJQX+ic+G/CNHY2SY2+x9eemH/s=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377E2m1X052987
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 09:02:48 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 09:02:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 09:02:48 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377E2mLB130367;
        Mon, 7 Aug 2023 09:02:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Kevin Cahalan <kevinacahalan@gmail.com>
Subject: [PATCH] remoteproc: core: Honor device tree /alias entries when assigning IDs
Date:   Mon, 7 Aug 2023 09:02:47 -0500
Message-ID: <20230807140247.956255-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On many platforms, such as Beaglebone-AI64 with many remote
processors, firmware configurations provided by the distributions can
vary substantially depending on the distribution build's functionality
and the specific remote cores enabled in that variant. Ensuring
consistent udev rules mapping remoteproc nodes to constant remote
proc device indices across distributions (yocto, ubuntu, debian and
it's variants, ...) on a board basis can be challenging due to the
various functions of these distributions. Varied device node paths
create challenges for applications that operate on remote processors,
especially in minimal embedded systems(initrd like) that may not
have udev-like capabilities and rely on a more straightforward bare
filesystem. This challenge is similar to that faced by I2C, RTC or the
GPIO subsystems.

Assign remoteproc device IDs based on device tree /aliases entries if
present, falling back to the existing numbering scheme if there is no
/aliases entry (which includes when the system isn't booted using DT)
or a numbering conflict. If the alias node is not present, the driver
behaves as before.

Cc: Robert Nelson <robertcnelson@gmail.com>
Reported-by: Kevin Cahalan <kevinacahalan@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Test log: Beaglebone-AI64
https://gist.github.com/nmenon/365cf80d6c0685dd9be7c2cb18d7c937 (along
with a test change to force the sequence of initialization)

The report occurred on Beagle discord channel - so I am not
sure how to share the logs of the report.

 drivers/remoteproc/remoteproc_core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 695cce218e8c..a12f3d37b8de 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/device.h>
 #include <linux/panic_notifier.h>
 #include <linux/slab.h>
@@ -2417,6 +2418,25 @@ static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
 	return 0;
 }
 
+static int rproc_device_get_id(struct device *dev)
+{
+	int of_id = -1, id = -1;
+
+	if (dev->of_node)
+		of_id = of_alias_get_id(dev->of_node, "remoteproc");
+
+	if (of_id >= 0) {
+		id = ida_simple_get(&rproc_dev_index, of_id, of_id + 1, GFP_KERNEL);
+		if (id < 0)
+			dev_warn(dev, "/aliases ID %d not available\n", of_id);
+	}
+
+	if (id < 0)
+		id = ida_alloc(&rproc_dev_index, GFP_KERNEL);
+
+	return id;
+}
+
 /**
  * rproc_alloc() - allocate a remote processor handle
  * @dev: the underlying device
@@ -2476,7 +2496,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 		goto put_device;
 
 	/* Assign a unique device index and name */
-	rproc->index = ida_alloc(&rproc_dev_index, GFP_KERNEL);
+	rproc->index = rproc_device_get_id(dev);
 	if (rproc->index < 0) {
 		dev_err(dev, "ida_alloc failed: %d\n", rproc->index);
 		goto put_device;
-- 
2.40.0

