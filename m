Return-Path: <linux-kernel+bounces-85395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9FD86B55C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B128B228E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1210B34CDE;
	Wed, 28 Feb 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVFkPQb2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DC6EF10
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139442; cv=none; b=LQOgIOh7HUYaVlxzosPoZxv/6v6NfPLFRBNEgjhoVHN0GFd4iM7SbnFscf9IT4YcXpHCym0ejX38hzpoAzdmFdGgbX0xj1jL/dRpkVLsYqmxo9xhvKisV2XPAM9guILpEd2diHuDM4bNDxBzOyrkQGovMuLpnZKyUgCpSbkwHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139442; c=relaxed/simple;
	bh=phbEv7ysbvgxwpG7TOOGa4Oqlsk+ALMGgBrAccT/rds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PZ7hUi9SN6jLrp8rB7DOJhDZnzwabmzu4TaA518+Vh4ZGEOGktJH31xsj2E3LUER8li71l1lXHTE+acXTG40w5rbLK6unJMuHNTAIjTEYxoXDviTUUA7u3Wr/OkXHAnml3UGjQ4N1U8zJEPIsiAMA6/2EDiCBdYEFkstKlc/J3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVFkPQb2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709139439; x=1740675439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=phbEv7ysbvgxwpG7TOOGa4Oqlsk+ALMGgBrAccT/rds=;
  b=bVFkPQb2sKU2rDr1RII8TbACuq1+5jRMDbw7ubLLeOoGVa4Hgig2Om+G
   OeBVCHMe1I7KgZh6Yi8VkcwAJVPIllpCFyov4sSXpezwLaxhhK7K6STD1
   SyOzpqJhCEw9lpRe3QdOVbyDyMW5NAMGKIuusWNR3nD9m4SuyobwP8hYz
   FpdnPAFRyP+j3JgXSwn/KwXTTBolQ/Im1s9cO2bdjMUYspNGkF/2FrfXq
   2bgy0/hbPXEEM7wZ74XtNhZeMT5U4NvmrCcrraJOpCDw9rgYnjqLA0zK/
   HWA+GVvZY9fMUXoEDCI9j6ufcHAEdDQH3U3V7svhlBmKvsj2pN9ey3iNd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3401200"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3401200"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:57:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="12213419"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:57:17 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v2 1/4] devcoredump: Add dev_coredump_put()
Date: Wed, 28 Feb 2024 08:57:06 -0800
Message-ID: <20240228165709.82089-1-jose.souza@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is useful for modules that do not want to keep coredump available
after its unload.
Otherwise, the coredump would only be removed after DEVCD_TIMEOUT
seconds.

v2:
- dev_coredump_put() documentation updated (Mukesh)

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/base/devcoredump.c  | 23 +++++++++++++++++++++++
 include/linux/devcoredump.h |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 7e2d1f0d903a6..82aeb09b3d1b5 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -304,6 +304,29 @@ static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
 				  offset);
 }
 
+/**
+ * dev_coredump_put - remove device coredump
+ * @dev: the struct device for the crashed device
+ *
+ * dev_coredump_put() removes coredump, if exists, for a given device from
+ * the file system and free its associated data otherwise, does nothing.
+ *
+ * It is useful for modules that do not want to keep coredump
+ * available after its unload.
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


