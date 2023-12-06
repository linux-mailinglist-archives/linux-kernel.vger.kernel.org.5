Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92D807804
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379152AbjLFSse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379150AbjLFSsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:48:18 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAEF1BF8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:47:49 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67ac8e5566cso864326d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701888468; x=1702493268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4q9MyQ/r2TBjpMUXQEhWuBacEcVfTmwF7KmTnqv12Q=;
        b=JvXJmxgHo+fTQqSgoxAPG5uR1C40ZRyTcCmy9ziUI0v47Xq/flSsSv/qY2y2eFtB0d
         ytjNCB8pYUOPHkM1TmlJsSX/DS1YSP07hpNohDfgmSOAVtx1OUfCZOZ5pkSJFJhAQycm
         htbQUBKcze9M8ezygTepPVCXdT0bMAwwEHLWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888468; x=1702493268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4q9MyQ/r2TBjpMUXQEhWuBacEcVfTmwF7KmTnqv12Q=;
        b=iRFTLGgmwB+GxsCWRxOQxiEd/Z/CgKz0pRogS6/ZFeV3DeRqMdpaS0lj3sHDZKWd20
         n/jhxNQz8ocfaEUaWR6O8+cQ4oqt9VZ16SyJd8dzuOXLkhzUsAbHxYSC2q7GV+rsd/ea
         rHO4APGlBHgL6zdDT0qM3i7em92W04RRntU3PQejm/t7NJ7QR0WhGG/TV5iMsGxAwiIH
         VkgWEx0uxdtQToKBJxmFEGDeMiitRWF7X0PBqmktXWD7W995EY7pbL6gxcn9xkGTQt0j
         R0lM3Aah+VWy3DgEDwikr6PDpFbq/7rhQNwFP7J1li2oFn7eZokSC7e2C+VJjdVMzDjd
         nVaw==
X-Gm-Message-State: AOJu0YxKhSQZDazEUSIYJAqGKaZc+62LbAfnTPPDIbEuX+z+BbAZ2xuO
        rs/oKhSDvJaBZHYZXensn/pYNQ==
X-Google-Smtp-Source: AGHT+IHiOJY5S1HzguMhAnwl7sMIiS7k+YcE7l7xbK3U/3mxe44aber4iMNXtni9CDi6QG9YXPKnrg==
X-Received: by 2002:a0c:ed42:0:b0:67a:a721:b19c with SMTP id v2-20020a0ced42000000b0067aa721b19cmr1238042qvq.87.1701888468177;
        Wed, 06 Dec 2023 10:47:48 -0800 (PST)
Received: from pazz.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id g11-20020a0cd7cb000000b0067abdf75926sm187432qvj.14.2023.12.06.10.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:47:47 -0800 (PST)
From:   Paz Zcharya <pazz@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org,
        Subrata Banik <subratabanik@google.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Paz Zcharya <pazz@chromium.org>,
        Drew Davenport <ddavenport@chromium.org>,
        matthew.auld@intel.com, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>,
        Marcin Wojtas <mwojtas@chromium.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH] [v2] drm/i915/display: Check GGTT to determine phys_base
Date:   Wed,  6 Dec 2023 18:46:26 +0000
Message-ID: <20231206184736.3769657-1-pazz@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was an assumption that for iGPU there should be a 1:1 mapping
of GGTT to physical address pointing to the framebuffer.
This assumption is not strictly true effective generation 8 or newer.
Fix that by checking GGTT to determine the phys address on gen8+.

The following algorithm for phys_base should be valid for all platforms:
1. Find pte
2. if(IS_DGFX(i915) && pte & GEN12_GGTT_PTE_LM) mem =
i915->mm.regions[INTEL_REGION_LMEM_0] else mem = i915->mm.stolen_region
3. phys_base = (pte & I915_GTT_PAGE_MASK) - mem->region.start;

- On older platforms, stolen_region points to system memory, starting at 0
- on DG2, it uses lmem region which starts at 0 as well
- on MTL, stolen_region points to stolen-local which starts at 0x800000

Changes from v1:
  - Add an if statement for gen7-, where there is a 1:1 mapping

Signed-off-by: Paz Zcharya <pazz@chromium.org>
---

 .../drm/i915/display/intel_plane_initial.c    | 64 +++++++++++--------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane_initial.c b/drivers/gpu/drm/i915/display/intel_plane_initial.c
index a55c09cbd0e4..7d9bb631b93b 100644
--- a/drivers/gpu/drm/i915/display/intel_plane_initial.c
+++ b/drivers/gpu/drm/i915/display/intel_plane_initial.c
@@ -59,44 +59,58 @@ initial_plane_vma(struct drm_i915_private *i915,
 		return NULL;
 
 	base = round_down(plane_config->base, I915_GTT_MIN_ALIGNMENT);
-	if (IS_DGFX(i915)) {
+
+	if (GRAPHICS_VER(i915) < 8) {
+		/*
+		 * In gen7-, there is a 1:1 mapping
+		 * between GSM and physical address.
+		 */
+		phys_base = base;
+		mem = i915->mm.stolen_region;
+	} else {
+		/*
+		 * In gen8+, there is no 1:1 mapping between
+		 * GSM and physical address, so we need to
+		 * check GGTT to determine the physical address.
+		 */
 		gen8_pte_t __iomem *gte = to_gt(i915)->ggtt->gsm;
 		gen8_pte_t pte;
 
 		gte += base / I915_GTT_PAGE_SIZE;
-
 		pte = ioread64(gte);
-		if (!(pte & GEN12_GGTT_PTE_LM)) {
-			drm_err(&i915->drm,
-				"Initial plane programming missing PTE_LM bit\n");
-			return NULL;
-		}
-
-		phys_base = pte & I915_GTT_PAGE_MASK;
-		mem = i915->mm.regions[INTEL_REGION_LMEM_0];
 
-		/*
-		 * We don't currently expect this to ever be placed in the
-		 * stolen portion.
-		 */
-		if (phys_base >= resource_size(&mem->region)) {
-			drm_err(&i915->drm,
-				"Initial plane programming using invalid range, phys_base=%pa\n",
-				&phys_base);
-			return NULL;
+		if (IS_DGFX(i915)) {
+			if (!(pte & GEN12_GGTT_PTE_LM)) {
+				drm_err(&i915->drm,
+					"Initial plane programming missing PTE_LM bit\n");
+				return NULL;
+			}
+			mem = i915->mm.regions[INTEL_REGION_LMEM_0];
+		} else {
+			mem = i915->mm.stolen_region;
 		}
 
-		drm_dbg(&i915->drm,
-			"Using phys_base=%pa, based on initial plane programming\n",
-			&phys_base);
-	} else {
-		phys_base = base;
-		mem = i915->mm.stolen_region;
+		phys_base = (pte & I915_GTT_PAGE_MASK) - mem->region.start;
 	}
 
 	if (!mem)
 		return NULL;
 
+	/*
+	 * We don't currently expect this to ever be placed in the
+	 * stolen portion.
+	 */
+	if (phys_base >= resource_size(&mem->region)) {
+		drm_err(&i915->drm,
+			"Initial plane programming using invalid range, phys_base=%pa\n",
+			&phys_base);
+		return NULL;
+	}
+
+	drm_dbg(&i915->drm,
+		"Using phys_base=%pa, based on initial plane programming\n",
+		&phys_base);
+
 	size = round_up(plane_config->base + plane_config->size,
 			mem->min_page_size);
 	size -= base;
-- 
2.43.0.472.g3155946c3a-goog

