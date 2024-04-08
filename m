Return-Path: <linux-kernel+bounces-135845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2689CC04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E8A1C21245
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B48E145321;
	Mon,  8 Apr 2024 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY0RjRKu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1F1448FB;
	Mon,  8 Apr 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602522; cv=none; b=SaAX5w3GFVqWh9BBlEKaA83QyZcr420bF6e7ywgdqMnFlfRZjauaewaY8SBHuz44/FIH515SL2uiyGN4pxdX3aygR4Pf7egFBsMlGH9QNA8g72+hTTJa2THIrRMoxfF3X9eItJndam1p1PZaxE1J8wIF1j11HXNKk0oN5jy71tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602522; c=relaxed/simple;
	bh=a35qe99T0ty/qo/ABfWr3rySxoEPvBFi4B3MDRC+sK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp+rjGeEazAwveM+i6BziwByZguQu7FA/T4EE7GwLEY2yAy14+/HSu7YdXnF8/AwyFJPVAq/6PYA9YTTTsGw69n6cohdiha0/CgJJ87JUJKkYw1uGibWNl3b7ttkcF3Gxh5S9Jr6sjVDdqVrQf6hzp+3bb22IxVNQ5WM2rV8CJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY0RjRKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4ECC433A6;
	Mon,  8 Apr 2024 18:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602522;
	bh=a35qe99T0ty/qo/ABfWr3rySxoEPvBFi4B3MDRC+sK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FY0RjRKufGT3vRk0kkLSo0GAMdzzXJtqvbI/jK2bsN2IIeTf7Fwbpa2oij+7EKGr6
	 QcJukV11+g9JvtPOMr5Cbq2aRi3rCgcRH1o2iOOo/emrisMWi8h7V/K62vSTe5urBo
	 dout4fC9OBY11y9IjcD95Ys6jt00sW9oA+HNiqF2VuQMuhafksmVGpSaEvyKOgTY7O
	 e4uYFc3Bhdvuh/ZM5H4ZdSW7as2p30fK3XITIkWFIaWjTGxYtevfTdjpvLCwldFXeg
	 MqalayoD2SYf+bFD9VScUhEFoxuYLsiZtN2pDaoW/xnYwvioGDTkRhprKUeJeH3lG3
	 U/QpQ0yuNeHLg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/9] tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
Date: Mon,  8 Apr 2024 11:55:12 -0700
Message-ID: <20240408185520.1550865-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240408185520.1550865-1-namhyung@kernel.org>
References: <20240408185520.1550865-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

   b112364867499 ("drm/i915: Add GuC submission interface version query")
   5cf0fbf763741 ("drm/i915: Add some boring kerneldoc")

This should be used to beautify DRM syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/drm/i915_drm.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index fd4f9574d177..2ee338860b7e 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -3013,6 +3013,7 @@ struct drm_i915_query_item {
 	 *  - %DRM_I915_QUERY_MEMORY_REGIONS (see struct drm_i915_query_memory_regions)
 	 *  - %DRM_I915_QUERY_HWCONFIG_BLOB (see `GuC HWCONFIG blob uAPI`)
 	 *  - %DRM_I915_QUERY_GEOMETRY_SUBSLICES (see struct drm_i915_query_topology_info)
+	 *  - %DRM_I915_QUERY_GUC_SUBMISSION_VERSION (see struct drm_i915_query_guc_submission_version)
 	 */
 	__u64 query_id;
 #define DRM_I915_QUERY_TOPOLOGY_INFO		1
@@ -3021,6 +3022,7 @@ struct drm_i915_query_item {
 #define DRM_I915_QUERY_MEMORY_REGIONS		4
 #define DRM_I915_QUERY_HWCONFIG_BLOB		5
 #define DRM_I915_QUERY_GEOMETRY_SUBSLICES	6
+#define DRM_I915_QUERY_GUC_SUBMISSION_VERSION	7
 /* Must be kept compact -- no holes and well documented */
 
 	/**
@@ -3566,6 +3568,20 @@ struct drm_i915_query_memory_regions {
 	struct drm_i915_memory_region_info regions[];
 };
 
+/**
+ * struct drm_i915_query_guc_submission_version - query GuC submission interface version
+ */
+struct drm_i915_query_guc_submission_version {
+	/** @branch: Firmware branch version. */
+	__u32 branch;
+	/** @major: Firmware major version. */
+	__u32 major;
+	/** @minor: Firmware minor version. */
+	__u32 minor;
+	/** @patch: Firmware patch version. */
+	__u32 patch;
+};
+
 /**
  * DOC: GuC HWCONFIG blob uAPI
  *
-- 
2.44.0.478.gd926399ef9-goog


