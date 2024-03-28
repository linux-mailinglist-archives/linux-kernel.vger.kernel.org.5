Return-Path: <linux-kernel+bounces-123280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877C58905E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FCC1C2723A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFCF13AD28;
	Thu, 28 Mar 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CeCgHmKA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9213AA36
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643878; cv=none; b=WItnEeGFphAGXvyJplUsBhu8AM4DqlvYeNmmY4rVyJJhxam5BNg8Z+3tqajuoIQ9MDjVOGgbGHzqTS7LNNe3GPo/3NwFv6s/P2Ton98xo2CJ3Xp2xpJSnHAHiq/9fblyPXBeumQkynPz+H2uO+SEoCv982HS4D8HcvsoCSXc5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643878; c=relaxed/simple;
	bh=mZGFxWlbLBmgwu26X3jwNzUAW5GWgk+GnRQDUpPlM/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co3pUZlZHh686zm7ybwwGuG7oPJ8AMKVyFLYAeEa7VkfECToGfJHKybVeiC7k3oUd9091c4vkcZ7FyjPwKQnceV/A6aP3J6pJF1GtDZSKJ9f+PfiTTgdVkccnKX6TA0AGwTW8DYVOf3hnfbrOUxPXvOC0MjJ18uDwcI07MfyuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CeCgHmKA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711643875; x=1743179875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mZGFxWlbLBmgwu26X3jwNzUAW5GWgk+GnRQDUpPlM/Q=;
  b=CeCgHmKA1soWBCe+MlnWamyB9Q5oidMmgAAOw0GRdLZqzOTmyIxFkv/O
   uL681Qi0o8Ww1CyLsmXEVf9IUSXsaqdXUCh0ZHokGC8LxPlhyO4WvRBfj
   k47XatzDZQLRwc0msZ4o6vdPPDMeMlWZF6pozC8B8yw3kAT+T9kEi6Ykg
   gVOjCKasmSSO41Ld2rm226JMJ/1K42bCbNVnvxXVGMlpoydW0smweV8uP
   u7PaCiLiIkubEIfftvMmKUdoG8EmC7Wj5VzeocJ3xntx+/wFLZkG1cB18
   IVscQkvGaOyXHHKW0svt3J6oQf5wIs+l2CH/rmc0TipA388kZhiYAioVv
   g==;
X-CSE-ConnectionGUID: RU9/t4oMQjKl/O0wlT58Aw==
X-CSE-MsgGUID: bMV7PNtlTUmcMJMsZ0b/BQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24296529"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24296529"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="39852825"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:37:52 -0700
From: Tony Luck <tony.luck@intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 02/74] x86/cpu/vfm: Add new macros to work with (vendor/family/model) values
Date: Thu, 28 Mar 2024 09:37:45 -0700
Message-ID: <20240328163746.243023-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328163746.243023-1-tony.luck@intel.com>
References: <20240328163746.243023-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid adding a slew of new macros for each new Intel CPU family
switch over from providing CPU model number #defines to a new
scheme that encodes vendor, family, and model in a single number.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpu_device_id.h | 93 ++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index eb8fcede9e3b..0e98d3fd0d38 100644
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
+ *			__u8	x86_vendor;
+ *			__u8	x86;
+ *			__u8	x86_model;
+ *			__u8	x86_reserved;
+ *		};
+ *		__u32		x86_vfm;
+ *	};
+ */
+#define VFM_VENDOR_BIT	0
+#define VFM_FAMILY_BIT	8
+#define VFM_MODEL_BIT	16
+#define VFM_RSVD_BIT	24
+
+#define	VFM_VENDOR_MASK	GENMASK(VFM_FAMILY_BIT - 1, VFM_VENDOR_BIT)
+#define	VFM_FAMILY_MASK	GENMASK(VFM_MODEL_BIT - 1, VFM_FAMILY_BIT)
+#define	VFM_MODEL_MASK	GENMASK(VFM_RSVD_BIT - 1, VFM_MODEL_BIT)
+
+#define VFM_VENDOR(vfm)	(((vfm) & VFM_VENDOR_MASK) >> VFM_VENDOR_BIT)
+#define VFM_FAMILY(vfm)	(((vfm) & VFM_FAMILY_MASK) >> VFM_FAMILY_BIT)
+#define VFM_MODEL(vfm)	(((vfm) & VFM_MODEL_MASK) >> VFM_MODEL_BIT)
+
+#define	VFM_MAKE(_vendor, _family, _model) (	\
+	((_vendor) << VFM_VENDOR_BIT) |		\
+	((_family) << VFM_FAMILY_BIT) |		\
+	((_model) << VFM_MODEL_BIT)		\
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


