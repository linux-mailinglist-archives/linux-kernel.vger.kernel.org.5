Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6457BBA45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjJFOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjJFOaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:30:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C4D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:30:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CBAC433C8;
        Fri,  6 Oct 2023 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696602654;
        bh=2fhphZG6bxXgGCz3VDXIQ9daJxLkRB/ZDJs2CpCzMAY=;
        h=From:To:Cc:Subject:Date:From;
        b=uPKWiP1SV4F7vTV3NT7BFtFzwcQaeWdCBLCOV7OOb+f4Ej+Zp4DvxjkEFs3IP63q8
         f0++zS91i5/o3Zvq5y54lKvmrWDZyTx3CoD/xMGvhFQgPjNYijut7ku4760DFdtZ51
         VByWkE+Jjp9fUUi5hCdDr/U9OTOHRuW5jKfh2vm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH] vduse: make vduse_class constant
Date:   Fri,  6 Oct 2023 16:30:44 +0200
Message-ID: <2023100643-tricolor-citizen-6c2d@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  137
X-Developer-Signature: v=1; a=openpgp-sha256; l=4498; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=2fhphZG6bxXgGCz3VDXIQ9daJxLkRB/ZDJs2CpCzMAY=; b=owGbwMvMwCRo6H6F97bub03G02pJDKkKUsKfim/9VthzaaV8576syabXTz60elDWo58ssdto1 tWH81bv74hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJ/PvIsGA2Q//D46VTpjgt jDCa/9T47L7VU/MZ5sqvOssbtz3o0NRDOnUHeJXvPpI78AwA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, we should make all 'class' structures declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at runtime.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++--------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index df7869537ef1..0ddd4b8abecb 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -134,7 +134,6 @@ static DEFINE_MUTEX(vduse_lock);
 static DEFINE_IDR(vduse_idr);
 
 static dev_t vduse_major;
-static struct class *vduse_class;
 static struct cdev vduse_ctrl_cdev;
 static struct cdev vduse_cdev;
 static struct workqueue_struct *vduse_irq_wq;
@@ -1528,6 +1527,16 @@ static const struct kobj_type vq_type = {
 	.default_groups	= vq_groups,
 };
 
+static char *vduse_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
+}
+
+static const struct class vduse_class = {
+	.name = "vduse",
+	.devnode = vduse_devnode,
+};
+
 static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
 {
 	int i;
@@ -1638,7 +1647,7 @@ static int vduse_destroy_dev(char *name)
 	mutex_unlock(&dev->lock);
 
 	vduse_dev_reset(dev);
-	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
+	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
 	vduse_dev_deinit_vqs(dev);
@@ -1805,7 +1814,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 
 	dev->minor = ret;
 	dev->msg_timeout = VDUSE_MSG_DEFAULT_TIMEOUT;
-	dev->dev = device_create_with_groups(vduse_class, NULL,
+	dev->dev = device_create_with_groups(&vduse_class, NULL,
 				MKDEV(MAJOR(vduse_major), dev->minor),
 				dev, vduse_dev_groups, "%s", config->name);
 	if (IS_ERR(dev->dev)) {
@@ -1821,7 +1830,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 
 	return 0;
 err_vqs:
-	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
+	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
 err_dev:
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
@@ -1934,11 +1943,6 @@ static const struct file_operations vduse_ctrl_fops = {
 	.llseek		= noop_llseek,
 };
 
-static char *vduse_devnode(const struct device *dev, umode_t *mode)
-{
-	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
-}
-
 struct vduse_mgmt_dev {
 	struct vdpa_mgmt_dev mgmt_dev;
 	struct device dev;
@@ -2082,11 +2086,9 @@ static int vduse_init(void)
 	int ret;
 	struct device *dev;
 
-	vduse_class = class_create("vduse");
-	if (IS_ERR(vduse_class))
-		return PTR_ERR(vduse_class);
-
-	vduse_class->devnode = vduse_devnode;
+	ret = class_register(&vduse_class);
+	if (ret)
+		return ret;
 
 	ret = alloc_chrdev_region(&vduse_major, 0, VDUSE_DEV_MAX, "vduse");
 	if (ret)
@@ -2099,7 +2101,7 @@ static int vduse_init(void)
 	if (ret)
 		goto err_ctrl_cdev;
 
-	dev = device_create(vduse_class, NULL, vduse_major, NULL, "control");
+	dev = device_create(&vduse_class, NULL, vduse_major, NULL, "control");
 	if (IS_ERR(dev)) {
 		ret = PTR_ERR(dev);
 		goto err_device;
@@ -2141,13 +2143,13 @@ static int vduse_init(void)
 err_wq:
 	cdev_del(&vduse_cdev);
 err_cdev:
-	device_destroy(vduse_class, vduse_major);
+	device_destroy(&vduse_class, vduse_major);
 err_device:
 	cdev_del(&vduse_ctrl_cdev);
 err_ctrl_cdev:
 	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
 err_chardev_region:
-	class_destroy(vduse_class);
+	class_unregister(&vduse_class);
 	return ret;
 }
 module_init(vduse_init);
@@ -2159,10 +2161,10 @@ static void vduse_exit(void)
 	destroy_workqueue(vduse_irq_bound_wq);
 	destroy_workqueue(vduse_irq_wq);
 	cdev_del(&vduse_cdev);
-	device_destroy(vduse_class, vduse_major);
+	device_destroy(&vduse_class, vduse_major);
 	cdev_del(&vduse_ctrl_cdev);
 	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
-	class_destroy(vduse_class);
+	class_unregister(&vduse_class);
 }
 module_exit(vduse_exit);
 
-- 
2.42.0

