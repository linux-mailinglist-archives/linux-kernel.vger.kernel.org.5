Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10037FF47F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjK3QRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3QRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:17:10 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4231D112
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:17:16 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77d63b733e4so53965285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701361035; x=1701965835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZVJygFoxlCvYJvp9UVcwgwa6qE6VPVWJwn+rUhq2G4=;
        b=FZxeNxU7vZCszFCRANxatR6xA8N0DVsIy2e9jyNZUUTiv89KEzHo3LF+XyGM87bcYf
         SwMmLnWpHS+W6SDXKAM91Exkqph1Y7Qc/wnzkDV/znU87Y+a+72dRcJDUmv6g4Wt/a21
         DUi1Wq190KyTl6wdjFiZ9lNynqillHypaM4N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361035; x=1701965835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZVJygFoxlCvYJvp9UVcwgwa6qE6VPVWJwn+rUhq2G4=;
        b=py7Nx/nYiycFNYhYU7yUSSHR/fs9D7+nW+zPwaLLJq+8kXXA8INbY/k73mHjJmGV3Y
         wArVSK8Kf/xtjqA2seDP4gLxSJcgCzTXEAkHHj1qhADBDxnlJAB7VgY3BfeIQ9A+GZO/
         U+z8P/KQAOHvxAvSbIFmPqDemB+nBOW8rA0HEDCGHOoxjCKcifwEt8dbxqXGr4uQuPsY
         dB/qeTpIVAJkuWXX2v5PU6z091b350hj9jQwEnfq4wZ07Cqpy2R3Y4xrf+QkpUb5spvD
         5QX5P8+a7vJ9lazGgsqm/NhtxrZ3uxAV2B2yH0k309EQC/EJMGtdI89Zzn7ddb74hgGq
         tJeg==
X-Gm-Message-State: AOJu0Yz2O/UCXCmx5DmwEAOAjvoKOSBMYX1V2xNkACMNnxRskQors1YZ
        5NhgQ7GHjucBg3XiSqQF9UgTxA==
X-Google-Smtp-Source: AGHT+IErMrgaIDjOcHVAZtmeSk15ZaD/Q3M/cJlyYmDzrPUA/Zy/eZCr1Ui99i1KLeCN7mHizwa5jQ==
X-Received: by 2002:a05:620a:4883:b0:77d:7843:a06b with SMTP id ea3-20020a05620a488300b0077d7843a06bmr27795774qkb.4.1701361035350;
        Thu, 30 Nov 2023 08:17:15 -0800 (PST)
Received: from pazz.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a09cd00b0077731466526sm617093qky.70.2023.11.30.08.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:17:14 -0800 (PST)
From:   Paz Zcharya <pazz@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, matthew.auld@intel.com,
        intel-gfx@lists.freedesktop.org,
        Drew Davenport <ddavenport@chromium.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
        Paz Zcharya <pazz@chromium.org>,
        Subrata Banik <subratabanik@google.com>,
        dri-devel@lists.freedesktop.org,
        Manasi Navare <navaremanasi@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marcin Wojtas <mwojtas@chromium.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: [PATCH] drm/i915/display: Check GGTT to determine phys_base
Date:   Thu, 30 Nov 2023 16:16:37 +0000
Message-ID: <20231130161651.1836047-1-pazz@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was an assumption that for iGPU there should be a 1:1 mapping
of GGTT to physical address pointing to actual framebuffer.
This assumption is not valid anymore for MTL.
Fix that by checking GGTT to determine the phys address.

The following algorithm for phys_base should be valid for all platforms:
1. Find pte
2. if(IS_DGFX(i915) && pte & GEN12_GGTT_PTE_LM) mem =
i915->mm.regions[INTEL_REGION_LMEM_0] else mem = i915->mm.stolen_region
3. phys_base = (pte & I915_GTT_PAGE_MASK) - mem->region.start;

- On older platforms, stolen_region points to system memory, starting at 0
- on DG2, it uses lmem region which starts at 0 as well
- on MTL, stolen_region points to stolen-local which starts at 0x800000

Signed-off-by: Paz Zcharya <pazz@chromium.org>
---

 .../drm/i915/display/intel_plane_initial.c    | 45 +++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane_initial.c b/drivers/gpu/drm/i915/display/intel_plane_initial.c
index a55c09cbd0e4..c4bf02ea966c 100644
--- a/drivers/gpu/drm/i915/display/intel_plane_initial.c
+++ b/drivers/gpu/drm/i915/display/intel_plane_initial.c
@@ -51,6 +51,8 @@ initial_plane_vma(struct drm_i915_private *i915,
 	struct intel_memory_region *mem;
 	struct drm_i915_gem_object *obj;
 	struct i915_vma *vma;
+	gen8_pte_t __iomem *gte = to_gt(i915)->ggtt->gsm;
+	gen8_pte_t pte;
 	resource_size_t phys_base;
 	u32 base, size;
 	u64 pinctl;
@@ -59,44 +61,41 @@ initial_plane_vma(struct drm_i915_private *i915,
 		return NULL;
 
 	base = round_down(plane_config->base, I915_GTT_MIN_ALIGNMENT);
-	if (IS_DGFX(i915)) {
-		gen8_pte_t __iomem *gte = to_gt(i915)->ggtt->gsm;
-		gen8_pte_t pte;
+	gte += base / I915_GTT_PAGE_SIZE;
 
-		gte += base / I915_GTT_PAGE_SIZE;
+	pte = ioread64(gte);
 
-		pte = ioread64(gte);
+	if (IS_DGFX(i915)) {
 		if (!(pte & GEN12_GGTT_PTE_LM)) {
 			drm_err(&i915->drm,
 				"Initial plane programming missing PTE_LM bit\n");
 			return NULL;
 		}
-
-		phys_base = pte & I915_GTT_PAGE_MASK;
 		mem = i915->mm.regions[INTEL_REGION_LMEM_0];
-
-		/*
-		 * We don't currently expect this to ever be placed in the
-		 * stolen portion.
-		 */
-		if (phys_base >= resource_size(&mem->region)) {
-			drm_err(&i915->drm,
-				"Initial plane programming using invalid range, phys_base=%pa\n",
-				&phys_base);
-			return NULL;
-		}
-
-		drm_dbg(&i915->drm,
-			"Using phys_base=%pa, based on initial plane programming\n",
-			&phys_base);
 	} else {
-		phys_base = base;
 		mem = i915->mm.stolen_region;
 	}
 
+	phys_base = (pte & I915_GTT_PAGE_MASK) - mem->region.start;
+
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
2.43.0.rc1.413.gea7ed67945-goog

