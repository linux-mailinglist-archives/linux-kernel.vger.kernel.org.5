Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D8B7F2268
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjKUAlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjKUAkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:40:47 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004101725;
        Mon, 20 Nov 2023 16:40:30 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5be24d41bb8so3456167a12.0;
        Mon, 20 Nov 2023 16:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527230; x=1701132030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqnPDeT1YoL9rNB4A1jsKDn6H/sLGf7y+LZ/0+TfYww=;
        b=kVu34LyO1x29wRIFsWFzoHS7nsUQF0LYfNMreCIhzo1iK4RXg4t+JMmwtnX4Ga0Lfj
         duEPcG7x/VUXHefeHY+XqqiqxRtIo55mTw/YxrjgQRP/Jj8yUhRfVPPuB1R2F4e2rukk
         GNnI8rOcJc6r3MboLkxDH0W9U+bpyW3zdhbm6Nu1Rhmb85B7ODVdDiiy5rsNgP+U5hiG
         SH9qB98jEnwl/8CDcBnM5gNpv3XmvRiU4L9T//Y/TmeH/xj/vEXtj/ammGT8V/Hr/D8O
         wLclmOEAKoo3JI4oLgLHE1ug6TAv2KT4ibrrHdhkHpXaB83SRz4jyhewda3uCbzC8W8K
         /d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527230; x=1701132030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqnPDeT1YoL9rNB4A1jsKDn6H/sLGf7y+LZ/0+TfYww=;
        b=XZF7JtUXaQqprPRHAX8IxKRdDIFqzDliqzOu4DS8TqFHJYjjpCGPFqP3O4UoEc2goe
         ipM1iPX43kE9UH55ezUaOMQ+5fzc/xwTwHekn4PmmgwQpv6uR++XHC55todf6+/oZLGZ
         drII12GjNpUBl51EVP1K9Te1oeIrsxNMu7m3BZtEDLMftmh1uHH4iK7U+MCmUfxPk3rS
         MEcK4aXUzaq5/Awl6tVjpVf0oAEmZrqFwYag+EkW9k9+bN1PKc7yA77XCKP1a/WqxTKx
         4RKpBszf7isgsU2kyD84p+YYD/o7kg5r7sdvb7spD0ElYDQgWbwAtmc5bIEnalN9abVX
         pNTg==
X-Gm-Message-State: AOJu0Yyf8AaQA19BH2pBlIdkQdGeuXXpOUV8lpJruqeAq8J/Zc0SJNN6
        x4gk57ma/uYukRCiM4RngfI=
X-Google-Smtp-Source: AGHT+IEdMYmXseGPjw5igm2guOY42XEWsmT2PS9nDaTFF8MnEWea9REnHW9MVjovgwoeMbDg2kIzIQ==
X-Received: by 2002:a05:6a20:3d13:b0:187:962d:746b with SMTP id y19-20020a056a203d1300b00187962d746bmr1577161pzi.9.1700527229910;
        Mon, 20 Nov 2023 16:40:29 -0800 (PST)
Received: from localhost ([47.215.232.245])
        by smtp.gmail.com with ESMTPSA id fd26-20020a056a002e9a00b00688435a9915sm6659357pfb.189.2023.11.20.16.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:40:29 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Lang Yu <Lang.Yu@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
        Leo Liu <leo.liu@amd.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        amd-gfx@lists.freedesktop.org (open list:AMD KFD),
        linux-kernel@vger.kernel.org (open list),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS)
Subject: [PATCH v2 6/7] drm/exec: Pass in initial # of objects
Date:   Mon, 20 Nov 2023 16:38:50 -0800
Message-ID: <20231121003935.5868-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121003935.5868-1-robdclark@gmail.com>
References: <20231121003935.5868-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

In cases where the # is known ahead of time, it is silly to do the table
resize dance.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c     |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  2 +-
 drivers/gpu/drm/drm_exec.c                       | 13 ++++++++++---
 drivers/gpu/drm/nouveau/nouveau_exec.c           |  2 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c           |  2 +-
 drivers/gpu/drm/tests/drm_exec_test.c            | 16 ++++++++--------
 include/drm/drm_exec.h                           |  2 +-
 12 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 41fbc4fd0fac..0bd3c4a6267a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1137,7 +1137,7 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
 
 	ctx->n_vms = 1;
 	ctx->sync = &mem->sync;
-	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&ctx->exec) {
 		ret = amdgpu_vm_lock_pd(vm, &ctx->exec, 2);
 		drm_exec_retry_on_contention(&ctx->exec);
@@ -1176,7 +1176,7 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 	int ret;
 
 	ctx->sync = &mem->sync;
-	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&ctx->exec) {
 		ctx->n_vms = 0;
 		list_for_each_entry(entry, &mem->attachments, list) {
@@ -2552,7 +2552,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 
 	amdgpu_sync_create(&sync);
 
-	drm_exec_init(&exec, 0);
+	drm_exec_init(&exec, 0, 0);
 	/* Reserve all BOs and page tables for validation */
 	drm_exec_until_all_locked(&exec) {
 		/* Reserve all the page directories */
@@ -2793,7 +2793,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 
 	mutex_lock(&process_info->lock);
 
-	drm_exec_init(&exec, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		list_for_each_entry(peer_vm, &process_info->vm_list_head,
 				    vm_list_node) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index df3ecfa9e13f..2464606494d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -66,7 +66,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 
 	amdgpu_sync_create(&p->sync);
 	drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
-		      DRM_EXEC_IGNORE_DUPLICATES);
+		      DRM_EXEC_IGNORE_DUPLICATES, 0);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 720011019741..796fa6f1420b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -70,7 +70,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct drm_exec exec;
 	int r;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
@@ -110,7 +110,7 @@ int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct drm_exec exec;
 	int r;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 84beeaa4d21c..49a5f1c73b3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -203,7 +203,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	struct drm_exec exec;
 	long r;
 
-	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES);
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_obj(&exec, &bo->tbo.base, 1);
 		drm_exec_retry_on_contention(&exec);
@@ -739,7 +739,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	}
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
-		      DRM_EXEC_IGNORE_DUPLICATES);
+		      DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		if (gobj) {
 			r = drm_exec_lock_obj(&exec, gobj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9ddbf1494326..abd0b9763904 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1122,7 +1122,7 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
 
 	amdgpu_sync_create(&sync);
 
-	drm_exec_init(&exec, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_lock_obj(&exec,
 				      &ctx_data->meta_data_obj->tbo.base);
@@ -1193,7 +1193,7 @@ int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
 	struct drm_exec exec;
 	long r;
 
-	drm_exec_init(&exec, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_lock_obj(&exec,
 				      &ctx_data->meta_data_obj->tbo.base);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index ca45ba8ac171..bfbf59326ee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -86,7 +86,7 @@ static int map_ring_data(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	amdgpu_sync_create(&sync);
 
-	drm_exec_init(&exec, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_lock_obj(&exec, &bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
@@ -149,7 +149,7 @@ static int unmap_ring_data(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct drm_exec exec;
 	long r;
 
-	drm_exec_init(&exec, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_lock_obj(&exec, &bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f2f3c338fd94..76d9f14ccc7c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1529,7 +1529,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
 	uint32_t gpuidx;
 	int r;
 
-	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0);
+	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
 	drm_exec_until_all_locked(&ctx->exec) {
 		for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
 			pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 5d2809de4517..48ee851b61d9 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -69,16 +69,23 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
  * drm_exec_init - initialize a drm_exec object
  * @exec: the drm_exec object to initialize
  * @flags: controls locking behavior, see DRM_EXEC_* defines
+ * @nr: the initial # of objects
  *
  * Initialize the object and make sure that we can track locked objects.
+ *
+ * If nr is non-zero then it is used as the initial objects table size.
+ * In either case, the table will grow (be re-allocated) on demand.
  */
-void drm_exec_init(struct drm_exec *exec, uint32_t flags)
+void drm_exec_init(struct drm_exec *exec, uint32_t flags, unsigned nr)
 {
+	if (!nr)
+		nr = PAGE_SIZE / sizeof(void *);
+
 	exec->flags = flags;
-	exec->objects = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	exec->objects = kvmalloc_array(nr, sizeof(void *), GFP_KERNEL);
 
 	/* If allocation here fails, just delay that till the first use */
-	exec->max_objects = exec->objects ? PAGE_SIZE / sizeof(void *) : 0;
+	exec->max_objects = exec->objects ? nr : 0;
 	exec->num_objects = 0;
 	exec->contended = DRM_EXEC_DUMMY;
 	exec->prelocked = NULL;
diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index 9a5ef574744b..769392276e4f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.c
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
@@ -103,7 +103,7 @@ nouveau_exec_job_submit(struct nouveau_job *job)
 
 	nouveau_uvmm_lock(uvmm);
 	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
-			    DRM_EXEC_IGNORE_DUPLICATES);
+			    DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(exec) {
 		struct drm_gpuva *va;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 5cf892c50f43..f93cfccc2c93 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1288,7 +1288,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 	}
 
 	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
-			    DRM_EXEC_IGNORE_DUPLICATES);
+			    DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(exec) {
 		list_for_each_op(op, &bind_job->ops) {
 			struct drm_gpuva_op *va_op;
diff --git a/drivers/gpu/drm/tests/drm_exec_test.c b/drivers/gpu/drm/tests/drm_exec_test.c
index 563949d777dd..81f928a429ba 100644
--- a/drivers/gpu/drm/tests/drm_exec_test.c
+++ b/drivers/gpu/drm/tests/drm_exec_test.c
@@ -46,7 +46,7 @@ static void sanitycheck(struct kunit *test)
 {
 	struct drm_exec exec;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_fini(&exec);
 	KUNIT_SUCCEED(test);
 }
@@ -60,7 +60,7 @@ static void test_lock(struct kunit *test)
 
 	drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		ret = drm_exec_lock_obj(&exec, &gobj);
 		drm_exec_retry_on_contention(&exec);
@@ -80,7 +80,7 @@ static void test_lock_unlock(struct kunit *test)
 
 	drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		ret = drm_exec_lock_obj(&exec, &gobj);
 		drm_exec_retry_on_contention(&exec);
@@ -107,7 +107,7 @@ static void test_duplicates(struct kunit *test)
 
 	drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
 
-	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES);
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		ret = drm_exec_lock_obj(&exec, &gobj);
 		drm_exec_retry_on_contention(&exec);
@@ -134,7 +134,7 @@ static void test_prepare(struct kunit *test)
 
 	drm_gem_private_object_init(priv->drm, &gobj, PAGE_SIZE);
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		ret = drm_exec_prepare_obj(&exec, &gobj, 1);
 		drm_exec_retry_on_contention(&exec);
@@ -159,7 +159,7 @@ static void test_prepare_array(struct kunit *test)
 	drm_gem_private_object_init(priv->drm, &gobj1, PAGE_SIZE);
 	drm_gem_private_object_init(priv->drm, &gobj2, PAGE_SIZE);
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec)
 		ret = drm_exec_prepare_array(&exec, array, ARRAY_SIZE(array),
 					     1);
@@ -174,14 +174,14 @@ static void test_multiple_loops(struct kunit *test)
 {
 	struct drm_exec exec;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec)
 	{
 		break;
 	}
 	drm_exec_fini(&exec);
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec)
 	{
 		break;
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index b5bf0b6da791..f1a66c048721 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -135,7 +135,7 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
 	return !!exec->contended;
 }
 
-void drm_exec_init(struct drm_exec *exec, uint32_t flags);
+void drm_exec_init(struct drm_exec *exec, uint32_t flags, unsigned nr);
 void drm_exec_fini(struct drm_exec *exec);
 bool drm_exec_cleanup(struct drm_exec *exec);
 int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj);
-- 
2.42.0

