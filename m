Return-Path: <linux-kernel+bounces-119761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A6988CCBB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574141C660B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34D13CF92;
	Tue, 26 Mar 2024 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdukS71c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212F13CC53;
	Tue, 26 Mar 2024 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480150; cv=none; b=d9cLiJq6e1OpiTN/nzRifC9RrL5jbzrPLE+9A1YJNlTHQKdxLPrm+EfHxl78D8ftAXQbVNAN3tA/RN1aDbzCF4Q9bsjE74ofHHiLxzTel/QBFS7YPDK6yyffGzTPoBGdP7JKHN8rBDg9k8KIEXNwtBzc9rQ7GHmIQEIf2Akidv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480150; c=relaxed/simple;
	bh=jPEKg4OZMPv+x29ywEYqCTSjJN+6hfNiWvLdCC14G+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGmRnOeuoNEpH9zJ8HWXUOJ7MpUmoMjT0StQolSxI8ibsQPgrDV4+etpq5+Ori20bsz9x39DxSNh3/AEoA7aIQTVBNXR7eu1wU2edvhw3fdU9CjR8927IFARoENRCZ3LPptGPDphf5ih1V3CkcoC83jKuNj0kMgueup2KVWibIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdukS71c; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711480148; x=1743016148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jPEKg4OZMPv+x29ywEYqCTSjJN+6hfNiWvLdCC14G+Q=;
  b=PdukS71cJYOfkDK2bq/Tqkjn4Dik6br72JyZG1okOIC3XobpZfQ9n366
   Ae+ro3yQr6RwT7FR2no3wYRUUmwlmgAY6OhvaiiRkr+UIRKhSK0VvvRLo
   9D+KkF41QbonW10rA5+daQ5MLqdjpVFgSKytukOsrYk2A9JzLWotI0E+p
   on/RRzM3fI8IhK/Uj4owlo45rZcZEyv4AIlnTT51U/YEphbkdel9AnGZr
   XxgFNkNcWmdajXJryLY+2cr0dfxMGxcSxNyyhZUFwkPA/S9+i971lfoTb
   swXEHFDScguBcvmKvsYOcaa75bhulsPkFhOpaI7jZMIAEyzwLa0NnR3wG
   Q==;
X-CSE-ConnectionGUID: 4ilfdbIURwqevsOu2+q/PQ==
X-CSE-MsgGUID: 1ilaa9qgTL2UZkAXClFELQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17696514"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17696514"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 12:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072978"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072978"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 12:09:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C0637284; Tue, 26 Mar 2024 21:09:04 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] media: atomisp: Remove unsused macros
Date: Tue, 26 Mar 2024 21:09:03 +0200
Message-ID: <20240326190903.1422069-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Entire defs.h can be killed, so do that.
Also kill same macro definitions in hive_types.h

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/media/atomisp/pci/bits.h      |  4 +-
 drivers/staging/media/atomisp/pci/defs.h      | 37 -------------------
 .../pci/hive_isp_css_common/host/dma_local.h  |  1 -
 .../staging/media/atomisp/pci/hive_types.h    | 19 ----------
 .../pci/runtime/debug/src/ia_css_debug.c      |  3 +-
 5 files changed, 4 insertions(+), 60 deletions(-)
 delete mode 100644 drivers/staging/media/atomisp/pci/defs.h

diff --git a/drivers/staging/media/atomisp/pci/bits.h b/drivers/staging/media/atomisp/pci/bits.h
index 9fab02ebddc5..f7a66287d763 100644
--- a/drivers/staging/media/atomisp/pci/bits.h
+++ b/drivers/staging/media/atomisp/pci/bits.h
@@ -16,9 +16,9 @@
 #ifndef _HRT_BITS_H
 #define _HRT_BITS_H
 
-#include "defs.h"
+#include <linux/args.h>
 
-#define _hrt_ones(n) HRTCAT(_hrt_ones_, n)
+#define _hrt_ones(n)	CONCATENATE(_hrt_ones_, n)
 #define _hrt_ones_0x0  0x00000000U
 #define _hrt_ones_0x1  0x00000001U
 #define _hrt_ones_0x2  0x00000003U
diff --git a/drivers/staging/media/atomisp/pci/defs.h b/drivers/staging/media/atomisp/pci/defs.h
deleted file mode 100644
index 785e7a670a00..000000000000
--- a/drivers/staging/media/atomisp/pci/defs.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Support for Intel Camera Imaging ISP subsystem.
- * Copyright (c) 2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
-
-#ifndef _HRT_DEFS_H_
-#define _HRT_DEFS_H_
-
-#ifndef HRTCAT
-#define _HRTCAT(m, n)     m##n
-#define HRTCAT(m, n)      _HRTCAT(m, n)
-#endif
-
-#ifndef HRTSTR
-#define _HRTSTR(x)   #x
-#define HRTSTR(x)    _HRTSTR(x)
-#endif
-
-#ifndef HRTMIN
-#define HRTMIN(a, b) (((a) < (b)) ? (a) : (b))
-#endif
-
-#ifndef HRTMAX
-#define HRTMAX(a, b) (((a) > (b)) ? (a) : (b))
-#endif
-
-#endif /* _HRT_DEFS_H_ */
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/dma_local.h b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/dma_local.h
index 48a1ace79897..1a71dbebbbe2 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/dma_local.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/dma_local.h
@@ -19,7 +19,6 @@
 #include <type_support.h>
 #include "dma_global.h"
 
-#include <defs.h>				/* HRTCAT() */
 #include <bits.h>				/* _hrt_get_bits() */
 #include <hive_isp_css_defs.h>		/* HIVE_DMA_NUM_CHANNELS */
 #include <dma_v2_defs.h>
diff --git a/drivers/staging/media/atomisp/pci/hive_types.h b/drivers/staging/media/atomisp/pci/hive_types.h
index 55d36931f079..34f462c0c9f9 100644
--- a/drivers/staging/media/atomisp/pci/hive_types.h
+++ b/drivers/staging/media/atomisp/pci/hive_types.h
@@ -17,25 +17,6 @@
 #define _HRT_HIVE_TYPES_H
 
 #include "version.h"
-#include "defs.h"
-
-#ifndef HRTCAT3
-#define _HRTCAT3(m, n, o)     m##n##o
-#define HRTCAT3(m, n, o)      _HRTCAT3(m, n, o)
-#endif
-
-#ifndef HRTCAT4
-#define _HRTCAT4(m, n, o, p)     m##n##o##p
-#define HRTCAT4(m, n, o, p)      _HRTCAT4(m, n, o, p)
-#endif
-
-#ifndef HRTMIN
-#define HRTMIN(a, b) (((a) < (b)) ? (a) : (b))
-#endif
-
-#ifndef HRTMAX
-#define HRTMAX(a, b) (((a) > (b)) ? (a) : (b))
-#endif
 
 /* boolean data type */
 typedef unsigned int hive_bool;
diff --git a/drivers/staging/media/atomisp/pci/runtime/debug/src/ia_css_debug.c b/drivers/staging/media/atomisp/pci/runtime/debug/src/ia_css_debug.c
index 3e92794555ec..3807b31bb98f 100644
--- a/drivers/staging/media/atomisp/pci/runtime/debug/src/ia_css_debug.c
+++ b/drivers/staging/media/atomisp/pci/runtime/debug/src/ia_css_debug.c
@@ -31,6 +31,7 @@
 #define __INLINE_STREAM2MMIO__
 #endif
 
+#include <linux/args.h>
 #include <linux/string.h> /* for strscpy() */
 
 #include "ia_css_debug.h"
@@ -861,7 +862,7 @@ void ia_css_debug_wake_up_sp(void)
 }
 
 #define FIND_DMEM_PARAMS_TYPE(stream, kernel, type) \
-	(struct HRTCAT(HRTCAT(sh_css_isp_, type), _params) *) \
+	(struct CONCATENATE(CONCATENATE(sh_css_isp_, type), _params) *) \
 	findf_dmem_params(stream, offsetof(struct ia_css_memory_offsets, dmem.kernel))
 
 #define FIND_DMEM_PARAMS(stream, kernel) FIND_DMEM_PARAMS_TYPE(stream, kernel, kernel)
-- 
2.43.0.rc1.1.gbec44491f096


