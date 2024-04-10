Return-Path: <linux-kernel+bounces-137850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8C489E83D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EACB288E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8379112E5E;
	Wed, 10 Apr 2024 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKtPTZq/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60043BE62;
	Wed, 10 Apr 2024 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716489; cv=none; b=bPI3jiWDSZlk7tByX2Fp6qE/F3rOy75mxqRyOGIZNcssYt2lFWq4T2v6m/otuvzIuUVN7h5peYu3602GRGPOo4tANApZ4d4z9aT4Ds05Owy4BKU5XRtUuroeow6yexZLAjvbuDUQiL8/J595L7JN/0RN7z43N3+rVizZW26P0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716489; c=relaxed/simple;
	bh=97waEfdu4g/jn/zcy7Jw0obSybbX1Ba1zMABmsAkRe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6xSvJNT5PZNg8FiHyQXkBeTD9mNI77DTvNmhsiug5+EntlJEulqKbKWzAt4k+S6FRVYL8zxKen46+fUrA3i3UqdMohVIj6Q59LT12BirC2D2Yur0M6x7rmsoXo2aXL8mvLgSNIKTniQclfxEUW66GH3LhhfjE0kTEf21HegFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKtPTZq/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712716489; x=1744252489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=97waEfdu4g/jn/zcy7Jw0obSybbX1Ba1zMABmsAkRe0=;
  b=IKtPTZq/GO8UJKZ0y3F99sPupBomTAaYRkcTo4Pq2oQUE01m3A6msakE
   jHxyvXM3eePerAwNaUOOgdFdry3EXw/RfdPYJeYjPrcAVahq8hQzI2dpY
   tdJMCvL2siq4qlMH+gaW/dewrzwKLnzN3gaQ4zLQxgwanoFU2Ga4nkO8c
   MWb1jpEdLgrIfM+mm/3iKYLOPJg+wx9h4yFoRFMYJutIwB/d8Wq2nq50B
   InzGMJSMTPq5lkimD0c4dgTI+OH7iybOnDuFILdEy4Ft29mVteA3iyTJ+
   Hgj3TjTvmzLJXwwus8I/qnCu7fYFNaniSQzp+CEiNRaUlZQxAwFdk+FJj
   A==;
X-CSE-ConnectionGUID: YfQZkmRMQ9SrGgdx4nM6KA==
X-CSE-MsgGUID: jzvd2IvLQUaF7Sgng1BLag==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11900180"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11900180"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:34:45 -0700
X-CSE-ConnectionGUID: C0dh7/ybRy+ntOWUiALZEw==
X-CSE-MsgGUID: V6jwpZppQZCusLJQQRHtzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43658584"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:34:44 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 4/4] soundwire: intel_init: resume all devices on exit.
Date: Wed, 10 Apr 2024 02:34:38 +0000
Message-Id: <20240410023438.487017-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410023438.487017-1-yung-chuan.liao@linux.intel.com>
References: <20240410023438.487017-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the manager becomes pm_runtime active in the remove procedure,
peripherals will become attached, and do the initialization
process. We have to wait until all the devices are fully resumed
before the cleanup, otherwise there is a possible race condition where
asynchronous workqueues initiate transfers on the bus that cannot
complete. This will ensure there are no SoundWire registers accessed
after the bus is powered-down.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 534c8795e7e8..a09134b97cd6 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -16,6 +16,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw_intel.h>
 #include "cadence_master.h"
+#include "bus.h"
 #include "intel.h"
 #include "intel_auxdevice.h"
 
@@ -356,6 +357,19 @@ EXPORT_SYMBOL_NS(sdw_intel_startup, SOUNDWIRE_INTEL_INIT);
  */
 void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 {
+	struct sdw_intel_link_res *link;
+
+	/* we first resume links and devices and wait synchronously before the cleanup */
+	list_for_each_entry(link, &ctx->link_list, list) {
+		struct sdw_bus *bus = &link->cdns->bus;
+		int ret;
+
+		ret = device_for_each_child(bus->dev, NULL, intel_resume_child_device);
+		if (ret < 0)
+			dev_err(bus->dev, "%s: intel_resume_child_device failed: %d\n",
+				__func__, ret);
+	}
+
 	sdw_intel_cleanup(ctx);
 	kfree(ctx->ids);
 	kfree(ctx->ldev);
-- 
2.34.1


