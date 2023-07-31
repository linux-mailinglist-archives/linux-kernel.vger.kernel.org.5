Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2B4768992
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjGaBZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGaBZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:25:05 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B7E10C0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 18:25:01 -0700 (PDT)
X-UUID: ec401524ccdd4a75a95bb13ecdf23484-20230731
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:4917b3d5-9121-418f-a1b7-2c16f347d37f,IP:5,U
        RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:10
X-CID-INFO: VERSION:1.1.28,REQID:4917b3d5-9121-418f-a1b7-2c16f347d37f,IP:5,URL
        :0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:10
X-CID-META: VersionHash:176cd25,CLOUDID:99b7f4b3-a467-4aa9-9e04-f584452e3794,B
        ulkID:2307310924429GZH7MN4,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
        TF_CID_SPAM_FAS
X-UUID: ec401524ccdd4a75a95bb13ecdf23484-20230731
X-User: zhanghao1@kylinos.cn
Received: from localhost.localdomain [(111.48.58.12)] by mailgw
        (envelope-from <zhanghao1@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1675230145; Mon, 31 Jul 2023 09:24:39 +0800
From:   zhanghao1 <zhanghao1@kylinos.cn>
To:     virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        linux-kernel@vger.kernel.org, zhanghao1 <zhanghao1@kylinos.cn>
Subject: [PATCH] A new virtio pci driver is added for listening to vcpus inside guest. Each vcpu creates a corresponding thread to periodically send data to qemu's back-end watchdog device.
Date:   Mon, 31 Jul 2023 09:24:05 +0800
Message-Id: <20230731012405.234611-1-zhanghao1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is mainly used with the back-end watchdog device of qemu.

Signed-off-by: zhanghao1 <zhanghao1@kylinos.cn>
---
 drivers/virtio/Kconfig                      |   9 +
 drivers/virtio/Makefile                     |   1 +
 drivers/virtio/virtio_vcpu_stall_detector.c | 299 ++++++++++++++++++++
 3 files changed, 309 insertions(+)
 create mode 100644 drivers/virtio/virtio_vcpu_stall_detector.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 0a53a61231c2..869323e345a1 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -173,4 +173,13 @@ config VIRTIO_DMA_SHARED_BUFFER
 	 This option adds a flavor of dma buffers that are backed by
 	 virtio resources.
 
+config VIRTIO_VCPU_WATCHDOG
+	tristate "Virtio vcpu watchdog driver"
+	depends on VIRTIO_PCI
+	help
+	 When this driver is bound inside a KVM guest, it will
+	 periodically "pet" an PCI virtio watchdog device from each vCPU
+	 and allow the host to detect vCPU stalls.
+
+	 If you do not intend to run this kernel as a guest, say N.
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 8e98d24917cc..c7341f078a34 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
 obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
 obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
 obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
+obj-$(CONFIG_VIRTIO_VCPU_WATCHDOG) += virtio_vcpu_stall_detector.o
diff --git a/drivers/virtio/virtio_vcpu_stall_detector.c b/drivers/virtio/virtio_vcpu_stall_detector.c
new file mode 100644
index 000000000000..58344ca528be
--- /dev/null
+++ b/drivers/virtio/virtio_vcpu_stall_detector.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// VCPU stall detector.
+// Copyright (C) Kylin Software, 2023
+
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/nmi.h>
+#include <uapi/linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+#include <linux/param.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+
+#define VCPU_STALL_REG_STATUS		(0x00)
+#define VCPU_STALL_REG_LOAD_CNT		(0x04)
+#define VCPU_STALL_REG_CURRENT_CNT	(0x08)
+#define VCPU_STALL_REG_CLOCK_FREQ_HZ	(0x0C)
+#define VCPU_STALL_REG_LEN		(0x10)
+#define VCPU_STALL_REG_TIMEOUT_SEC	(0x14)
+
+#define VCPU_STALL_DEFAULT_CLOCK_HZ	(10)
+#define VCPU_STALL_MAX_CLOCK_HZ		(100)
+#define VCPU_STALL_DEFAULT_TIMEOUT_SEC	(8)
+#define VCPU_STALL_MAX_TIMEOUT_SEC	(600)
+
+struct vcpu_stall_detect_config {
+	u32 clock_freq_hz;
+	u32 stall_timeout_sec;
+
+	enum cpuhp_state hp_online;
+};
+
+struct vcpu_stall_priv {
+	struct hrtimer vcpu_hrtimer;
+	struct virtio_device *vdev;
+	u32 cpu_id;
+};
+
+struct vcpu_stall {
+	struct vcpu_stall_priv *priv;
+	struct virtqueue *vq;
+	spinlock_t lock;
+	struct pet_event {
+		u32 cpu_id;
+		bool is_initialized;
+		u32 ticks;
+	} pet_event;
+};
+
+static const struct virtio_device_id vcpu_stall_id_table[] = {
+	{ VIRTIO_ID_WATCHDOG, VIRTIO_DEV_ANY_ID },
+	{ 0, },
+};
+
+/* The vcpu stall configuration structure which applies to all the CPUs */
+static struct vcpu_stall_detect_config vcpu_stall_config;
+static struct vcpu_stall *vcpu_stall;
+
+static struct vcpu_stall_priv __percpu *vcpu_stall_detectors;
+
+static enum hrtimer_restart
+vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
+{
+	u32 ticks, ping_timeout_ms;
+	struct scatterlist sg;
+	int unused, err = 0;
+
+	struct vcpu_stall_priv *vcpu_stall_detector =
+		this_cpu_ptr(vcpu_stall->priv);
+
+	/* Reload the stall detector counter register every
+	 * `ping_timeout_ms` to prevent the virtual device
+	 * from decrementing it to 0. The virtual device decrements this
+	 * register at 'clock_freq_hz' frequency.
+	 */
+	ticks = vcpu_stall_config.clock_freq_hz *
+				vcpu_stall_config.stall_timeout_sec;
+
+	spin_lock(&vcpu_stall->lock);
+	while (virtqueue_get_buf(vcpu_stall->vq, &unused))
+		;
+	vcpu_stall->pet_event.ticks = cpu_to_virtio32(vcpu_stall_detector->vdev, ticks);
+	vcpu_stall->pet_event.is_initialized = true;
+	vcpu_stall->pet_event.cpu_id = vcpu_stall_detector->cpu_id;
+
+	sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
+	err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
+	if (!err)
+		virtqueue_kick(vcpu_stall->vq);
+	else
+		pr_err("cpu:%d failed to add outbuf, err:%d\n", vcpu_stall_detector->cpu_id, err);
+
+	spin_unlock(&vcpu_stall->lock);
+
+	ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
+			  MSEC_PER_SEC / 2;
+	hrtimer_forward_now(hrtimer,
+			    ms_to_ktime(ping_timeout_ms));
+	return HRTIMER_RESTART;
+}
+
+static int start_stall_detector_cpu(unsigned int cpu)
+{
+	u32 ticks, ping_timeout_ms;
+	struct scatterlist sg;
+	struct hrtimer *vcpu_hrtimer;
+	int err = 0;
+
+	struct vcpu_stall_priv *vcpu_stall_detector =
+		this_cpu_ptr(vcpu_stall->priv);
+
+	vcpu_stall_detector->cpu_id = cpu;
+
+	vcpu_hrtimer = &vcpu_stall_detector->vcpu_hrtimer;
+
+	/* Compute the number of ticks required for the stall detector
+	 * counter register based on the internal clock frequency and the
+	 * timeout value given from the device tree.
+	 */
+	ticks = vcpu_stall_config.clock_freq_hz *
+		vcpu_stall_config.stall_timeout_sec;
+	vcpu_stall->pet_event.ticks = cpu_to_virtio32(vcpu_stall_detector->vdev, ticks);
+
+	/* Pet the stall detector at half of its expiration timeout
+	 * to prevent spurious resets.
+	 */
+	ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
+			  MSEC_PER_SEC / 2;
+
+	hrtimer_init(vcpu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	vcpu_hrtimer->function = vcpu_stall_detect_timer_fn;
+
+	vcpu_stall->pet_event.is_initialized = true;
+
+	spin_lock(&vcpu_stall->lock);
+	vcpu_stall->pet_event.cpu_id = cpu;
+	sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
+	err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
+	if (!err)
+		virtqueue_kick(vcpu_stall->vq);
+
+	spin_unlock(&vcpu_stall->lock);
+
+	hrtimer_start(vcpu_hrtimer, ms_to_ktime(ping_timeout_ms),
+		      HRTIMER_MODE_REL_PINNED);
+	return err;
+}
+
+static int stop_stall_detector_cpu(unsigned int cpu)
+{
+	int err = 0;
+	struct scatterlist sg;
+
+	struct vcpu_stall_priv *vcpu_stall_detector =
+		per_cpu_ptr(vcpu_stall_detectors, cpu);
+
+	/* Disable the stall detector for the current CPU */
+	hrtimer_cancel(&vcpu_stall_detector->vcpu_hrtimer);
+	vcpu_stall->pet_event.is_initialized = false;
+	vcpu_stall->pet_event.cpu_id = cpu;
+
+	spin_lock(&vcpu_stall->lock);
+	sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
+	err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
+	if (!err)
+		virtqueue_kick(vcpu_stall->vq);
+
+	spin_unlock(&vcpu_stall->lock);
+
+	return err;
+}
+
+static int vcpu_stall_detect_probe(struct virtio_device *vdev)
+{
+	int ret, cpu;
+	u32 clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
+	u32 stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;
+
+	vcpu_stall = kzalloc(sizeof(struct vcpu_stall), GFP_KERNEL);
+	if (!vcpu_stall) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	vdev->priv = vcpu_stall;
+
+	vcpu_stall->priv = devm_alloc_percpu(&vdev->dev,
+					typeof(struct vcpu_stall_priv));
+	if (!vcpu_stall->priv) {
+		ret = -ENOMEM;
+		goto failed_priv;
+	}
+
+	for_each_possible_cpu(cpu) {
+		struct vcpu_stall_priv *priv;
+
+		priv = per_cpu_ptr(vcpu_stall->priv, cpu);
+		priv->vdev = vdev;
+	}
+
+	ret = virtio_cread_feature(vdev, VCPU_STALL_REG_CLOCK_FREQ_HZ,
+						struct vcpu_stall_detect_config, clock_freq_hz,
+						&clock_freq_hz);
+	if (ret || !clock_freq_hz) {
+		if (!(clock_freq_hz > 0 &&
+		      clock_freq_hz < VCPU_STALL_MAX_CLOCK_HZ)) {
+			dev_warn(&vdev->dev, "clk out of range\n");
+			clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
+		}
+	}
+	ret = virtio_cread_feature(vdev, VCPU_STALL_REG_TIMEOUT_SEC,
+						struct vcpu_stall_detect_config, stall_timeout_sec,
+						&stall_timeout_sec);
+	if (ret || !stall_timeout_sec) {
+		if (!(stall_timeout_sec > 0 &&
+		      stall_timeout_sec < VCPU_STALL_MAX_TIMEOUT_SEC)) {
+			dev_warn(&vdev->dev, "stall timeout out of range\n");
+			stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;
+		}
+	}
+
+	vcpu_stall_config = (struct vcpu_stall_detect_config) {
+		.clock_freq_hz		= clock_freq_hz,
+		.stall_timeout_sec	= stall_timeout_sec
+	};
+
+	/* find virtqueue for guest to send pet event to host */
+	vcpu_stall->vq = virtio_find_single_vq(vdev, NULL, "pet-event");
+	if (IS_ERR(vcpu_stall->vq)) {
+		dev_err(&vdev->dev, "failed to find vq\n");
+		goto failed_priv;
+	}
+
+	spin_lock_init(&vcpu_stall->lock);
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"virt/vcpu_stall_detector:online",
+				start_stall_detector_cpu,
+				stop_stall_detector_cpu);
+	if (ret < 0) {
+		dev_err(&vdev->dev, "failed to install cpu hotplug\n");
+		goto failed_priv;
+	}
+
+	vcpu_stall_config.hp_online = ret;
+	return 0;
+
+
+failed_priv:
+	kfree(vcpu_stall);
+err:
+	return ret;
+}
+
+static void vcpu_stall_detect_remove(struct virtio_device *vdev)
+{
+	int cpu;
+
+	cpuhp_remove_state(vcpu_stall_config.hp_online);
+
+	for_each_possible_cpu(cpu)
+		stop_stall_detector_cpu(cpu);
+}
+
+static unsigned int features_legacy[] = {
+	VCPU_STALL_REG_STATUS, VCPU_STALL_REG_LOAD_CNT, VCPU_STALL_REG_CURRENT_CNT,
+	VCPU_STALL_REG_CLOCK_FREQ_HZ, VCPU_STALL_REG_LEN, VCPU_STALL_REG_TIMEOUT_SEC
+};
+
+
+static unsigned int features[] = {
+	VCPU_STALL_REG_STATUS, VCPU_STALL_REG_LOAD_CNT, VCPU_STALL_REG_CURRENT_CNT,
+	VCPU_STALL_REG_CLOCK_FREQ_HZ, VCPU_STALL_REG_LEN, VCPU_STALL_REG_TIMEOUT_SEC
+};
+
+static struct virtio_driver vcpu_stall_detect_driver = {
+	.feature_table	= features,
+	.feature_table_size = ARRAY_SIZE(features),
+	.feature_table_legacy	= features_legacy,
+	.feature_table_size_legacy	= ARRAY_SIZE(features_legacy),
+	.driver.name	= KBUILD_MODNAME,
+	.driver.owner	= THIS_MODULE,
+	.id_table =	vcpu_stall_id_table,
+	.probe  = vcpu_stall_detect_probe,
+	.remove = vcpu_stall_detect_remove,
+};
+
+module_virtio_driver(vcpu_stall_detect_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(virtio, vcpu_stall_id_table);
+MODULE_AUTHOR("zhanghao1 <zhanghao1@kylinos.cn>");
+MODULE_DESCRIPTION("VCPU stall detector");
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
