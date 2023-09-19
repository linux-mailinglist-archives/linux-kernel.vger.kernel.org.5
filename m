Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949507A6E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjISWHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjISWHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4594DCE6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/MlFYOq/NSmxR/1uKfeYpusgfIpU4R7fczdhyvWYPnY=;
        b=QUcATbM/CTwCEWCJss3SMI52DfpMa3pgClAv+e17AXbaXu32UUmdSmBPLbr9/HaTorBOSC
        M2/zcXCGcS2+y9Gh3nX9jAexif201OMJJHFpqVqo+Rl6HJgEkggyJGxPtRdz5SGnjSwruw
        hLmagirv0Bau/Z+nsQP8qhaORjBODhI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-Lg_ndyiHNuukkxvrUTeaew-1; Tue, 19 Sep 2023 18:06:14 -0400
X-MC-Unique: Lg_ndyiHNuukkxvrUTeaew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F29093822565;
        Tue, 19 Sep 2023 22:06:13 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9158E40C2064;
        Tue, 19 Sep 2023 22:06:13 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        ruanjinjie <ruanjinjie@huawei.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 22/44] drm/nouveau/disp: remove SOR routing updates from supervisor
Date:   Tue, 19 Sep 2023 17:56:17 -0400
Message-ID: <20230919220442.202488-23-lyude@redhat.com>
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

- these shouldn't be necessary now, and are done in acquire()/release()
- preparation for GSP-RM, where we don't control the supervisor

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gf119.c | 1 -
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c | 1 -
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gf119.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gf119.c
index a48e9bdf4cd07..937baae6a3ebb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gf119.c
@@ -1038,7 +1038,6 @@ gf119_disp_super(struct work_struct *work)
 				continue;
 			nv50_disp_super_2_0(disp, head);
 		}
-		nvkm_outp_route(disp);
 		list_for_each_entry(head, &disp->heads, head) {
 			if (!(mask[head->id] & 0x00010000))
 				continue;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
index 4ebc030e40d12..7ac59bab6309f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
@@ -863,7 +863,6 @@ gv100_disp_super(struct work_struct *work)
 				continue;
 			nv50_disp_super_2_0(disp, head);
 		}
-		nvkm_outp_route(disp);
 		list_for_each_entry(head, &disp->heads, head) {
 			if (!(mask[head->id] & 0x00010000))
 				continue;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
index be81168029604..a4ce605177895 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
@@ -1371,7 +1371,6 @@ nv50_disp_super(struct work_struct *work)
 				continue;
 			nv50_disp_super_2_0(disp, head);
 		}
-		nvkm_outp_route(disp);
 		list_for_each_entry(head, &disp->heads, head) {
 			if (!(super & (0x00000200 << head->id)))
 				continue;
-- 
2.41.0

