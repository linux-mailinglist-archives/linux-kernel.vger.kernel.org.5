Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454C27D2BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjJWHrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjJWHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BEFD65
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698047207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlB5NNBc9uQkf+X7NN8+WEA3je5xbSkk2BMonKhyqZE=;
        b=KOHzmfE9dSbcOkonPW3HtBEuA34d1Dd/cb6nbzPgMXqmcWyLg1Vmo7MGFJyNu0Q6NoK2F4
        TJCNPULcyOcM1o6fAOhsDQ0puBUhaKjGqUdmMLvaJrconHbF+rBp2ZYL2hU6Iwe5Y/J5/d
        jRqgxFPCye/D+KFa+hDVsGCLsExGLgM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-5uhUS5UqP52zSmAzteZbEw-1; Mon, 23 Oct 2023 03:46:37 -0400
X-MC-Unique: 5uhUS5UqP52zSmAzteZbEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 038F180171C;
        Mon, 23 Oct 2023 07:46:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45EC6170EF;
        Mon, 23 Oct 2023 07:46:31 +0000 (UTC)
From:   Albert Esteve <aesteve@redhat.com>
To:     qemu-devel@nongnu.org
Cc:     zackr@vmware.com, contact@emersion.fr, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@gmail.com>, banackm@vmware.com,
        Rob Clark <robdclark@gmail.com>, javierm@redhat.com,
        krastevm@vmware.com, spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mombasawalam@vmware.com,
        Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v6 3/9] drm/vmwgfx: Use the hotspot properties from cursor planes
Date:   Mon, 23 Oct 2023 09:46:07 +0200
Message-ID: <20231023074613.41327-4-aesteve@redhat.com>
In-Reply-To: <20231023074613.41327-1-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zack Rusin <zackr@vmware.com>

Atomic modesetting got support for mouse hotspots via the hotspot
properties. Port the legacy kms hotspot handling to the new properties
on cursor planes.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Cc: Maaz Mombasawala <mombasawalam@vmware.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Martin Krastev <krastevm@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 818b7f109f538..bea0abc3d4188 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -768,13 +768,8 @@ vmw_du_cursor_plane_atomic_update(struct drm_plane *plane,
 	struct vmw_plane_state *old_vps = vmw_plane_state_to_vps(old_state);
 	s32 hotspot_x, hotspot_y;
 
-	hotspot_x = du->hotspot_x;
-	hotspot_y = du->hotspot_y;
-
-	if (new_state->fb) {
-		hotspot_x += new_state->fb->hot_x;
-		hotspot_y += new_state->fb->hot_y;
-	}
+	hotspot_x = du->hotspot_x + new_state->hotspot_x;
+	hotspot_y = du->hotspot_y + new_state->hotspot_y;
 
 	du->cursor_surface = vps->surf;
 	du->cursor_bo = vps->bo;
-- 
2.41.0

