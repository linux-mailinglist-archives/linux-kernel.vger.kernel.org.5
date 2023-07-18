Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF08A7580FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjGRPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjGRPdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0869198A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689694325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nze9cEhxidO799p4WuWgw+8RBtrm/EbtjYeDGWps2R4=;
        b=hu8OkiaQs5TQi6/UV7xTWxPPNnfUw1Vq05A6b/tsxJf8MwAg6GlCIzAapRyE6OwGvgmg9w
        8HjFAu5eu6pinnyIdYAnOqlgovhXVEyb2Nw6RuqVdaQmirJIembGx2MpGrXHRJHEbMJbze
        XmhUXl68y4JrYOEDO2tPDtEUszHNURI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-PHzj08aHPEWzaEUacDIGdw-1; Tue, 18 Jul 2023 11:32:01 -0400
X-MC-Unique: PHzj08aHPEWzaEUacDIGdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB7DE8DC6F6;
        Tue, 18 Jul 2023 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.34.131.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1E7640C206F;
        Tue, 18 Jul 2023 15:30:05 +0000 (UTC)
From:   Milan Zamazal <mzamazal@redhat.com>
To:     linux-iio@vger.kernel.org
Cc:     Milan Zamazal <mzamazal@redhat.com>, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Subject: [PATCH v2] iio: core: Prevent invalid memory access when there is no parent
Date:   Tue, 18 Jul 2023 17:29:17 +0200
Message-Id: <20230718152917.435962-1-mzamazal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
  BUG: kernel NULL pointer dereference, address: ...
  ...
  Call Trace:
  ...
  asm_exc_page_fault
  container_offline
  __iio_device_register
  krealloc
  iio_device_attach_buffer
  iio_simple_dummy_configure_buffer
  iio_triggered_buffer_setup_ext
  iio_dummy_probe
  iio_sw_device_create
  device_make_group
  configfs_mkdir

Since there seems to be no reason to make a parent device of an IIO
dummy device mandatory, let’s prevent the invalid memory access in
__iio_device_register when the parent device is NULL.  With this
change, the IIO dummy driver works fine with configfs.

Fixes: 813665564b3d ("iio: core: Convert to use firmware node handle instead of OF node")
Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
---
Changes in v2:
 - Added a source comment about the dummy IIO device.
 - Adjusted the backtrace cited in the commit message a bit.
 - Replaced `... != NULL' condition with `...'.
 - Dropped the unnecessary `fwnode != NULL' check (the involved calls
   do the right thing when the argument is NULL).
---
 drivers/iio/industrialio-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c117f50d0cf3..adcba832e6fa 100644
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
@@ -1899,7 +1899,8 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	/* If the calling driver did not initialize firmware node, do it here */
 	if (dev_fwnode(&indio_dev->dev))
 		fwnode = dev_fwnode(&indio_dev->dev);
-	else
+	/* The default dummy IIO device has no parent */
+	else if (indio_dev->dev.parent)
 		fwnode = dev_fwnode(indio_dev->dev.parent);
 	device_set_node(&indio_dev->dev, fwnode);
 
-- 
2.40.1

