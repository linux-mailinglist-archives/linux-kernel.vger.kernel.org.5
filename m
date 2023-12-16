Return-Path: <linux-kernel+bounces-1922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA448155E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CD6B23F02
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04362110B;
	Sat, 16 Dec 2023 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1+t8tUS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819A10FE;
	Sat, 16 Dec 2023 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702689415; x=1734225415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uu/DuVeOYQ8cy5ChNWdZWy4tzkcdqBmvZKljPoGxouA=;
  b=P1+t8tUSa6V8ChZpa8Peuf3IOdntlWwfnbbuiKlqmCPc2pchZphsCGIe
   NyV/s/gIzGPbgZ47WxogjnGcolzkqviyG2hYztwYmIzZdwaf+Pmb4cyJg
   HOgpxGMNUCA7ejcPOlLS+LBENpZ5wZjUAUVzlSHQPhMSnitz714olI68J
   2v2/G42E1SvEboTiLak5UBYpubz1cq976waHB5qkjWcnRjFrSvfsuOWle
   9X271oP9N60LPU3VWw0e/o6qnCl2dIEl2uKIAb87sTxb/sUrUvVexI2gI
   KIXwAE1VEvQiSFTX4lJD1lyBmx45eEf9PYcquNyZ3ZaU0VkvAgB/KFUcP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="392520044"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="392520044"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 17:16:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="948139340"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="948139340"
Received: from simmons1-mobl5.amr.corp.intel.com (HELO rjingar-desk5.intel.com) ([10.213.162.133])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 17:16:53 -0800
From: rjingar <rajvi.jingar@linux.intel.com>
To: irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	markgross@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rajvi.jingar@linux.intel.com
Subject: [PATCH 1/2] platform/x86/intel/pmc: Fix hang in pmc_core_send_ltr_ignore()
Date: Fri, 15 Dec 2023 17:16:50 -0800
Message-Id: <20231216011650.1973941-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajvi Jingar <rajvi.jingar@linux.intel.com>

For input value 0, PMC stays unassigned which causes crash while trying
to access PMC for register read/write. Include LTR index 0 in pmc_index
and ltr_index calculation.

Fixes: 2bcef4529222 ("platform/x86:intel/pmc: Enable debugfs multiple PMC support")
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 983e3a8f4910..55eb6a4683fb 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -474,7 +474,7 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
 	 * is based on the contiguous indexes from ltr_show output.
 	 * pmc index and ltr index needs to be calculated from it.
 	 */
-	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs) && ltr_index > 0; pmc_index++) {
+	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs) && ltr_index >= 0; pmc_index++) {
 		pmc = pmcdev->pmcs[pmc_index];
 
 		if (!pmc)
-- 
2.34.1


