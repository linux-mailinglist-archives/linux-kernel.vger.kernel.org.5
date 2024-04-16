Return-Path: <linux-kernel+bounces-147631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3378A76B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3AD1C20D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA3E15688D;
	Tue, 16 Apr 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeDPlNaZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD241553A2;
	Tue, 16 Apr 2024 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302572; cv=none; b=YLSVi2uBDsLhRrQlcDHdXpCBxozjkUs5OY8xc8edfoTORFMktyHWRIqOj3C1I35mUjLBi0R/Jzj1ukAmUnO8aQOnivX2qrejlTU6EqL6e4VBrBWGDTxfy2Db9llkIKt/agw7XJtywgVzOIBxvR8ATfhjSjtH1iGfDlf5+F4OQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302572; c=relaxed/simple;
	bh=d6oEEkZiXpUwThcVd9DaoNme+tX9GdjYQA7hJsSQwr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLQWMh+R3Ds9H2GZIvxH3ei3LxjCIlrF+r8RhWWQ1x/4MOVIftr0oer8u5KocP9VyLV3iZ2ni2a2oPpXgOVJuTCYTkBjnRDWnEE51CcOUWsL6+9aoIHHsL9JGU5YwRxjmWY10Dhxd/ksM5akHZjiblxVUtGT5vVVEGo8/xcX6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeDPlNaZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302570; x=1744838570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d6oEEkZiXpUwThcVd9DaoNme+tX9GdjYQA7hJsSQwr0=;
  b=MeDPlNaZ29CNDqSeUWV7J0uBtAN1jHdDp25hBuaJ+FzBsuH7XJf1Znn4
   jVaAqHYGosq+vPSx4WXTs8XYEI8l0l01L7jsOBbVso0iBPUzKkJCxzUw+
   Ob02G2elbfVcTyeaA+YNe7yhPm6i3jnDzhbX3eaT3unz5/30RGkK9rwVQ
   m4WQPGqbyeIBs9t9Y1IiISXfVsTBM5Ql+dDxCPsl305nxKbpTE2OF/C1c
   N6WY1yPNIO+q2lw/5Zmdhss/+5AhoI5+I6vkkRTa/dAyWxVNLfesEinRr
   5Msx6W4uCzUs9MnQbZDvk9af+8blVnGbBZ+EgiUTpqSKtda3st2e04/Sw
   g==;
X-CSE-ConnectionGUID: BFB7twvtSWqxRDM5DQhO7w==
X-CSE-MsgGUID: HBFFJHU8Sri/OPcVEzQlxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234995"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234995"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:50 -0700
X-CSE-ConnectionGUID: ZdptqxCNRgCp0ESakjc7aA==
X-CSE-MsgGUID: uzzJfCg4SrOsxBcp39RMZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="53366760"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:49 -0700
From: Tony Luck <tony.luck@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v3 68/74] x86/cpu/vfm: Update drivers/staging/media/atomisp/include/linux/atomisp_platform.h
Date: Tue, 16 Apr 2024 14:22:47 -0700
Message-ID: <20240416212247.9949-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 .../atomisp/include/linux/atomisp_platform.h  | 26 ++++++++-----------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
index 487ef5846c24..59f71659b2d8 100644
--- a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
@@ -18,6 +18,7 @@
 #ifndef ATOMISP_PLATFORM_H_
 #define ATOMISP_PLATFORM_H_
 
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
 
@@ -217,22 +218,17 @@ void atomisp_unregister_subdev(struct v4l2_subdev *subdev);
 int v4l2_get_acpi_sensor_info(struct device *dev, char **module_id_str);
 
 /* API from old platform_camera.h, new CPUID implementation */
-#define __IS_SOC(x) (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && \
-		     boot_cpu_data.x86 == 6 &&                       \
-		     boot_cpu_data.x86_model == (x))
-#define __IS_SOCS(x,y) (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && \
-		        boot_cpu_data.x86 == 6 &&                       \
-		        (boot_cpu_data.x86_model == (x) || \
-		         boot_cpu_data.x86_model == (y)))
-
-#define IS_MFLD	__IS_SOC(INTEL_FAM6_ATOM_SALTWELL_MID)
-#define IS_BYT	__IS_SOC(INTEL_FAM6_ATOM_SILVERMONT)
-#define IS_CHT	__IS_SOC(INTEL_FAM6_ATOM_AIRMONT)
-#define IS_MRFD	__IS_SOC(INTEL_FAM6_ATOM_SILVERMONT_MID)
-#define IS_MOFD	__IS_SOC(INTEL_FAM6_ATOM_AIRMONT_MID)
+#define __IS_SOC(x) (boot_cpu_data.x86_vfm == x)
+#define __IS_SOCS(x, y) (boot_cpu_data.x86_vfm == x || boot_cpu_data.x86_vfm == y)
+
+#define IS_MFLD	__IS_SOC(INTEL_ATOM_SALTWELL_MID)
+#define IS_BYT	__IS_SOC(INTEL_ATOM_SILVERMONT)
+#define IS_CHT	__IS_SOC(INTEL_ATOM_AIRMONT)
+#define IS_MRFD	__IS_SOC(INTEL_ATOM_SILVERMONT_MID)
+#define IS_MOFD	__IS_SOC(INTEL_ATOM_AIRMONT_MID)
 
 /* Both CHT and MOFD come with ISP2401 */
-#define IS_ISP2401 __IS_SOCS(INTEL_FAM6_ATOM_AIRMONT, \
-			     INTEL_FAM6_ATOM_AIRMONT_MID)
+#define IS_ISP2401 __IS_SOCS(INTEL_ATOM_AIRMONT, \
+			     INTEL_ATOM_AIRMONT_MID)
 
 #endif /* ATOMISP_PLATFORM_H_ */
-- 
2.44.0


