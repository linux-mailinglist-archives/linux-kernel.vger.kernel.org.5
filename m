Return-Path: <linux-kernel+bounces-85921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 522E586BCD4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805FD1C20F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F24C67;
	Thu, 29 Feb 2024 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjWpyBL/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF115B1;
	Thu, 29 Feb 2024 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166433; cv=none; b=a3tH/2kyoLlFGg9isR/mU2CBSLuEXPqiFcADsH2OceSOqc5TmxsXBxBovybERYu+N1/qa1ookU1cxRmWIXjAsTXB+8w0/+EFuyhYW5H1y6ExS89O+CQUJ2OoqejdceZDmzfFtgPUmvDiWS3963plFVMLr9cPIJ1mc+w9d2M5VK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166433; c=relaxed/simple;
	bh=6dE0XlBWX4tvzDq8lQshCJ55gvJcczOTwWaRKM0Khy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+VSnrfpkAgRncBz3iczpfV+Pq3nu1QC4ehx84JJXa9b3ZS3yxS48gfxCzbQtpe4OoONjj4PujlpdMD9099kjIaziUi6q4ruW4sj/5Pzh5k0ft0Y5/vTe4RlmhTYXr14PQzXHtmJUUWPBbJ4oQPSaIqmrJj3wJSzux6D6UZkRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjWpyBL/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709166432; x=1740702432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6dE0XlBWX4tvzDq8lQshCJ55gvJcczOTwWaRKM0Khy0=;
  b=CjWpyBL/ISc4XLxm1QH7MhR93wbW8/kyDNMzd4JehabyLwGXZyVy+Uhd
   jJRy/rUIH+YM8m6eYnhWxOyQE7c5Ztt9nUCx4a4u6PMB6gW/Tqta1ISuY
   IRAN6IxAmFfN8aHJKYXvUYj2W8ZBVayvYoR0B74ix8KsM0OilpdSnxUQ3
   Hs35EXFmDLbmTpszGuYT8iXgu9Tih7ky0Bn8mAIK7E79g64M1asVKVPBi
   s7NfR7YLVudUC9ir7qds5L5xIREng4s6TMq7tym8Ad/MWntiASwfg/1Ha
   LcTE4wJAA6UYb7WC5GdOmP/osU3mvRWpZI1jSkKtPOQDsFMCQjz47UXT2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="4188786"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="4188786"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:27:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7666801"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orviesa009.jf.intel.com with ESMTP; 28 Feb 2024 16:27:11 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	markgross@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: ISST: Allow reading core-power state on HWP disabled systems
Date: Wed, 28 Feb 2024 16:26:59 -0800
Message-Id: <20240229002659.1416623-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HWP (Hardware P-states) is disabled, dynamic SST features are
disabled. But user should still be able to read the current core-power
state, with legacy P-states. This will allow users to read current
configuration with static SST enabled from BIOS.

To address this, do not call disable_dynamic_sst_features() when the
request is for reading the state.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 2662fbbddf0c..1d918000d72b 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -462,10 +462,10 @@ static long isst_if_core_power_state(void __user *argp)
 	struct tpmi_per_power_domain_info *power_domain_info;
 	struct isst_core_power core_power;
 
-	if (disable_dynamic_sst_features())
+	if (copy_from_user(&core_power, argp, sizeof(core_power)))
 		return -EFAULT;
 
-	if (copy_from_user(&core_power, argp, sizeof(core_power)))
+	if (core_power.get_set && disable_dynamic_sst_features())
 		return -EFAULT;
 
 	power_domain_info = get_instance(core_power.socket_id, core_power.power_domain_id);
-- 
2.40.1


