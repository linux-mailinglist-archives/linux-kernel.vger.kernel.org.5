Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4417BFF14
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjJJOWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjJJOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:22:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FC191;
        Tue, 10 Oct 2023 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696947767; x=1728483767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QuUaC9YOuX87JW2J8slurScV01GdxJIdY83DI5FquNY=;
  b=GK+YQS2hvDmQGFZ70CGVEBY4pTuFMx08phhs7aPrmdBHTNSjKK1xgOjz
   Dh5mNGgA7Q7m7whJ62Yt6j1OxdEQPV9PZ+Rlc/IeMHhh8Q53oAnd5HVlR
   fJX8wZy4wR/1Hj00qfKgpowGbY7rctIw+P6AFdB/RWj8vihJGTqWcTIzb
   dtKp/soLbL8xjIOSOPKtGukBa6IWrnF6vsLqpFTv1TiioJk1aFPziWm/K
   bgKiRec1heZrd4gPSsvrMInn8MD3DZ66uK14XxH6MOEhH7SzdE4NK7ymN
   z6CYvSSTUUXUmzVR92OWLXJqrzBfGevoNbcXekaA5qWVkB+I97mCCSnli
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="381665076"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="381665076"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="823794124"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="823794124"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.36.106])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:22:44 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Add unaligned.h to check-headers.sh
Date:   Tue, 10 Oct 2023 17:22:34 +0300
Message-Id: <20231010142234.20061-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005190451.175568-1-adrian.hunter@intel.com>
References: <20231005190451.175568-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add include/asm-generic/unaligned.h to check-headers.sh bringing
tools/include/asm-generic/unaligned.h up to date so that the kernel and
tools versions match.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Based on top of 5 patch set "perf intel-pt: Use of get_unaligned_le16() etc"


 tools/include/asm-generic/unaligned.h | 129 ++++++++++++++++++++++++--
 tools/perf/check-headers.sh           |   1 +
 2 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
index 9140bb4e16c6..156743d399ae 100644
--- a/tools/include/asm-generic/unaligned.h
+++ b/tools/include/asm-generic/unaligned.h
@@ -1,11 +1,11 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_UNALIGNED_H
+#define __ASM_GENERIC_UNALIGNED_H
+
 /*
- * Copied from the kernel sources to tools/perf/:
+ * This is the most generic implementation of unaligned accesses
+ * and should work almost anywhere.
  */
-
-#ifndef __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
-#define __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
-
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wpacked"
 
@@ -37,7 +37,120 @@ static inline u64 get_unaligned_le64(const void *p)
 	return le64_to_cpu(__get_unaligned_t(__le64, p));
 }
 
-#pragma GCC diagnostic pop
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_t(__le16, cpu_to_le16(val), p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_t(__le32, cpu_to_le32(val), p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_t(__le64, cpu_to_le64(val), p);
+}
+
+static inline u16 get_unaligned_be16(const void *p)
+{
+	return be16_to_cpu(__get_unaligned_t(__be16, p));
+}
+
+static inline u32 get_unaligned_be32(const void *p)
+{
+	return be32_to_cpu(__get_unaligned_t(__be32, p));
+}
+
+static inline u64 get_unaligned_be64(const void *p)
+{
+	return be64_to_cpu(__get_unaligned_t(__be64, p));
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	__put_unaligned_t(__be16, cpu_to_be16(val), p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	__put_unaligned_t(__be32, cpu_to_be32(val), p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	__put_unaligned_t(__be64, cpu_to_be64(val), p);
+}
+
+static inline u32 __get_unaligned_be24(const u8 *p)
+{
+	return p[0] << 16 | p[1] << 8 | p[2];
+}
 
-#endif /* __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H */
+static inline u32 get_unaligned_be24(const void *p)
+{
+	return __get_unaligned_be24(p);
+}
+
+static inline u32 __get_unaligned_le24(const u8 *p)
+{
+	return p[0] | p[1] << 8 | p[2] << 16;
+}
+
+static inline u32 get_unaligned_le24(const void *p)
+{
+	return __get_unaligned_le24(p);
+}
+
+static inline void __put_unaligned_be24(const u32 val, u8 *p)
+{
+	*p++ = val >> 16;
+	*p++ = val >> 8;
+	*p++ = val;
+}
+
+static inline void put_unaligned_be24(const u32 val, void *p)
+{
+	__put_unaligned_be24(val, p);
+}
+
+static inline void __put_unaligned_le24(const u32 val, u8 *p)
+{
+	*p++ = val;
+	*p++ = val >> 8;
+	*p++ = val >> 16;
+}
+
+static inline void put_unaligned_le24(const u32 val, void *p)
+{
+	__put_unaligned_le24(val, p);
+}
+
+static inline void __put_unaligned_be48(const u64 val, u8 *p)
+{
+	*p++ = val >> 40;
+	*p++ = val >> 32;
+	*p++ = val >> 24;
+	*p++ = val >> 16;
+	*p++ = val >> 8;
+	*p++ = val;
+}
+
+static inline void put_unaligned_be48(const u64 val, void *p)
+{
+	__put_unaligned_be48(val, p);
+}
+
+static inline u64 __get_unaligned_be48(const u8 *p)
+{
+	return (u64)p[0] << 40 | (u64)p[1] << 32 | (u64)p[2] << 24 |
+		p[3] << 16 | p[4] << 8 | p[5];
+}
+
+static inline u64 get_unaligned_be48(const void *p)
+{
+	return __get_unaligned_be48(p);
+}
+#pragma GCC diagnostic pop
 
+#endif /* __ASM_GENERIC_UNALIGNED_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 4314c9197850..d09c3d46f08f 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -161,6 +161,7 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
 check arch/x86/include/asm/amd-ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
 check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
+check include/asm-generic/unaligned.h '-I "^#include <linux/unaligned/packed_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
-- 
2.34.1

