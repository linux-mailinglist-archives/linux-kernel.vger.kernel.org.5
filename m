Return-Path: <linux-kernel+bounces-84009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E734586A147
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE3C1F224BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0041714F975;
	Tue, 27 Feb 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNWniD1z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93E314E2CB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067622; cv=none; b=fOVk70fzi3JVp5SAGpnhyafqOvMROd81LkU/TUUTPLplhduPE39UBIqQQn2f/G26x6E0HBAJFDNXsV9ctcT5R/byDL3+E0G7zGNQxiadr2+YATKgMutyMM6QAjp5KadVXnHYpi3DyKT0yjevqcIG+X5cP/3ZXa5i4NdJAU0OSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067622; c=relaxed/simple;
	bh=AIkMM1NMy91FDgmfFFaJ0HxHDsRelsqEiKUcFIg+iw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEY6m4H5vngLIJAmFIl5YDopt2LxVNAGQ/4ZWCKdnqCFqJODIdtuqAVizHO3SdPggU+mXmf7gQdNmlf0etT8HbzFgr0uYoinKAF0MGTwrXHzkwtIAxrXeXa/0ynWk8GKXpCBpZqT2mCdRtKJfkKIbp78edBkiYvD7yLutk1BTCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNWniD1z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709067621; x=1740603621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AIkMM1NMy91FDgmfFFaJ0HxHDsRelsqEiKUcFIg+iw8=;
  b=FNWniD1zrr9PoKOCcGiMrAj2+KWZxw26DhT1sCDcBpk1XLKobm7brJhV
   3+AryNna8+FNQaKdowZN+ucUXMUPk9ldGBt127k7WLu+0uMi7TPOzVTEM
   ZZUeZY8+V8LHBl+x94LbvW7aqCrzWx/MKYa6K9LV1dIRbMZWINU5Mr4zY
   PuMlJs1svdmB7waivjv8BwTlIqSS55WC3Jb0x1UXink0zXcge3Pd6Xrbt
   fu2AAE8UWrrI3qnUSn/dD/ew+EWfKMQzZ7OefaPeKA9ipSroQ8yFKEIZq
   4/13L78axYeqJmZGYlnteq0I4JRE7N3eHIzuDowEWhzsqdKiFPvlBVD9U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14858450"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14858450"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:00:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7150425"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:00:19 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH 3/4] drm/xe: Remove devcoredump during driver release
Date: Tue, 27 Feb 2024 13:00:07 -0800
Message-ID: <20240227210008.182904-3-jose.souza@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227210008.182904-1-jose.souza@intel.com>
References: <20240227210008.182904-1-jose.souza@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This will remove devcoredump from file system and free its resources
during driver unload.

This fix the driver unload after gpu hang happened, otherwise this
it would report that Xe KMD is still in use and it would leave the
kernel in a state that Xe KMD can't be unload without a reboot.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 13 ++++++++++++-
 drivers/gpu/drm/xe/xe_devcoredump.h |  5 +++++
 drivers/gpu/drm/xe/xe_device.c      |  4 ++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 68d3d623a05bf..3fef81396fe8a 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -9,6 +9,8 @@
 #include <linux/devcoredump.h>
 #include <generated/utsrelease.h>
 
+#include <drm/drm_managed.h>
+
 #include "xe_device.h"
 #include "xe_exec_queue.h"
 #include "xe_force_wake.h"
@@ -231,5 +233,14 @@ void xe_devcoredump(struct xe_sched_job *job)
 	dev_coredumpm(xe->drm.dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
 		      xe_devcoredump_read, xe_devcoredump_free);
 }
-#endif
 
+static void xe_driver_devcoredump_fini(struct drm_device *drm, void *arg)
+{
+	dev_coredump_put(drm->dev);
+}
+
+int xe_devcoredump_init(struct xe_device *xe)
+{
+	return drmm_add_action_or_reset(&xe->drm, xe_driver_devcoredump_fini, xe);
+}
+#endif
diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
index df8671f0b5eb2..9eba67f37234f 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.h
+++ b/drivers/gpu/drm/xe/xe_devcoredump.h
@@ -11,10 +11,15 @@ struct xe_sched_job;
 
 #ifdef CONFIG_DEV_COREDUMP
 void xe_devcoredump(struct xe_sched_job *job);
+int xe_devcoredump_init(struct xe_device *xe);
 #else
 static inline void xe_devcoredump(struct xe_sched_job *job)
 {
 }
+static inline int xe_devcoredump_init(struct xe_device *xe)
+{
+	return 0;
+}
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 919ad88f0495a..22be76537c7da 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -20,6 +20,7 @@
 #include "regs/xe_regs.h"
 #include "xe_bo.h"
 #include "xe_debugfs.h"
+#include "xe_devcoredump.h"
 #include "xe_dma_buf.h"
 #include "xe_drm_client.h"
 #include "xe_drv.h"
@@ -502,6 +503,9 @@ int xe_device_probe(struct xe_device *xe)
 			return err;
 	}
 
+	err = xe_devcoredump_init(xe);
+	if (err)
+		return err;
 	err = drmm_add_action_or_reset(&xe->drm, xe_driver_flr_fini, xe);
 	if (err)
 		return err;
-- 
2.44.0


