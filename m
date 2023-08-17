Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E7277FDD4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354306AbjHQSXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354371AbjHQSXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:23:09 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777893A91
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tnViSDrYq1wVWUVUWxxofLSdzl3fRoe0iOVgg7Jsz5Q=; b=V22JJw0HLWytmsYzKrtpGIlp45
        n/uwaHbfHzs5ylLbHWCXbNlzDjKHxtpB1xzd1Qs3NWGahj+1EO64TImsMG84zQGm0/L/cNxg2ik+E
        ssj/Qn1FnMbF1C2+UdFG9CcC1b72GN/yBKyEfv1MlKfeNjZXngymIglaVytFlHidFUd+U5G5MMrJl
        v2cU1sIscYKmu7qkfneo4sYR3C6uc1f+t7izA8uFD9uGbOZm2AYUJ4wDLGg+h3wOfotmCgQACJcSP
        901JFiDhFOPzQ9qCcQuckByoypYAfe8rpIihXAuLmXYiLxEQgdpJzCcnvxs+JWWxebSsknhUc4rwY
        +BqVxREw==;
Received: from [191.193.179.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qWhcG-0021I9-1u; Thu, 17 Aug 2023 20:21:04 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 2/5] drm/amdgpu: Rework coredump to use memory dynamically
Date:   Thu, 17 Aug 2023 15:20:47 -0300
Message-ID: <20230817182050.205925-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817182050.205925-1-andrealmeid@igalia.com>
References: <20230817182050.205925-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of storing coredump information inside amdgpu_device struct,
move if to a proper separated struct and allocate it dynamically. This
will make it easier to further expand the logged information.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v5: no change
v4: change kmalloc to kzalloc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 14 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 63 ++++++++++++++--------
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c6a332261ab..0d560b713948 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1088,11 +1088,6 @@ struct amdgpu_device {
 	uint32_t                        *reset_dump_reg_list;
 	uint32_t			*reset_dump_reg_value;
 	int                             num_regs;
-#ifdef CONFIG_DEV_COREDUMP
-	struct amdgpu_task_info         reset_task_info;
-	bool                            reset_vram_lost;
-	struct timespec64               reset_time;
-#endif
 
 	bool                            scpm_enabled;
 	uint32_t                        scpm_status;
@@ -1105,6 +1100,15 @@ struct amdgpu_device {
 	uint32_t			aid_mask;
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
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
 {
 	return container_of(ddev, struct amdgpu_device, ddev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bf4781551f88..b5b879bcc5c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4799,12 +4799,17 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
 	return 0;
 }
 
-#ifdef CONFIG_DEV_COREDUMP
+#ifndef CONFIG_DEV_COREDUMP
+static void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
+			    struct amdgpu_reset_context *reset_context)
+{
+}
+#else
 static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
 		size_t count, void *data, size_t datalen)
 {
 	struct drm_printer p;
-	struct amdgpu_device *adev = data;
+	struct amdgpu_coredump_info *coredump = data;
 	struct drm_print_iterator iter;
 	int i;
 
@@ -4818,21 +4823,21 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
 	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
 	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
 	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
-	drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, adev->reset_time.tv_nsec);
-	if (adev->reset_task_info.pid)
+	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
+	if (coredump->reset_task_info.pid)
 		drm_printf(&p, "process_name: %s PID: %d\n",
-			   adev->reset_task_info.process_name,
-			   adev->reset_task_info.pid);
+			   coredump->reset_task_info.process_name,
+			   coredump->reset_task_info.pid);
 
-	if (adev->reset_vram_lost)
+	if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
-	if (adev->num_regs) {
+	if (coredump->adev->num_regs) {
 		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
 
-		for (i = 0; i < adev->num_regs; i++)
+		for (i = 0; i < coredump->adev->num_regs; i++)
 			drm_printf(&p, "0x%08x: 0x%08x\n",
-				   adev->reset_dump_reg_list[i],
-				   adev->reset_dump_reg_value[i]);
+				   coredump->adev->reset_dump_reg_list[i],
+				   coredump->adev->reset_dump_reg_value[i]);
 	}
 
 	return count - iter.remain;
@@ -4840,14 +4845,32 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
 
 static void amdgpu_devcoredump_free(void *data)
 {
+	kfree(data);
 }
 
-static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
+static void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
+			    struct amdgpu_reset_context *reset_context)
 {
+	struct amdgpu_coredump_info *coredump;
 	struct drm_device *dev = adev_to_drm(adev);
 
-	ktime_get_ts64(&adev->reset_time);
-	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_NOWAIT,
+	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
+
+	if (!coredump) {
+		DRM_ERROR("%s: failed to allocate memory for coredump\n", __func__);
+		return;
+	}
+
+	coredump->reset_vram_lost = vram_lost;
+
+	if (reset_context->job && reset_context->job->vm)
+		coredump->reset_task_info = reset_context->job->vm->task_info;
+
+	coredump->adev = adev;
+
+	ktime_get_ts64(&coredump->reset_time);
+
+	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
 		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
 }
 #endif
@@ -4955,15 +4978,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 					goto out;
 
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
-#ifdef CONFIG_DEV_COREDUMP
-				tmp_adev->reset_vram_lost = vram_lost;
-				memset(&tmp_adev->reset_task_info, 0,
-						sizeof(tmp_adev->reset_task_info));
-				if (reset_context->job && reset_context->job->vm)
-					tmp_adev->reset_task_info =
-						reset_context->job->vm->task_info;
-				amdgpu_reset_capture_coredumpm(tmp_adev);
-#endif
+
+				amdgpu_coredump(tmp_adev, vram_lost, reset_context);
+
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
 					amdgpu_inc_vram_lost(tmp_adev);
-- 
2.41.0

