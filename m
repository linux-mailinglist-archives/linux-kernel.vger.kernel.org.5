Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91C7EC370
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbjKONQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343926AbjKONQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C091F189
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700054167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPNZAc6r0CSSO6lMN8bwDAougMdgFH11dwZvW1JyD1g=;
        b=UdAR/0iFW/NySxhyhm8uHp+xGalEE8pKj+ty8VpJGl3j3CLO52a+XpLb4gPW+oaiN8x96l
        iuLdPUBGKs7iDhceWMnzdvCZ10ohrPqO9nUx56MXuqG55ybcktEAbeSzwORozfp5sfb+FE
        vtXlzbOgsxbfFNrnmnny3VgcIHvMUvE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-5B9X58hIORykrwvdxA0t0Q-1; Wed, 15 Nov 2023 08:16:05 -0500
X-MC-Unique: 5B9X58hIORykrwvdxA0t0Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32f8cb825c5so3204285f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054163; x=1700658963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPNZAc6r0CSSO6lMN8bwDAougMdgFH11dwZvW1JyD1g=;
        b=WXbd/LYEzAegze9YJ8I8jGvnnvKTlS6HcJriqBP1djeQYS+5ccVjunua8FHqMSaZ3c
         1IpkPlyJ4qvkNS2FYwif2e2Iisq1WB4/Ol3n4/OMdWBwhDequoCWOQwg/UvOUKbiN7QH
         eeMqtsQntii2lfV4vfBU5Bo3ReJWcFWdQNXL45AHN2HXZtrPMhfU/KP4iY7rWfKoO4GR
         g/ZGfeUnxpye7gBm13g33nxvdRRQ7wnB6+bdNsZYht0IClTmAfWLXXkRtYv7uJnggHpm
         +D7adeq1CLGcVlbHt8wp8EB1tee5n6y1vGpRbWA/OtQ8m9tlatV7UZFvzISs6CrrccaS
         olKw==
X-Gm-Message-State: AOJu0YwQJdM6XxI3QusAwuVyy3PJq7txx2wiGQsv73sALDXPISdq8be+
        7pJNUBZFnmvFXQ3zZ1RrwEwgtk9tZQAdOGGszsLFUCPJXtuARdfmi+a9xTSJzj0jvHHlCQ2hcgX
        CZv6Uqrzw1yAJkKSAxx7fx8JloSYkc70Wo8MdiCpuCfmPa9z24aNrAKRe1cq2/h5DYpg0VJVAwE
        MEUOBzitA=
X-Received: by 2002:a5d:6b8f:0:b0:331:4e5e:d9e7 with SMTP id n15-20020a5d6b8f000000b003314e5ed9e7mr5201145wrx.34.1700054163387;
        Wed, 15 Nov 2023 05:16:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH90wwQXO1DSYdUi0fT0muUxSLgnxdRuPpEfFKAh1lwXIDvxopHNTDogbaEw6FCwpQCc2B74A==
X-Received: by 2002:a5d:6b8f:0:b0:331:4e5e:d9e7 with SMTP id n15-20020a5d6b8f000000b003314e5ed9e7mr5201118wrx.34.1700054163127;
        Wed, 15 Nov 2023 05:16:03 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d6341000000b00323293bd023sm10579306wrw.6.2023.11.15.05.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:16:02 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Erico Nunes <nunes.erico@gmail.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 5/5] drm/todo: Add entry about implementing buffer age for damage tracking
Date:   Wed, 15 Nov 2023 14:15:44 +0100
Message-ID: <20231115131549.2191589-6-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115131549.2191589-1-javierm@redhat.com>
References: <20231115131549.2191589-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
---

(no changes since v1)

 Documentation/gpu/todo.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index b62c7fa0c2bc..5c43a958814b 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -782,6 +782,26 @@ Contact: Hans de Goede
 
 Level: Advanced
 
+Buffer age or other damage accumulation algorithm for buffer damage handling
+============================================================================
+
+Drivers that do per-buffer uploads, need a buffer damage handling (rather than
+frame damage like drivers that do per-plane or per-CRTC uploads), but there is
+no support to get the buffer age or any other damage accumulation algorithm.
+
+For this reason, the damage helpers just fallback to a full plane update if the
+framebuffer attached to a plane has changed since the last page-flip.
+
+This should be improved to get damage tracking properly working on drivers that
+do per-buffer uploads.
+
+More information about damage tracking and references to learning materials in
+`Damage Tracking Properties <https://docs.kernel.org/gpu/drm-kms.html#damage-tracking-properties>`_
+
+Contact: Javier Martinez Canillas <javierm@redhat.com>
+
+Level: Advanced
+
 Outside DRM
 ===========
 
-- 
2.41.0

