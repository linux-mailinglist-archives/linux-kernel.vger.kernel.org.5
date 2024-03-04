Return-Path: <linux-kernel+bounces-90743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4587045A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5008D1C21007
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D70D40C15;
	Mon,  4 Mar 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ji2JuPx1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB56726AE7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563156; cv=none; b=oW0HLrNtsmTsNEJT8LSW/O4ey8wF54s/CPDyUFcsn4mGSB2cUKOQiAGZ0aHQT+VKdViwX6H/6EjhoplEHkoNchoL9MId0NU7BhfMo4w265hmf7reA9pqhbD+e5uPA+8vPp8m/0ctB0IysoHyGkeTUpvQRxesWfegFVDcFan9+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563156; c=relaxed/simple;
	bh=+MRf5Lm7FcBWGyRnw6HSAym7eF960AjwB9H891dwqBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MehSEmGdXip2iUcxFI2TL2f0EwcGzJdgGFHoKTBO29hqNMgWG62WOxp2T9Iot4gnvXqdpB1a4JBXjkafUxiTre6y1XoNmwDm6WvC/5jAFYkruzqMOHSyxmCgyYI2LViFHmE63A3MqlGuFesy1mIgsluQNkk08JFKrKRSVbf5lZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ji2JuPx1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709563155; x=1741099155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+MRf5Lm7FcBWGyRnw6HSAym7eF960AjwB9H891dwqBg=;
  b=ji2JuPx1crnRorsQ4wb1oF1A0XRZ4uZTAZ1NhAewnrXt0fcSbYzNRTuN
   ne1yohJvL0YCCupG2KwxilBJ2TLdYVB6qiKpPM3ASAJ3Tzs3b/x02PfFJ
   l6ZGREZG3JLgNITeTC1UUECSdNFOT76XUu0SqT2Non18LXqSE2+UTnVBk
   0idfv1HjE7a6vifswqqnR+KnmepCJw/Qu4ismswCTFJ+WwRZpcRZXa/p/
   8E6kHv0g5NuWvuNTjpAn5hlz966xM9nsFWCk4fGzWN4ypaRJig7pKKMBQ
   Dk93BIJqyycVqAZJ5Uk1q9NwxRxSLxXFlpuR9Qblkk5RvLqB8CSVJK7kE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="15464629"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="15464629"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:39:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9162521"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:39:12 -0800
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v3 1/4] devcoredump: Add dev_coredump_put()
Date: Mon,  4 Mar 2024 06:39:02 -0800
Message-ID: <20240304143905.52740-1-jose.souza@intel.com>
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
Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
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


