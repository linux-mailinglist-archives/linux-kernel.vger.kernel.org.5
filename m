Return-Path: <linux-kernel+bounces-46592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1378441C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42C11F22BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE683CA0;
	Wed, 31 Jan 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ou0OvIwy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D328287A;
	Wed, 31 Jan 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711033; cv=none; b=TpLseAR6GJDVKgvzordYkaqU2mLSm4FtWsyZApQe/5uX9GpswspBS5PvDpT8OMk0MFy/LuTMZ29ApuKPrCwgVoBbVGQBEF3l0S0dMQ8aciJYkgk7GvRV0aMmc7UE8ONdrHJ/xtAyvjBB683UtBUKfO01IGk0NxkB1MRDseTbjes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711033; c=relaxed/simple;
	bh=ExThFueBF01BuVDK0GX8VUsqgRBQ4Ib5Eh3cgKUlZ7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ajEqjAc6/ZeDj1/d7TuArsfeRA+uuZTht4wTRL03A43kB1/dyddh5YBUYI5ywZGLJw9oaZkupj1x7EwwnK5IZp/s/yhEtckLyRrZzNA+30HFwkshxpgJOMsP6lNwLsJRumiCExYNINZmEqtTY0ysjRg0cQprvsTl6zG647AVDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ou0OvIwy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706711032; x=1738247032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ExThFueBF01BuVDK0GX8VUsqgRBQ4Ib5Eh3cgKUlZ7A=;
  b=Ou0OvIwyxtbk4ZJsRFz3z91toRLMryB7vvAgpKwHr3LfQahWIZwRqb1m
   4VtwyvcN/wGViUv2jMt/MSamaswPXCNDH6ygOevL2903PIP7g7lawOLXQ
   Y4gep2OfqUzKf4OsVLFnOazoFyhZ5/x6bZ7koIecoRbxEY80Cy4ZkgO9r
   1xzDCjAgAZRT7SwhtU3oZDcoqARVmhOp21JHo+6MQE5BWhg9YweiVt90k
   E6fWXrLfKmetRUobg+Inx2shsDMMpbTve4bUsHukz4E/VgP9nvQhzEEMI
   k7OguPLdwR7nfxeGr6xvj2vetQ4ZFrGq1X1Qwi926SRJqD4vY6kHJf+EW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10995802"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10995802"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4068683"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:23:48 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	peterz@infradead.org
Cc: mingo@redhat.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 1/5] powercap: intel_rapl: Sort header files
Date: Wed, 31 Jan 2024 22:23:31 +0800
Message-Id: <20240131142335.84218-2-rui.zhang@intel.com>
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

Sort header files alphabetically.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index aa627a6b12a4..315e304219e2 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -5,27 +5,27 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitmap.h>
 #include <linux/cleanup.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/intel_rapl.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/list.h>
-#include <linux/types.h>
-#include <linux/device.h>
-#include <linux/slab.h>
 #include <linux/log2.h>
-#include <linux/bitmap.h>
-#include <linux/delay.h>
-#include <linux/sysfs.h>
-#include <linux/cpu.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/powercap.h>
-#include <linux/suspend.h>
-#include <linux/intel_rapl.h>
 #include <linux/processor.h>
-#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
-#include <asm/iosf_mbi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/iosf_mbi.h>
 
 /* bitmasks for RAPL MSRs, used by primitive access functions */
 #define ENERGY_STATUS_MASK      0xffffffff
-- 
2.34.1


