Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CF27D9E63
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346083AbjJ0Q7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346009AbjJ0Q7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:59:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510871B1;
        Fri, 27 Oct 2023 09:59:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b26a3163acso2164942b3a.2;
        Fri, 27 Oct 2023 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698425971; x=1699030771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8RmDco3yC3v+3yvrh6eYN9grmgq77s+0DKqGNckmlM=;
        b=ltEdMVFE/6sXDL6JICWsN75SXCoNKuR6sBsCp853LGHhqPwD26PzFtjcrU4kt1Wr1K
         2ZAurTgEPFX2DQi78tEgeCKqWaFD3pZOSYge38+W70ZMavBlHgxAtoPsaYzm8xQfbZU+
         51aspuNQRdMnjFrMpgVDMwqMkT3G0gRlIllKvDbIY0stkXKet/jnGiFMt36ycI3M62is
         3P8aUdHQGua2sjOl47KISvswBnBdhEnk4negcYoMIsD0zUVXZu0IxaopgLiIvYbzhF5S
         ODcVU6jtT42wC0M8IGwY3/PYeqjz/Qwr/qhZoW6Xi05RnndPBsSSwldRQRPsM7SZmo8c
         a+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698425971; x=1699030771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8RmDco3yC3v+3yvrh6eYN9grmgq77s+0DKqGNckmlM=;
        b=l0IveqAsyaEYL5ifPQqFsokvDpTTTCMtKi/8r35ninFeGXn/cNE/Y9+29Zz1JAWV9k
         hjZLYpCsBTVDtVZvI7/mD+iKuvulaGYD20Y7F6ltR344odd3J/UkDiIRHzq7SXCL8xhJ
         BrN/rIN2yQGkcfqiWpsjZUHYwM2dNGgtQHrr47g7wyZizIScOovt6/xLzBWUXaX4FiPa
         EV6+RMTSXvTl+pR48yVKVbOW2N+NM6DtDI+UA1zQNOLSs3BNWXYrXLT5Jvub2Egje0Kp
         ecFsaJB5/uKBxilzw3t0BWbQrDKIbPvwIzj9g/V/wovQmMJVDZs9bBYSULfcD3IcNSk+
         ytuA==
X-Gm-Message-State: AOJu0YzKvHtmKagFdwPsnjeLAfM8avlMwAGSEB7OaIkh/dFWzneRSH9R
        jYb+mZqQNCOHwbjDFb2DuJ4=
X-Google-Smtp-Source: AGHT+IGcCDjD1BW09esItqwaRO3LZ9+ZgRLPW1fpZoKAd4lXmN90PAUSB93jicmG79kEPwmifa05mw==
X-Received: by 2002:a05:6a00:2356:b0:6b1:bf32:4fb5 with SMTP id j22-20020a056a00235600b006b1bf324fb5mr3294581pfj.28.1698425971178;
        Fri, 27 Oct 2023 09:59:31 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id r8-20020aa78b88000000b006b4ca26f3c9sm1605609pfd.74.2023.10.27.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:59:30 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dong Chenchen <dongchenchen2@huawei.com>,
        Philip Yang <Philip.Yang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS)
Subject: [PATCH 6/7] drm/exec: Pass in initial # of objects
Date:   Fri, 27 Oct 2023 09:58:40 -0700
Message-ID: <20231027165859.395638-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027165859.395638-1-robdclark@gmail.com>
References: <20231027165859.395638-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

In cases where the # is known ahead of time, it is silly to do the table
resize dance.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  4 ++--
 drivers/gpu/drm/drm_exec.c              | 15 ++++++++++++---
 drivers/gpu/drm/nouveau/nouveau_exec.c  |  2 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c  |  2 +-
 include/drm/drm_exec.h                  |  2 +-
 8 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index efdb1c48f431..d27ca8f61929 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -65,7 +65,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 	}
 
 	amdgpu_sync_create(&p->sync);
-	drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
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
index ca4d2d430e28..16f1715148ad 100644
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
index b6015157763a..3c351941701e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1105,7 +1105,7 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
 
 	amdgpu_sync_create(&sync);
 
-	drm_exec_init(&exec, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_lock_obj(&exec,
 				      &ctx_data->meta_data_obj->tbo.base);
@@ -1176,7 +1176,7 @@ int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
 	struct drm_exec exec;
 	long r;
 
-	drm_exec_init(&exec, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_lock_obj(&exec,
 				      &ctx_data->meta_data_obj->tbo.base);
diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 5d2809de4517..27d11c20d148 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -69,16 +69,25 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
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
+	size_t sz = PAGE_SIZE;
+
+	if (nr)
+		sz = (size_t)nr * sizeof(void *);
+
 	exec->flags = flags;
-	exec->objects = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	exec->objects = kmalloc(sz, GFP_KERNEL);
 
 	/* If allocation here fails, just delay that till the first use */
-	exec->max_objects = exec->objects ? PAGE_SIZE / sizeof(void *) : 0;
+	exec->max_objects = exec->objects ? sz / sizeof(void *) : 0;
 	exec->num_objects = 0;
 	exec->contended = DRM_EXEC_DUMMY;
 	exec->prelocked = NULL;
diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index 19024ce21fbb..f5930cc0b3fb 100644
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
index aae780e4a4aa..3a9331a1c830 100644
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
2.41.0

