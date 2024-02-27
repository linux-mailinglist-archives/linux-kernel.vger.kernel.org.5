Return-Path: <linux-kernel+bounces-84008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FF486A167
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC1BB2BB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1F14EFF4;
	Tue, 27 Feb 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEspGJRd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F914DFF6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067621; cv=none; b=WW70G8QHdgTPDmS7v9HseX5n16SR4fXnLM1RUfmaUIyDC0OMX/kqCir5N+iug9dNUjftpyN/ABKoH359LadVKZ7Osw2KSI+aFZyWojrYcccFDvyZwKwVQEAl0JIlPDO6KMBh/KvzThZLFsLw0K7jDfpZ+bTkPmOyoUW1JVZ6oTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067621; c=relaxed/simple;
	bh=g5hSKz8PPuysfPZ2UMVY6d54ATC/Id6iUngulkNyu8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5qs2QgJZpOY6RVcQDiOx6saHox4vCmfOnoxQXRhmGyTn54IKFC10mHgA3wIToYbcagIaB8MYn3DwYxI63dUuk6E12RMkXPjSfGT+jf+saAxsw4O+JzvhEttwRyMRSfUFKHAUowNWGpbxw7woujaysVo4/qVE3xprzSY3Tpf7tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEspGJRd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709067620; x=1740603620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g5hSKz8PPuysfPZ2UMVY6d54ATC/Id6iUngulkNyu8w=;
  b=VEspGJRd7t8nQYINgeb6iZGx8NTPivmeK7KBTc6F/BZyA9WWSKrPr8fN
   F6HH0um1kj6wWlHtBar55BLkno2X7EfV3k3SPQe6nQ0BQh9L2X4DTFGsC
   T80VdzZTSDyhfPBHhp171ZeI88GZO4twNV5iPdeAiUXKui+rvP/2KJa/s
   jow8eObI2HmtCWrugfZZ9icnK2UoMMYanhAYgQFqL5Vzf//wVHoakZ/dd
   tmoQkhICypcpQGqOQuVlXa5/M51IVXubFQ+PyWSMyy/FZQsyEBJHwwV5m
   wdqxUOgm+M/xUD7rgr/cT89V6D0u/JTiTAIIj+sHPSpT84NPLMu7iCrw+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14858445"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14858445"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7150417"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:00:17 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH 2/4] devcoredump: Add dev_coredump_timeout_set()
Date: Tue, 27 Feb 2024 13:00:06 -0800
Message-ID: <20240227210008.182904-2-jose.souza@intel.com>
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

Add function to set a custom coredump timeout.

Current 5-minute timeout may be too short for users to search and
understand what needs to be done to capture coredump to report bugs.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/base/devcoredump.c  | 23 +++++++++++++++++++++++
 include/linux/devcoredump.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index e96427411b87c..2857ceb3eb3aa 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -326,6 +326,29 @@ void dev_coredump_put(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_coredump_put);
 
+/**
+ * dev_coredump_timeout_set - set coredump timeout
+ * @dev: the struct device for the crashed device
+ * @secs_timeout: new timeout in seconds
+ *
+ * If giving device has a coredump this sets a new timeout for coredump.
+ */
+void dev_coredump_timeout_set(struct device *dev, unsigned long secs_timeout)
+{
+	struct device *existing;
+	struct devcd_entry *devcd;
+
+	existing = class_find_device(&devcd_class, NULL, dev,
+				     devcd_match_failing);
+	if (!existing)
+		return;
+
+	devcd = dev_to_devcd(existing);
+	mod_delayed_work(system_wq, &devcd->del_wk, HZ * secs_timeout);
+	put_device(existing);
+}
+EXPORT_SYMBOL_GPL(dev_coredump_timeout_set);
+
 /**
  * dev_coredumpm - create device coredump with read/free methods
  * @dev: the struct device for the crashed device
diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
index c8f7eb6cc1915..70fe72a5c6d36 100644
--- a/include/linux/devcoredump.h
+++ b/include/linux/devcoredump.h
@@ -65,6 +65,7 @@ void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		    size_t datalen, gfp_t gfp);
 
 void dev_coredump_put(struct device *dev);
+void dev_coredump_timeout_set(struct device *dev, unsigned long secs_timeout);
 #else
 static inline void dev_coredumpv(struct device *dev, void *data,
 				 size_t datalen, gfp_t gfp)
@@ -90,6 +91,11 @@ static inline void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 static inline void dev_coredump_put(struct device *dev)
 {
 }
+
+static inline void dev_coredump_timeout_set(struct device *dev,
+					    unsigned long secs_timeout)
+{
+}
 #endif /* CONFIG_DEV_COREDUMP */
 
 #endif /* __DEVCOREDUMP_H */
-- 
2.44.0


