Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB407D195A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjJTWyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFD8D68
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697842443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qFRLhmS2CQCqNG3Gndm1rIdWDDyvH+OTofhMbIHOAf0=;
        b=QAfKHyDrAfN7Y5Qccy+DYy707PCW6ZuGHWAb9FQ9gVPFGTl3kaonhmsfi6uUvUykrLW6s9
        S3Dnaf1e+bdTHHTtA1SyntMoDBbMcM4T4GqeJvRf3QbuHMcQ/+/cWguV6uAxjX5V99ElCz
        kdKfjJnlLbRLKVjepnk8mC57AEbwyEY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-Dp0jy4rKMSiZ67rfzU6qWw-1; Fri, 20 Oct 2023 18:54:02 -0400
X-MC-Unique: Dp0jy4rKMSiZ67rfzU6qWw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40768556444so7821885e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697842440; x=1698447240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFRLhmS2CQCqNG3Gndm1rIdWDDyvH+OTofhMbIHOAf0=;
        b=FEyMfjRth98es+CzSpvwKEfwPZUuFFrcHvT0yHFpDTEAMILa++dSYhuDr0rfunAB0j
         H7YRgoTp+tYibU4aS59XSMnbJzOB+dG6YWQVGqalgYxB7Z4CrJttJgRc/h6hRmjqWm7T
         8i338UNFnzZEskAJIOGH0fMY6/rzNlVTWBdplM+/YKytG/sAahVdTMqNun5WO+EFbMIi
         vLdl59d3pbkbsU+OZ5OMDOzKomjoPg4qdlmXwr/dIdsRroikrD0MDLh4bAoGEc9uJcoU
         Q425vFEm5NIvt5T+OYBidbGJfZkJpnO+8CW1ZMkp3gFBVNQ/3dMMxHltj0YYohGQpjGY
         bdag==
X-Gm-Message-State: AOJu0YyJiVLZETFwNuSgODBuxIBgEB3bS8oSOiPC2Gft6wzBJ5+5ydK4
        Z/RRNo9DeUeMioJ/R8EcpKzU4Q6csxFPk/GwpZkNh8so38fKVagIm7TICQDwmmBobrUsfX4lm1u
        ycfp/1sRC10Xph7NNmTtgTkqNmK4ED3FZ3bbPt6jkKS+1kcgzRNR5JJwG8qNlVcds85a5mxd6HQ
        c0zRWoJwI=
X-Received: by 2002:a5d:58ea:0:b0:32d:819d:ec75 with SMTP id f10-20020a5d58ea000000b0032d819dec75mr2386189wrd.60.1697842440557;
        Fri, 20 Oct 2023 15:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEokgbV7EOSbvHnFRW97a9AjS0odPg33+dhDQZB4Y/IUzZKrmGCj6yiNFw5I1rWq8uRWtpElQ==
X-Received: by 2002:a5d:58ea:0:b0:32d:819d:ec75 with SMTP id f10-20020a5d58ea000000b0032d819dec75mr2386176wrd.60.1697842440162;
        Fri, 20 Oct 2023 15:54:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d5510000000b0032d2489a399sm2530010wrv.49.2023.10.20.15.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 15:53:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Fix possible uninitialized usage of crtc_state variable
Date:   Sat, 21 Oct 2023 00:52:57 +0200
Message-ID: <20231020225338.1686974-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a possible uninitialized use of the crtc_state variable in function
ssd132x_primary_plane_atomic_check() and avoid the following Smatch warn:

    drivers/gpu/drm/solomon/ssd130x.c:921 ssd132x_primary_plane_atomic_check()
    error: uninitialized symbol 'crtc_state'.

Fixes: fdd591e00a9c ("drm/ssd130x: Add support for the SSD132x OLED controller family")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/dri-devel/7dd6ca45-8263-44fe-a318-2fd9d761425d@moroto.mountain/
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 32f0857aec9f..e0174f82e353 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -910,7 +910,7 @@ static int ssd132x_primary_plane_atomic_check(struct drm_plane *plane,
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane_state);
 	struct drm_crtc *crtc = plane_state->crtc;
-	struct drm_crtc_state *crtc_state;
+	struct drm_crtc_state *crtc_state = NULL;
 	const struct drm_format_info *fi;
 	unsigned int pitch;
 	int ret;
-- 
2.41.0

