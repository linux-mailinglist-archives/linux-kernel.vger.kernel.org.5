Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAFC7E1577
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjKER1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjKER13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:27:29 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E433C5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 09:27:27 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b9ff2b6f9bso1616454241.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 09:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699205246; x=1699810046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27FuzK5ZhNIAiarJZJb+WVFq6M3PPP0ewVP4DAogA48=;
        b=NY0oaXz5lpbFVBBWPTazZnaAAs9DRbsKiAyXHz7e6uldu9QEbAqOV6X76meR/zSEnZ
         72MWc4qQqAAcqLBlnAxfjX+gDQDZlXImiDKKRnT2HVh02CfMhALW6yyM0oejG2IGLpXl
         uJFuSOt0uQK5rfnPO5Ik6ZmW5+6Ro3Zji107M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699205246; x=1699810046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27FuzK5ZhNIAiarJZJb+WVFq6M3PPP0ewVP4DAogA48=;
        b=vcspi5BwmLp9GhB0NLvJJL07m6Y9fBSRMykSP03mswv3QBeQ+l8b0Azq5KPzR13tFA
         r5zKzrnl/Pvtsea4I8e7DceL2JH27yufw/rIcbXvSm4J+oZbrFne8stGQoeZQoFvagAE
         aUVT6Em5vhRfojXpGuEq8xslPlW61xJvHbs3v03OBQopLxL/n9SXq+EN9GNEDgI+igz4
         3oE63Hzc0pCSoaRfek7JS/siaAaiFiSRHtBgWqsapHNaM0BZS83QiZJPO69fa2uYnVPp
         RAAxe+aQAoV0Uhvnv8+YYcg4h2Gjl+IR9o28G7OYuEVwiVLbJb2tDIrihfrzny2EvLx9
         Bwwg==
X-Gm-Message-State: AOJu0YzMIjRFbz/pD2l7SmpTYeIK3Lq/fqjMfpmGeTew0lI4e+2algWy
        tXRqIE+E1W3KlWRgrgxEYFjVXg==
X-Google-Smtp-Source: AGHT+IHnBSvxKGHMNSsayQ2PStwCHZkBQc8ZVPr8KEhVF5onVc3h55FT/zT95gdJePBz8TwPBbanXw==
X-Received: by 2002:a05:6102:1085:b0:45d:8660:b91 with SMTP id s5-20020a056102108500b0045d86600b91mr7395347vsr.9.1699205246307;
        Sun, 05 Nov 2023 09:27:26 -0800 (PST)
Received: from pazz.c.googlers.com.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id h5-20020ac846c5000000b0041cbf113c28sm2635106qto.40.2023.11.05.09.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 09:27:25 -0800 (PST)
From:   Paz Zcharya <pazz@chromium.org>
To:     matthew.auld@intel.com, Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Subrata Banik <subratabanik@google.com>,
        Manasi Navare <navaremanasi@chromium.org>,
        Marcin Wojtas <mwojtas@chromium.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Paz Zcharya <pazz@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/display: Fix phys_base to be relative not absolute
Date:   Sun,  5 Nov 2023 17:27:03 +0000
Message-ID: <20231105172718.18673-1-pazz@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the value of variable `phys_base` to be the relative offset in
stolen memory, and not the absolute offset of the GSM.

Currently, the value of `phys_base` is set to "Surface Base Address,"
which in the case of Meter Lake is 0xfc00_0000. This causes the
function `i915_gem_object_create_region_at` to fail in line 128, when
it attempts to verify that the range does not overflow:

if (range_overflows(offset, size, resource_size(&mem->region)))
      return ERR_PTR(-EINVAL);

where:
  offset = 0xfc000000
  size = 0x8ca000
  mem->region.end + 1 = 0x4400000
  mem->region.start = 0x800000
  resource_size(&mem->region) = 0x3c00000

call stack:
  i915_gem_object_create_region_at
  initial_plane_vma
  intel_alloc_initial_plane_obj
  intel_find_initial_plane_obj
  intel_crtc_initial_plane_config

Looking at the flow coming next, we see that `phys_base` is only used
once, in function `_i915_gem_object_stolen_init`, in the context of
the offset *in* the stolen memory. Combining that with an
examinination of the history of the file seems to indicate the
current value set is invalid.

call stack (functions using `phys_base`)
  _i915_gem_object_stolen_init
  __i915_gem_object_create_region
  i915_gem_object_create_region_at
  initial_plane_vma
  intel_alloc_initial_plane_obj
  intel_find_initial_plane_obj
  intel_crtc_initial_plane_config

[drm:_i915_gem_object_stolen_init] creating preallocated stolen
object: stolen_offset=0x0000000000000000, size=0x00000000008ca000

Signed-off-by: Paz Zcharya <pazz@chromium.org>
---

 drivers/gpu/drm/i915/display/intel_plane_initial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane_initial.c b/drivers/gpu/drm/i915/display/intel_plane_initial.c
index a55c09cbd0e4..e696cb13756a 100644
--- a/drivers/gpu/drm/i915/display/intel_plane_initial.c
+++ b/drivers/gpu/drm/i915/display/intel_plane_initial.c
@@ -90,7 +90,7 @@ initial_plane_vma(struct drm_i915_private *i915,
 			"Using phys_base=%pa, based on initial plane programming\n",
 			&phys_base);
 	} else {
-		phys_base = base;
+		phys_base = 0;
 		mem = i915->mm.stolen_region;
 	}
 
-- 
2.42.0.869.gea05f2083d-goog

