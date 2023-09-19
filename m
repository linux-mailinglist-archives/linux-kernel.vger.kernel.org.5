Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620B17A6E68
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjISWJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjISWJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A111B8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFieiXbaBTjfuTiZca2mPcFhbLUov1B8cBzL+moIOfI=;
        b=iFcI0/6Tua2P36uJK6EORI6/m+qQCQvmYfBIxhn41AbAyCeLW1d3UATjJzfOJhA1lAH72O
        sVbSMIJaMyxqZ029+200a5+jJPBt0xrM8//cso040nL1cHk+w1RYVA6KO99hJaKDuWRsVs
        42BZzWgck2+gPIi6hz83amA2h/8E25Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-u6ZPMQjhPmGjAgPc6Tpi0Q-1; Tue, 19 Sep 2023 18:07:36 -0400
X-MC-Unique: u6ZPMQjhPmGjAgPc6Tpi0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69C32800883;
        Tue, 19 Sep 2023 22:07:36 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0920A40C2064;
        Tue, 19 Sep 2023 22:07:36 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 40/44] drm/nouveau/kms/nv50-: create heads after outps/conns
Date:   Tue, 19 Sep 2023 17:56:35 -0400
Message-ID: <20230919220442.202488-41-lyude@redhat.com>
In-Reply-To: <20230919220442.202488-1-lyude@redhat.com>
References: <20230919220442.202488-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

- output info will be used later to determine MST support

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 64 ++++++++++++-------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 2134502ec04e2..26d59346703e3 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2774,38 +2774,6 @@ nv50_display_create(struct drm_device *dev)
 		dev->mode_config.cursor_height = 64;
 	}
 
-	/* create crtc objects to represent the hw heads */
-	for_each_set_bit(i, &disp->disp->head_mask, sizeof(disp->disp->head_mask) * 8) {
-		struct nv50_head *head;
-
-		head = nv50_head_create(dev, i);
-		if (IS_ERR(head)) {
-			ret = PTR_ERR(head);
-			goto out;
-		}
-
-		if (has_mst) {
-			head->msto = nv50_msto_new(dev, head, i);
-			if (IS_ERR(head->msto)) {
-				ret = PTR_ERR(head->msto);
-				head->msto = NULL;
-				goto out;
-			}
-
-			/*
-			 * FIXME: This is a hack to workaround the following
-			 * issues:
-			 *
-			 * https://gitlab.gnome.org/GNOME/mutter/issues/759
-			 * https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
-			 *
-			 * Once these issues are closed, this should be
-			 * removed
-			 */
-			head->msto->encoder.possible_crtcs = disp->disp->head_mask;
-		}
-	}
-
 	/* create encoder/connector objects based on VBIOS DCB table */
 	for (i = 0, dcbe = &dcb->entry[0]; i < dcb->entries; i++, dcbe++) {
 		struct nouveau_encoder *outp;
@@ -2868,6 +2836,38 @@ nv50_display_create(struct drm_device *dev)
 		connector->funcs->destroy(connector);
 	}
 
+	/* create crtc objects to represent the hw heads */
+	for_each_set_bit(i, &disp->disp->head_mask, sizeof(disp->disp->head_mask) * 8) {
+		struct nv50_head *head;
+
+		head = nv50_head_create(dev, i);
+		if (IS_ERR(head)) {
+			ret = PTR_ERR(head);
+			goto out;
+		}
+
+		if (has_mst) {
+			head->msto = nv50_msto_new(dev, head, i);
+			if (IS_ERR(head->msto)) {
+				ret = PTR_ERR(head->msto);
+				head->msto = NULL;
+				goto out;
+			}
+
+			/*
+			 * FIXME: This is a hack to workaround the following
+			 * issues:
+			 *
+			 * https://gitlab.gnome.org/GNOME/mutter/issues/759
+			 * https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
+			 *
+			 * Once these issues are closed, this should be
+			 * removed
+			 */
+			head->msto->encoder.possible_crtcs = disp->disp->head_mask;
+		}
+	}
+
 	/* Disable vblank irqs aggressively for power-saving, safe on nv50+ */
 	dev->vblank_disable_immediate = true;
 
-- 
2.41.0

