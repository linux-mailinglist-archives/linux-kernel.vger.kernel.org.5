Return-Path: <linux-kernel+bounces-155871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B08AF83A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2C51F251D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD871144D3C;
	Tue, 23 Apr 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBIW/eaC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D611442EA;
	Tue, 23 Apr 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905190; cv=none; b=DuT4kphVTg6tu2hK4UUV9KPm/dXan+wnJbhzSIyCRfwYpep/TvP52M2+NUemAAr+crwyxtG47fmPE3/iDm90N1B1sGEYoh8xZ2mHA4Yg7Djmd3C6pfVfpkqj5ujnn2a8TKl9pwEfvyOSJcINh6nTq+AVC4H3omiDk3o/Zhi2ouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905190; c=relaxed/simple;
	bh=l7QgDdD1rzDrQ916sGv1Kt/ZiPp4TwJIzuhR1lO0qgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F2wo8t2weJnnkdOmHr/yjRkjBcsTABlkktcUCG/D90Vnx6z5uBjJgcfDedO44NkF1MrAY3Qz+yrczQAGj+vMUAgsUxWR6OZpnd2VRMV9OnVTqMBgSuZ19Q01S7QDK83/6MFlOP6b7nOCJAkkUYFeCiBCJsaF1//19ABcy+yOI5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBIW/eaC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905189; x=1745441189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l7QgDdD1rzDrQ916sGv1Kt/ZiPp4TwJIzuhR1lO0qgY=;
  b=PBIW/eaCAmOQ7YsQjMdS0FORaCntRlSJXyLJYxplb/GPzALuWCuLr7iX
   4JkfL2lbfsL+0kMxCNF17FUOm/QpVMohNI9Qss8xcaAAjwruLZXRorn4Y
   QFxLr7DzS4qORvPrwUsv1+h9pH3AMPUUO5Zlev7LavnKLRu6QN1pa+ZFr
   W1rzdp8GGBeUU/EVG7NBnrPLRurjn2348FVMU6B3bay6S/BBOUhtgVa5Y
   i5dKnGfsEas4NvF2cDFwqFkDR8J9rBHCT6cLav/1xk+SGpSKifCPnbE48
   B2sye2a2WUafNTR7E51Ers/xxAusABu5cXGaJ4QY1Wo79RhGm9MsyBFUu
   A==;
X-CSE-ConnectionGUID: iU0X2PeOQI2yIgyUMSKhOA==
X-CSE-MsgGUID: Amp2KhcOQXCpFxnKJXWyBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912334"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912334"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:25 -0700
X-CSE-ConnectionGUID: tDkUjkwRQ2qhXYH69Bgv2g==
X-CSE-MsgGUID: HnktJxoeQYWNk026ltG/RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533092"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 09/10] platform/x86: ISST: Add dev_fmt
Date: Tue, 23 Apr 2024 13:46:18 -0700
Message-Id: <20240423204619.3946901-10-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
References: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dev_fmt for formatting log messages.

No functional impact is expected.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index e75fb9eba598..039333eac71a 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -17,6 +17,8 @@
  * the hardware mapping.
  */
 
+#define dev_fmt(fmt) "tpmi_sst: " fmt
+
 #include <linux/auxiliary_bus.h>
 #include <linux/delay.h>
 #include <linux/intel_tpmi.h>
-- 
2.40.1


