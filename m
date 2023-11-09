Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D187E7029
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbjKIR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbjKIR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C4235BC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699550716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y0steN0/ACKFTtJOvpHMkiOMUe7bddz5OgwOILeHxPA=;
        b=LZutde8nifGetZOoGaJyDm42ry3qHT2mwHdnmjQtynnXKrvWeUHcvrFBL0jLk7R+gwaZuc
        /EJFpLVc6xE9g8aUNrNmPxyv706CICodU/WFtFmmdg2mh2UZ47th0TZcm4AqW72UhZN/nW
        /RrdSR02s5CMW3g91yZZ/XZDRR8z338=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-LzTXkVDwMW60EJV4my14Iw-1; Thu, 09 Nov 2023 12:25:14 -0500
X-MC-Unique: LzTXkVDwMW60EJV4my14Iw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5079c865541so1062148e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550712; x=1700155512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0steN0/ACKFTtJOvpHMkiOMUe7bddz5OgwOILeHxPA=;
        b=RZCBPlinFfAhcIzNRMxw/w2s/f3Ht1rPifcg61xsePvplRiFJNQt/tw8MOkJTmazRp
         hYrhuUWoVkOeuzb6e393kFzUc99AtjDW1bwKye4COULYl+ug4pDR454PTIZ28zxTO6FW
         81ARI3m8mQtaontKTvx8DfbKiH2R4a9OKAoHzHqLbGYNnR3a27tD5fQOd0+9HfvCiAgE
         yPTUVplW9twoCj53Tek+H49kF9SGbnjkzdnhq3pMq76AfUA8vkb279Zh25ht2tZL8NNl
         rtnotI/xyPuAX7anS/3IpS6NSoQQ0BboJZoD/z9hu1v6CbMn41NzHp2hZL9H6Ug/5ueE
         behA==
X-Gm-Message-State: AOJu0YxtCOptIksOwHAjAQFwpuJnQOVdpyTqV54vMscN3oddbsLpoAt7
        3yWfxqcvzADGaVx8TNYEqD/FIvNq+IsFoeaTRs6JDm5806erk1Zd76F33NkqHi6fZBL1k3tAtj0
        No45yFUbzHOENHaKq+CEgangdR1plV5z4EZxgCRWqO4bmK+kNw9fWl4KVGtS0LT2TVRLITAmga2
        W8H03cEMs=
X-Received: by 2002:a19:e007:0:b0:507:b935:9f5f with SMTP id x7-20020a19e007000000b00507b9359f5fmr1877882lfg.24.1699550712376;
        Thu, 09 Nov 2023 09:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENtuNNft+jXRPbq2qJhlZT81jWdLguxD1V9O4aFnQJMyc+8VWIMEbR49N4zRWK0Yg8oNcUMw==
X-Received: by 2002:a19:e007:0:b0:507:b935:9f5f with SMTP id x7-20020a19e007000000b00507b9359f5fmr1877857lfg.24.1699550712088;
        Thu, 09 Nov 2023 09:25:12 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f15-20020a056000128f00b00323293bd023sm135806wrx.6.2023.11.09.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:11 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Simon Ser <contact@emersion.fr>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        stable@vger.kernel.org,
        nerdopolis <bluescreen_avenger@verizon.net>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 3/6] drm/virtio: Use drm_atomic_helper_buffer_damage_merged() for buffer damage
Date:   Thu,  9 Nov 2023 18:24:37 +0100
Message-ID: <20231109172449.1599262-4-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109172449.1599262-1-javierm@redhat.com>
References: <20231109172449.1599262-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does per-buffer uploads. It needs to use the damage helper that
handles buffer damages, rather than the helper that handles frame damages.

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/virtio/virtgpu_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a000..1adfd9813cde 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -183,7 +183,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		return;
 	}
 
-	if (!drm_atomic_helper_damage_merged(old_state, plane->state, &rect))
+	if (!drm_atomic_helper_buffer_damage_merged(old_state, plane->state, &rect))
 		return;
 
 	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
-- 
2.41.0

