Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28187A6E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjISWGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjISWGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E50BF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlndQIDvmQNNiDBOWM0TZkkOp47C0AT0vhY18+2aUjE=;
        b=gGQHBt2+r9ZQJ2VQosievbHHAnRjL07HU6ak9g9rwUx55OSFdOBUtKqEVW37hWgwlcRvWv
        BXfpB4lfxp4jqRetm1Uzgsr/FZuRq+WcNT5195/XOLnC6KSTwHsI1mRzYVzrjsyY7u+n2J
        5vGrmt/eWM4UMxNE5l6BQTjjTDt+G9Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-22c3P2eXNY-K10RoW_-XLg-1; Tue, 19 Sep 2023 18:05:08 -0400
X-MC-Unique: 22c3P2eXNY-K10RoW_-XLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 804A73822565;
        Tue, 19 Sep 2023 22:05:06 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02E1940C2064;
        Tue, 19 Sep 2023 22:05:05 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH v3 02/44] drm/nouveau/imem: support allocations not preserved across suspend
Date:   Tue, 19 Sep 2023 17:55:57 -0400
Message-ID: <20230919220442.202488-3-lyude@redhat.com>
In-Reply-To: <20230919220442.202488-1-lyude@redhat.com>
References: <20230919220442.202488-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

Will initially be used to tag some large grctx allocations which don't
need to be saved, to speedup suspend/resume.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../drm/nouveau/include/nvkm/core/memory.h    |  1 +
 .../drm/nouveau/include/nvkm/subdev/instmem.h |  2 +-
 drivers/gpu/drm/nouveau/nvkm/core/memory.c    | 15 +++++++++++++--
 .../drm/nouveau/nvkm/subdev/instmem/base.c    | 19 ++++++++++++++-----
 .../drm/nouveau/nvkm/subdev/instmem/priv.h    |  1 +
 5 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/memory.h b/drivers/gpu/drm/nouveau/include/nvkm/core/memory.h
index d3b6a68ddda36..fc0f389813916 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/memory.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/memory.h
@@ -12,6 +12,7 @@ struct nvkm_tags {
 };
 
 enum nvkm_memory_target {
+	NVKM_MEM_TARGET_INST_SR_LOST, /* instance memory - not preserved across suspend */
 	NVKM_MEM_TARGET_INST, /* instance memory */
 	NVKM_MEM_TARGET_VRAM, /* video memory */
 	NVKM_MEM_TARGET_HOST, /* coherent system memory */
diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/instmem.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/instmem.h
index fcdaefc99fe85..92a36ddfc29ff 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/instmem.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/instmem.h
@@ -26,7 +26,7 @@ struct nvkm_instmem {
 
 u32 nvkm_instmem_rd32(struct nvkm_instmem *, u32 addr);
 void nvkm_instmem_wr32(struct nvkm_instmem *, u32 addr, u32 data);
-int nvkm_instobj_new(struct nvkm_instmem *, u32 size, u32 align, bool zero,
+int nvkm_instobj_new(struct nvkm_instmem *, u32 size, u32 align, bool zero, bool preserve,
 		     struct nvkm_memory **);
 int nvkm_instobj_wrap(struct nvkm_device *, struct nvkm_memory *, struct nvkm_memory **);
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/core/memory.c b/drivers/gpu/drm/nouveau/nvkm/core/memory.c
index c69daac9bac7b..a705c2dfca809 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/memory.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/memory.c
@@ -140,12 +140,23 @@ nvkm_memory_new(struct nvkm_device *device, enum nvkm_memory_target target,
 {
 	struct nvkm_instmem *imem = device->imem;
 	struct nvkm_memory *memory;
+	bool preserve = true;
 	int ret;
 
-	if (unlikely(target != NVKM_MEM_TARGET_INST || !imem))
+	if (unlikely(!imem))
 		return -ENOSYS;
 
-	ret = nvkm_instobj_new(imem, size, align, zero, &memory);
+	switch (target) {
+	case NVKM_MEM_TARGET_INST_SR_LOST:
+		preserve = false;
+		break;
+	case NVKM_MEM_TARGET_INST:
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	ret = nvkm_instobj_new(imem, size, align, zero, preserve, &memory);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/base.c
index e0e4f97be0294..24886eabe8dc3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/base.c
@@ -94,15 +94,21 @@ nvkm_instobj_wrap(struct nvkm_device *device,
 		  struct nvkm_memory *memory, struct nvkm_memory **pmemory)
 {
 	struct nvkm_instmem *imem = device->imem;
+	int ret;
 
 	if (!imem->func->memory_wrap)
 		return -ENOSYS;
 
-	return imem->func->memory_wrap(imem, memory, pmemory);
+	ret = imem->func->memory_wrap(imem, memory, pmemory);
+	if (ret)
+		return ret;
+
+	container_of(*pmemory, struct nvkm_instobj, memory)->preserve = true;
+	return 0;
 }
 
 int
-nvkm_instobj_new(struct nvkm_instmem *imem, u32 size, u32 align, bool zero,
+nvkm_instobj_new(struct nvkm_instmem *imem, u32 size, u32 align, bool zero, bool preserve,
 		 struct nvkm_memory **pmemory)
 {
 	struct nvkm_subdev *subdev = &imem->subdev;
@@ -130,6 +136,7 @@ nvkm_instobj_new(struct nvkm_instmem *imem, u32 size, u32 align, bool zero,
 		nvkm_done(memory);
 	}
 
+	container_of(memory, struct nvkm_instobj, memory)->preserve = preserve;
 done:
 	if (ret)
 		nvkm_memory_unref(&memory);
@@ -176,9 +183,11 @@ nvkm_instmem_fini(struct nvkm_subdev *subdev, bool suspend)
 
 	if (suspend) {
 		list_for_each_entry(iobj, &imem->list, head) {
-			int ret = nvkm_instobj_save(iobj);
-			if (ret)
-				return ret;
+			if (iobj->preserve) {
+				int ret = nvkm_instobj_save(iobj);
+				if (ret)
+					return ret;
+			}
 		}
 
 		nvkm_bar_bar2_fini(subdev->device);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h
index fe92986a38858..390ca00ab5678 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h
@@ -25,6 +25,7 @@ void nvkm_instmem_boot(struct nvkm_instmem *);
 struct nvkm_instobj {
 	struct nvkm_memory memory;
 	struct list_head head;
+	bool preserve;
 	u32 *suspend;
 };
 
-- 
2.41.0

