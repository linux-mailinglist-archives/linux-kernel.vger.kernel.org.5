Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8866C7DE903
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347532AbjKAXcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347598AbjKAXcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2819123
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698881504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9h4gDR/fORcBfQCQq3ZbFmiTv2MIcBJK9/ph1UUGxK8=;
        b=WGzRVmpQPnqFt2rxiTUVRigh7CIpQKqYxHZQLLYOZcJb1w4D6PGwTC191ralI7EGdolor1
        lamgcpBVO5PpP6qDpWK+YODNt9LpLZ0qozTch3zVLwCyZbciTF/3z6UHOLibc+fBysaZH8
        gUQsGRyt7CbIll1G+eIww3gQN5SupiA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-_kNplbaSPRqTKXx-4nHUjg-1; Wed, 01 Nov 2023 19:31:42 -0400
X-MC-Unique: _kNplbaSPRqTKXx-4nHUjg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c7f0a33afbso19711166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 16:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698881501; x=1699486301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h4gDR/fORcBfQCQq3ZbFmiTv2MIcBJK9/ph1UUGxK8=;
        b=fijkkvRZVOMXnRAQplK1vsgIbt0vMsUWBaGweSpxMHuYf2jW1soagdlKplT1Y7e12v
         h0/ORxienJlgzODSaox14G4VjErik7dl/HOpGxZbC4yzyLe7jxZR5LUdcyQnP8rORlXC
         XRYp5OMsot9nHEIo0V8Fg8rzcj9CMaD7udXLx07EksOTSXS/arsGAlL9jwMRAjLQ+6cl
         ZP/ritq/E1ju+huQQA64kffziU9PiA6nueQKQEZa4uW837D9R8zrPilQz5wivmu27Elq
         IHID09aq1G0Zo9/T/gZ3HdGECzI21y002fp6NYueHY0gb1oycCrDYUHv7VWfAX5cFdj/
         bovA==
X-Gm-Message-State: AOJu0Yx+LwGikVtRidVgvCZlClOxRoQWmgmUAjK0j9rVL5cV/KQMPZhu
        XxlgPsAHwcsTxrPItXyhoFvzMPZK089LQvgqL1rqNSCYB80AWRtDEaJ76WVsA5VIh+wY9qHjzOr
        KWJqj/bcTY3zuU1KyYGjS35EY
X-Received: by 2002:a17:907:7f07:b0:9bd:fa48:83c5 with SMTP id qf7-20020a1709077f0700b009bdfa4883c5mr3418680ejc.70.1698881501311;
        Wed, 01 Nov 2023 16:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdgbVt+h8vUAhN1SkYA6wFpnHn4HoiLCPG0PpaFbeDsw3PgAnduK8dK75Vj39qRfRTq7aa3g==
X-Received: by 2002:a17:907:7f07:b0:9bd:fa48:83c5 with SMTP id qf7-20020a1709077f0700b009bdfa4883c5mr3418674ejc.70.1698881501118;
        Wed, 01 Nov 2023 16:31:41 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906584d00b009cd1fca4d68sm464340ejs.5.2023.11.01.16.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 16:31:40 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v8 06/12] drm/nouveau: make use of the GPUVM's shared dma-resv
Date:   Thu,  2 Nov 2023 00:30:58 +0100
Message-ID: <20231101233113.8059-7-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101233113.8059-1-dakr@redhat.com>
References: <20231101233113.8059-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM GEM objects private to a single GPUVM can use a shared dma-resv.
Make use of the shared dma-resv of GPUVM rather than a driver specific
one.

The shared dma-resv originates from a "root" GEM object serving as
container for the dma-resv to make it compatible with drm_exec.

In order to make sure the object proving the shared dma-resv can't be
freed up before the objects making use of it, let every such GEM object
take a reference on it.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c   | 11 +++++++++--
 drivers/gpu/drm/nouveau/nouveau_bo.h   |  5 +++++
 drivers/gpu/drm/nouveau/nouveau_gem.c  | 10 ++++++++--
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  7 ++-----
 drivers/gpu/drm/nouveau/nouveau_uvmm.h |  1 -
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 0f3bd187ede6..7afad86da64b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -148,10 +148,17 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 	 * If nouveau_bo_new() allocated this buffer, the GEM object was never
 	 * initialized, so don't attempt to release it.
 	 */
-	if (bo->base.dev)
+	if (bo->base.dev) {
+		/* Gem objects not being shared with other VMs get their
+		 * dma_resv from a root GEM object.
+		 */
+		if (nvbo->no_share)
+			drm_gem_object_put(nvbo->r_obj);
+
 		drm_gem_object_release(&bo->base);
-	else
+	} else {
 		dma_resv_fini(&bo->base._resv);
+	}
 
 	kfree(nvbo);
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.h b/drivers/gpu/drm/nouveau/nouveau_bo.h
index 07f671cf895e..70c551921a9e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.h
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.h
@@ -26,6 +26,11 @@ struct nouveau_bo {
 	struct list_head entry;
 	int pbbo_index;
 	bool validate_mapped;
+
+	/* Root GEM object we derive the dma_resv of in case this BO is not
+	 * shared between VMs.
+	 */
+	struct drm_gem_object *r_obj;
 	bool no_share;
 
 	/* GPU address space is independent of CPU word size */
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index a0d303e5ce3d..49c2bcbef129 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -111,7 +111,8 @@ nouveau_gem_object_open(struct drm_gem_object *gem, struct drm_file *file_priv)
 	if (vmm->vmm.object.oclass < NVIF_CLASS_VMM_NV50)
 		return 0;
 
-	if (nvbo->no_share && uvmm && &uvmm->resv != nvbo->bo.base.resv)
+	if (nvbo->no_share && uvmm &&
+	    drm_gpuvm_resv(&uvmm->base) != nvbo->bo.base.resv)
 		return -EPERM;
 
 	ret = ttm_bo_reserve(&nvbo->bo, false, false, NULL);
@@ -245,7 +246,7 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int align, uint32_t domain,
 		if (unlikely(!uvmm))
 			return -EINVAL;
 
-		resv = &uvmm->resv;
+		resv = drm_gpuvm_resv(&uvmm->base);
 	}
 
 	if (!(domain & (NOUVEAU_GEM_DOMAIN_VRAM | NOUVEAU_GEM_DOMAIN_GART)))
@@ -288,6 +289,11 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int align, uint32_t domain,
 	if (drm->client.device.info.family >= NV_DEVICE_INFO_V0_TESLA)
 		nvbo->valid_domains &= domain;
 
+	if (nvbo->no_share) {
+		nvbo->r_obj = drm_gpuvm_resv_obj(&uvmm->base);
+		drm_gem_object_get(nvbo->r_obj);
+	}
+
 	*pnvbo = nvbo;
 	return 0;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index f74bf30bc683..8977a518de96 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1802,7 +1802,6 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 	int ret;
 
 	mutex_init(&uvmm->mutex);
-	dma_resv_init(&uvmm->resv);
 	mt_init_flags(&uvmm->region_mt, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&uvmm->region_mt, &uvmm->mutex);
 
@@ -1842,14 +1841,14 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 			    kernel_managed_addr, kernel_managed_size,
 			    NULL, 0, &cli->uvmm.vmm.vmm);
 	if (ret)
-		goto out_free_gpuva_mgr;
+		goto out_gpuvm_fini;
 
 	cli->uvmm.vmm.cli = cli;
 	mutex_unlock(&cli->mutex);
 
 	return 0;
 
-out_free_gpuva_mgr:
+out_gpuvm_fini:
 	drm_gpuvm_destroy(&uvmm->base);
 out_unlock:
 	mutex_unlock(&cli->mutex);
@@ -1907,6 +1906,4 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
 	nouveau_vmm_fini(&uvmm->vmm);
 	drm_gpuvm_destroy(&uvmm->base);
 	mutex_unlock(&cli->mutex);
-
-	dma_resv_fini(&uvmm->resv);
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.h b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
index 06a0c36de392..22607270fae0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
@@ -12,7 +12,6 @@ struct nouveau_uvmm {
 	struct nouveau_vmm vmm;
 	struct maple_tree region_mt;
 	struct mutex mutex;
-	struct dma_resv resv;
 
 	bool disabled;
 };
-- 
2.41.0

