Return-Path: <linux-kernel+bounces-1923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD68155E4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCEFDB23F37
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C2710FE;
	Sat, 16 Dec 2023 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHSwmXTB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066411852;
	Sat, 16 Dec 2023 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702689427; x=1734225427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mkZmks8ROVSmnV6+EMeQT+TwjHNSjsWx9+cU31FtD2k=;
  b=IHSwmXTBVCJsXa3DENN+jy3QTJN8fLZOHxQ/B+v5nEdraowSvaMYBPHT
   WWq73QnLnjnqcTQvI8G9KO8JO2/5llaegoMRY9IE7nqpW2aBNWhwQgCPk
   6hUISqbAMR9dkdC4tq6zAS2twDEqJsLp3dxSvycgGNrJhf90RrOJodxvq
   un78zSi1zRlJEninVrt6Pub3Q6oHpc1OIM354sZIvH6k7OLIfKLII+87A
   b44BxeG8eVi/dHf8m+OUWBiV/kOR9Jqyr37wem4aX/bAz8jDTyY4E5OG1
   yOaw73xqr64sReC2INuFmD2Z2OstJprZn4+twUTzpZA3qtqAyg8GvdjNG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="395086355"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="395086355"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 17:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="809164137"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="809164137"
Received: from simmons1-mobl5.amr.corp.intel.com (HELO rjingar-desk5.intel.com) ([10.213.162.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 17:17:05 -0800
From: rjingar <rajvi.jingar@linux.intel.com>
To: irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	markgross@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rajvi.jingar@linux.intel.com
Subject: [PATCH 2/2] platform/x86/intel/pmc: Fix in pmc_core_ssram_get_pmc()
Date: Fri, 15 Dec 2023 17:17:02 -0800
Message-Id: <20231216011702.1976408-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajvi Jingar <rajvi.jingar@linux.intel.com>

Passing PMC_IDX_MAIN in pmc_core_pmc_add() adds only primary pmc to pmcdev.
Use pmc_idx instead to add all available pmcs.

Fixes: a01486dc4bb1 ("platform/x86/intel/pmc: Cleanup SSRAM discovery")
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core_ssram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 3501c7bd6b33..55e54207987c 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -287,7 +287,7 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
 	if (!map)
 		return -ENODEV;
 
-	return pmc_core_pmc_add(pmcdev, pwrm_base, map, PMC_IDX_MAIN);
+	return pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
 }
 
 int pmc_core_ssram_init(struct pmc_dev *pmcdev)
-- 
2.34.1


