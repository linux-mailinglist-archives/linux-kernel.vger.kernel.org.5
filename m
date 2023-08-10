Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4A6778172
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbjHJTX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjHJTXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:23:54 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ACE273D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bWa+vn0ncc56O4owG5Ir2kLx6Wlo5Rlnv9Jk6857I5w=; b=sW6fFgbZa37lhLAlgVs6JJMvla
        NhS56d7xpPtGM857J+5lX+7FFDa3WOW46iatBBsK3Z0mt0J4feItJ7gb/N78XtUkakykwt/6iYFqY
        qR/f/vZBS8i5aGZl1X4yAQjSeZCMlL3+hvhPp0+CQD3VMBSOJPeGM9tjcOCeMBDt5Pma2DnXEb6M7
        JLYWpTs9RVq2tfOTK+Op8e2Ihvuign+Eaygnf2OWf8ytJmM6meDSZBSCOLPvlL4n1q3QQdM55V4ug
        4CVje/dQOoYFRkCszqYK5oVO/nIYLIMQlcobia6yDR3L0i6UcVCZ3rPrvGy1WEQkxTe4sb1Nd2pnj
        hca/u6Rw==;
Received: from [191.193.179.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qUBG7-00Gp5H-TC; Thu, 10 Aug 2023 21:23:48 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RESEND v3 4/5] drm/amdgpu: Move coredump code to amdgpu_reset file
Date:   Thu, 10 Aug 2023 16:23:29 -0300
Message-ID: <20230810192330.198326-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810192330.198326-1-andrealmeid@igalia.com>
References: <20230810192330.198326-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Giving that we use codedump just for device resets, move it's functions
and structs to a more semantic file, the amdgpu_reset.{c, h}.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  9 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 78 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 11 +++
 4 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0d560b713948..314b06cddc39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1100,15 +1100,6 @@ struct amdgpu_device {
 	uint32_t			aid_mask;
 };
 
-#ifdef CONFIG_DEV_COREDUMP
-struct amdgpu_coredump_info {
-	struct amdgpu_device		*adev;
-	struct amdgpu_task_info         reset_task_info;
-	struct timespec64               reset_time;
-	bool                            reset_vram_lost;
-};
-#endif
-
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
 {
 	return container_of(ddev, struct amdgpu_device, ddev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 419b6336de64..9706f608723a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -32,8 +32,6 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <linux/pci.h>
-#include <linux/devcoredump.h>
-#include <generated/utsrelease.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/apple-gmux.h>
 
@@ -4799,84 +4797,6 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
 	return 0;
 }
 
-#ifndef CONFIG_DEV_COREDUMP
-static void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-			    struct amdgpu_reset_context *reset_context)
-{
-}
-#else
-static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
-		size_t count, void *data, size_t datalen)
-{
-	struct drm_printer p;
-	struct amdgpu_coredump_info *coredump = data;
-	struct drm_print_iterator iter;
-	int i;
-
-	iter.data = buffer;
-	iter.offset = 0;
-	iter.start = offset;
-	iter.remain = count;
-
-	p = drm_coredump_printer(&iter);
-
-	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
-	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
-	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
-	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
-	if (coredump->reset_task_info.pid)
-		drm_printf(&p, "process_name: %s PID: %d\n",
-			   coredump->reset_task_info.process_name,
-			   coredump->reset_task_info.pid);
-
-	if (coredump->reset_vram_lost)
-		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
-	if (coredump->adev->num_regs) {
-		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
-
-		for (i = 0; i < coredump->adev->num_regs; i++)
-			drm_printf(&p, "0x%08x: 0x%08x\n",
-				   coredump->adev->reset_dump_reg_list[i],
-				   coredump->adev->reset_dump_reg_value[i]);
-	}
-
-	return count - iter.remain;
-}
-
-static void amdgpu_devcoredump_free(void *data)
-{
-	kfree(data);
-}
-
-static void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-			    struct amdgpu_reset_context *reset_context)
-{
-	struct amdgpu_coredump_info *coredump;
-	struct drm_device *dev = adev_to_drm(adev);
-
-	coredump = kmalloc(sizeof(*coredump), GFP_NOWAIT);
-
-	if (!coredump) {
-		DRM_ERROR("%s: failed to allocate memory for coredump\n", __func__);
-		return;
-	}
-
-	memset(coredump, 0, sizeof(*coredump));
-
-	coredump->reset_vram_lost = vram_lost;
-
-	if (reset_context->job && reset_context->job->vm)
-		coredump->reset_task_info = reset_context->job->vm->task_info;
-
-	coredump->adev = adev;
-
-	ktime_get_ts64(&coredump->reset_time);
-
-	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
-		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
-}
-#endif
-
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 5fed06ffcc6b..b02b56193447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -21,6 +21,9 @@
  *
  */
 
+#include <linux/devcoredump.h>
+#include <generated/utsrelease.h>
+
 #include "amdgpu_reset.h"
 #include "aldebaran.h"
 #include "sienna_cichlid.h"
@@ -167,5 +170,80 @@ void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
 	up_write(&reset_domain->sem);
 }
 
+#ifndef CONFIG_DEV_COREDUMP
+void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
+		     struct amdgpu_reset_context *reset_context)
+{
+}
+#else
+static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
+		size_t count, void *data, size_t datalen)
+{
+	struct drm_printer p;
+	struct amdgpu_coredump_info *coredump = data;
+	struct drm_print_iterator iter;
+	int i;
+
+	iter.data = buffer;
+	iter.offset = 0;
+	iter.start = offset;
+	iter.remain = count;
+
+	p = drm_coredump_printer(&iter);
+
+	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
+	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
+	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
+	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
+	if (coredump->reset_task_info.pid)
+		drm_printf(&p, "process_name: %s PID: %d\n",
+			   coredump->reset_task_info.process_name,
+			   coredump->reset_task_info.pid);
+
+	if (coredump->reset_vram_lost)
+		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
+	if (coredump->adev->num_regs) {
+		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
+
+		for (i = 0; i < coredump->adev->num_regs; i++)
+			drm_printf(&p, "0x%08x: 0x%08x\n",
+				   coredump->adev->reset_dump_reg_list[i],
+				   coredump->adev->reset_dump_reg_value[i]);
+	}
+
+	return count - iter.remain;
+}
+
+static void amdgpu_devcoredump_free(void *data)
+{
+	kfree(data);
+}
+
+void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
+			    struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_coredump_info *coredump;
+	struct drm_device *dev = adev_to_drm(adev);
+
+	coredump = kmalloc(sizeof(*coredump), GFP_NOWAIT);
+
+	if (!coredump) {
+		DRM_ERROR("%s: failed to allocate memory for coredump\n", __func__);
+		return;
+	}
+
+	memset(coredump, 0, sizeof(*coredump));
+
+	coredump->reset_vram_lost = vram_lost;
+
+	if (reset_context->job && reset_context->job->vm)
+		coredump->reset_task_info = reset_context->job->vm->task_info;
 
+	coredump->adev = adev;
 
+	ktime_get_ts64(&coredump->reset_time);
+
+	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
+		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
+}
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index f4a501ff87d9..362954521721 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -87,6 +87,15 @@ struct amdgpu_reset_domain {
 	atomic_t reset_res;
 };
 
+#ifdef CONFIG_DEV_COREDUMP
+struct amdgpu_coredump_info {
+	struct amdgpu_device		*adev;
+	struct amdgpu_task_info         reset_task_info;
+	struct timespec64               reset_time;
+	bool                            reset_vram_lost;
+};
+#endif
+
 
 int amdgpu_reset_init(struct amdgpu_device *adev);
 int amdgpu_reset_fini(struct amdgpu_device *adev);
@@ -126,4 +135,6 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
+void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
+		     struct amdgpu_reset_context *reset_context);
 #endif
-- 
2.41.0

