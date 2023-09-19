Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F907A6E69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjISWJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjISWJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9C51998
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7PaP71eH6VCgE4PDxsdmAcLxjFzbczIBit0VWWdGJc=;
        b=Ncj11yVVheP+NQ39A2xf/xd0qjR0Khx867VVwxh61bD0PB+UPjg3YU4Vb1fN26cYRV0p/N
        88dEr+FQ69KUOkEnqvTqiGXKyIbWqPpRI6Ab/gscVuxgL/u2VoVEaVVcTsHFmEXk5LAjxf
        hjmm+hlVJFOEmTxeZm4ELB3cVBlciLI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-1jZhupujPPycyZqrfQ7ZHQ-1; Tue, 19 Sep 2023 18:07:02 -0400
X-MC-Unique: 1jZhupujPPycyZqrfQ7ZHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 084B1382256A;
        Tue, 19 Sep 2023 22:07:02 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B08840C2064;
        Tue, 19 Sep 2023 22:07:01 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 30/44] drm/nouveau/kms/nv50-: flush mst disables together
Date:   Tue, 19 Sep 2023 17:56:25 -0400
Message-ID: <20230919220442.202488-31-lyude@redhat.com>
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

- fixes some issues tearing down modes on tiled displays

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 +----------
 drivers/gpu/drm/nouveau/dispnv50/disp.h |  1 -
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 48e099ed7d51c..1fcd1b36a2751 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2084,13 +2084,6 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
 			help->atomic_disable(encoder, state);
 			outp->disabled = true;
 			interlock[NV50_DISP_INTERLOCK_CORE] |= 1;
-			if (outp->flush_disable) {
-				nv50_disp_atomic_commit_wndw(state, interlock);
-				nv50_disp_atomic_commit_core(state, interlock);
-				memset(interlock, 0x00, sizeof(interlock));
-
-				flushed = true;
-			}
 		}
 	}
 
@@ -2376,10 +2369,8 @@ nv50_disp_outp_atomic_check_clr(struct nv50_atom *atom,
 			return PTR_ERR(outp);
 
 		if (outp->encoder->encoder_type == DRM_MODE_ENCODER_DPMST ||
-		    nouveau_encoder(outp->encoder)->dcb->type == DCB_OUTPUT_DP) {
-			outp->flush_disable = true;
+		    nouveau_encoder(outp->encoder)->dcb->type == DCB_OUTPUT_DP)
 			atom->flush_disable = true;
-		}
 		outp->clr.ctrl = true;
 		atom->lock_core = true;
 	}
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.h b/drivers/gpu/drm/nouveau/dispnv50/disp.h
index 42209f5b06f91..1e5601223c753 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.h
@@ -83,7 +83,6 @@ struct nv50_outp_atom {
 	struct list_head head;
 
 	struct drm_encoder *encoder;
-	bool flush_disable;
 
 	bool disabled;
 	bool enabled;
-- 
2.41.0

