Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265D1772B00
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjHGQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjHGQeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B901BDF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691425977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piPAJWb0pb900GeCYfzlLDbns7cOjvHHVSLvNcNzuY4=;
        b=fGO5AfZbERvGfkD2FJid6dTDUWJVPHGhFlvQ1H2KHaegw70LrWgzJrtcyfZJXjLvqq0WKi
        5UXEJnza4biKYJk7EK4YB4iNxExYabqOPXqjVgIOZgeAIpQ7barf/LrlfRdNH0cwD7blFJ
        WIOMzTM3w4L3RC3wMDos5myQavis17g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-wRzHF3_zN-y-wncBUy5D9w-1; Mon, 07 Aug 2023 12:32:56 -0400
X-MC-Unique: wRzHF3_zN-y-wncBUy5D9w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bfe3dd009so756789866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425974; x=1692030774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piPAJWb0pb900GeCYfzlLDbns7cOjvHHVSLvNcNzuY4=;
        b=diuYd2g9duZRzcy6NSWc6Zkfh+Z7yy+R1/4qYQ93NXjYAWw0WzbglV/DmfcCAp6XSZ
         EOLb7BBLb1VZBboYjmZmnRBfgoNn55xeIiSFMOgl0hytNg52zyDxpdUKXROrR4si+LLj
         RWJYZHVlZhm/ndcPgLsjZRR5pDyMyR+vJ6PpY8BBzeoQzv8eXtK4RaGlUIKdqdDqXJL3
         r3HTKbw7nbawSrEaSsLx2CHQeR2ZA3yMpcZaULoRVDimhyiN8UDiVGSPkJVswyUtjX8q
         bzOqYd3lXwK6YI1XTmb+OuWFcz+Va+cg99M+VIG/ilAUpl6Xww692K++o0nL9X3823qR
         JblA==
X-Gm-Message-State: AOJu0YzOe0f46BjQWEUsetRCzA6ZnvpSKgjjp3DexmoAhofSrz4/F6xY
        Zmhnu/8Pf/o+MA1jLTuFP1BkJUTpJjd8FIILz6u63coYZedlBJPx61VWJS/6ASrNJ2cTdVFzY1G
        WAFJ1+pc/luja6Oiu1QMKiiJ/yf2zA6qw
X-Received: by 2002:a17:906:108f:b0:994:1880:dc32 with SMTP id u15-20020a170906108f00b009941880dc32mr8042334eju.17.1691425974848;
        Mon, 07 Aug 2023 09:32:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAOrA3sQdOCxahpEKiwq8VOW54ZSfWV5X0WyopCri708v3H0dc43QYOi6NsAXi+7lwk8xLjA==
X-Received: by 2002:a17:906:108f:b0:994:1880:dc32 with SMTP id u15-20020a170906108f00b009941880dc32mr8042319eju.17.1691425974672;
        Mon, 07 Aug 2023 09:32:54 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id f8-20020a170906560800b00992b7ff3993sm5334625ejq.126.2023.08.07.09.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:32:54 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
        kherbst@redhat.com, lyude@redhat.com, sfr@canb.auug.org.au
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH drm-misc-next 3/5] drm/nouveau: remove incorrect __user annotations
Date:   Mon,  7 Aug 2023 18:32:24 +0200
Message-ID: <20230807163238.2091-4-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807163238.2091-1-dakr@redhat.com>
References: <20230807163238.2091-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix copy-paste error causing EXEC and VM_BIND syscalls data pointers
to carry incorrect __user annotations.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_exec.c | 6 +++---
 drivers/gpu/drm/nouveau/nouveau_exec.h | 2 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 6 +++---
 drivers/gpu/drm/nouveau/nouveau_uvmm.h | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index 42d9dd43ea02..0f927adda4ed 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.c
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
@@ -293,7 +293,7 @@ nouveau_exec(struct nouveau_exec_job_args *args)
 
 static int
 nouveau_exec_ucopy(struct nouveau_exec_job_args *args,
-		   struct drm_nouveau_exec __user *req)
+		   struct drm_nouveau_exec *req)
 {
 	struct drm_nouveau_sync **s;
 	u32 inc = req->wait_count;
@@ -352,7 +352,7 @@ nouveau_exec_ufree(struct nouveau_exec_job_args *args)
 
 int
 nouveau_exec_ioctl_exec(struct drm_device *dev,
-			void __user *data,
+			void *data,
 			struct drm_file *file_priv)
 {
 	struct nouveau_abi16 *abi16 = nouveau_abi16_get(file_priv);
@@ -360,7 +360,7 @@ nouveau_exec_ioctl_exec(struct drm_device *dev,
 	struct nouveau_abi16_chan *chan16;
 	struct nouveau_channel *chan = NULL;
 	struct nouveau_exec_job_args args = {};
-	struct drm_nouveau_exec __user *req = data;
+	struct drm_nouveau_exec *req = data;
 	int ret = 0;
 
 	if (unlikely(!abi16))
diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.h b/drivers/gpu/drm/nouveau/nouveau_exec.h
index 3032db27b8d7..778cacd90f65 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.h
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.h
@@ -48,7 +48,7 @@ struct nouveau_exec_job {
 int nouveau_exec_job_init(struct nouveau_exec_job **job,
 			  struct nouveau_exec_job_args *args);
 
-int nouveau_exec_ioctl_exec(struct drm_device *dev, void __user *data,
+int nouveau_exec_ioctl_exec(struct drm_device *dev, void *data,
 			    struct drm_file *file_priv);
 
 #endif
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index b515a21aa08e..2acbac73e57a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1687,7 +1687,7 @@ nouveau_uvmm_vm_bind(struct nouveau_uvmm_bind_job_args *args)
 
 static int
 nouveau_uvmm_vm_bind_ucopy(struct nouveau_uvmm_bind_job_args *args,
-			   struct drm_nouveau_vm_bind __user *req)
+			   struct drm_nouveau_vm_bind *req)
 {
 	struct drm_nouveau_sync **s;
 	u32 inc = req->wait_count;
@@ -1749,12 +1749,12 @@ nouveau_uvmm_vm_bind_ufree(struct nouveau_uvmm_bind_job_args *args)
 
 int
 nouveau_uvmm_ioctl_vm_bind(struct drm_device *dev,
-			   void __user *data,
+			   void *data,
 			   struct drm_file *file_priv)
 {
 	struct nouveau_cli *cli = nouveau_cli(file_priv);
 	struct nouveau_uvmm_bind_job_args args = {};
-	struct drm_nouveau_vm_bind __user *req = data;
+	struct drm_nouveau_vm_bind *req = data;
 	int ret = 0;
 
 	if (unlikely(!nouveau_cli_uvmm_locked(cli)))
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.h b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
index 3923c03012f9..534baadc3bf7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
@@ -89,10 +89,10 @@ void nouveau_uvmm_fini(struct nouveau_uvmm *uvmm);
 void nouveau_uvmm_bo_map_all(struct nouveau_bo *nvbov, struct nouveau_mem *mem);
 void nouveau_uvmm_bo_unmap_all(struct nouveau_bo *nvbo);
 
-int nouveau_uvmm_ioctl_vm_init(struct drm_device *dev, void __user *data,
+int nouveau_uvmm_ioctl_vm_init(struct drm_device *dev, void *data,
 			       struct drm_file *file_priv);
 
-int nouveau_uvmm_ioctl_vm_bind(struct drm_device *dev, void __user *data,
+int nouveau_uvmm_ioctl_vm_bind(struct drm_device *dev, void *data,
 			       struct drm_file *file_priv);
 
 static inline void nouveau_uvmm_lock(struct nouveau_uvmm *uvmm)
-- 
2.41.0

