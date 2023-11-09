Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEF07E7023
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344552AbjKIR0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344550AbjKIR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D2835BD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699550718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7sDHSqMuo7yUORgn5WByoTm7yhsDzWS7QFyd4p9GXpM=;
        b=gWvE5NG129QJ6Oit0WT325wdq/TCrLsRFmtdEYG5nG568XM5h4FHAo5PQ4Dl7NsUMZZjha
        t3WdnG+haBmQpW6gVQgNs6E2SMUjy0g+pHhinraY8bP6oldZsYi8WFZfAESt30pbgKaIaH
        /XF7zX25ZTe4WmvGK0Mz0f/akXv5Ryw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-yIkP4aZEMuGzMNw-xdDCAg-1; Thu, 09 Nov 2023 12:25:16 -0500
X-MC-Unique: yIkP4aZEMuGzMNw-xdDCAg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507d2e150c2so1103390e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550714; x=1700155514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sDHSqMuo7yUORgn5WByoTm7yhsDzWS7QFyd4p9GXpM=;
        b=rAYrrF803IHYRk9HJmkmvM5Q5mGyWAom1IwrUrd8WL+wRRzsBPjelrQWnLOKdwZZmo
         BH1rFywNSpzOZc5J/kURICwBJQVtvvTParg4dKBEQWehpK0VkgsWNZtKGU+s7j/hRNsN
         whThczLRhH5+C6ZLvb1eFQN1kCcHUZf48eOWwODTwmZXi1UFruTmC6izmpOjJUs/hHUG
         ykNSOurLASBVXXibNZkh0Bkvfd6o7LwRBbq1lDkAh6VF88EwqwWS1/AtxymE3t5T7pQP
         RwnHWxcLOENBoPZVR8AJhwVGYzoIXzBdxs0OMPaL3sJg6ZmhCsFCnKrXYFlZ7oFPDnZh
         vpUQ==
X-Gm-Message-State: AOJu0YwSxNeJsf+9TIDKQjhxdNqsXNUDqm6F8zBnhhEvoXYkKBb6QXR+
        qxICub6y/VdesJ0tkEWxGblnAI0QHAl0RdufOXvrPtPA39w4y8xPR3fogW/fvLN0OcrDTrf2tzE
        vkv1l0/7pkPh2vTACKQ42A14io0exrDdilnhYaQQvrWxC1Yo23KxkApdPodMEmp80EO1TWrMnZ0
        lqkl8GzIQ=
X-Received: by 2002:ac2:5e9e:0:b0:507:a6a5:a87b with SMTP id b30-20020ac25e9e000000b00507a6a5a87bmr1916881lfq.51.1699550714324;
        Thu, 09 Nov 2023 09:25:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJVNz0Dz1HSXbQ0UB49yuozjenPpk3U6wkuD6qjSBnU9rrxSOmkfygjO1wSFqzgZsRaJXpyw==
X-Received: by 2002:ac2:5e9e:0:b0:507:a6a5:a87b with SMTP id b30-20020ac25e9e000000b00507a6a5a87bmr1916854lfq.51.1699550714038;
        Thu, 09 Nov 2023 09:25:14 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c1-20020adfed81000000b0032fab28e9c9sm119847wro.73.2023.11.09.09.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:13 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Simon Ser <contact@emersion.fr>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH 4/6] drm/vmwgfx: Use drm_atomic_helper_buffer_damage_iter_init() for buffer damage
Date:   Thu,  9 Nov 2023 18:24:38 +0100
Message-ID: <20231109172449.1599262-5-javierm@redhat.com>
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

Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 1489ad73c103..91cda125784e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -2912,7 +2912,7 @@ int vmw_du_helper_plane_update(struct vmw_du_update_plane *update)
 	 * Iterate in advance to check if really need plane update and find the
 	 * number of clips that actually are in plane src for fifo allocation.
 	 */
-	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
+	drm_atomic_helper_buffer_damage_iter_init(&iter, old_state, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-- 
2.41.0

