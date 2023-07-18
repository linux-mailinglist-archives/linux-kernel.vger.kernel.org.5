Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18EB757B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjGRMJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjGRMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E08710FF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689682045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yjWCLI452VH7qr/ipPngolmC3Xdx62iryCFAqOd/N2M=;
        b=U1RtsucHMO36cDora5Z5gQ+6V9vesoZSBZkeHPcWIqokdvyR541P4KOSJQeiSeGT5nvbJN
        84/py9LxUCU3ebTUlgi1VdsQdLmjMaOb/EQqerXbvIqpCcdv1b/2XGz2y6dFsxQmWbtmXA
        2YWxc6NSWr3F2iEOdLZLD6f7fI663yw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-Ldm-cCfpM7i3Ho1AXClnvg-1; Tue, 18 Jul 2023 08:07:23 -0400
X-MC-Unique: Ldm-cCfpM7i3Ho1AXClnvg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56D67380391B;
        Tue, 18 Jul 2023 12:07:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.34.131.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A3E14CD0F5;
        Tue, 18 Jul 2023 12:07:22 +0000 (UTC)
From:   Milan Zamazal <mzamazal@redhat.com>
To:     linux-iio@vger.kernel.org
Cc:     Milan Zamazal <mzamazal@redhat.com>, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] iio: core: Prevent invalid memory access when there is no parent
Date:   Tue, 18 Jul 2023 14:07:00 +0200
Message-Id: <20230718120700.132579-1-mzamazal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 813665564b3d ("iio: core: Convert to use firmware node handle
instead of OF node") switched the kind of nodes to use for label
retrieval in device registration.  Probably an unwanted change in that
commit was that if the device has no parent then NULL pointer is
accessed.  This is what happens in the stock IIO dummy driver when a
new entry is created in configfs:

  # mkdir /sys/kernel/config/iio/devices/dummy/foo
  BUG: kernel NULL pointer dereference, address: 0000000000000278
  ...
  ? asm_exc_page_fault+0x22/0x30
  ? container_offline+0x20/0x20
  __iio_device_register+0x45/0xc10
  ? krealloc+0x73/0xa0
  ? iio_device_attach_buffer+0x31/0xc0
  ? iio_simple_dummy_configure_buffer+0x20/0x20
  ? iio_triggered_buffer_setup_ext+0xb4/0x100
  iio_dummy_probe+0x112/0x190
  iio_sw_device_create+0xa8/0xd0
  device_make_group+0xe/0x40
  configfs_mkdir+0x1a6/0x440

Since there seems to be no reason to make a parent device of an IIO
dummy device mandatory, let’s prevent the invalid memory access in
__iio_device_register when the parent device is NULL.  With this
change, the IIO dummy driver works fine with configfs.

Fixes: 813665564b3d ("iio: core: Convert to use firmware node handle instead of OF node")
Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
---
 drivers/iio/industrialio-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c117f50d0cf3..229527b3434a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1888,7 +1888,7 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct fwnode_handle *fwnode;
+	struct fwnode_handle *fwnode = NULL;
 	int ret;
 
 	if (!indio_dev->info)
@@ -1899,11 +1899,12 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	/* If the calling driver did not initialize firmware node, do it here */
 	if (dev_fwnode(&indio_dev->dev))
 		fwnode = dev_fwnode(&indio_dev->dev);
-	else
+	else if (indio_dev->dev.parent != NULL)
 		fwnode = dev_fwnode(indio_dev->dev.parent);
-	device_set_node(&indio_dev->dev, fwnode);
-
-	fwnode_property_read_string(fwnode, "label", &indio_dev->label);
+	if (fwnode != NULL) {
+		device_set_node(&indio_dev->dev, fwnode);
+		fwnode_property_read_string(fwnode, "label", &indio_dev->label);
+	}
 
 	ret = iio_check_unique_scan_index(indio_dev);
 	if (ret < 0)
-- 
2.40.1

