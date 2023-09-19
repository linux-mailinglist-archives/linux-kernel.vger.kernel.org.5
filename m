Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF447A6E40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjISWHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjISWHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64842133
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ukWm8E4MXrFEn8VGs9bEfemFfkQ4q8a0KKeIDWRajp4=;
        b=AOOxb6i7uTRb1JqplSAuyJMBBGHpvSvqE3Zzav1x+8R0fwjwMKwHR0h334aSKPejQraS0V
        JY9X8Bg7Ii7PPWBjbXprEn6IYwy3DYUiHHTazsAFmGLa3CSKdjOu3Kj3mvL2nKMAot4zOH
        VjpNomygZEapPgHSl6BcFiI/H3gl6Hc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-LEuT2XwlPAKP04Y5yWQd6Q-1; Tue, 19 Sep 2023 18:06:11 -0400
X-MC-Unique: LEuT2XwlPAKP04Y5yWQd6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95A573C0253E;
        Tue, 19 Sep 2023 22:06:10 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C231440C2064;
        Tue, 19 Sep 2023 22:06:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 21/44] drm/nouveau/disp: release outputs post-modeset
Date:   Tue, 19 Sep 2023 17:56:16 -0400
Message-ID: <20230919220442.202488-22-lyude@redhat.com>
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

Prior to this commit, KMS would call release() prior to modeset, and the
second supervisor interrupt would update SOR routing if needed.

Now, KMS will call release() post-modeset and update routing immediately.

- preparation for GSP-RM

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c        | 18 ++++++++----------
 .../gpu/drm/nouveau/nvkm/engine/disp/outp.c    |  1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/uoutp.c   |  2 ++
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index ab048cf25d866..50a0ff304291e 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -477,7 +477,6 @@ nv50_dac_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *st
 
 	core->func->dac->ctrl(core, nv_encoder->outp.or.id, ctrl, NULL);
 	nv_encoder->crtc = NULL;
-	nvif_outp_release(&nv_encoder->outp);
 }
 
 static void
@@ -1300,6 +1299,11 @@ nv50_mstm_cleanup(struct drm_atomic_state *state,
 		}
 	}
 
+	if (mstm->disabled) {
+		nvif_outp_release(&mstm->outp->outp);
+		mstm->disabled = false;
+	}
+
 	mstm->modified = false;
 }
 
@@ -1334,12 +1338,6 @@ nv50_mstm_prepare(struct drm_atomic_state *state,
 				nv50_msto_prepare(state, mst_state, &mstm->mgr, msto);
 		}
 	}
-
-	if (mstm->disabled) {
-		if (!mstm->links)
-			nvif_outp_release(&mstm->outp->outp);
-		mstm->disabled = false;
-	}
 }
 
 static struct drm_connector *
@@ -1582,7 +1580,6 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *st
 
 	nv_encoder->update(nv_encoder, nv_crtc->index, NULL, 0, 0);
 	nv50_audio_disable(encoder, nv_crtc);
-	nvif_outp_release(&nv_encoder->outp);
 	nv_encoder->crtc = NULL;
 }
 
@@ -1827,7 +1824,6 @@ nv50_pior_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *s
 
 	core->func->pior->ctrl(core, nv_encoder->outp.or.id, ctrl, NULL);
 	nv_encoder->crtc = NULL;
-	nvif_outp_release(&nv_encoder->outp);
 }
 
 static void
@@ -1990,8 +1986,10 @@ nv50_disp_atomic_commit_core(struct drm_atomic_state *state, u32 *interlock)
 						  nv_encoder->conn, NULL, NULL);
 				outp->enabled = outp->disabled = false;
 			} else {
-				if (outp->disabled)
+				if (outp->disabled) {
+					nvif_outp_release(&nv_encoder->outp);
 					outp->disabled = false;
+				}
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
index b288ea6658da6..20a013f1bbbac 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
@@ -238,6 +238,7 @@ void
 nvkm_outp_release(struct nvkm_outp *outp)
 {
 	nvkm_outp_release_or(outp, NVKM_OUTP_USER);
+	nvkm_outp_route(outp->disp);
 }
 
 void
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
index ffd174091454f..40cbb4ddc0378 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -188,6 +188,8 @@ nvkm_uoutp_mthd_release(struct nvkm_outp *outp, void *argv, u32 argc)
 
 	if (argc != sizeof(args->vn))
 		return -ENOSYS;
+	if (!outp->ior)
+		return -EINVAL;
 
 	nvkm_outp_release(outp);
 	return 0;
-- 
2.41.0

