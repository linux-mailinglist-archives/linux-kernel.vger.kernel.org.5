Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C67F68EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjKWWNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKWWN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:13:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1B110D0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700777611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MuULYoz5ao+rLNA+YbUecP2cAJXv6WyavKrHjMaHS4=;
        b=N5vrvuTS1sPYcdT+cCZ3vQHFtX0dE5FOp6XmnK6NUU41W25BSVQoU1NVsdJBmfflWqWCFX
        YFCJT/gRXsUO2HhFZ37r8Sf2ziqj3R7N5jka8wvzsq/sqlNLc5zughSY5lJwxx69V1qf+e
        C4sbbrJgjuz76GMxfnFzm36mBecU960=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Q5LmLyhONca7s1lakKbPhg-1; Thu, 23 Nov 2023 17:13:29 -0500
X-MC-Unique: Q5LmLyhONca7s1lakKbPhg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-332e41ed0b4so571516f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777607; x=1701382407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MuULYoz5ao+rLNA+YbUecP2cAJXv6WyavKrHjMaHS4=;
        b=g7HMCdelWokJfFWVeklyf6hFvoX2vgEzvaLTMy1g3/f2TKPXuCOePJeomGEkeBNfxU
         Si5h7MROka7+yp1Wq7yEkVCeynUNO4GtZqKmaNqse+XrGw7oPaxTv2b2EwuTi+PMYRP6
         IYDQF4UCXd4IJGSwbct0C0ycxpuiaW0a4KMYeFFST2AErzQQavN54DoZ7+dYmpTdIDAf
         JNIRvcSf8GMuSSly2Sh9jIgtgEZk26uC5svB95IOFKYFOOdu/VyrdZHnzJxmSA63Tk1h
         eYw87k+BGQkic48lPpwRe6+LWcwKN2ith9S4NaagE+hVY7zIgTa6TXkDn5Fin4/ElgsR
         A+uw==
X-Gm-Message-State: AOJu0Yx1uKLjuJEeS7H9A3Rdj9edNTxRfMypj8G3+jj40BuIwU4uaz6z
        o/cLIzF6UqAhp9+ACc6/vAZgi6vAKTDZ7PrmUaimKjLYBmhyrK/K5t2+o0JxwEikw/TPBTY2h4U
        NAMez+46GqAqZ1Wn7QiKexo+uwCOl310gzHdTCnx5wUuHCYncCF64AOp3lT0oH2cbKhLNKIFuVw
        Y66KyAVdE=
X-Received: by 2002:a5d:40c8:0:b0:332:e777:a8d4 with SMTP id b8-20020a5d40c8000000b00332e777a8d4mr565989wrq.36.1700777607690;
        Thu, 23 Nov 2023 14:13:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbblMAN+hzDoQaplfSW1Ls9XUsnDbl4YuadfKrIq6lj50fMHkQHToWy2rbRvbEJLq7TAFUoA==
X-Received: by 2002:a5d:40c8:0:b0:332:e777:a8d4 with SMTP id b8-20020a5d40c8000000b00332e777a8d4mr565964wrq.36.1700777607350;
        Thu, 23 Nov 2023 14:13:27 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b00332c6a52040sm2681153wrt.100.2023.11.23.14.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:13:27 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>, Zack Rusin <zackr@vmware.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Erico Nunes <nunes.erico@gmail.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 5/5] drm/todo: Add entry about implementing buffer age for damage tracking
Date:   Thu, 23 Nov 2023 23:13:04 +0100
Message-ID: <20231123221315.3579454-6-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123221315.3579454-1-javierm@redhat.com>
References: <20231123221315.3579454-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only damage tracking for frame damage is supported. If a driver
needs to do buffer damage (e.g: the framebuffer attached to plane's state
has changed since the last page-flip), the damage helpers just fallback to
a full plane update.

Add en entry in the TODO about implementing buffer age or any other damage
accumulation algorithm for buffer damage handling.

Suggested-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Simon Ser <contact@emersion.fr>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Acked-by: Sima Vetter <daniel.vetter@ffwll.ch>
---

Changes in v4:
- Reference the &drm_plane_state.ignore_damage_clips and the damage helpers
  in the buffer damage TODO entry (Sima Vetter).

 Documentation/gpu/todo.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index b62c7fa0c2bc..503d57c75215 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -782,6 +782,29 @@ Contact: Hans de Goede
 
 Level: Advanced
 
+Buffer age or other damage accumulation algorithm for buffer damage
+===================================================================
+
+Drivers that do per-buffer uploads, need a buffer damage handling (rather than
+frame damage like drivers that do per-plane or per-CRTC uploads), but there is
+no support to get the buffer age or any other damage accumulation algorithm.
+
+For this reason, the damage helpers just fallback to a full plane update if the
+framebuffer attached to a plane has changed since the last page-flip. Drivers
+set &drm_plane_state.ignore_damage_clips to true as indication to
+drm_atomic_helper_damage_iter_init() and drm_atomic_helper_damage_iter_next()
+helpers that the damage clips should be ignored.
+
+This should be improved to get damage tracking properly working on drivers that
+do per-buffer uploads.
+
+More information about damage tracking and references to learning materials can
+be found in :ref:`damage_tracking_properties`.
+
+Contact: Javier Martinez Canillas <javierm@redhat.com>
+
+Level: Advanced
+
 Outside DRM
 ===========
 
-- 
2.41.0

