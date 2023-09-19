Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C082C7A6E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjISWH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjISWHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7774E12D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5EB4cMc8vWcWVwJ/amQGwgf/CouzqS0AGMeVlmD153s=;
        b=JVtRYSYzYH5xe3uLO6mfU3W5H5qjWTRMfDDfyhMSWun4RY5TJMl1ImEWXByFC5yorbTSDP
        kTUvAf5NCd/0dV1I8pD0gRUA8fATTuBF/CMzQc72j6YODRB+V3pcTYkLdk914RD34z5mja
        eT5b0fBfhuv5iakxamGW//taSD52jZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-dZ7kl8r0NoC0QzAAMPCjWw-1; Tue, 19 Sep 2023 18:06:07 -0400
X-MC-Unique: dZ7kl8r0NoC0QzAAMPCjWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8CBB85A5BD;
        Tue, 19 Sep 2023 22:06:06 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 683F440C2064;
        Tue, 19 Sep 2023 22:06:06 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 20/44] drm/nouveau/disp: move hdmi disable out of release()
Date:   Tue, 19 Sep 2023 17:56:15 -0400
Message-ID: <20230919220442.202488-21-lyude@redhat.com>
In-Reply-To: <20230919220442.202488-1-lyude@redhat.com>
References: <20230919220442.202488-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

- release() is being moved post-modeset, preserve hdmi behaviour for now

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c          |  8 ++++++++
 drivers/gpu/drm/nouveau/nouveau_encoder.h        |  6 +++++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 15 +++++++--------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 7a7b3464a6671..ab048cf25d866 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -842,6 +842,8 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 		size = 0;
 
 	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, &args.infoframe, size);
+
+	nv_encoder->hdmi.enabled = true;
 }
 
 /******************************************************************************
@@ -1562,6 +1564,12 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *st
 	}
 #endif
 
+	if (nv_encoder->dcb->type == DCB_OUTPUT_TMDS && nv_encoder->hdmi.enabled) {
+		nvif_outp_hdmi(&nv_encoder->outp, nv_crtc->index,
+			       false, 0, 0, 0, false, false, false);
+		nv_encoder->hdmi.enabled = false;
+	}
+
 	if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
 		ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/nouveau/nouveau_encoder.h
index ea8ef10e71aae..b3a9415ba879c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
+++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
@@ -69,7 +69,11 @@ struct nouveau_encoder {
 
 	struct nv04_output_reg restore;
 
-	union {
+	struct {
+		struct {
+			bool enabled;
+		} hdmi;
+
 		struct {
 			struct nv50_mstm *mstm;
 			int link_nr;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
index 8ba96323e1de5..ffd174091454f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -154,6 +154,13 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void *argv, u32 argc)
 	    (args->v0.scdc && !ior->func->hdmi->scdc))
 		return -EINVAL;
 
+	if (!args->v0.enable) {
+		ior->func->hdmi->infoframe_avi(ior, args->v0.head, NULL, 0);
+		ior->func->hdmi->infoframe_vsi(ior, args->v0.head, NULL, 0);
+		ior->func->hdmi->ctrl(ior, args->v0.head, false, 0, 0);
+		return 0;
+	}
+
 	ior->func->hdmi->ctrl(ior, args->v0.head, args->v0.enable,
 			      args->v0.max_ac_packet, args->v0.rekey);
 	if (ior->func->hdmi->scdc)
@@ -177,19 +184,11 @@ nvkm_uoutp_mthd_acquire_lvds(struct nvkm_outp *outp, bool dual, bool bpc8)
 static int
 nvkm_uoutp_mthd_release(struct nvkm_outp *outp, void *argv, u32 argc)
 {
-	struct nvkm_head *head = outp->asy.head;
-	struct nvkm_ior *ior = outp->ior;
 	union nvif_outp_release_args *args = argv;
 
 	if (argc != sizeof(args->vn))
 		return -ENOSYS;
 
-	if (ior->func->hdmi && head) {
-		ior->func->hdmi->infoframe_avi(ior, head->id, NULL, 0);
-		ior->func->hdmi->infoframe_vsi(ior, head->id, NULL, 0);
-		ior->func->hdmi->ctrl(ior, head->id, false, 0, 0);
-	}
-
 	nvkm_outp_release(outp);
 	return 0;
 }
-- 
2.41.0

