Return-Path: <linux-kernel+bounces-85397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF20286B55F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9047AB23066
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2E12F38F;
	Wed, 28 Feb 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTywNE41"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85548208B2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139444; cv=none; b=fJxop5ABJHv6WKjMxkt55mb5o1DT8FfXIIPLZoCW+fKSTtUdlMzXJU/diX04qgMHPzY9YZKx3YY3LnmLRQrWstJf8jl7hZRTb0pCZ5zeOOhK0Ij1aA7awssqJ/V/H3BeGQrC5XuDBS93y/L/o6YnHlDd7uPywacwVdUHY12UAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139444; c=relaxed/simple;
	bh=AIkMM1NMy91FDgmfFFaJ0HxHDsRelsqEiKUcFIg+iw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqTNkvkG9eGkkNbGv4P7DTr0D1J2WMcnVdGrtyWPTpVwBYbPdlIx7IiLSDsHElzQOBQ+Vj/dHrpVwdM6ZJj+X2Or3P+NjhLCvm3jx/FGu58+QlgxI1nX/lqzdmXKUtE/QyHmNLs5lC9VVqQ1irkI1tm5RB8QTsbC682NlkctX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTywNE41; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709139442; x=1740675442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AIkMM1NMy91FDgmfFFaJ0HxHDsRelsqEiKUcFIg+iw8=;
  b=CTywNE41vHAyg5zlXuFLhmMXodQaFSiAJ/Es7lUzgyBHegC+Xc3Cj+Yc
   Y2KIWts6UcU23+mO6o/FuD87OY9lfo0jIHDNpjgZXFGXWyCDhpJaP228p
   jBgE0GmUyqV4/irPHafrYP8okOg/19CKDBw4V+MG0+YbB53Wmd75Lr54w
   LrTpAVzVq7TNTBFw/s0qA5sv48O3Yof5UT+3nAGKsq/KusubZUIzdfLew
   gGR39187SfX0dx7Vl/efhus06JJJ8Leofq7VmCil0yePByAw4l++Kpf1n
   xvAS6B+HZhA+wV4MyNI0e6A2J1cIlRAUadMJ1+wEvvd0YpDF/wcLnv0+9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3401214"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3401214"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="12213438"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:57:21 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v2 3/4] drm/xe: Remove devcoredump during driver release
Date: Wed, 28 Feb 2024 08:57:08 -0800
Message-ID: <20240228165709.82089-3-jose.souza@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240228165709.82089-1-jose.souza@intel.com>
References: <20240228165709.82089-1-jose.souza@intel.com>
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


