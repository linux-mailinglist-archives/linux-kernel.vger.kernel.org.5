Return-Path: <linux-kernel+bounces-10266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBC81D1E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D08A285A80
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E303D520;
	Sat, 23 Dec 2023 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Et1q5zCF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5461B79F2;
	Sat, 23 Dec 2023 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703301956; x=1734837956;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ejKM6Nv6PFWughHe2wl2ebjlYx53nsbMF+dHQa95DuA=;
  b=Et1q5zCFBn422eTLZeiIeSFsavJl0RRJlwRJiniYisjn9xdeYSQB48xu
   hnqKTH6EYFG4s5p688p/gVxDmhyoMzzTjq9R2qPcJLXOa3fRugQXevnKJ
   y97I4/E1/gc1P4daZpT3RfAhEvX7tuxvzcVlI3BIT2wK37nEpgI6toUXK
   0canW1Cnbm81de6a0Q97UH+TSIUgWj4Yx4oA7HUtb7QYt4s9JphQhD/Q1
   FKieVxNnOjjw/S4PmY7a9qP9wrnYyEsz7jSr2mm775hTmGOu6dat1pA6w
   EJiYUfXHIY2zBB03dE7muW6V7iCAIlIRc+vNAP8DvxRgQLO3u/EWDjV+8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395922871"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="395922871"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1024436818"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="1024436818"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.110])
	by linux.intel.com (Postfix) with ESMTP id B6F88580DB9;
	Fri, 22 Dec 2023 19:25:51 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] platform/x86/intel/pmc: Add suspend callback
Date: Fri, 22 Dec 2023 19:25:43 -0800
Message-Id: <20231223032548.1680738-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231223032548.1680738-1-david.e.box@linux.intel.com>
References: <20231223032548.1680738-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a suspend callback to struct pmc for performing platform specific tasks
before device suspend. This is needed in order to perform GBE LTR ignore on
certain platforms at suspend-time instead of at probe-time and replace the
GBE LTR ignore removal that was done in order to fix a bug introduced by
commit 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
core_configure()").

Fixes: 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and core_configure()")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 3 +++
 drivers/platform/x86/intel/pmc/core.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index cdaab728e942..31905003bb05 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1430,6 +1430,9 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 
+	if (pmcdev->suspend)
+		pmcdev->suspend(pmcdev);
+
 	/* Check if the syspend will actually use S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 2891d8d04fad..ce9b9efc9790 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -389,6 +389,7 @@ struct pmc {
  * @s0ix_counter:	S0ix residency (step adjusted)
  * @num_lpm_modes:	Count of enabled modes
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
+ * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
  *
  * pmc_dev contains info about power management controller device.
@@ -406,6 +407,7 @@ struct pmc_dev {
 	u64 s0ix_counter;
 	int num_lpm_modes;
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
+	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 
 	bool has_die_c6;
-- 
2.34.1


