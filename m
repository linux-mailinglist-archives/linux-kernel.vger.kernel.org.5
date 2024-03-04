Return-Path: <linux-kernel+bounces-90746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5665A87045F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8F90B26B0E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD747A6B;
	Mon,  4 Mar 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtKTOoVk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11252575B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563159; cv=none; b=VeR7miPmG8pbYUYybUQyd8raF8gvVcAXuAsa9WB8XRBVXOPXfPF4PpiYTG3FXpH3zgKDxXyTG8XrJejhPIQW3mjcXZG9WUSXRg2FHHJ1PnLr4vinVshEOy5J5s/w1hsk/3cDQR5FEQLlScfyd+BGJphEP2cPvuNfsJ/pmeAvc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563159; c=relaxed/simple;
	bh=Ev9vAd6KMr30CCRVCaJ2grIXca9Zj7XJ7NQCoKyrOb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyK02Hh3jx/C0qJacrimq9mFMBv7BUsqqDPHY5u49vRI51e/MfKLtjtKg+2IZwJTb/3Sj1c7MtT5T486LchSZgZiEnQRLwNe6N9baJmGQDffU0wM4I9hcMJjxC2iImJIPVLHlEP3+KZUHcz1WXFe7WZlDkxDhLWbG/2qMQiNqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtKTOoVk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709563158; x=1741099158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ev9vAd6KMr30CCRVCaJ2grIXca9Zj7XJ7NQCoKyrOb0=;
  b=VtKTOoVkkGwuP/NR+aSxEGhIDLJVaFfhK91Up617JSyVJ1D3sWaPdRdc
   J7bxO8aNaIsvtHg5vqTts2eGGTp+abkMm0gQebXBkF8JV8RPBUF+8qmEi
   zBC3lPWFElHiVZklsNpGZJitEZHbESRWfiPUG0MqXt9sUkIKBH9THoqG5
   L6ETLw16WnSLDiGCC87qNNI7aXhA2tPk75ad0fXMKMlkFfJXpsEpzR/8K
   3QRnDMOvAGABR4quIrC8wIYx72YSkhguMkNxjHEkEEIpe8jxLs9P/5Lit
   9uEVXA+EB0Km7y4xqlJp6BHMO6Q9StA9n8IpDe6BhIiEU270aRIfIbtla
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="15464639"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="15464639"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:39:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9162547"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:39:16 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v3 3/4] drm/xe: Remove devcoredump during driver release
Date: Mon,  4 Mar 2024 06:39:04 -0800
Message-ID: <20240304143905.52740-3-jose.souza@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304143905.52740-1-jose.souza@intel.com>
References: <20240304143905.52740-1-jose.souza@intel.com>
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
Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 13 ++++++++++++-
 drivers/gpu/drm/xe/xe_devcoredump.h |  5 +++++
 drivers/gpu/drm/xe/xe_device.c      |  4 ++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 0fcd306803236..109c027188bd9 100644
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
@@ -230,5 +232,14 @@ void xe_devcoredump(struct xe_sched_job *job)
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


