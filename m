Return-Path: <linux-kernel+bounces-46595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B48441C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75C81F231C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705D58288C;
	Wed, 31 Jan 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvFqLAnp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8E84A29;
	Wed, 31 Jan 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711043; cv=none; b=p7G271R7BRvV38B0Jfou10JxtDx2vISYm+LbE4nMjEu3dZl95nJ4bzlHKasxKaQO57fxvz+RghJJYR9JxOZh9aqlGGJt6nauTPiAQi9YTjtJYtUGFrKr9DorG6u5J+mWt2o0U1ZzqrXn7cFh25kWniq5AkK6EbMWoza/t4RzCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711043; c=relaxed/simple;
	bh=P/1acTucceqt/grzvkOvrapX+WjE/maAY0kvtIA7xMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIAL5BOhOT6e/Q3Kqo1D6pCIRTpZZR06lG/2mOkAUBMaJs23Zenpe6nEn72IihNUicvxJVOMwpySv+U5lu3TzwsJNMdABBmweI18iz8q1Zi4DIqlyYcP/O3I4uj8gOUuyYzuTuuXFChHzK3pwi5wRkUVT3Cs7avO0qFD82YeVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvFqLAnp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706711042; x=1738247042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/1acTucceqt/grzvkOvrapX+WjE/maAY0kvtIA7xMU=;
  b=cvFqLAnp4Lci5GIF4NcpbU+t5OrEEgxSYox3S8S9KcV8ovom6CtTuc3+
   1l19x043Ep3O43NwLLJhLjwIRAVbRtS535/uggzynZW6CkneUNkCsqe0I
   mKFjl2zCaR9GH4ChOh31UDLC/BgQIQhOQkXWiT8t8tLqVGRJxSSNFgGYw
   csciAnwrVr+Qfq3KThjh5qPm/UPhkS2CCZJfcBMuI8TsF46/Cx237UMkr
   3nDxE0HZwdPg8OiEjq2kGvIBk3cA51xIJ+jtzTDKq1Pc/r+lVFMIXs639
   qJq/WqR3TnC5Ze0jEuikSM8VmAELZOz1reeCY1OpdFsmPlYtSJ5CqJQ3a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10995839"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10995839"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:24:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4068756"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:23:58 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	peterz@infradead.org
Cc: mingo@redhat.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 4/5] powercap: intel_rapl: Fix BROADWELL_D Dram energy unit
Date: Wed, 31 Jan 2024 22:23:34 +0800
Message-Id: <20240131142335.84218-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131142335.84218-1-rui.zhang@intel.com>
References: <20240131142335.84218-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BROADWELL_D uses a fixed energy unit for Dram Domain like the other Xeon
servers, e.g. BROADWELL_X.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 318174c87249..094e226b8bd3 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1235,7 +1235,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&rapl_defaults_hsw_server),
 	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&rapl_defaults_hsw_server),
 
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&rapl_defaults_core),
-- 
2.34.1


