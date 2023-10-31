Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F3A7DD93E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347384AbjJaXXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjJaXXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:23:12 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0408C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:23:09 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id 6a1803df08f44-67540aa0f5bso5503806d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698794589; x=1699399389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw2B6vE9G+G7w2w874BluWAOKQISQdBMx0gd2n/sE7M=;
        b=BW2mFTuv9jDc9OJMZjLLQAknYgReepwrgGsbY8uK98i89x/HVhTTkmQA0pdMa4TbKr
         /7OD2bos/IzXxe2zvUQ98g4L3lymefDPSQxvp/fe5T5aMFBrKBE61HC3ys9N4j2mXzDO
         A5IkVcAvl/G927jFfP/GYPYrKfvXTaOOD1+zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698794589; x=1699399389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sw2B6vE9G+G7w2w874BluWAOKQISQdBMx0gd2n/sE7M=;
        b=xAW4Y/Iek6FovdM6uxQoRQ/MhAYQMMnVszcrS4xXNeFB95wQlMVkXn0I7v9EmWK2uO
         ZRxk9CKaaN9+uT6+iw69rt7/Ve76mBPA9D9gZn3opVS+GgO/TJ4oFaoGPJIqKHtbK/fA
         RDUY2voAL3dGvB9fgIEoKXmqn5mHRvRcR7C4G3O6Dt34jHjmosQxLg7PxsTo1EUbOj+B
         n3TDQp7709MW5LDapaDd87/QZn4Wh8RC2SIHN2Z8MBucs3JEA4odbZrdoG63nkEkmV2b
         cX1vGWxLeJHb6Z/xAgD/vFPzXpZEMYE6194bxMgC0PkKfx61zS/hAPAfcT4pT6OaZog7
         lxyQ==
X-Gm-Message-State: AOJu0YysEEolrfVIXEBFRE4XRZgH4cQcAtAmHjoZktLIu6KHhR50ikj0
        DwyueRunx+xYrAZrhMG1zZyzxw==
X-Google-Smtp-Source: AGHT+IELeE7KSX8SDWfKXXFosnM7eJQ87gPQKSBzDxY0zO3dL8fVjd9KroIOSfLXxROs54MZq4uAgw==
X-Received: by 2002:a05:6214:d09:b0:672:3f54:b94f with SMTP id 9-20020a0562140d0900b006723f54b94fmr7618938qvh.7.1698794589164;
        Tue, 31 Oct 2023 16:23:09 -0700 (PDT)
Received: from pazz.c.googlers.com.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id f2-20020a0ccc82000000b0066d1d2242desm937757qvl.120.2023.10.31.16.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 16:23:08 -0700 (PDT)
From:   Paz Zcharya <pazz@chromium.org>
X-Google-Original-From: Paz Zcharya <pazz@google.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Subrata Banik <subratabanik@google.com>,
        Drew Davenport <ddavenport@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Manasi Navare <navaremanasi@chromium.org>,
        Paz Zcharya <pazz@chromium.org>, Paz Zcharya <pazz@google.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
        Khaled Almahallawy <khaled.almahallawy@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Mika Kahola <mika.kahola@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Suraj Kandpal <suraj.kandpal@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/display: Only fail fastset on PSR2
Date:   Tue, 31 Oct 2023 23:21:57 +0000
Message-ID: <20231031232245.1331194-1-pazz@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, i915 fails fastset if both the sink and the source support
any version of PSR and regardless of the configuration setting of the
driver (i.e., i915.enable_psr kernel argument). However, the
implementation of PSR1 enable sequence is already seamless
and works smoothly with fastset. Accordingly, do not fail fastset
if PSR2 is not enabled.

Signed-off-by: Paz Zcharya <pazz@google.com>
---

 drivers/gpu/drm/i915/display/intel_dp.c  | 4 ++--
 drivers/gpu/drm/i915/display/intel_psr.c | 2 +-
 drivers/gpu/drm/i915/display/intel_psr.h | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index e0e4cb529284..a1af96e31518 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2584,8 +2584,8 @@ bool intel_dp_initial_fastset_check(struct intel_encoder *encoder,
 		fastset = false;
 	}
 
-	if (CAN_PSR(intel_dp)) {
-		drm_dbg_kms(&i915->drm, "[ENCODER:%d:%s] Forcing full modeset to compute PSR state\n",
+	if (CAN_PSR(intel_dp) && psr2_global_enabled(intel_dp)) {
+		drm_dbg_kms(&i915->drm, "[ENCODER:%d:%s] Forcing full modeset due to PSR2\n",
 			    encoder->base.base.id, encoder->base.name);
 		crtc_state->uapi.mode_changed = true;
 		fastset = false;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 97d5eef10130..388bc3246db9 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -187,7 +187,7 @@ static bool psr_global_enabled(struct intel_dp *intel_dp)
 	}
 }
 
-static bool psr2_global_enabled(struct intel_dp *intel_dp)
+bool psr2_global_enabled(struct intel_dp *intel_dp)
 {
 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
 
diff --git a/drivers/gpu/drm/i915/display/intel_psr.h b/drivers/gpu/drm/i915/display/intel_psr.h
index 0b95e8aa615f..6f3c36389cd3 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.h
+++ b/drivers/gpu/drm/i915/display/intel_psr.h
@@ -21,6 +21,7 @@ struct intel_encoder;
 struct intel_plane;
 struct intel_plane_state;
 
+bool psr2_global_enabled(struct intel_dp *intel_dp);
 void intel_psr_init_dpcd(struct intel_dp *intel_dp);
 void intel_psr_pre_plane_update(struct intel_atomic_state *state,
 				struct intel_crtc *crtc);
-- 
2.42.0.820.g83a721a137-goog

