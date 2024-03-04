Return-Path: <linux-kernel+bounces-90747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBCF870460
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD62D1C211FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDAD46535;
	Mon,  4 Mar 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxTbWTPM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026245BF6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563161; cv=none; b=gJ+KCj5zoFrPw2vEAiV+iaM0nNL/fthZADKGk16JRjr8ILjJzg61U+y7ZGumlfi5Slc3iT4yckhcxQGdaflm8NVLjuTmxxH2dN9wY2/JBGU8+b4lyj1iKMvnnV6knoulWSX0eb3m6jOjBQQnnp5znOyNb5jBMDE2j0t2e4aaVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563161; c=relaxed/simple;
	bh=TQZp5xpOX2dnHZfG1mH9kj65SYkNhEAl0tLk1zElFu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCiE6aIjKPW5DmpSMMI6WAAwmwZEa/Y25IxvSe3xRFPUOWOdQV0GJycNY4hWI4ZaOVqT8cN749Byn2c59m4oSLIhKSbCivjI6AM9AzSBtMB0kldwjaJbhN1ES0T3LQFiM8sAyh7HNzvU3XPAESDay9EwXRBjsyexxMFTVew+VYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxTbWTPM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709563159; x=1741099159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQZp5xpOX2dnHZfG1mH9kj65SYkNhEAl0tLk1zElFu0=;
  b=fxTbWTPM6vY/SxI7rqxSR1H3NzoWUV1/AUSyNp/Sx/ezxh6hhqgH8V0n
   TlWm0kt1bOoBTvsFLPfHQ4+7Ft3Kc5QGmOQVn6hcGKJ7+Sr87uRXWjJHF
   b4zYBoPX3VoAtE93HX3Gb2XTSEvT6H2rIHr6Ge9f28bAX0JN7wsuMMEjk
   2uhZVEhppkDYglOT/VZOX4HWM/LOWciBZqsOfN1iQZKXFeo0Fw00cNZt8
   kZzaU3r4ytx/F/M9kHtbxc2OuYjbAACAAyVytaL+0uuQAWVv1JhUvbnev
   meExvP4Tz8pdUg8JTpQknzh/1paqPDsfuphR++SR5VCstWRW3WpLf0gb2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="15464644"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="15464644"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9162552"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:39:18 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v3 4/4] drm/xe: Increase devcoredump timeout
Date: Mon,  4 Mar 2024 06:39:05 -0800
Message-ID: <20240304143905.52740-4-jose.souza@intel.com>
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

5 minutes is too short for a regular user to search and understand
what he needs to do to report capture devcoredump and report a bug to
us, so here increasing this timeout to 1 hour.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 109c027188bd9..08c60531e0db4 100644
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
@@ -229,8 +232,9 @@ void xe_devcoredump(struct xe_sched_job *job)
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


