Return-Path: <linux-kernel+bounces-83945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA9D86A062
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D248C1F22F82
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EBF145351;
	Tue, 27 Feb 2024 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwqSkhkf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2B51C5D;
	Tue, 27 Feb 2024 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062894; cv=none; b=qY6XfwXSbRxekNCiD+Xc2NyPJiW0mp0u3AjyOvjQir7w/dFG1SLNO73bpj9IczG7jzcekfPBVYY0Gv9cCJL2QpjYl2ZXSzz2mvswsM8hG0st+ZMkZDx/2BhWhWhGJJ795KnpSS8TNrIIRfEPhSK5xzukGbqYCBv9GDmMQtvPhTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062894; c=relaxed/simple;
	bh=k+e5j/RZ38n+f/g3s3klnPj+vtf9R3Ifx3kc3Cj6uwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kFrokQgulMej7Djb7ncvpzS5L6Y22QAofnVcWWY73q7mx8tWkRhbYM5HEM3VIHqGnlciH8BW1ywHVoHqyChh2g5n9/a+elXE0mbIMXs1Z/EBKmyxkjuaWy4wEgRtp+cgN1qXX4jmL4WqLlQGErz9Eu+RDAVs8PAMTOfediXQTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwqSkhkf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709062892; x=1740598892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k+e5j/RZ38n+f/g3s3klnPj+vtf9R3Ifx3kc3Cj6uwc=;
  b=HwqSkhkfAgL5q8dNk9YTl5eJ0c3rcO136lzSAYB7WGASOpi8+HxaNr01
   iBQQfNKsUq1ABJmikHrztxg0Es3p7+CaI7S0/8tIHgOb0TnaeNxFkgL/a
   u6swa47Xzh05Vm0XymaJ1Qeg/1UAoHmEZlIBPU+Zgeg8EMiiZHu+BbSoA
   5O8rMpfnq1V93pE4Dx5kgh9KvypXv7x6D1MuqipSvYFvrZyrgO9cydR0x
   DYl55K/aj02lVZ7RgmnMBlUyyGMp8497zPxhR29lvZQ1Di5o5Ryp50dzI
   Tc6os9ZoOCP6iy3qiNPLsX0rElIzUrO1aG1TuxqWJAaN2TYUyRvOtMnAh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3290611"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3290611"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 11:41:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7130747"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 27 Feb 2024 11:41:29 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: processor_thermal: Add Lunar Lake-M PCI ID
Date: Tue, 27 Feb 2024 11:41:12 -0800
Message-Id: <20240227194112.1289979-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Lunar Lake-M PCI ID for processor thermal device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h | 1 +
 .../thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 95c6013a33fb..674f3c85dfbc 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -25,6 +25,7 @@
 #define PCI_DEVICE_ID_INTEL_HSB_THERMAL	0x0A03
 #define PCI_DEVICE_ID_INTEL_ICL_THERMAL	0x8a03
 #define PCI_DEVICE_ID_INTEL_JSL_THERMAL	0x4E03
+#define PCI_DEVICE_ID_INTEL_LNLM_THERMAL	0x641D
 #define PCI_DEVICE_ID_INTEL_MTLP_THERMAL	0x7D03
 #define PCI_DEVICE_ID_INTEL_RPL_THERMAL	0xA71D
 #define PCI_DEVICE_ID_INTEL_SKL_THERMAL	0x1903
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index d7495571dd5d..4e1dfd283651 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -407,6 +407,7 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
+	{ PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
-- 
2.43.0


