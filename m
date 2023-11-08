Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2E7E4DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbjKHAOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343772AbjKHAOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:14:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC3010F6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699402407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9h4gDR/fORcBfQCQq3ZbFmiTv2MIcBJK9/ph1UUGxK8=;
        b=Ik9yd4WO4wTRb4fv3tCMBpJ7jIrDC6sCEc61nZbRWNdk271pk0azZ7kraR+oJ+3eQZv7YW
        XJJ1kL0EwymFNS9P09ivnUk31yzG2+bDYN95WW1/qANloz5rGJpmdn++HpN6t/CQRwvMVI
        Lme/Vekx4xPD3TtmU8wGV7oFBR7Dk/4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-KpNMu-SPNLqAsVYGtahgUg-1; Tue, 07 Nov 2023 19:13:26 -0500
X-MC-Unique: KpNMu-SPNLqAsVYGtahgUg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-542fe446d45so4829727a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699402405; x=1700007205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h4gDR/fORcBfQCQq3ZbFmiTv2MIcBJK9/ph1UUGxK8=;
        b=h/WKv1ibcU6YwZyLEBMd942hifyXEfiNY9mTw9uT4ESx7xSz20j43cxKZZnUbQURMj
         USTAnHT8Oo4Y73fsWiiQ0O/ApBNJ7IAuNdIh6+YrPwBntpbllGhjgQngRyXsvG7Mzf8f
         HOv5o0itH+MxEg55Ja54xcIilsdAOHs+ymhwhvAnJBbNPThqGIjLSfdXB0+aaljbb+1z
         ozMSzuI9SiHKNIE/puk7xBQOmJGpEp6GEMRim6iQjRFKKYVGrVFkwKD65f26c8zZ0R7h
         bMigenxwm1UM8mkGc+aI06kT86K0R1n3dEatmvSEmLGVrtWasi5pv5Kzza7Bv4YfkRvD
         oCLg==
X-Gm-Message-State: AOJu0YxVxvdjAHFoEwfk2Nou+28j1py3z9b8g49nYLpP22mAGsYSzd2v
        tu6B5bdJAuJJGbtYkwZfA6YzoYmFHyZS5IdjdpL3bt9xfGi0ILd48PqwswKwiGIiMUibUMrPBKM
        8hGHrdkWlaVmSOzQJwM2/dWXL
X-Received: by 2002:a17:907:7288:b0:9df:2fb1:1a83 with SMTP id dt8-20020a170907728800b009df2fb11a83mr116950ejc.39.1699402405140;
        Tue, 07 Nov 2023 16:13:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6TxzGOVynHm2MVgI3JMEgsR1Tuq7ffZRHHKjsz/3VqKP8rN60HGRHbpCunv2dFkEPK57cFw==
X-Received: by 2002:a17:907:7288:b0:9df:2fb1:1a83 with SMTP id dt8-20020a170907728800b009df2fb11a83mr116935ejc.39.1699402404913;
        Tue, 07 Nov 2023 16:13:24 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906644900b009b913aa7cdasm176602ejn.92.2023.11.07.16.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 16:13:24 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v9 06/12] drm/nouveau: make use of the GPUVM's shared dma-resv
Date:   Wed,  8 Nov 2023 01:12:36 +0100
Message-ID: <20231108001259.15123-7-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231108001259.15123-1-dakr@redhat.com>
References: <20231108001259.15123-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

