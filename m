Return-Path: <linux-kernel+bounces-85399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D639286B563
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DBE1F26DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A637B15D5B2;
	Wed, 28 Feb 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NphCj0O2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872EA3FBB7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139449; cv=none; b=LIWVybOIrJ8EBrNsrdDqGVwJ35H4l0YzLVIBV6fSTqpMW3W4LYWzx0A/Y9Xe12lSCdS5K8N9y1d4Gl5Rqth2zRjbCgDH0V7aIZU2rQlI7CoVzorTLYeQPuox0KAiYfkkvUXAN2bFNrwZPMV0Q4h0RS5yq4QVVmyQv90yZpY4qMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139449; c=relaxed/simple;
	bh=Ztn1ISsr+ww0L63y9IS9gk+ABQmLXaSuSOq9U/IgZcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlZf4ZGsHKQuXi/izIpJTEdfjPQe3xZZn728tF6buiN/Fak/Knufeve+SUUttdzBViKrItYCv73EXNtVI6Uz5AL2SP79s70AHBrdwzD4jrhC77MMbJYCo0lkzHW0LLHi8xHsFzePOME7igA0IcouEP+JCyhXU/GwUqkydcd6dxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NphCj0O2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709139444; x=1740675444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ztn1ISsr+ww0L63y9IS9gk+ABQmLXaSuSOq9U/IgZcw=;
  b=NphCj0O27vmOkoye8GYhb2ipqFpRZd3solMba4NCGxmEbJ2uBua8FUpz
   Mism33QNIGPQ8E1mW111fp1eUfkA5eTjWLwtjT+3NivJOGuJ2Rro9Ieaj
   rLBvAMqHS/XiBBBswnqu+lRp1DJAQFvRY8z7m56D5tC8m95b0ndLza3nP
   GJy9DydCVgSVkHTcNiAJjEEfSyfDT9NzyUvzzGu7dzRMfykBIfqhyZlZ2
   hBNIUH62s4tZTrKUWTuUj12isMItolKGFCs9c+acBiJoN3TltVf6fM1LV
   irCMaTNOLAP0Rwq2r+FUeV7fvdl45LKR3spgDmwo5D8YC7480BwzeRIB+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3401222"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3401222"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:57:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="12213455"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:57:23 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v2 4/4] drm/xe: Increase devcoredump timeout
Date: Wed, 28 Feb 2024 08:57:09 -0800
Message-ID: <20240228165709.82089-4-jose.souza@intel.com>
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

5 minutes is too short for a regular user to search and understand
what he needs to do to report capture devcoredump and report a bug to
us, so here increasing this timeout to 1 hour.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 3fef81396fe8a..a26aac63d6ecf 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -52,6 +52,9 @@
 
 #ifdef CONFIG_DEV_COREDUMP
 
+/* 1 hour timeout */
+#define XE_COREDUMP_TIMEOUT_JIFFIES (60 * 60 * HZ)
+
 static struct xe_device *coredump_to_xe(const struct xe_devcoredump *coredump)
 {
 	return container_of(coredump, struct xe_device, devcoredump);
@@ -230,8 +233,9 @@ void xe_devcoredump(struct xe_sched_job *job)
 	drm_info(&xe->drm, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
 		 xe->drm.primary->index);
 
-	dev_coredumpm(xe->drm.dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
-		      xe_devcoredump_read, xe_devcoredump_free);
+	dev_coredumpm_timeout(xe->drm.dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
+			      xe_devcoredump_read, xe_devcoredump_free,
+			      XE_COREDUMP_TIMEOUT_JIFFIES);
 }
 
 static void xe_driver_devcoredump_fini(struct drm_device *drm, void *arg)
-- 
2.44.0


