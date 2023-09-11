Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF8F79A1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjIKDVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjIKDVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:21:36 -0400
X-Greylist: delayed 1226 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Sep 2023 20:20:52 PDT
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FEA11F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7sZpSJvnRHyrZ+jjbKVjxcohzBAnlC6ITQhg9CqD/uA=; b=GBUD0Ocgp7tNXEPKwTWIb0Nw/2
        6qaImQPoaWg8J+bZaUroeIniPoaL2CY/GPbXP79q1q+t3L6QX5bc2z083GleAJ8y+7p4fUSUcf2aR
        lhsduTGPpnNhOd4VoPx8yX/lbSzjuVEr/w8der9os262sf+sY0tQvcOaI57Ox9iIHzoph32alZsvE
        u/yrkEXDQGBUoWkfrfs6Yegfku/Ceq0z46uL7aMeQ2kt1rgaQstSPOW3u6FJUuyB49U4nrYrrAWGw
        PZURKHdZz7ofxvl5RVdF8kh3m1UBtoryQXj3HJslJ9Y+H97t4s29c/zrL3cAtrbqszL3FNzFD9V7W
        QWK1INbg==;
Received: from [187.10.204.7] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qfXA7-002C6C-FJ; Mon, 11 Sep 2023 05:00:31 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Shashank Sharma <shashank.sharma@amd.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 3/5] drm/amdgpu: Encapsulate all device reset info
Date:   Mon, 11 Sep 2023 00:00:16 -0300
Message-ID: <20230911030018.73540-4-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911030018.73540-1-andrealmeid@igalia.com>
References: <20230911030018.73540-1-andrealmeid@igalia.com>
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

To better organize struct amdgpu_device, keep all reset information
related fields together in a separated struct.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
---
v6: no changes
v5: new patch, as required by Shashank Sharma
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 34 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 16 +++++-----
 3 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0d560b713948..56d78ca6e917 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -781,6 +781,26 @@ struct amdgpu_mqd {
 #define AMDGPU_PRODUCT_NAME_LEN 64
 struct amdgpu_reset_domain;
 
+#ifdef CONFIG_DEV_COREDUMP
+struct amdgpu_coredump_info {
+	struct amdgpu_device	*adev;
+	struct amdgpu_task_info reset_task_info;
+	struct timespec64	reset_time;
+	bool			reset_vram_lost;
+};
+#endif
+
+struct amdgpu_reset_info {
+	/* reset dump register */
+	u32 *reset_dump_reg_list;
+	u32 *reset_dump_reg_value;
+	int num_regs;
+
+#ifdef CONFIG_DEV_COREDUMP
+	struct amdgpu_coredump_info *coredump_info;
+#endif
+};
+
 /*
  * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
  */
@@ -1084,10 +1104,7 @@ struct amdgpu_device {
 
 	struct mutex			benchmark_mutex;
 
-	/* reset dump register */
-	uint32_t                        *reset_dump_reg_list;
-	uint32_t			*reset_dump_reg_value;
-	int                             num_regs;
+	struct amdgpu_reset_info	reset_info;
 
 	bool                            scpm_enabled;
 	uint32_t                        scpm_status;
@@ -1100,15 +1117,6 @@ struct amdgpu_device {
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a4faea4fa0b5..3136a0774dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2016,8 +2016,8 @@ static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < adev->num_regs; i++) {
-		sprintf(reg_offset, "0x%x\n", adev->reset_dump_reg_list[i]);
+	for (i = 0; i < adev->reset_info.num_regs; i++) {
+		sprintf(reg_offset, "0x%x\n", adev->reset_info.reset_dump_reg_list[i]);
 		up_read(&adev->reset_domain->sem);
 		if (copy_to_user(buf + len, reg_offset, strlen(reg_offset)))
 			return -EFAULT;
@@ -2074,9 +2074,9 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 	if (ret)
 		goto error_free;
 
-	swap(adev->reset_dump_reg_list, tmp);
-	swap(adev->reset_dump_reg_value, new);
-	adev->num_regs = i;
+	swap(adev->reset_info.reset_dump_reg_list, tmp);
+	swap(adev->reset_info.reset_dump_reg_value, new);
+	adev->reset_info.num_regs = i;
 	up_write(&adev->reset_domain->sem);
 	ret = size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b5b879bcc5c9..96975591841d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4790,10 +4790,10 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
 
 	lockdep_assert_held(&adev->reset_domain->sem);
 
-	for (i = 0; i < adev->num_regs; i++) {
-		adev->reset_dump_reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);
-		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
-					     adev->reset_dump_reg_value[i]);
+	for (i = 0; i < adev->reset_info.num_regs; i++) {
+		adev->reset_info.reset_dump_reg_value[i] = RREG32(adev->reset_info.reset_dump_reg_list[i]);
+		trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
+					     adev->reset_info.reset_dump_reg_value[i]);
 	}
 
 	return 0;
@@ -4831,13 +4831,13 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
 
 	if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
-	if (coredump->adev->num_regs) {
+	if (coredump->adev->reset_info.num_regs) {
 		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
 
-		for (i = 0; i < coredump->adev->num_regs; i++)
+		for (i = 0; i < coredump->adev->reset_info.num_regs; i++)
 			drm_printf(&p, "0x%08x: 0x%08x\n",
-				   coredump->adev->reset_dump_reg_list[i],
-				   coredump->adev->reset_dump_reg_value[i]);
+				   coredump->adev->reset_info.reset_dump_reg_list[i],
+				   coredump->adev->reset_info.reset_dump_reg_value[i]);
 	}
 
 	return count - iter.remain;
-- 
2.42.0

