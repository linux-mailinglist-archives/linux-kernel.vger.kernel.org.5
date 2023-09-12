Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F8879D1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjILNNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjILNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:13:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C810D1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694524399; x=1726060399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CmVDPIi6iDITv7lp9F+ldlMc0s9EvQk1kBwLwS5H+Ao=;
  b=kD+1tf8S1gcCakuVastyxFv1XQO/G8ujNEKs8bx7LRueuoRf4YFskD27
   DS9ap9zQqIroSMHjXFQD/8jEpa0MI64vp5ok+OPZvgDDhF7xMX9eBNeFe
   QGJFaOZ7v/fwVP2XQSG6H9yulTVnRzTi8lHieUhpNQN6p29hwkYmFAxTN
   h2NWJeI3rDoyb3Sz06jwPRy1TEz+T3y5z/e8S57HuG17ZdBYKlQCXW/NV
   PSCBwfHAFu9vicqgbpRHTjkh35pHZNI6AV6WQBhdqpWFR7PQGe/BBNkTu
   03ObTgr1Sjaitncg7ERm0q4fbD/0Ink4rz5jjPvJShCzJ1h4eQpI3tMmL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464740108"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464740108"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:13:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737116348"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="737116348"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:13:16 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/xe/gsc: add has_heci_gscfi indication to device
Date:   Tue, 12 Sep 2023 16:08:33 +0300
Message-Id: <20230912130835.2488728-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912130835.2488728-1-alexander.usyskin@intel.com>
References: <20230912130835.2488728-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Mark support of MEI-GSC interaction per device.
Add has_heci_gscfi indication to xe_device and xe_pci structures.
Mark DG1 and DG2 devices as supported.

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h | 3 +++
 drivers/gpu/drm/xe/xe_pci.c          | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index e4391c94e576..bac3d893b128 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -34,6 +34,7 @@ struct xe_ggtt;
 #define GRAPHICS_VERx100(xe) ((xe)->info.graphics_verx100)
 #define MEDIA_VERx100(xe) ((xe)->info.media_verx100)
 #define IS_DGFX(xe) ((xe)->info.is_dgfx)
+#define HAS_HECI_GSCFI(xe) ((xe)->info.has_heci_gscfi)
 
 #define XE_VRAM_FLAGS_NEED64K		BIT(0)
 
@@ -242,6 +243,8 @@ struct xe_device {
 		u8 has_link_copy_engine:1;
 		/** @enable_display: display enabled */
 		u8 enable_display:1;
+		/** @has_heci_gscfi: device has heci gscfi */
+		u8 has_heci_gscfi:1;
 
 #if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
 		const struct intel_display_device_info *display;
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 60f3474844e2..dcbef397e03e 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -79,6 +79,7 @@ struct xe_device_desc {
 	u8 require_force_probe:1;
 	u8 is_dgfx:1;
 	u8 has_display:1;
+	u8 has_heci_gscfi:1;
 
 	u8 has_llc:1;
 };
@@ -348,6 +349,7 @@ static const struct xe_device_desc dg1_desc = {
 	PLATFORM(XE_DG1),
 	.has_display = true,
 	.require_force_probe = true,
+	.has_heci_gscfi = 1,
 };
 
 static const u16 dg2_g10_ids[] = { XE_DG2_G10_IDS(NOP), XE_ATS_M150_IDS(NOP), 0 };
@@ -357,6 +359,7 @@ static const u16 dg2_g12_ids[] = { XE_DG2_G12_IDS(NOP), 0 };
 #define DG2_FEATURES \
 	DGFX_FEATURES, \
 	PLATFORM(XE_DG2), \
+	.has_heci_gscfi = 1, \
 	.subplatforms = (const struct xe_subplatform_desc[]) { \
 		{ XE_SUBPLATFORM_DG2_G10, "G10", dg2_g10_ids }, \
 		{ XE_SUBPLATFORM_DG2_G11, "G11", dg2_g11_ids }, \
@@ -686,6 +689,7 @@ static int xe_info_init(struct xe_device *xe,
 		return -ENODEV;
 
 	xe->info.is_dgfx = desc->is_dgfx;
+	xe->info.has_heci_gscfi = desc->has_heci_gscfi;
 	xe->info.graphics_name = graphics_desc->name;
 	xe->info.media_name = media_desc ? media_desc->name : "none";
 	xe->info.has_llc = desc->has_llc;
@@ -830,7 +834,7 @@ static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	xe_display_info_init(xe);
 
-	drm_dbg(&xe->drm, "%s %s %04x:%04x dgfx:%d gfx:%s (%d.%02d) media:%s (%d.%02d) display:%s dma_m_s:%d tc:%d",
+	drm_dbg(&xe->drm, "%s %s %04x:%04x dgfx:%d gfx:%s (%d.%02d) media:%s (%d.%02d) display:%s dma_m_s:%d tc:%d gscfi:%d",
 		desc->platform_name,
 		subplatform_desc ? subplatform_desc->name : "",
 		xe->info.devid, xe->info.revid,
@@ -842,7 +846,8 @@ static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		xe->info.media_verx100 / 100,
 		xe->info.media_verx100 % 100,
 		str_yes_no(xe->info.enable_display),
-		xe->info.dma_mask_size, xe->info.tile_count);
+		xe->info.dma_mask_size, xe->info.tile_count,
+		xe->info.has_heci_gscfi);
 
 	drm_dbg(&xe->drm, "Stepping = (G:%s, M:%s, D:%s, B:%s)\n",
 		xe_step_name(xe->info.step.graphics),
-- 
2.34.1

