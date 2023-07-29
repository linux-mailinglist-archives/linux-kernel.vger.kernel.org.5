Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B88767A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbjG2A4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjG2A4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:56:14 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4760E4B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:55:16 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so49331801fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690591757; x=1691196557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeTSuwZPlptjGhIuO9GsGe/aAqJgvkK628OoK+PRdAE=;
        b=VsttY5+SOr9fF9DKFAkD1fpnsZIU2pLzIzH48JAnNTF5WLWlpLyduf34wSQbvaNWAb
         q0T98HLRjion0v+Y7GwNdbH2nO50r6azAiH0r5Frq1ZaCCH8lItorpS6m2+vQR62eH9A
         yCcuwR3l9OiBfirFtuZ7x38cXj0lPnJHQNKLKigfGi84TTJgUD4g3GhZP3EK0oE51Ey5
         dYiVwpdI8VzxFLpdaBvu+EZApctr+dAKbxBXZzNoF5/W7MeqLK177oiDz4ESd7tEX8gi
         2Otd6PUFptJhMXbFJrehHaYdH0YZ4JJ8iqOxiPYAmbgnXuoHCYlwShe9sd7G0vTI7HkK
         PLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591757; x=1691196557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeTSuwZPlptjGhIuO9GsGe/aAqJgvkK628OoK+PRdAE=;
        b=L/TCQGxcppUh2evyxmK0XKE8Xo+IFhUmjELwv0xLHcdXBuAvqXWbsu8qqPVMS/F+3T
         5gKSRJEuaMvyxShZarvfQ2JX/VMc/2IOqG2ajmq8oKy91p82qZ48Lx5Qiw0gapXytOaJ
         O2isQfV09/HB+mw9F9LgPkZnl1uK64EJsRwnbKXYV3qLQm3CpGw8fMNKW1+zUAnVZZpt
         lWSetDCZywaeBn0By8WJPizSEdWUsfvfae8XRS0gMg0JZllq2SvR0sEx6XFPeDMgOBeX
         dQkQt6E5WCWURMX98z+hNU6hVhJ3WYbFMEKPZFaGiCR3PKegOUX9QE99hWPntWFZGtL2
         bXXQ==
X-Gm-Message-State: ABy/qLa+gV/oaMthAYUpt8O7YPpSvZrjvOY5Lajrxd+B1CyPKobCJJ62
        FlsYZH21lNYwM3AkMLZtM6iIRQ==
X-Google-Smtp-Source: APBJJlGnkBGsncWn163VGZiB6FNproqXBRlBWlgFqMTpY6qxbaEinFwvcwwZIU85m+UD+VdKOfxU6g==
X-Received: by 2002:a05:6512:2825:b0:4f8:6d9d:abe0 with SMTP id cf37-20020a056512282500b004f86d9dabe0mr1946529lfb.33.1690591756849;
        Fri, 28 Jul 2023 17:49:16 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a24-20020a19f818000000b004fe20d1b288sm500702lff.159.2023.07.28.17.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:49:16 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/uapi: document the USB subconnector type
Date:   Sat, 29 Jul 2023 03:49:12 +0300
Message-Id: <20230729004913.215872-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To properly define the USB-C DP altmode connectors, add the USB
subconnector type.

Suggested-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_connector.c | 1 +
 include/uapi/drm/drm_mode.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index a6066e4a5e9a..9e96b038f5d0 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1050,6 +1050,7 @@ static const struct drm_prop_enum_list drm_dp_subconnector_enum_list[] = {
 	{ DRM_MODE_SUBCONNECTOR_DisplayPort, "DP"        }, /* DP */
 	{ DRM_MODE_SUBCONNECTOR_Wireless,    "Wireless"  }, /* DP */
 	{ DRM_MODE_SUBCONNECTOR_Native,	     "Native"    }, /* DP */
+	{ DRM_MODE_SUBCONNECTOR_USB,	     "USB"       }, /* DP */
 };
 
 DRM_ENUM_NAME_FN(drm_get_dp_subconnector_name,
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 92d96a2b6763..0f74918b011c 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -398,6 +398,7 @@ enum drm_mode_subconnector {
 	DRM_MODE_SUBCONNECTOR_HDMIA       = 11, /*            DP */
 	DRM_MODE_SUBCONNECTOR_Native      = 15, /*            DP */
 	DRM_MODE_SUBCONNECTOR_Wireless    = 18, /*            DP */
+	DRM_MODE_SUBCONNECTOR_USB         = 20, /*            DP */
 };
 
 #define DRM_MODE_CONNECTOR_Unknown	0
-- 
2.39.2

