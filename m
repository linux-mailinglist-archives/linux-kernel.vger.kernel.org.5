Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176B7D2BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjJWHsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjJWHrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F898D7A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698047218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pm5AJQT4ZR4lNVtsmA024I9/ZkwIPN6rBQ2nDY0rX4w=;
        b=NMYUIO/vj/m8BD3Ii7TzSaBnXY7ZmlSqvQXGA5ja5UtxASbuilsAodjn5DL10CKfj0l7gQ
        8s4SioAuEwicNh/ThBLp9/STiZde7/GzNiEAnD38okiLXH56e1sR2b7BflI2sHXz5btG25
        h308EwDyldHIFgozNVQZWWGbPycof18=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-wvTWb6zpPVOeM-FEuSC8Pw-1; Mon,
 23 Oct 2023 03:46:52 -0400
X-MC-Unique: wvTWb6zpPVOeM-FEuSC8Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EEB91C06E26;
        Mon, 23 Oct 2023 07:46:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5282C503B;
        Mon, 23 Oct 2023 07:46:46 +0000 (UTC)
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
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v6 6/9] drm/virtio: Use the hotspot properties from cursor planes
Date:   Mon, 23 Oct 2023 09:46:10 +0200
Message-ID: <20231023074613.41327-7-aesteve@redhat.com>
In-Reply-To: <20231023074613.41327-1-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: virtualization@lists.linux-foundation.org
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a0004..20de599658c1f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -323,16 +323,16 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		DRM_DEBUG("update, handle %d, pos +%d+%d, hot %d,%d\n", handle,
 			  plane->state->crtc_x,
 			  plane->state->crtc_y,
-			  plane->state->fb ? plane->state->fb->hot_x : 0,
-			  plane->state->fb ? plane->state->fb->hot_y : 0);
+			  plane->state->hotspot_x,
+			  plane->state->hotspot_y);
 		output->cursor.hdr.type =
 			cpu_to_le32(VIRTIO_GPU_CMD_UPDATE_CURSOR);
 		output->cursor.resource_id = cpu_to_le32(handle);
 		if (plane->state->fb) {
 			output->cursor.hot_x =
-				cpu_to_le32(plane->state->fb->hot_x);
+				cpu_to_le32(plane->state->hotspot_x);
 			output->cursor.hot_y =
-				cpu_to_le32(plane->state->fb->hot_y);
+				cpu_to_le32(plane->state->hotspot_y);
 		} else {
 			output->cursor.hot_x = cpu_to_le32(0);
 			output->cursor.hot_y = cpu_to_le32(0);
-- 
2.41.0

