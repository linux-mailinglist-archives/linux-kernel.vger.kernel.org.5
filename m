Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F1F794382
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbjIFTDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbjIFTCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:02:40 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB931B7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:02:35 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79545e141c7so3331939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694026954; x=1694631754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7euIhAUxsBgqAycWxnasjxETI8zYNC1RLZ3qD73WsM=;
        b=VhiYRzrqvKBxeIkXtmhdECvVB0SQgUHOBovReJrTXn7y+2+xZBhrSiZhW8RhRspuZH
         UqMcPXZTbo3wAaQSOFXfBG4Os+8QBiVbTwxqXxt4jZ6Bv3kzvGOweAQeoPZgcATEQM0L
         b0jwDtoqQU70Vo8h202GNayhYZKWO4HAQ2LsDEMkxMQoUQzdfXPzCRM3fK4Hgab1b2Yd
         VRsp1Xg6mkWvMykt1ygxU0D6V1hrimmXH0ZpkmmA8XktbD9yXT3ijtgHyAtLEC0c4uJJ
         RHBDmFBg25ViyzCwKOnwLXLePzm8VHnUZ8MiAA7aSr10uHAkeWzqjP4Q7bcrN/ZjLiUs
         /9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026954; x=1694631754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7euIhAUxsBgqAycWxnasjxETI8zYNC1RLZ3qD73WsM=;
        b=NGMgZX9oEcnrE3lUK/OvPKwYvUPG0yKoeQ3sHIEDUxm0mszztAQxS8cAe0V0+IpBLE
         TQIdFfhbYJVu2y1akPdyBjr+drgcu3XHlnXNvZ0uEgESshK1fcx6dUJ3KPSrN9I5jKO+
         jOo6zyA8qIImwjZFShnOB9Wnd8enKlpVZkeq7mCD7HLohGDG1fo7VPYFJrm+F/aaOlqM
         w+B+JBg/TmJLLkvJqOmNMB0SscYzUWH08lRgeN2asGHyKOKjS5/oCHWBgrpL5rkTTJRV
         neY5G8eVVfDFIv6QvDFu8fZ2ZhUGBogtEpQgiSqYPBQ8GMSprBZ9c9PxYBvvBnD0kEWK
         AGVw==
X-Gm-Message-State: AOJu0Ywlk9ZgvnPRjaWIjisNkwSXykNNMgGXBvTq/I8ZQqfjUP3LzO0I
        +axyY2us/d+i4dEgCbhsSnyucGu61vw89g==
X-Google-Smtp-Source: AGHT+IEerlB6JrUC+Z/0QRgCoRQoVs5aiPA8URhXDpxxGTJSTcPFuBIaCE9H+Uno/nfLK9zvHQVWkg==
X-Received: by 2002:a5e:a718:0:b0:794:c9a8:27eb with SMTP id b24-20020a5ea718000000b00794c9a827ebmr544496iod.5.1694026954382;
        Wed, 06 Sep 2023 12:02:34 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id w11-20020a5d844b000000b0076ffebfc9fasm5152306ior.47.2023.09.06.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:02:34 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH v3 4/5] drm/vc4: add trailing newlines to drm_dbg msgs
Date:   Wed,  6 Sep 2023 13:02:22 -0600
Message-ID: <20230906190224.583577-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906190224.583577-1-jim.cromie@gmail.com>
References: <20230906190224.583577-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By at least strong convention, a print-buffer's trailing newline says
"message complete, send it".  The exception (no TNL, followed by a call
to pr_cont) proves the general rule.

Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index bef9d45ef1df..959123759711 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -592,7 +592,7 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, old_state);
 	struct drm_device *dev = crtc->dev;
 
-	drm_dbg(dev, "Disabling CRTC %s (%u) connected to Encoder %s (%u)",
+	drm_dbg(dev, "Disabling CRTC %s (%u) connected to Encoder %s (%u)\n",
 		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
 
 	require_hvs_enabled(dev);
@@ -620,7 +620,7 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 	int idx;
 
-	drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)",
+	drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)\n",
 		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
 
 	if (!drm_dev_enter(dev, &idx))
-- 
2.41.0

