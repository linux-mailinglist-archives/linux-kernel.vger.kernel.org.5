Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2E87A6E37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjISWHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjISWGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A0DEA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txBkK1g64IFW2dm4mpw4nbcLbEYBgAGBSdwWC/i0adY=;
        b=a6VE9sbOWNX1fS+KWcOZxsgg6B90uVbXYbP5YbY9Hmm4afq1KoxyQKR5s7XAeVGJTrH5uX
        kDNEdMV3L94toX7iCcoA9nLE0WqJwwhYpaDTri9uAagYsAUUyjhysZXtcnNZFaMaXZR40H
        FVIfje7WoXrqr2z+Zbr7KxEFcNumHGI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-ulE4CPWPO5SikagALureFQ-1; Tue, 19 Sep 2023 18:05:55 -0400
X-MC-Unique: ulE4CPWPO5SikagALureFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A26F23822567;
        Tue, 19 Sep 2023 22:05:54 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 414DE40C2064;
        Tue, 19 Sep 2023 22:05:54 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 17/44] drm/nouveau/kms/nv50-: keep output state around until modeset complete
Date:   Tue, 19 Sep 2023 17:56:12 -0400
Message-ID: <20230919220442.202488-18-lyude@redhat.com>
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

- we'll want this info post-UPDATE for later patches

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index a72cb74184472..8fa3bb8c2f41e 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2080,7 +2080,7 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
 	nv50_crc_atomic_init_notifier_contexts(state);
 
 	/* Update output path(s). */
-	list_for_each_entry_safe(outp, outt, &atom->outp, head) {
+	list_for_each_entry(outp, &atom->outp, head) {
 		const struct drm_encoder_helper_funcs *help;
 		struct drm_encoder *encoder;
 
@@ -2094,9 +2094,6 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
 			help->atomic_enable(encoder, state);
 			interlock[NV50_DISP_INTERLOCK_CORE] = 1;
 		}
-
-		list_del(&outp->head);
-		kfree(outp);
 	}
 
 	/* Update head(s). */
@@ -2194,6 +2191,11 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
 	if (atom->lock_core)
 		mutex_unlock(&disp->mutex);
 
+	list_for_each_entry_safe(outp, outt, &atom->outp, head) {
+		list_del(&outp->head);
+		kfree(outp);
+	}
+
 	/* Wait for HW to signal completion. */
 	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
 		struct nv50_wndw_atom *asyw = nv50_wndw_atom(new_plane_state);
-- 
2.41.0

