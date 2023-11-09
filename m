Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA007E63FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjKIGjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjKIGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:39:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7CE25AC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 22:39:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D514C433C7;
        Thu,  9 Nov 2023 06:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699511978;
        bh=sO4WnXpvLMBqMDcdpNBtm7DrjRg70ylnfrCOBHdFMPU=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=YNgQeue5L2dxAq/ruPGePGFD68wl1x2evzBZW6mdgnAkMyU1Ej7QH3m7vSEXI43DU
         +84cJ5/N/otN0c+fHpanI7Oz44v5+na404cvjgFrmqlfPxc9LjRgCm+iyK2I5rcL58
         torq/fTg92c/e1AA97Q4uJsXhG3EmF3zf5tXipSd52MuDoyyjxL1XuaTMEg2RG32XV
         zbYLT7dX+EiNlA/U/n5oAzaWFEo17Z0YZFowmWG3wI4uP8tJpzQerr6x7/96ueMEOI
         xea2VOZxdLQ/AuWUTXe/L/29P2d8rMhn6R9b0Ux/35ReM6ADtA9ZRAIX/LrFWE7c1X
         U8jmAgYGF/BFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id E78B9C4332F;
        Thu,  9 Nov 2023 06:39:37 +0000 (UTC)
From:   zhengjia zhu via B4 Relay 
        <devnull+quic_zhezhu.quicinc.com@kernel.org>
Date:   Thu, 09 Nov 2023 14:39:32 +0800
Subject: [PATCH] msm: misc: enable QRC support on msm-5.4 on RB3-Gen2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-qrc-v1-1-8f0c538fc74d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKV+TGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwNL3cKiZN1Uk+TEJDOjNIM081QloMqCotS0zAqwKdGxtbUAJaYw4lU
 AAAA=
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        zhengjia zhu <quic_zhezhu@quicinc.com>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699511976; l=22249;
 i=quic_zhezhu@quicinc.com; s=20231109; h=from:subject:message-id;
 bh=6Vwb98S/ak/tBt6ZhyvPI4npcPWUZ3o7O96CUl2/mis=;
 b=D/pdDrFRtGWJtpo930OZiphndtNhIofuJkBU2vS2w9iZFwhNzS/OkVN/l3wK//QxNRi4CMJnu
 IIv8WW8Yq6jB69gxoUQXtEz8mAiAMvIeeB4MidNeT11t1bmQnklPzEw
X-Developer-Key: i=quic_zhezhu@quicinc.com; a=ed25519;
 pk=30RJrtt2ekzgIThVcPNGRHjXU50RSnFVkcKEqWnKM9Y=
X-Endpoint-Received: by B4 Relay for quic_zhezhu@quicinc.com/20231109 with auth_id=98
X-Original-From: zhengjia zhu <quic_zhezhu@quicinc.com>
Reply-To: <quic_zhezhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengjia zhu <quic_zhezhu@quicinc.com>

QRC Driver support functions:
- Read data from serial device port.
- Write data to serial device port.
- Pin control reset robotic controller.

Signed-off-by: zhengjia zhu <quic_zhezhu@quicinc.com>
---
 drivers/misc/qrc/Kconfig    |  25 ++++
 drivers/misc/qrc/Makefile   |   9 ++
 drivers/misc/qrc/qrc_core.c | 312 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/qrc/qrc_core.h | 142 ++++++++++++++++++
 drivers/misc/qrc/qrc_uart.c | 352 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 840 insertions(+)

diff --git a/drivers/misc/qrc/Kconfig b/drivers/misc/qrc/Kconfig
new file mode 100644
index 000000000000..59f734c02092
--- /dev/null
+++ b/drivers/misc/qrc/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# QRC device driver configuration
+#
+
+menu "qrc device driver"
+
+config QRC
+	bool "QRC device driver for Robotic SDK MCU"
+	help
+	   This kernel configuration is used to enable robotic controller
+	   device driver. Say Y here if you want to enable robotic
+	   controller device driver.
+	   When in doubt, say N.
+
+config QRC_DEBUG
+	bool "QRC Debugging"
+	depends on QRC
+	help
+	  Say Y here if you want the robotic controller to produce
+	  a bunch of debug messages to the system log. Select this if you
+	  are having a problem with robotic controller support and want
+	  to see more of what is going on.
+	  When in doubt, say N.
+endmenu
diff --git a/drivers/misc/qrc/Makefile b/drivers/misc/qrc/Makefile
new file mode 100644
index 000000000000..d811992aa0d9
--- /dev/null
+++ b/drivers/misc/qrc/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the QRC bus specific drivers.
+
+
+obj-$(CONFIG_QRC)		+=  qrc_core.o qrc_uart.o
+
+
+#ccflags-$(CONFIG_QRC_DEBUG) := -DDEBUG
diff --git a/drivers/misc/qrc/qrc_core.c b/drivers/misc/qrc/qrc_core.c
new file mode 100644
index 000000000000..9d03f35e9683
--- /dev/null
+++ b/drivers/misc/qrc/qrc_core.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* driver/misc/qrc/qrc_core.c
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/cdev.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+
+#include "qrc_core.h"
+
+#define FIFO_CLEAR 0x1
+
+#define QRC_DEVICE_NAME "qrc"
+
+static dev_t qrc_devt;
+static struct class *qrc_class;
+
+static int qrc_cdev_fasync(int fd, struct file *filp, int mode)
+{
+	struct qrc_dev *qrc;
+
+	qrc = filp->private_data;
+	return fasync_helper(fd, filp, mode, &qrc->async_queue);
+}
+
+static int qrc_cdev_open(struct inode *inode, struct file *filp)
+{
+	struct qrc_dev *qrc;
+
+	qrc = container_of(inode->i_cdev,
+						struct qrc_dev, cdev);
+	filp->private_data = qrc;
+	if (qrc->qrc_ops != NULL)
+		qrc->qrc_ops->qrcops_open(qrc);
+	return 0;
+}
+
+static int qrc_cdev_release(struct inode *inode, struct file *filp)
+{
+	struct qrc_dev *qrc;
+
+	qrc = filp->private_data;
+	if (qrc->qrc_ops != NULL)
+		qrc->qrc_ops->qrcops_close(qrc);
+
+	return 0;
+}
+
+/* GPIO control  */
+static int
+qrc_control_gpio_init(struct qrc_dev *qdev, struct device_node *node)
+{
+	int ret;
+
+	/* QRC BOOT0 GPIO */
+	qdev->qrc_boot0_gpio = of_get_named_gpio(node,
+	"qcom,qrc-boot-gpio", 0);
+	if (qdev->qrc_boot0_gpio < 0)
+		pr_err("qrc_boot0_gpio is not available\n");
+
+	/* UART RESET GPIO */
+	qdev->qrc_reset_gpio = of_get_named_gpio(node,
+	"qcom,qrc-reset-gpio", 0);
+	if (qdev->qrc_reset_gpio < 0)
+		pr_err("qrc_reset_gpio is not available\n");
+
+	if (gpio_is_valid(qdev->qrc_boot0_gpio)) {
+		ret = gpio_request(qdev->qrc_boot0_gpio, "QRC_BOOT0_GPIO");
+		if (unlikely(ret)) {
+			pr_err("gpio request qrc_boot0_gpio failed for:%d\n",
+					qdev->qrc_boot0_gpio);
+			return ret;
+		}
+	}
+
+	if (gpio_is_valid(qdev->qrc_reset_gpio)) {
+		ret = gpio_request(qdev->qrc_reset_gpio, "QRC_RESET_GPIO");
+		if (unlikely(ret)) {
+			pr_err("gpio request qrc_reset_gpio failed for:%d\n",
+			qdev->qrc_reset_gpio);
+			return ret;
+		}
+	}
+
+	ret = gpio_direction_output(qdev->qrc_reset_gpio, 0);
+	ret += gpio_export(qdev->qrc_reset_gpio, 0);
+
+	if (ret) {
+		pr_err("Unable to configure GPIO%d (RESET)\n",
+			qdev->qrc_reset_gpio);
+		ret = -EBUSY;
+		gpio_free(qdev->qrc_reset_gpio);
+		return ret;
+	}
+
+	ret = gpio_direction_output(qdev->qrc_boot0_gpio, 1);
+	ret += gpio_export(qdev->qrc_boot0_gpio, 0);
+	if (ret) {
+		pr_err("Unable to configure GPIO%d (BOOT0)\n",
+			qdev->qrc_boot0_gpio);
+		ret = -EBUSY;
+		gpio_free(qdev->qrc_boot0_gpio);
+		return ret;
+	}
+	/* default config gpio status.boot=1,reset=0 */
+	gpio_set_value(qdev->qrc_boot0_gpio, 1);
+	gpio_set_value(qdev->qrc_reset_gpio, 0);
+
+	return 0;
+}
+
+static void
+qrc_control_gpio_uninit(struct qrc_dev *qdev)
+{
+	gpio_free(qdev->qrc_boot0_gpio);
+	gpio_free(qdev->qrc_reset_gpio);
+}
+
+static void qrc_gpio_reboot(struct qrc_dev *qdev)
+{
+	gpio_set_value(qdev->qrc_reset_gpio, 1);
+	msleep(100);
+	gpio_set_value(qdev->qrc_reset_gpio, 0);
+}
+static long qrc_cdev_ioctl(struct file *filp, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct qrc_dev *qdev;
+
+	qdev = filp->private_data;
+	switch (cmd) {
+	case QRC_FIFO_CLEAR:
+		mutex_lock(&qdev->mutex);
+		qdev->qrc_ops->qrcops_data_clean(qdev);
+		mutex_unlock(&qdev->mutex);
+		return 0;
+	case QRC_REBOOT:
+		if (gpio_is_valid(qdev->qrc_reset_gpio)) {
+			qrc_gpio_reboot(qdev);
+			return 0;
+		} else
+			return -EFAULT;
+	case QRC_BOOT_TO_MEM:
+		if (gpio_is_valid(qdev->qrc_boot0_gpio)) {
+			gpio_set_value(qdev->qrc_boot0_gpio, 1);
+			qrc_gpio_reboot(qdev);
+			return 0;
+		} else
+			return -EFAULT;
+	case QRC_BOOT_TO_FLASH:
+		if (gpio_is_valid(qdev->qrc_boot0_gpio)) {
+			gpio_set_value(qdev->qrc_boot0_gpio, 0);
+			qrc_gpio_reboot(qdev);
+			return 0;
+		} else
+			return -EFAULT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static unsigned int qrc_cdev_poll(struct file *filp, poll_table *wait)
+{
+	unsigned int mask = 0;
+	struct qrc_dev *qrc;
+
+	qrc = filp->private_data;
+	mutex_lock(&qrc->mutex);
+
+	poll_wait(filp, &qrc->r_wait, wait);
+
+	if (qrc->qrc_ops->qrcops_data_status(qrc) != 0)
+		mask |= POLLIN | POLLRDNORM;
+
+	mutex_unlock(&qrc->mutex);
+	return mask;
+}
+
+static ssize_t qrc_cdev_read(struct file *filp, char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	int ret;
+	struct qrc_dev *qrc;
+	DECLARE_WAITQUEUE(wait, current);
+
+	qrc = filp->private_data;
+
+	mutex_lock(&qrc->mutex);
+	add_wait_queue(&qrc->r_wait, &wait);
+
+	while (qrc->qrc_ops->qrcops_data_status(qrc) == 0) {
+
+		if (filp->f_flags & O_NONBLOCK) {
+			ret = -EAGAIN;
+			goto out;
+		}
+		__set_current_state(TASK_INTERRUPTIBLE);
+		mutex_unlock(&qrc->mutex);
+
+		schedule();
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			goto remove;
+		}
+
+		mutex_lock(&qrc->mutex);
+	}
+
+	ret = qrc->qrc_ops->qrcops_receive(qrc, buf, count);
+
+out:
+	mutex_unlock(&qrc->mutex);
+remove:
+	remove_wait_queue(&qrc->r_wait, &wait);
+	set_current_state(TASK_RUNNING);
+	return ret;
+}
+
+static ssize_t qrc_cdev_write(struct file *filp, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct qrc_dev *qrc;
+	enum qrcdev_tx ret;
+
+	qrc = filp->private_data;
+	ret = qrc->qrc_ops->qrcops_xmit(buf, count, qrc);
+	if (ret == QRCDEV_TX_OK)
+		return count;
+
+	return 0;
+}
+
+static const struct file_operations qrc_cdev_fops = {
+	.owner = THIS_MODULE,
+	.read = qrc_cdev_read,
+	.write = qrc_cdev_write,
+	.unlocked_ioctl = qrc_cdev_ioctl,
+	.poll = qrc_cdev_poll,
+	.fasync = qrc_cdev_fasync,
+	.open = qrc_cdev_open,
+	.release = qrc_cdev_release,
+};
+
+/*-------Interface for qrc device ---------*/
+int qrc_register_device(struct qrc_dev *qdev, struct device *dev)
+{
+	int ret;
+	dev_t devt;
+
+	if (!qdev)
+		return -ENOMEM;
+
+	mutex_init(&qdev->mutex);
+	init_waitqueue_head(&qdev->r_wait);
+	init_waitqueue_head(&qdev->w_wait);
+
+	/*register cdev*/
+	qrc_class = class_create(THIS_MODULE, "qrc_class");
+	if (IS_ERR(qrc_class)) {
+		pr_err("failed to allocate class\n");
+		return PTR_ERR(qrc_class);
+	}
+	ret = alloc_chrdev_region(&qrc_devt, 0, 1, "qrc");
+	if (ret < 0) {
+		pr_err("failed to allocate char device region\n");
+		class_destroy(qrc_class);
+		return ret;
+	}
+
+	devt = MKDEV(MAJOR(qrc_devt), 0);
+
+	cdev_init(&qdev->cdev, &qrc_cdev_fops);
+	ret = qrc_control_gpio_init(qdev, dev->of_node);
+
+	ret = cdev_add(&qdev->cdev, devt, 1);
+	if (ret) {
+		pr_err("qrc failed to add char device\n");
+		return ret;
+	}
+
+	qdev->dev = device_create(qrc_class, dev, devt, qdev,
+							"qrc");
+	if (IS_ERR(qdev->dev)) {
+		ret = PTR_ERR(qdev->dev);
+		goto del_cdev;
+	}
+
+	return 0;
+
+del_cdev:
+	cdev_del(&qdev->cdev);
+	return ret;
+}
+
+void qrc_unregister(struct qrc_dev *qdev)
+{
+	device_destroy(qrc_class, qdev->dev->devt);
+	qrc_control_gpio_uninit(qdev);
+	dev_info(qdev->dev, "qrc drv unregistered\n");
+}
diff --git a/drivers/misc/qrc/qrc_core.h b/drivers/misc/qrc/qrc_core.h
new file mode 100644
index 000000000000..1126bf36b32b
--- /dev/null
+++ b/drivers/misc/qrc/qrc_core.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* driver/misc/qrc/qrc_core.h
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _QRC_CORE_H
+#define _QRC_CORE_H
+
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/kfifo.h>
+#include <linux/sched/signal.h>
+#include <linux/uaccess.h>
+#include <linux/ioctl.h>
+
+#define QRC_NAME_SIZE 30
+#define QRC_INTERFACE_SIZE 30
+#define QRC_FIFO_SIZE	0x1000
+
+struct qrc_dev;
+
+/* IOCTL commands */
+#define QRC_IOC_MAGIC   'q'
+
+/* Clear read fifo */
+#define QRC_FIFO_CLEAR	_IO(QRC_IOC_MAGIC, 1)
+/* Reboot QRC controller */
+#define QRC_REBOOT	_IO(QRC_IOC_MAGIC, 2)
+/* QRC boot from memory */
+#define QRC_BOOT_TO_MEM	_IO(QRC_IOC_MAGIC, 3)
+/* QRC boot from flash */
+#define QRC_BOOT_TO_FLASH	_IO(QRC_IOC_MAGIC, 4)
+
+
+enum qrcdev_state_t {
+	__STATE_IDLE,
+	__STATE_READING,
+	__STATE_WRITING,
+};
+
+enum qrc_interface {
+	UART = 0,
+	SPI,
+};
+
+enum qrcdev_tx {
+	__QRCDEV_TX_MIN	 = INT_MIN,	/* make sure enum is signed (-1)*/
+	QRCDEV_TX_OK	 = 0x00,	/* driver took care of packet */
+	QRCDEV_TX_BUSY	 = 0x10,	/* driver tx path was busy*/
+};
+
+struct qrc_device_stats {
+	unsigned long	rx_bytes;
+	unsigned long	tx_bytes;
+	unsigned long	rx_errors;
+	unsigned long	tx_errors;
+	unsigned long	collisions;
+	unsigned long	rx_length_errors;
+	unsigned long	rx_over_errors;
+	unsigned long	rx_fifo_errors;
+};
+
+struct qrc_device_ops {
+	int		(*qrcops_init)(struct qrc_dev *dev);
+	void		(*qrcops_uninit)(struct qrc_dev *dev);
+	int		(*qrcops_open)(struct qrc_dev *dev);
+	int		(*qrcops_close)(struct qrc_dev *dev);
+	int		(*qrcops_setup)(struct qrc_dev *dev);
+	enum qrcdev_tx	(*qrcops_xmit)(const char __user  *buf,
+			size_t data_length, struct qrc_dev *dev);
+	int		(*qrcops_receive)(struct qrc_dev *dev,
+			char __user *buf, size_t count);
+	int		(*qrcops_data_status)
+			(struct qrc_dev *dev);
+	int		(*qrcops_config)(struct qrc_dev *dev);
+	void	(*qrcops_data_clean)(struct qrc_dev *dev);
+};
+
+/* qrc char device */
+struct qrc_dev {
+	struct qrc_device_stats stats;
+	/* qrc dev ops */
+	struct qrc_device_ops *qrc_ops;
+	struct mutex mutex;
+	wait_queue_head_t r_wait;
+	wait_queue_head_t w_wait;
+	struct fasync_struct *async_queue;
+	struct cdev cdev;
+	struct device *dev;
+	void *data;
+	int qrc_boot0_gpio;
+	int qrc_reset_gpio;
+};
+
+/**
+ * struct qrcuart - The qrcuart device structure.
+ * @qrc_dev:  This is robotic controller device structure.
+ *                    It include interface for qrcuart.
+ * @lock: spinlock for transmitting lock.
+ * @tx_work: Flushes transmit TX buffer.
+ * @serdev: Serial device bus structure.
+ * @qrc_rx_fifo: Qrcuart receive buffer.
+ * @tx_head: String head in XMIT queue.
+ * @tx_left: Bytes left in XMIT queue.
+ * @tx_buffer: XMIT buffer.
+ * @is_open: Flag shows if the device is open.
+ * This structure is used to define robotic controller uart device.
+ */
+struct qrcuart {
+	struct qrc_dev *qrc_dev;
+	spinlock_t lock;
+	struct work_struct tx_work;
+	struct serdev_device *serdev;
+	struct kfifo qrc_rx_fifo;
+	unsigned char *tx_head;
+	int tx_left;
+	unsigned char *tx_buffer;
+	bool is_open;
+};
+
+struct qrcspi {
+	struct qrc_dev *qrc_dev;
+	spinlock_t lock;			/* transmit lock */
+};
+
+static inline void qrc_set_data(struct qrc_dev *dev, void *data)
+{
+	dev->data = data;
+}
+static inline void *qrc_get_data(const struct qrc_dev *dev)
+{
+	return dev->data;
+}
+
+int qrc_register_device(struct qrc_dev *qdev, struct device *dev);
+void qrc_unregister(struct qrc_dev *qdev);
+
+#endif
+
diff --git a/drivers/misc/qrc/qrc_uart.c b/drivers/misc/qrc/qrc_uart.c
new file mode 100644
index 000000000000..2e7f384833c3
--- /dev/null
+++ b/drivers/misc/qrc/qrc_uart.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* driver/misc/qrc/qrc_uart.c
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/serdev.h>
+#include <linux/types.h>
+#include<linux/slab.h>
+#include <linux/init.h>
+#include <linux/cdev.h>
+#include <linux/of_device.h>
+
+#include "qrc_core.h"
+
+#define QRC_RX_FIFO_SIZE 0x400
+#define QRC_TX_BUFF_SIZE 0x400
+#define QRCUART_DRV_NAME "qrcuart"
+#define QRC_DRV_VERSION "0.1.0"
+
+
+static int qrcuart_setup(struct qrc_dev *dev);
+
+static int
+qrc_uart_receive(struct serdev_device *serdev, const unsigned char *data,
+		size_t count)
+{
+	struct qrcuart *qrc = serdev_device_get_drvdata(serdev);
+	struct qrc_dev *qrc_dev = qrc->qrc_dev;
+	int ret;
+
+	/* check count */
+	ret = kfifo_avail(&qrc->qrc_rx_fifo);
+	if (!ret)
+		return 0;
+
+	if (count > ret)
+		count = ret;
+
+	ret = kfifo_in(&qrc->qrc_rx_fifo, data, count);
+	if (!ret)
+		return 0;
+
+	wake_up_interruptible(&qrc_dev->r_wait);
+
+	return count;
+}
+
+/* Write out any remaining transmit buffer. Scheduled when tty is writable */
+static void qrcuart_transmit(struct work_struct *work)
+{
+	struct qrcuart *qrc = container_of(work, struct qrcuart, tx_work);
+	int written;
+
+	spin_lock_bh(&qrc->lock);
+
+	if (qrc->tx_left <= 0) {
+		/* Now serial buffer is almost free & we can start
+		 * transmission of another packet
+		 */
+		spin_unlock_bh(&qrc->lock);
+		return;
+	}
+
+	written = serdev_device_write_buf(qrc->serdev, qrc->tx_head,
+					  qrc->tx_left);
+	if (written > 0) {
+		qrc->tx_left -= written;
+		qrc->tx_head += written;
+	}
+	spin_unlock_bh(&qrc->lock);
+}
+
+/* Called by the driver when there's room for more data.
+ * Schedule the transmit.
+ */
+static void qrc_uart_wakeup(struct serdev_device *serdev)
+{
+	struct qrcuart *qrc = serdev_device_get_drvdata(serdev);
+
+	schedule_work(&qrc->tx_work);
+}
+
+static struct serdev_device_ops qrc_serdev_ops = {
+	.receive_buf = qrc_uart_receive,
+	.write_wakeup = qrc_uart_wakeup,
+};
+
+/*----------------Interface to QRC core -----------------------------*/
+
+static int qrcuart_open(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	struct serdev_device *serdev = qrc->serdev;
+	int ret;
+
+	if (!qrc->is_open) {
+		ret = serdev_device_open(serdev);
+		if (ret) {
+			pr_err("qrcuart :Unable to open device\n");
+			return ret;
+		}
+		serdev_device_set_baudrate(serdev, 115200);
+		serdev_device_set_flow_control(serdev, false);
+		qrc->is_open = true;
+	}
+
+	return 0;
+}
+
+static int qrcuart_close(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	struct serdev_device *serdev = qrc->serdev;
+
+	flush_work(&qrc->tx_work);
+	spin_lock_bh(&qrc->lock);
+	qrc->tx_left = 0;
+	spin_unlock_bh(&qrc->lock);
+
+	if (qrc->is_open) {
+		serdev_device_close(serdev);
+		qrc->is_open = false;
+	}
+
+	return 0;
+}
+
+static int qrcuart_init(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	size_t len;
+	int ret;
+
+	/* Finish setting up the device info. */
+	len = QRC_TX_BUFF_SIZE;
+	qrc->tx_buffer = devm_kmalloc(&qrc->serdev->dev, len, GFP_KERNEL);
+
+	if (!qrc->tx_buffer)
+		return -ENOMEM;
+
+	qrc->tx_head = qrc->tx_buffer;
+	qrc->tx_left = 0;
+
+	ret = kfifo_alloc(&qrc->qrc_rx_fifo, QRC_RX_FIFO_SIZE,
+					  GFP_KERNEL);
+	if (ret)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void qrcuart_uninit(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	kfifo_free(&qrc->qrc_rx_fifo);
+}
+
+/*put data from kfifo to qrc fifo */
+static int qrcuart_receive(struct qrc_dev *dev, char __user *buf,
+			       size_t count)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	u32 fifo_len, trans_len;
+
+	if (!kfifo_is_empty(&qrc->qrc_rx_fifo)) {
+		fifo_len = kfifo_len(&qrc->qrc_rx_fifo);
+		if (count > fifo_len)
+			count = fifo_len;
+		if (kfifo_to_user(&qrc->qrc_rx_fifo,
+				(void *)buf, count, &trans_len))
+			return -EFAULT;
+		return trans_len;
+	}
+	return 0;
+}
+
+static int qrcuart_data_status(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+
+	return kfifo_len(&qrc->qrc_rx_fifo);
+}
+
+static void qrcuart_data_clean(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+
+	kfifo_reset(&qrc->qrc_rx_fifo);
+}
+
+static enum qrcdev_tx qrcuart_xmit(const char __user  *buf,
+				size_t data_length, struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	struct qrc_device_stats *n_stats = &dev->stats;
+	size_t written;
+	u8 *pos;
+
+	WARN_ON(qrc->tx_left);
+
+	pos = qrc->tx_buffer + qrc->tx_left;
+	if ((data_length + qrc->tx_left) > QRC_TX_BUFF_SIZE) {
+		pr_err("qrcuart transmit date overflow %d\n", data_length);
+		return __QRCDEV_TX_MIN;
+	}
+
+	if (copy_from_user(pos, buf, data_length))
+		return __QRCDEV_TX_MIN;
+
+	pos += data_length;
+
+	spin_lock(&qrc->lock);
+
+	written = serdev_device_write_buf(qrc->serdev, qrc->tx_buffer,
+					  pos - qrc->tx_buffer);
+	if (written > 0) {
+		qrc->tx_left = (pos - qrc->tx_buffer) - written;
+		qrc->tx_head = qrc->tx_buffer + written;
+		n_stats->tx_bytes += written;
+	}
+
+	spin_unlock(&qrc->lock);
+
+	return QRCDEV_TX_OK;
+}
+
+static int qrcuart_config(struct qrc_dev *dev)
+{
+	/*baudrate,wordlength ... config*/
+	return 0;
+}
+
+static struct qrc_device_ops qrcuart_qrc_ops = {
+	.qrcops_open = qrcuart_open,
+	.qrcops_close = qrcuart_close,
+	.qrcops_init = qrcuart_init,
+	.qrcops_uninit = qrcuart_uninit,
+	.qrcops_xmit = qrcuart_xmit,
+	.qrcops_receive = qrcuart_receive,
+	.qrcops_config = qrcuart_config,
+	.qrcops_setup = qrcuart_setup,
+	.qrcops_data_status = qrcuart_data_status,
+	.qrcops_data_clean = qrcuart_data_clean,
+};
+
+static int qrcuart_setup(struct qrc_dev *dev)
+{
+	dev->qrc_ops = &qrcuart_qrc_ops;
+	return 0;
+}
+
+static int qrc_uart_probe(struct serdev_device *serdev)
+{
+	struct qrc_dev *qdev;
+	struct qrcuart *qrc;
+	int ret = 0;
+
+	qrc = kmalloc(sizeof(*qrc), GFP_KERNEL);
+	if (!qrc)
+		return -ENOMEM;
+	qdev = kmalloc(sizeof(*qdev), GFP_KERNEL);
+	if (!qdev) {
+		kfree(qrc);
+		return -ENOMEM;
+	}
+	qrc_set_data(qdev, qrc);
+
+	qrc->qrc_dev = qdev;
+	qrc->serdev = serdev;
+	spin_lock_init(&qrc->lock);
+	INIT_WORK(&qrc->tx_work, qrcuart_transmit);
+	qrcuart_setup(qdev);
+	ret = qrcuart_init(qdev);
+	if (ret) {
+		pr_err("qrcuart: Fail to init qrc structure\n");
+		kfree(qdev);
+		kfree(qrc);
+		return ret;
+	}
+	serdev_device_set_drvdata(serdev, qrc);
+	serdev_device_set_client_ops(serdev, &qrc_serdev_ops);
+
+	ret = serdev_device_open(serdev);
+	if (ret) {
+		pr_err("qrcuart :Unable to open device\n");
+		goto free;
+	}
+	serdev_device_close(serdev);
+	qrc->is_open = false;
+
+	ret = qrc_register_device(qdev, &serdev->dev);
+
+	if (ret) {
+		pr_err("qrcuart: Unable to register qrc device %s\n");
+		cancel_work_sync(&qrc->tx_work);
+		goto free;
+	}
+
+	return 0;
+
+free:
+	qrcuart_uninit(qdev);
+	kfree(qdev);
+	kfree(qrc);
+	return ret;
+}
+
+static void qrc_uart_remove(struct serdev_device *serdev)
+{
+	struct qrcuart *qrc = serdev_device_get_drvdata(serdev);
+
+	if (qrc->is_open)
+		serdev_device_close(serdev);
+
+	qrcuart_uninit(qrc->qrc_dev);
+	cancel_work_sync(&qrc->tx_work);
+	qrc_unregister(qrc->qrc_dev);
+	kfree(qrc->qrc_dev);
+	kfree(qrc);
+	dev_info(&serdev->dev, "qrcuart drv removed\n");
+}
+
+static const struct of_device_id qrc_uart_of_match[] = {
+	{
+	 .compatible = "qcom,qrc-uart",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, qrc_of_match);
+
+static struct serdev_device_driver qrc_uart_driver = {
+	.probe = qrc_uart_probe,
+	.remove = qrc_uart_remove,
+	.driver = {
+		.name = QRCUART_DRV_NAME,
+		.of_match_table = of_match_ptr(qrc_uart_of_match),
+	},
+};
+
+module_serdev_device_driver(qrc_uart_driver);
+
+/**********************************************/
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. QRC Uart Driver");
+MODULE_LICENSE("GPL v2");

---
base-commit: ab57716449b3438c0136f6f412a2e59e0cf037a9
change-id: 20231109-qrc-e4cab62f0f7e

Best regards,
-- 
zhengjia zhu <quic_zhezhu@quicinc.com>

