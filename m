Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32D67E702F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbjKIR0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbjKIR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5961F35BE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699550722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQsLMrBO0s8gsbhcurrkAKTlTUKc8bmHZW0Ex5lVbpk=;
        b=DMX+sItOYcOs2cnMjOd+jDBrke9M0RGB+HrRhlxbT7+7jJO56EtgSPoQsmTkxZGlTjATOU
        fEEcfi+Lf9JeWfVgxc7eLo2OClzUH9JDHfpJaL7iX5x7y8EFqUcXMNQVCBVe/XskL9WY+I
        MfvGhv0DNRtsZZDAukNfsZ49dYijGqs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-KgoYNOBQOmajo8gOq3HdxA-1; Thu, 09 Nov 2023 12:25:21 -0500
X-MC-Unique: KgoYNOBQOmajo8gOq3HdxA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f7cfab43eso568415f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550718; x=1700155518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQsLMrBO0s8gsbhcurrkAKTlTUKc8bmHZW0Ex5lVbpk=;
        b=o6uNIIPzwIPdrtwqwzztt9OLKbVZUAkww/dCcQVaZVBSwc+MD582EoaZu8Q8pbqWD9
         coaOMiY3grqBtBjEe1wiOLA11TAMxrCHxzTADb/JRRcN2gQ/Z6VUjjNfsUvu/QRfvQjs
         uUHdFKA1cC57QoztAGEB0s4R6PjE3dRYdlZ8PzH5EmflZTemPqnjS2VUNP+sgIP3UU1o
         idmz2s2Lb7y8trOUTCvxIgrrTNEu6viMLKE4gkqRljsAqBEEV+U3UGz/8YxyVHss3NVN
         bUcow1LNezdom88yDzGmSIZ/2F2cv5OrTgjJ7nAif18EDyd9wQgbplqBPjfs7IRz0pb2
         H3uQ==
X-Gm-Message-State: AOJu0YyelwCDyUzVesQmpLh7vraUE8LIXHb+tXyX8Dgbomp99AevqBUu
        pg5QO7Iz6A0YvR0Rz/kvAyxRS+/XvAsk4gT8D1Vvc+Dj+0TprjiA5ekJNHRIOYjRWTobjJCC1IM
        6BbyWXHO9enx6iCk4Q3SOXm6VhDcuGp7O65rYHcFdz5r0PPQqA1u/rUh95IYeIZixfelT5aCKSi
        biPPcf+nw=
X-Received: by 2002:a05:6000:1cb:b0:32f:7963:8493 with SMTP id t11-20020a05600001cb00b0032f79638493mr4461568wrx.37.1699550718246;
        Thu, 09 Nov 2023 09:25:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD/Ij413ZeKujXk6kJlWHHEPZiWIxqmSIPmvd4/ZL4FLHzk3PoQZkslp1/W1fbI9IJfywcfQ==
X-Received: by 2002:a05:6000:1cb:b0:32f:7963:8493 with SMTP id t11-20020a05600001cb00b0032f79638493mr4461536wrx.37.1699550717778;
        Thu, 09 Nov 2023 09:25:17 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d6e88000000b0032db430fb9bsm121425wrz.68.2023.11.09.09.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:17 -0800 (PST)
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
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: [PATCH 6/6] drm/todo: Add entry about implementing buffer age for damage tracking
Date:   Thu,  9 Nov 2023 18:24:40 +0100
Message-ID: <20231109172449.1599262-7-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109172449.1599262-1-javierm@redhat.com>
References: <20231109172449.1599262-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---

 Documentation/gpu/todo.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 03fe5d1247be..adaa154210a0 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -765,6 +765,26 @@ Contact: Hans de Goede
 
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

