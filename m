Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2652B7B33B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjI2Ndo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjI2Ndj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:33:39 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404E1B6;
        Fri, 29 Sep 2023 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695994416; x=1727530416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mkE5g6d4vsWIIAfJc7WURGplVW7QHWWFOxb2jmbnKZM=;
  b=bKq5bes3R/Bm8XM7o436g78R0rG2oSDSEkWiW8F2geKJTXYzNFtZaztg
   RBTLcKy8ucLQ7xU1ghZmbaX4zNhcIzU4ck0WZ0BnCB4DI6dKh73SoN/Aa
   CGoPsD/t6Cwwz0KoMkJ49kK65wd9f/PdKaHsajW2Ianab6V3IUBq9kizE
   s=;
X-IronPort-AV: E=Sophos;i="6.03,187,1694736000"; 
   d="scan'208";a="675347594"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:33:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 6A92080697;
        Fri, 29 Sep 2023 13:33:27 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 13:33:27 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 13:33:24 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-crypto@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v2 1/2] misc: Add Nitro Secure Module driver
Date:   Fri, 29 Sep 2023 13:33:19 +0000
Message-ID: <20230929133320.74848-2-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929133320.74848-1-graf@amazon.com>
References: <20230929133320.74848-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running Linux inside a Nitro Enclave, the hypervisor provides a
special virtio device called "NSM". This device has 2 main functions:

  1) Provide attestation reports
  2) Modify PCR state
  3) Provide entropy

This patch adds the core NSM driver that exposes a /dev/nsm device node
which user space can use to request attestation documents and influence
PCR states. A follow up patch will add a hwrng driver to feed its entropy
into the kernel.

Originally-by: Petre Eftime <petre.eftime@gmail.com>
Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Remove boilerplate
  - Add uapi header
---
 MAINTAINERS              |  10 +
 drivers/misc/Kconfig     |  11 +
 drivers/misc/Makefile    |   1 +
 drivers/misc/nsm.c       | 448 +++++++++++++++++++++++++++++++++++++++
 include/linux/nsm.h      |  35 +++
 include/uapi/linux/nsm.h |  24 +++
 6 files changed, 529 insertions(+)
 create mode 100644 drivers/misc/nsm.c
 create mode 100644 include/linux/nsm.h
 create mode 100644 include/uapi/linux/nsm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b19995690904..d54bf3ea2b9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15098,6 +15098,16 @@ F:	include/linux/nitro_enclaves.h
 F:	include/uapi/linux/nitro_enclaves.h
 F:	samples/nitro_enclaves/
 
+NITRO SECURE MODULE (NSM)
+M:	Alexander Graf <graf@amazon.com>
+L:	linux-kernel@vger.kernel.org
+L:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
+S:	Supported
+W:	https://aws.amazon.com/ec2/nitro/nitro-enclaves/
+F:	drivers/misc/nsm.c
+F:	include/linux/nsm.h
+F:	include/uapi/linux/nsm.h
+
 NOHZ, DYNTICKS SUPPORT
 M:	Frederic Weisbecker <frederic@kernel.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index cadd4a820c03..7b1ed309d469 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -562,6 +562,17 @@ config TPS6594_PFSM
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps6594-pfsm.
 
+config NSM
+	tristate "Nitro (Enclaves) Security Module support"
+	depends on VIRTIO
+	help
+	  This driver provides support for the Nitro Security Module
+	  in AWS EC2 Nitro based Enclaves. The driver exposes a /dev/nsm
+	  device user space can use to communicate with the hypervisor.
+
+	  To compile this driver as a module, choose M here.
+	  The module will be called nsm.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f2a4d1ff65d4..ea6ea5bbbc9c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
 obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
+obj-$(CONFIG_NSM)		+= nsm.o
diff --git a/drivers/misc/nsm.c b/drivers/misc/nsm.c
new file mode 100644
index 000000000000..69bd98473b54
--- /dev/null
+++ b/drivers/misc/nsm.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Amazon Nitro Secure Module driver.
+ *
+ * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <linux/nsm.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ids.h>
+#include <linux/wait.h>
+#include <uapi/linux/nsm.h>
+
+#define NSM_DEV_NAME          "nsm"
+#define NSM_REQUEST_MAX_SIZE  0x1000
+#define NSM_RESPONSE_MAX_SIZE 0x3000
+
+/* Timeout for NSM virtqueue respose in milliseconds. */
+#define NSM_DEFAULT_TIMEOUT_MSECS (120000) /* 2 minutes */
+
+/* The name of the NSM device virtqueue */
+const char *NSM_VQ_NAME = "nsm.vq.0";
+
+/* NSM device ID */
+static const struct virtio_device_id nsm_id_table[] = {
+	{ VIRTIO_ID_NITRO_SEC_MOD, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+/* Virtio MMIO device definition */
+struct virtio_mmio_device {
+	struct virtio_device vdev;
+	struct platform_device *pdev;
+
+	void __iomem *base;
+	unsigned long version;
+
+	/* a list of queues so we can dispatch IRQs */
+	spinlock_t lock;
+	struct list_head virtqueues;
+};
+
+/* Virtqueue list entry */
+struct virtio_mmio_vq_info {
+	/* The actual virtqueue */
+	struct virtqueue *vq;
+
+	/* The list node for the virtqueues list */
+	struct list_head node;
+};
+
+static struct virtio_device *nsm_vdev;
+static struct nsm_hwrng *nsm_hwrng;
+static struct mutex nsm_lock;
+static wait_queue_head_t nsm_waitqueue;
+static bool nsm_device_notified;
+
+/* Get the virtqueue */
+static struct virtqueue *nsm_get_vq(struct virtio_device *vdev)
+{
+	struct virtio_mmio_device *vm_dev =
+		container_of(vdev, struct virtio_mmio_device, vdev);
+	struct virtio_mmio_vq_info *info;
+
+	list_for_each_entry(info, &vm_dev->virtqueues, node)
+		return info->vq;
+
+	return NULL;
+}
+
+/* Copy an entire message from user-space to kernel-space */
+static int message_memdup_from_user(struct nsm_kernel_message *dst,
+	struct nsm_message *src)
+{
+	struct nsm_message shallow_copy;
+
+	if (!src || !dst)
+		return -EINVAL;
+
+	/* The destination's request and response buffers should be NULL. */
+	if (dst->request.iov_base || dst->response.iov_base)
+		return -EINVAL;
+
+	/* First, make a shallow copy to be able to read the inner pointers */
+	if (copy_from_user(&shallow_copy, src, sizeof(shallow_copy)) != 0)
+		return -EINVAL;
+
+	/* Verify the user input size. */
+	if (shallow_copy.request.iov_len > NSM_REQUEST_MAX_SIZE)
+		return -EMSGSIZE;
+
+	/* Allocate kernel memory for the user request */
+	dst->request.iov_len = shallow_copy.request.iov_len;
+	dst->request.iov_base = kmalloc(dst->request.iov_len, GFP_KERNEL);
+	if (!dst->request.iov_base)
+		return -ENOMEM;
+
+	/* Copy the request content */
+	if (copy_from_user(dst->request.iov_base,
+		shallow_copy.request.iov_base, dst->request.iov_len) != 0) {
+		kfree(dst->request.iov_base);
+		return -EFAULT;
+	}
+
+	/* Allocate kernel memory for the response, up to a fixed limit */
+	dst->response.iov_len = shallow_copy.response.iov_len;
+	if (dst->response.iov_len > NSM_RESPONSE_MAX_SIZE)
+		dst->response.iov_len = NSM_RESPONSE_MAX_SIZE;
+
+	dst->response.iov_base = kmalloc(dst->response.iov_len, GFP_KERNEL);
+	if (!dst->response.iov_base) {
+		kfree(dst->request.iov_base);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/* Copy a message back to user-space */
+static int message_copy_to_user(struct nsm_message *user_msg,
+	struct nsm_kernel_message *kern_msg)
+{
+	struct nsm_message shallow_copy;
+
+	if (!kern_msg || !user_msg)
+		return -EINVAL;
+
+	/*
+	 * First, do a shallow copy of the user-space message. This is needed in
+	 * order to get the request block data, which we do not need to copy but
+	 * must preserve in the message sent back to user-space.
+	 */
+	if (copy_from_user(&shallow_copy, user_msg, sizeof(shallow_copy)) != 0)
+		return -EINVAL;
+
+	/* Do not exceed the capacity of the user-provided response buffer */
+	shallow_copy.response.iov_len = kern_msg->response.iov_len;
+
+	/* Only the response content must be copied back to user-space */
+	if (copy_to_user(shallow_copy.response.iov_base,
+		kern_msg->response.iov_base,
+		shallow_copy.response.iov_len) != 0)
+		return -EINVAL;
+
+	if (copy_to_user(user_msg, &shallow_copy, sizeof(shallow_copy)) != 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+/* Virtqueue interrupt handler */
+static void nsm_vq_callback(struct virtqueue *vq)
+{
+	nsm_device_notified = true;
+	wake_up(&nsm_waitqueue);
+}
+
+/* Forward a message to the NSM device and wait for the response from it */
+int nsm_communicate_with_device(struct virtio_device *vdev,
+				struct nsm_kernel_message *message)
+{
+	struct virtqueue *vq = NULL;
+	struct scatterlist sg_in, sg_out;
+	unsigned int len;
+	void *queue_buf;
+	bool kicked;
+	int rc;
+
+	if (!vdev)
+		return -EINVAL;
+
+	if (!message)
+		return -EINVAL;
+
+	vq = nsm_get_vq(vdev);
+	if (!vq)
+		return -ENXIO;
+
+	/* Verify if buffer memory is valid. */
+	if (!virt_addr_valid(message->request.iov_base) ||
+		!virt_addr_valid(((u8 *)message->request.iov_base) +
+			message->request.iov_len - 1) ||
+		!virt_addr_valid(message->response.iov_base) ||
+		!virt_addr_valid(((u8 *)message->response.iov_base) +
+			message->response.iov_len - 1))
+		return -EINVAL;
+
+	/* Initialize scatter-gather lists with request and response buffers. */
+	sg_init_one(&sg_out, message->request.iov_base,
+		message->request.iov_len);
+	sg_init_one(&sg_in, message->response.iov_base,
+		message->response.iov_len);
+
+	mutex_lock(&nsm_lock);
+
+	/* Add the request buffer (read by the device). */
+	rc = virtqueue_add_outbuf(vq, &sg_out, 1, message->request.iov_base,
+		GFP_KERNEL);
+	if (rc) {
+		mutex_unlock(&nsm_lock);
+		return rc;
+	}
+
+	/* Add the response buffer (written by the device). */
+	rc = virtqueue_add_inbuf(vq, &sg_in, 1, message->response.iov_base,
+		GFP_KERNEL);
+	if (rc)
+		goto cleanup;
+
+	nsm_device_notified = false;
+	kicked = virtqueue_kick(vq);
+	if (!kicked) {
+		/* Cannot kick the virtqueue. */
+		rc = -EIO;
+		goto cleanup;
+	}
+
+	/* If the kick succeeded, wait for the device's response. */
+	rc = wait_event_timeout(nsm_waitqueue,
+		nsm_device_notified == true,
+		msecs_to_jiffies(NSM_DEFAULT_TIMEOUT_MSECS));
+	if (!rc) {
+		rc = -ETIMEDOUT;
+		goto cleanup;
+	}
+
+	queue_buf = virtqueue_get_buf(vq, &len);
+	if (!queue_buf || (queue_buf != message->request.iov_base)) {
+		pr_err("NSM device received wrong request buffer.");
+		rc = -ENODATA;
+		goto cleanup;
+	}
+
+	queue_buf = virtqueue_get_buf(vq, &len);
+	if (!queue_buf || (queue_buf != message->response.iov_base)) {
+		pr_err("NSM device received wrong response buffer.");
+		rc = -ENODATA;
+		goto cleanup;
+	}
+
+	/* Make sure the response length doesn't exceed the buffer capacity. */
+	if (len < message->response.iov_len)
+		message->response.iov_len = len;
+
+	rc = 0;
+
+cleanup:
+	if (rc) {
+		/* Clean the virtqueue. */
+		while (virtqueue_get_buf(vq, &len) != NULL)
+			;
+	}
+
+	mutex_unlock(&nsm_lock);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(nsm_communicate_with_device);
+
+static long nsm_dev_ioctl(struct file *file, unsigned int cmd,
+	unsigned long arg)
+{
+	struct nsm_kernel_message message;
+	int status = 0;
+
+	if (cmd != NSM_IOCTL_REQUEST)
+		return -EINVAL;
+
+	/* The kernel message structure must be cleared */
+	memset(&message, 0, sizeof(message));
+
+	/* Copy the message from user-space to kernel-space */
+	status = message_memdup_from_user(&message, (struct nsm_message *)arg);
+	if (status != 0)
+		return status;
+
+	/* Communicate with the NSM device */
+	status = nsm_communicate_with_device(nsm_vdev, &message);
+
+	if (status != 0)
+		goto out;
+
+	/* Copy the response back to user-space */
+	status = message_copy_to_user((struct nsm_message *)arg, &message);
+
+out:
+	/* At this point, everything succeeded, so clean up and finish. */
+	kfree(message.request.iov_base);
+	kfree(message.response.iov_base);
+
+	return status;
+}
+
+static int nsm_dev_file_open(struct inode *node, struct file *file)
+{
+	pr_debug("NSM device file opened.\n");
+	return 0;
+}
+
+static int nsm_dev_file_close(struct inode *inode, struct file *file)
+{
+	pr_debug("NSM device file closed.\n");
+	return 0;
+}
+
+/* Supported driver operations */
+static const struct file_operations nsm_dev_fops = {
+	.open = nsm_dev_file_open,
+	.release = nsm_dev_file_close,
+	.unlocked_ioctl = nsm_dev_ioctl,
+};
+
+/* Driver configuration */
+static struct miscdevice nsm_driver_miscdevice = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= NSM_DEV_NAME,
+	.fops	= &nsm_dev_fops,
+	.mode	= 0666
+};
+
+static int nsm_device_init_vq(struct virtio_device *vdev)
+{
+	struct virtqueue *vq = virtio_find_single_vq(vdev,
+		nsm_vq_callback, NSM_VQ_NAME);
+	if (IS_ERR(vq))
+		return PTR_ERR(vq);
+
+	return 0;
+}
+
+/* Handler for probing the NSM device */
+static int nsm_device_probe(struct virtio_device *vdev)
+{
+	int rc;
+
+	if (nsm_vdev)
+		return -EEXIST;
+
+	nsm_vdev = vdev;
+
+	rc = nsm_device_init_vq(vdev);
+	if (rc) {
+		pr_err("NSM device queue failed to initialize: %d.\n", rc);
+		return rc;
+	}
+
+	rc = misc_register(&nsm_driver_miscdevice);
+	if (rc) {
+		pr_err("NSM misc device registration error: %d.\n", rc);
+		vdev->config->del_vqs(vdev);
+		return rc;
+	}
+
+	if (nsm_hwrng)
+		nsm_hwrng->probe(vdev);
+
+	pr_debug("NSM device has been probed.\n");
+	return 0;
+}
+
+/* Handler for removing the NSM device */
+static void nsm_device_remove(struct virtio_device *vdev)
+{
+	if (vdev != nsm_vdev)
+		return;
+
+	if (nsm_hwrng)
+		nsm_hwrng->remove(vdev);
+
+	vdev->config->del_vqs(vdev);
+	misc_deregister(&nsm_driver_miscdevice);
+	nsm_vdev = NULL;
+	pr_debug("NSM device has been removed.\n");
+}
+
+int nsm_register_hwrng(struct nsm_hwrng *_nsm_hwrng)
+{
+	if (nsm_hwrng)
+		return -EEXIST;
+
+	nsm_hwrng = _nsm_hwrng;
+	if (nsm_vdev)
+		nsm_hwrng->probe(nsm_vdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nsm_register_hwrng);
+
+void nsm_unregister_hwrng(struct nsm_hwrng *_nsm_hwrng)
+{
+	if (_nsm_hwrng != nsm_hwrng)
+		return;
+
+	if (nsm_vdev)
+		nsm_hwrng->remove(nsm_vdev);
+	nsm_hwrng = NULL;
+}
+EXPORT_SYMBOL_GPL(nsm_unregister_hwrng);
+
+/* NSM device configuration structure */
+static struct virtio_driver virtio_nsm_driver = {
+	.feature_table             = 0,
+	.feature_table_size        = 0,
+	.feature_table_legacy      = 0,
+	.feature_table_size_legacy = 0,
+	.driver.name               = KBUILD_MODNAME,
+	.driver.owner              = THIS_MODULE,
+	.id_table                  = nsm_id_table,
+	.probe                     = nsm_device_probe,
+	.remove                    = nsm_device_remove,
+};
+
+static int __init nsm_driver_init(void)
+{
+	int rc;
+
+	mutex_init(&nsm_lock);
+	init_waitqueue_head(&nsm_waitqueue);
+
+	rc = register_virtio_driver(&virtio_nsm_driver);
+	if (rc)
+		pr_err("NSM driver initialization error: %d.\n", rc);
+
+	return rc;
+}
+
+static void __exit nsm_driver_exit(void)
+{
+	unregister_virtio_driver(&virtio_nsm_driver);
+	mutex_destroy(&nsm_lock);
+	pr_debug("NSM driver exited.\n");
+}
+
+module_init(nsm_driver_init);
+module_exit(nsm_driver_exit);
+
+MODULE_DEVICE_TABLE(virtio, nsm_id_table);
+MODULE_DESCRIPTION("Virtio NSM driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/nsm.h b/include/linux/nsm.h
new file mode 100644
index 000000000000..82753de5485e
--- /dev/null
+++ b/include/linux/nsm.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Amazon Nitro Secure Module driver.
+ *
+ * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#ifndef __LINUX_NSM_H
+#define __LINUX_NSM_H
+
+#include <linux/uio.h>
+#include <linux/virtio.h>
+
+#define NSM_RESPONSE_MAX_SIZE 0x3000
+
+struct nsm_hwrng {
+	int (*probe)(struct virtio_device *dev);
+	void (*remove)(struct virtio_device *dev);
+};
+
+int nsm_register_hwrng(struct nsm_hwrng *nsm_hwrng);
+void nsm_unregister_hwrng(struct nsm_hwrng *nsm_hwrng);
+
+/* Copy of NSM message in kernel-space */
+struct nsm_kernel_message {
+	/* Copy of user request in kernel memory */
+	struct kvec request;
+	/* Copy of user response in kernel memory */
+	struct kvec response;
+};
+
+int nsm_communicate_with_device(struct virtio_device *dev,
+				struct nsm_kernel_message *message);
+
+#endif /* __LINUX_NSM_H */
diff --git a/include/uapi/linux/nsm.h b/include/uapi/linux/nsm.h
new file mode 100644
index 000000000000..794791631ffb
--- /dev/null
+++ b/include/uapi/linux/nsm.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#ifndef __UAPI_LINUX_NSM_H
+#define __UAPI_LINUX_NSM_H
+
+#include <linux/uio.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* NSM message from user-space */
+struct nsm_message {
+	/* Request from user */
+	struct iovec request;
+	/* Response to user */
+	struct iovec response;
+};
+
+#define NSM_MAGIC		0x0A
+#define NSM_IOCTL_REQUEST	_IOWR(NSM_MAGIC, 0, struct nsm_message)
+
+#endif /* __UAPI_LINUX_MISC_BCM_VK_H */
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



