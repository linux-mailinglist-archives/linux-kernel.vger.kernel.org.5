Return-Path: <linux-kernel+bounces-126947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4428944C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1201C218AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7050278;
	Mon,  1 Apr 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwsQHTF1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104914F88B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995891; cv=none; b=gDraqelTs4We5gohpUMPKeMl/YfbYaiaXYCtBH39SDV3Z0dsKq31JP7iepNMJGRSV8GDzgdxkernmbkPt5FTGjUflEU5kEkGR0ijX47emYXkUAz0J7+eVArtC8xefAk1uBU6nxQTB0en9dVlJgY4q5g/6utz5QaUnICUhDtCano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995891; c=relaxed/simple;
	bh=JTNh3a1WtKL5+kDA3YORboP66Meh6PzGt83LtqtZ92U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvHt9vv7L2T8pAN0lDnLLfpdeC0C+6ESr9DT6sKq8553HJGQoQ7U2MKtaUBvIbnv5MC6MgQ/PbIM3sm+lnvxBxh4UYDyf49CAL9LnpjbnlUi4g67bcn10oP00FCpNqyeKk3HYWS42+Effk4AIuGfaMP2QfsDCdiaU0JPo/pFPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwsQHTF1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711995890; x=1743531890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTNh3a1WtKL5+kDA3YORboP66Meh6PzGt83LtqtZ92U=;
  b=GwsQHTF1hXPoUeVf2n7tyGRTE1Q1MowkRiUyvFpYphwmTEK79Ki8166G
   au91QszKF4NQrDnOCn6LnupgRnC7+RFgFoK7ngbcM8ZwGkHiIV6jKkiN3
   j9DS4gpo/rMuPf/FVWCu3Cbwt7/GPZah8LrTghi/F4ictQcGhZOiebOKT
   Q3TSmz3KfMm2RtSdhUDj749HqZJ/gBq910LLZxhuSRQ00QR2awIAtwzPF
   qTcN44MOdxI9qpqyZTA/JSym9Emh+y4ULAVkbpEKUEm5AZ6CKdUNNQvdM
   MjFJ9LOXXNrANkob8VAapTXN4sDkYIhYv3291r0ah3MWqNDb6hV0iyxgQ
   g==;
X-CSE-ConnectionGUID: V3TfSHa6Q2aQKmq7cZiLyw==
X-CSE-MsgGUID: nO+xyaihSjShrgcC26q6cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7072866"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="7072866"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:24:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17829304"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:24:50 -0700
Date: Mon, 1 Apr 2024 11:24:48 -0700
From: Tony Luck <tony.luck@intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/74] x86/cpu/vfm: Add new macros to work with
 (vendor/family/model) values
Message-ID: <Zgr78PA1qTiuu82b@agluck-desk3>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-3-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328163746.243023-3-tony.luck@intel.com>


To avoid adding a slew of new macros for each new Intel CPU family
switch over from providing CPU model number #defines to a new
scheme that encodes vendor, family, and model in a single number.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpu_device_id.h | 93 ++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index eb8fcede9e3b..b8a86c227d65 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -2,6 +2,39 @@
 #ifndef _ASM_X86_CPU_DEVICE_ID
 #define _ASM_X86_CPU_DEVICE_ID
 
+/*
+ * Can't use <linux/bitfield.h> because it generates expressions that
+ * cannot be used in structure initializers. Bitfield construction
+ * here must match the union in struct cpuinfo_86:
+ *	union {
+ *		struct {
+ *			__u8	x86_model;
+ *			__u8	x86;
+ *			__u8	x86_vendor;
+ *			__u8	x86_reserved;
+ *		};
+ *		__u32		x86_vfm;
+ *	};
+ */
+#define VFM_MODEL_BIT	0
+#define VFM_FAMILY_BIT	8
+#define VFM_VENDOR_BIT	16
+#define VFM_RSVD_BIT	24
+
+#define	VFM_MODEL_MASK	GENMASK(VFM_FAMILY_BIT - 1, VFM_MODEL_BIT)
+#define	VFM_FAMILY_MASK	GENMASK(VFM_VENDOR_BIT - 1, VFM_FAMILY_BIT)
+#define	VFM_VENDOR_MASK	GENMASK(VFM_RSVD_BIT - 1, VFM_VENDOR_BIT)
+
+#define VFM_MODEL(vfm)	(((vfm) & VFM_MODEL_MASK) >> VFM_MODEL_BIT)
+#define VFM_FAMILY(vfm)	(((vfm) & VFM_FAMILY_MASK) >> VFM_FAMILY_BIT)
+#define VFM_VENDOR(vfm)	(((vfm) & VFM_VENDOR_MASK) >> VFM_VENDOR_BIT)
+
+#define	VFM_MAKE(_vendor, _family, _model) (	\
+	((_model) << VFM_MODEL_BIT) |		\
+	((_family) << VFM_FAMILY_BIT) |		\
+	((_vendor) << VFM_VENDOR_BIT)		\
+)
+
 /*
  * Declare drivers belonging to specific x86 CPUs
  * Similar in spirit to pci_device_id and related PCI functions
@@ -49,6 +82,16 @@
 	.driver_data	= (unsigned long) _data				\
 }
 
+#define X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(_vendor, _family, _model, \
+						    _steppings, _feature, _data) { \
+	.vendor		= _vendor,					\
+	.family		= _family,					\
+	.model		= _model,					\
+	.steppings	= _steppings,					\
+	.feature	= _feature,					\
+	.driver_data	= (unsigned long) _data				\
+}
+
 /**
  * X86_MATCH_VENDOR_FAM_MODEL_FEATURE - Macro for CPU matching
  * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
@@ -164,6 +207,56 @@
 	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
 						     steppings, X86_FEATURE_ANY, data)
 
+/**
+ * X86_MATCH_VFM - Match encoded vendor/family/model
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * Stepping and feature are set to wildcards
+ */
+#define X86_MATCH_VFM(vfm, data)			\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
+		VFM_VENDOR(vfm),			\
+		VFM_FAMILY(vfm),			\
+		VFM_MODEL(vfm),				\
+		X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+
+/**
+ * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @steppings:	Bitmask of steppings to match
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * feature is set to wildcard
+ */
+#define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)	\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
+		VFM_VENDOR(vfm),			\
+		VFM_FAMILY(vfm),			\
+		VFM_MODEL(vfm),				\
+		steppings, X86_FEATURE_ANY, data)
+
+/**
+ * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @feature:	A X86_FEATURE bit
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * Steppings is set to wildcard
+ */
+#define X86_MATCH_VFM_FEATURE(vfm, feature, data)	\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
+		VFM_VENDOR(vfm),			\
+		VFM_FAMILY(vfm),			\
+		VFM_MODEL(vfm),				\
+		X86_STEPPING_ANY, feature, data)
+
 /*
  * Match specific microcode revisions.
  *
-- 
2.44.0


