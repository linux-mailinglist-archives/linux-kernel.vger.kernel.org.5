Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1999F7BA084
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbjJEOjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjJEOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:36:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF52336A9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:59:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F81C43140;
        Thu,  5 Oct 2023 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696514323;
        bh=DBqd7AkU7DoctJZB0I+61/B9KY1iQe4pE42vmDX0AyY=;
        h=From:To:Cc:Subject:Date:From;
        b=ptJJPyqoL9jyG92VOx03xz1lMgofmxd2qO7NZ8CcbYm5yNHCMf8nWXbX/MjZZ1/p0
         7dYNC3pAj83a8hqUQHTLGOLoB+ip6enJbnbZM79ZLo1YtvXMZm2jG5NBCQ1qJfejBe
         F7TPvYBuxM+c6NXSTgjSJ1oJnleIeZ4gWTTe+nTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>
Subject: [PATCH 1/3] staging: greybus: raw: make raw_class constant
Date:   Thu,  5 Oct 2023 15:58:34 +0200
Message-ID: <2023100533-broadband-hunk-9e91@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  81
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=DBqd7AkU7DoctJZB0I+61/B9KY1iQe4pE42vmDX0AyY=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlyBzlZa/er/6s6eWmpSMDJU2W7Z85/pXy59zTHbqslV bfNsqU9O2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiNswM87Ofh/TaBruIr7LQ 6cre27FAw1iyimF+Wvd11YCnUT+1bhxWe2Ouuybf7cl+AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, making all 'class' structures to be declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/greybus/raw.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
index 8bca8cb12cc6..a00978c8e1d2 100644
--- a/drivers/staging/greybus/raw.c
+++ b/drivers/staging/greybus/raw.c
@@ -32,7 +32,10 @@ struct raw_data {
 	u8 data[];
 };
 
-static struct class *raw_class;
+static const struct class raw_class = {
+	.name = "gb_raw",
+};
+
 static int raw_major;
 static const struct file_operations raw_fops;
 static DEFINE_IDA(minors);
@@ -195,7 +198,7 @@ static int gb_raw_probe(struct gb_bundle *bundle,
 	if (retval)
 		goto error_connection_disable;
 
-	raw->device = device_create(raw_class, &connection->bundle->dev,
+	raw->device = device_create(&raw_class, &connection->bundle->dev,
 				    raw->dev, raw, "gb!raw%d", minor);
 	if (IS_ERR(raw->device)) {
 		retval = PTR_ERR(raw->device);
@@ -229,7 +232,7 @@ static void gb_raw_disconnect(struct gb_bundle *bundle)
 	struct raw_data *temp;
 
 	// FIXME - handle removing a connection when the char device node is open.
-	device_destroy(raw_class, raw->dev);
+	device_destroy(&raw_class, raw->dev);
 	cdev_del(&raw->cdev);
 	gb_connection_disable(connection);
 	ida_simple_remove(&minors, MINOR(raw->dev));
@@ -340,11 +343,9 @@ static int raw_init(void)
 	dev_t dev;
 	int retval;
 
-	raw_class = class_create("gb_raw");
-	if (IS_ERR(raw_class)) {
-		retval = PTR_ERR(raw_class);
+	retval = class_register(&raw_class);
+	if (retval)
 		goto error_class;
-	}
 
 	retval = alloc_chrdev_region(&dev, 0, NUM_MINORS, "gb_raw");
 	if (retval < 0)
@@ -361,7 +362,7 @@ static int raw_init(void)
 error_gb:
 	unregister_chrdev_region(dev, NUM_MINORS);
 error_chrdev:
-	class_destroy(raw_class);
+	class_unregister(&raw_class);
 error_class:
 	return retval;
 }
@@ -371,7 +372,7 @@ static void __exit raw_exit(void)
 {
 	greybus_deregister(&gb_raw_driver);
 	unregister_chrdev_region(MKDEV(raw_major, 0), NUM_MINORS);
-	class_destroy(raw_class);
+	class_unregister(&raw_class);
 	ida_destroy(&minors);
 }
 module_exit(raw_exit);
-- 
2.42.0

