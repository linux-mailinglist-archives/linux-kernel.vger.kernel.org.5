Return-Path: <linux-kernel+bounces-132987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A61899CF1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3B61F23262
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D5616C87F;
	Fri,  5 Apr 2024 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIN5424d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF913C670;
	Fri,  5 Apr 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320275; cv=none; b=unRmbR/Pfiqj25KtLWh0NTP9yo9t0z1dK1GowQKDep7u+phme78f7S4NCwEJrpIsYgrAraYvf53VfG6+TBtIP5RScrEkG9gSQoLCrROmqJ0/Gjiaaag6dLXByDUUqK1qITQYEXZkvDOqxNwbmkLhRHt+yxni4sEe6Czc7r8lEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320275; c=relaxed/simple;
	bh=nOZUjovfA1TSvzaMpe+qzYO18xLqNYoJ7Tk9cqEQ9rg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XcUdCYMfzJg49LWRX7igOUjuQVTH23TrAFP7GVHhKbQQvN/qzPK8BUHjYgsxCkFHYFmMfyYAfK6APChM+kG4vUJYlZRGAiogCO7QlY1dhIEul/dUXNQDs2EEXfOOBlW8B+D4+KtmizvRd+dNMap/sG9re67dKqAXbxCqAHXxCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIN5424d; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712320273; x=1743856273;
  h=from:to:cc:subject:date:message-id;
  bh=nOZUjovfA1TSvzaMpe+qzYO18xLqNYoJ7Tk9cqEQ9rg=;
  b=DIN5424dRHwznOMDV2yxfzEA4UeRBwB+sC/2mQZlzDkXC/H9urdqgZRJ
   p8fUPMjDYqmC+x2tghTZrzESbbwUS3lVE1uL6/sY/YSxU0kcl2v2y87hx
   KXQwSUIqa8Ru+i875db9UbviIZ3dDUW7F1j53SHCSoBf/MVG1Y54KnAgC
   8IBFuX9/b2HP7q4+7zONUZBZ9YvpICCBODNQZReWDeNBBeISUhIbnSjIy
   8CJD/Xp5by9miFxHr8QwE/0SNhNYojxhkvTaR6043/P71ovd8cwAzb3nz
   MccKGEPicFLPDMa2NLRPNtsVnqmy03VSoTvOGULtOOhtEyyYyglvoMZ2v
   g==;
X-CSE-ConnectionGUID: O2RYbtIxRBORnJ1wW25NTw==
X-CSE-MsgGUID: q398mmydSNiyrpmSBbDc9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7773668"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7773668"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 05:31:12 -0700
X-CSE-ConnectionGUID: 3snKCyrzT+Gbdqac/nMkQw==
X-CSE-MsgGUID: rjKZHFngSDaA6MQNajB4yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23832355"
Received: from srpawnik.iind.intel.com ([10.223.107.103])
  by orviesa003.jf.intel.com with ESMTP; 05 Apr 2024 05:31:11 -0700
From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To: rafael@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: sumeet.r.pawnikar@intel.com
Subject: [PATCH] ACPI: DPTF: Add Lunar Lake support
Date: Fri,  5 Apr 2024 17:48:19 +0530
Message-Id: <20240405121819.31331-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add Lunar Lake ACPI IDs for DPTF devices.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c                       | 1 +
 drivers/acpi/dptf/dptf_power.c                          | 2 ++
 drivers/acpi/dptf/int340x_thermal.c                     | 6 ++++++
 drivers/acpi/fan.h                                      | 1 +
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 6 files changed, 12 insertions(+)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 654aaa53c67f..d202730fafd8 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -150,6 +150,7 @@ static const struct acpi_device_id pch_fivr_device_ids[] = {
 	{"INTC1045", 0},
 	{"INTC1049", 0},
 	{"INTC1064", 0},
+	{"INTC106B", 0},
 	{"INTC10A3", 0},
 	{"", 0},
 };
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index b8187babbbbb..8023b3e23315 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -232,6 +232,8 @@ static const struct acpi_device_id int3407_device_ids[] = {
 	{"INTC1061", 0},
 	{"INTC1065", 0},
 	{"INTC1066", 0},
+	{"INTC106C", 0},
+	{"INTC106D", 0},
 	{"INTC10A4", 0},
 	{"INTC10A5", 0},
 	{"", 0},
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index b7113fa92fa6..014ada759954 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -43,6 +43,12 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INTC1064"},
 	{"INTC1065"},
 	{"INTC1066"},
+	{"INTC1068"},
+	{"INTC1069"},
+	{"INTC106A"},
+	{"INTC106B"},
+	{"INTC106C"},
+	{"INTC106D"},
 	{"INTC10A0"},
 	{"INTC10A1"},
 	{"INTC10A2"},
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index e7b4b4e4a55e..f89d19c922dc 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -15,6 +15,7 @@
 	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
 	{"INTC1048", }, /* Fan for Alder Lake generation */ \
 	{"INTC1063", }, /* Fan for Meteor Lake generation */ \
+	{"INTC106A", }, /* Fan for Lunar Lake generation */ \
 	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
 	{"PNP0C0B", } /* Generic ACPI fan */
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 427d370648d5..f8ebdd19d340 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -705,6 +705,7 @@ static const struct acpi_device_id int3400_thermal_match[] = {
 	{"INTC1040", 0},
 	{"INTC1041", 0},
 	{"INTC1042", 0},
+	{"INTC1068", 0},
 	{"INTC10A0", 0},
 	{}
 };
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index 9b33fd3a66da..86901f9f54d8 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -284,6 +284,7 @@ static const struct acpi_device_id int3403_device_ids[] = {
 	{"INTC1043", 0},
 	{"INTC1046", 0},
 	{"INTC1062", 0},
+	{"INTC1069", 0},
 	{"INTC10A1", 0},
 	{"", 0},
 };
-- 
2.17.1


