Return-Path: <linux-kernel+bounces-121521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E8688EB46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A10B3C04A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE714884D;
	Wed, 27 Mar 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzJ1AF/U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BEE59B71;
	Wed, 27 Mar 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553111; cv=none; b=oFzJMW1iEc85Q1kW29yneCPQa+DI22W0or7wyr0xZwBhcgDAHXn9yDEiWfz/KF5HBIoVZpaA96jYpfvaF5av8BGp5MhSfOjqKBjaLE1aRQkMc60eh8TD5+csTD3e4wNJEkd6evXLWjGborDqngMQbptVC29nMlRr6aiEl75uBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553111; c=relaxed/simple;
	bh=7aqDMG3jXWM6P9Y6VUwEci4LhL45xGo7CgLld4wLHOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxtWafzIA9rOIzFrhmLByS+ouPPAkgViRuDYnbEx4kgvzBgc092pF97IdYDEeBYmpv+pyncaHQzlw60Qi6V94FOg+AdSsAMrcl8zuWd5RtBKtj7XK3IYBT5bY9mI3XFn8drNGsgTa5JD+12F4Zdv6iDN4u59PkZZkhwZwJrXDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzJ1AF/U; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553110; x=1743089110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7aqDMG3jXWM6P9Y6VUwEci4LhL45xGo7CgLld4wLHOc=;
  b=hzJ1AF/U9qnizza8DO/smL/UeCBJLQ4EQs9qz3mRGQCF+v0lFmynweIv
   o3ISX/9eF7am6jb7N/euw2Efoy4JqWizcAhHQMyHd9Nz+YElZ2GZPaEdS
   zPMjMZR0SUZr/WMRVjj2NDQvFcuJo4bglECWZM0/x7TbPSLKhiSwIsPse
   oDSkhYyI7MSZ1KikOJstpkC/dZ2TNP9nFKW5z8Xiu5fuY70JtyiXV2mkG
   gemGQ73IzeN7HM/wl+IgmGA1K0hmqWoPZsNzgcG+vMKO9e3wpanxC9yZH
   Zx8v4qVpPliizmhAFh+Vie8BwX7IFGFuM6Ri72woX6gPPLoT8y1ew10ei
   A==;
X-CSE-ConnectionGUID: ZNzS/yUeQg+mGa7AjKDOpQ==
X-CSE-MsgGUID: D7bWW5myT5STH262TF4Ueg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518206"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518206"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414270"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:25:07 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 11/21] tools: move alignment-related macros to new <linux/align.h>
Date: Wed, 27 Mar 2024 16:23:48 +0100
Message-ID: <20240327152358.2368467-12-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, tools have *ALIGN*() macros scattered across the unrelated
headers, as there are only 3 of them and they were added separately
each time on an as-needed basis.
Anyway, let's make it more consistent with the kernel headers and allow
using those macros outside of the mentioned headers. Create
<linux/align.h> inside the tools/ folder and include it where needed.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 tools/include/linux/align.h  | 12 ++++++++++++
 tools/include/linux/bitmap.h |  2 +-
 tools/include/linux/mm.h     |  5 +----
 3 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 tools/include/linux/align.h

diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
new file mode 100644
index 000000000000..14e34ace80dd
--- /dev/null
+++ b/tools/include/linux/align.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TOOLS_LINUX_ALIGN_H
+#define _TOOLS_LINUX_ALIGN_H
+
+#include <uapi/linux/const.h>
+
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif /* _TOOLS_LINUX_ALIGN_H */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index f3566ea0f932..8c6852dba04f 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -3,6 +3,7 @@
 #define _TOOLS_LINUX_BITMAP_H
 
 #include <string.h>
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/find.h>
 #include <stdlib.h>
@@ -126,7 +127,6 @@ static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 #define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
-#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
 
 static inline bool bitmap_equal(const unsigned long *src1,
 				const unsigned long *src2, unsigned int nbits)
diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index f3c82ab5b14c..7a6b98f4e579 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -2,8 +2,8 @@
 #ifndef _TOOLS_LINUX_MM_H
 #define _TOOLS_LINUX_MM_H
 
+#include <linux/align.h>
 #include <linux/mmzone.h>
-#include <uapi/linux/const.h>
 
 #define PAGE_SHIFT		12
 #define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
@@ -11,9 +11,6 @@
 
 #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
 
-#define ALIGN(x, a)			__ALIGN_KERNEL((x), (a))
-#define ALIGN_DOWN(x, a)		__ALIGN_KERNEL((x) - ((a) - 1), (a))
-
 #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
 
 #define __va(x) ((void *)((unsigned long)(x)))
-- 
2.44.0


