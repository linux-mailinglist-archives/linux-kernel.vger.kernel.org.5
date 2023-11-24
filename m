Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC17F7044
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345387AbjKXJnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjKXJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:42:59 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EDF1736
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:42:59 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54b0073d50fso313665a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1700818978; x=1701423778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=to4wr7o29hJLCsI5wEPXc4ZsMUCJc0r7+FdlNSU99fk=;
        b=UseAgOlNzJodxgpj/GiK12Bwh0jhIQpLUqoWG19Muv2gUdwDw016gFKnHq2GcAEXhC
         7AoG9Phft6oVLHz2O+vroiZvuHEaoQNrQ7jLKa8mh3EELIJrv+sck5PxuO5A9tF85JkS
         1Q3wRBf2GZJt02eEUQ1yVK824vjZQ84+5TH18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818978; x=1701423778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=to4wr7o29hJLCsI5wEPXc4ZsMUCJc0r7+FdlNSU99fk=;
        b=oxrqIldlSx+xwDYcfudr0imFLhX4K612ZDxVubGTq+agTkHHEfWnnV/KVF4/roXNdF
         b/O6lPd/Uybcv63ZPprlxQTAJrlX5p3d7jl58HWxIv6uyA9pFPnx+xAkRKNIz/cUY/YD
         3CYnqdp+xaqw8Xz5gj8+q2GcJog/JNEIkQsxFqnc1UPp2G7bobWm/yLNTIAbKk2FZirG
         9JqTBqEyJm5R/21RnWZsN7tih5oa2Cs6v0ZxbXViycC1B2s1v1Qb5NuHAieMzw35DDWZ
         Dgw2wkXLeqPAkd4j+5Fjnnrz0i0zOcBiPanpDlYA42+mkD6w2kDIDcDioOttGhLDGJ+w
         SXVA==
X-Gm-Message-State: AOJu0YwNvDkGrU3YsxmEO0E9iUEhyt7z8Z3X8I02oxrllYIuYXdOYkXt
        /ucqMc2S76HhbRrpsG2AmBz0jtGUo9KNAF1127dvqA==
X-Google-Smtp-Source: AGHT+IH3EXSz81Q3iGLUIaX7f+Td5N1csaSiswyO7wzlBhBwY/rrd8Kphlgy1/Xz60elHfn9o/VmOQ==
X-Received: by 2002:a17:906:2707:b0:a04:c9c4:8fc with SMTP id z7-20020a170906270700b00a04c9c408fcmr1544976ejc.18.1700818978131;
        Fri, 24 Nov 2023 01:42:58 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:7c18:b9c9:f303:f6bb])
        by smtp.gmail.com with ESMTPSA id h4-20020a170906398400b009fd541851f4sm1847685eje.198.2023.11.24.01.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:42:57 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: Fix typo in post_disable() description
Date:   Fri, 24 Nov 2023 10:42:30 +0100
Message-ID: <20231124094253.658064-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/singals/signals/

Fixes: 199e4e967af4 ("drm: Extract drm_bridge.h")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 include/drm/drm_bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index cfb7dcdb66c4..9ef461aa9b9e 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -194,7 +194,7 @@ struct drm_bridge_funcs {
 	 * or &drm_encoder_helper_funcs.dpms hook.
 	 *
 	 * The bridge must assume that the display pipe (i.e. clocks and timing
-	 * singals) feeding it is no longer running when this callback is
+	 * signals) feeding it is no longer running when this callback is
 	 * called.
 	 *
 	 * The @post_disable callback is optional.
-- 
2.42.0

