Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99A7A6E09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjISWF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjISWF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D80DC0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8u3cLqlQIYdOREW60hMS4Co9cQn7jWijgctfO2tY6gg=;
        b=EdZKeU/c+/QqiNkjzs4iuc2HqvfR0xlJphl1ld8HFj/SIt4Pk7IU8FfWZLBWIiVoXKAbSM
        Q8+apQkW6AC1maFx5rxW4IffGcV76i1RG55K5uzQnquusOSBVWN7+fnPMDvkstKaZ/GRUr
        GhjS8czwIfd+FeG9xNF//7ilpFBzblE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-692-OXCJCIifNvOpgWtW13gbng-1; Tue, 19 Sep 2023 18:05:09 -0400
X-MC-Unique: OXCJCIifNvOpgWtW13gbng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F8C73C02532;
        Tue, 19 Sep 2023 22:05:08 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5360240C2064;
        Tue, 19 Sep 2023 22:05:07 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 03/44] drm/nouveau/gr/gf100-: lose contents of global ctxbufs across suspend
Date:   Tue, 19 Sep 2023 17:55:58 -0400
Message-ID: <20230919220442.202488-4-lyude@redhat.com>
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

Some of these buffers are quite large, and there's no need to preserve
them across suspend.

Mark the contents as lost to speedup suspend/resume.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index 3648868bb9fc5..c494a1ff2d572 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -2032,18 +2032,18 @@ gf100_gr_oneinit(struct nvkm_gr *base)
 	}
 
 	/* Allocate global context buffers. */
-	ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, gr->func->grctx->pagepool_size,
-			      0x100, false, &gr->pagepool);
+	ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST_SR_LOST,
+			      gr->func->grctx->pagepool_size, 0x100, false, &gr->pagepool);
 	if (ret)
 		return ret;
 
-	ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, gr->func->grctx->bundle_size,
+	ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST_SR_LOST, gr->func->grctx->bundle_size,
 			      0x100, false, &gr->bundle_cb);
 	if (ret)
 		return ret;
 
-	ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, gr->func->grctx->attrib_cb_size(gr),
-			      0x1000, false, &gr->attrib_cb);
+	ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST_SR_LOST,
+			      gr->func->grctx->attrib_cb_size(gr), 0x1000, false, &gr->attrib_cb);
 	if (ret)
 		return ret;
 
-- 
2.41.0

