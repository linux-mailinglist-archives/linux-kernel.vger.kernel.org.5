Return-Path: <linux-kernel+bounces-65463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B5A854D67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472BC28DBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992E85D910;
	Wed, 14 Feb 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePB/i5iO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127295CDC9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926077; cv=none; b=hOzWuKXN8wcacffbM6cIIl3KJKxBQTPaQhuBEvuV+kOTqrQyPClxYlPKwKlCp5sb21qYxd4e+vJ0QU3v0QGorV9jQU9dztm79d3FDMjDUQ10kd7fzfmbuIArWSqU+b6L3vC7X1Hog6yNutWRedtUzMJqyWuKrx2E03S5WvqA9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926077; c=relaxed/simple;
	bh=VujCBmuxbzMp+KdK6LlDdgxP+TebDwZSMVtNMdB+1dk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Moztk4SuppTvN6yDPi/WvmK77+khyvGlQh+g697MKYhpjGERqZ/wInIc2v3FDRjvFLFQezwZa4TM7800PLsotqpiyjFSC7p8I6a+/ApoAHWAeHiv3ERzKjBSv8ukkmuiZbOFq/DZWOpjCzB5LcjEAZHU08f5JMVXoWnitDFJ73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePB/i5iO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707926076; x=1739462076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VujCBmuxbzMp+KdK6LlDdgxP+TebDwZSMVtNMdB+1dk=;
  b=ePB/i5iOgRqR+TKngGnIwkiCkZdXhOx4k4PQNoTEsM4JtRbRasWS4QCc
   hToqIfHjC7FH5A956rsf4kjKMpK1SbEYWie2dDFxGueuLl4NM9UiIt1WZ
   VZC3kxyvbs2tQsby3VnUe9CMOoYOkgB3GoGXpy/XeUo/YzJhuv0hjt3sA
   3MpbQJzuEZFmapGVFytheltGkCBiigdxQvKEERYsSAPSTP+ptQNCkIplE
   Pa2in3PC6ikIs5W3kZQJUeZqwPhJHs8/DjqviNMsHKDuSIH1s6U5DcEi6
   c4Hk1DsESa9Yy2MVy6ThIADHHOnjch6LttdI57rFQch1W6EzQOar6gqVO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13071861"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="13071861"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:54:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7893650"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.138.241])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:54:34 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [RFC] include/linux/make_type.h: Helpers for making u16/u32/u64 values
Date: Wed, 14 Feb 2024 16:54:08 +0100
Message-Id: <20240214155408.1569-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is quite common practice to make u16, u32 or u64 values from
smaller words.  Add simple helpers for that.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/make_type.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 include/linux/make_type.h

diff --git a/include/linux/make_type.h b/include/linux/make_type.h
new file mode 100644
index 000000000000..60e2e091ea3c
--- /dev/null
+++ b/include/linux/make_type.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_MAKE_TYPE_H
+#define _LINUX_MAKE_TYPE_H
+
+#include <linux/types.h>
+
+/**
+ * make_u16 - make u16 value from two u8 values
+ * @hi__: value representing upper 8 bits
+ * @lo__: value representing lower 8 bits
+ */
+#define make_u16(hi__, lo__)  ((u16)(u8)(hi__) << 8 | (u8)(lo__))
+
+/**
+ * make_u32 - make u32 value from two u16 values
+ * @hi__: value representing upper 16 bits
+ * @lo__: value representing lower 16 bits
+ */
+#define make_u32(hi__, lo__)  ((u32)(u16)(hi__) << 16 | (u16)(lo__))
+
+/**
+ * make_u64 - make u64 value from two u32 values
+ * @hi__: value representing upper 32 bits
+ * @lo__: value representing lower 32 bits
+ */
+#define make_u64(hi__, lo__)  ((u64)(hi__) << 32 | (u32)(lo__))
+
+#endif
-- 
2.43.0


