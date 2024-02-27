Return-Path: <linux-kernel+bounces-84007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBFA86A158
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C12B233DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9014EFCE;
	Tue, 27 Feb 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhxqhSbD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3513AA36
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067620; cv=none; b=rQkU8Yj/21RogQ6xWqD9ZjfLMIHYmj7nVMiW4FpvrrYsj7xL+WvWNj+a6J4nKRXnBNqWmnSM1Gbk2OWsWIK6mkgV3B/tmnz8TXLJ4Hfpl1giQJ/STLcMMEJGpF+Njqa2Ekggf/LPQt3Ou+9qbJl7D0EsfunhvMXdYEZDJc9GBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067620; c=relaxed/simple;
	bh=RE/r0QBlJkpfsDcdAyyvBwd5gHrITMQLec9sLSeOxDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ta5SXgPrniOfUXMze+a5DXyQCUB8IhV3Yyzry6AhtO2VmejP0ap2FTfS/QSyvFfpShOsEhlSbVn1JmIBgCjgVi1EBOxkWwUCo0DfAY5e91dbqsD8NOQ9H3lzO9RcXb2ht1dlQBbBuYomDLbaZVooJF1iwHZjL/kCantKbqlKW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhxqhSbD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709067618; x=1740603618;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RE/r0QBlJkpfsDcdAyyvBwd5gHrITMQLec9sLSeOxDo=;
  b=nhxqhSbDiBp972rNAyv08Ln4t9PLnmkQgDaICHyWe3Tuye5TMSmUjS1o
   6Qxr5l0faIRc18FVnVTWur+nxzsBnbXzDoOKjDZzxUvXtqo39WCg9J9GF
   7TL8h2Hu5YeXD+gPErhybN/mJIsR25tXhEkz+PHrtT+bDN3JAC7p25LXi
   vKjXtzq+NIRshzUGUQ5NWzy5rkamGpxId/WOU1p9Vy9lS8KN+jCnE6727
   20ziw6YPpQGb6BmA9sE4Dvda466O/rl3RYRe0VeeuQrsiQlpI8t8PJ8gN
   AUS1ttYSdneEiCeONHDRZvuKnnN8W3cZvDtIhLk8w0so9/u6aMoqCNETc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14858440"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14858440"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7150405"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:00:14 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH 1/4] devcoredump: Add dev_coredump_put()
Date: Tue, 27 Feb 2024 13:00:05 -0800
Message-ID: <20240227210008.182904-1-jose.souza@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is useful for drivers that don't want to keep a coredump
available after unloading.
Otherwise, the coredump would only be removed after DEVCD_TIMEOUT
seconds.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/base/devcoredump.c  | 22 ++++++++++++++++++++++
 include/linux/devcoredump.h |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 7e2d1f0d903a6..e96427411b87c 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -304,6 +304,28 @@ static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
 				  offset);
 }
 
+/**
+ * dev_coredump_put - remove device coredump
+ * @dev: the struct device for the crashed device
+ *
+ * If giving device has a coredump this removes it from file system and free
+ * associated data otherwise does nothing.
+ * This is useful for drivers that don't want to keep a coredump
+ * available after unloading.
+ */
+void dev_coredump_put(struct device *dev)
+{
+	struct device *existing;
+
+	existing = class_find_device(&devcd_class, NULL, dev,
+				     devcd_match_failing);
+	if (existing) {
+		devcd_free(existing, NULL);
+		put_device(existing);
+	}
+}
+EXPORT_SYMBOL_GPL(dev_coredump_put);
+
 /**
  * dev_coredumpm - create device coredump with read/free methods
  * @dev: the struct device for the crashed device
diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
index c008169ed2c6f..c8f7eb6cc1915 100644
--- a/include/linux/devcoredump.h
+++ b/include/linux/devcoredump.h
@@ -63,6 +63,8 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 
 void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		    size_t datalen, gfp_t gfp);
+
+void dev_coredump_put(struct device *dev);
 #else
 static inline void dev_coredumpv(struct device *dev, void *data,
 				 size_t datalen, gfp_t gfp)
@@ -85,6 +87,9 @@ static inline void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 {
 	_devcd_free_sgtable(table);
 }
+static inline void dev_coredump_put(struct device *dev)
+{
+}
 #endif /* CONFIG_DEV_COREDUMP */
 
 #endif /* __DEVCOREDUMP_H */
-- 
2.44.0


