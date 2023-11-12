Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ED57E8F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjKLJnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:43:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BBE2D64
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699782177; x=1731318177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dE0hghh+wuYV8oKVl43s7OS4ftZk66STgAdHkYO/4fw=;
  b=NaCebm40VgNDzxSf/X11YVs4DsdpQbPxeYlEx+7e0UffwoHdr+ZSsOx7
   VF7UwcCgkb3nXu1SjGPj2tDNbF9iWJZFUvdAX4gNl9Dl6nGTcGCNrXE5o
   DKLovac9dlQ8ZRjSvfzs0jiEZdhBw9DYSrCe0Qx/UitegVIgSqDin3FhJ
   9W8j2pz05KMYPOgt6RQDGHcQfKTok037k+RZASP6OBYk0lDczsnax29Gd
   Rs498Iv9E52KjQAHShBzHcjL/v922sCrtrBlO9hMPJmW2LMVG3Uffpafg
   iC8ckU0fiAhU+9HQBmpR9BLM6xny5AmX8f91D6+u9mHrFKoHCSQcbTvU6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="421418571"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="421418571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 01:42:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="907800337"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="907800337"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga001.fm.intel.com with ESMTP; 12 Nov 2023 01:42:54 -0800
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     anup@brainfault.org, haicheng.li@intel.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH] riscv: Optimize hweight API with Zbb extension
Date:   Sun, 12 Nov 2023 17:52:44 +0800
Message-Id: <20231112095244.4015351-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hamming Weight of a number is the total number of bits set in it, so
the cpop/cpopw instruction from Zbb extension can be used to accelerate
hweight() API.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/include/asm/arch_hweight.h | 78 +++++++++++++++++++++++++++
 arch/riscv/include/asm/bitops.h       |  4 +-
 2 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/arch_hweight.h

diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
new file mode 100644
index 000000000000..c20236a0725b
--- /dev/null
+++ b/arch/riscv/include/asm/arch_hweight.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Based on arch/x86/include/asm/arch_hweight.h
+ */
+
+#ifndef _ASM_RISCV_HWEIGHT_H
+#define _ASM_RISCV_HWEIGHT_H
+
+#include <asm/alternative-macros.h>
+#include <asm/hwcap.h>
+
+#if (BITS_PER_LONG == 64)
+#define CPOPW	"cpopw "
+#elif (BITS_PER_LONG == 32)
+#define CPOPW	"cpop "
+#else
+#error "Unexpected BITS_PER_LONG"
+#endif
+
+static __always_inline unsigned int __arch_hweight32(unsigned int w)
+{
+#ifdef CONFIG_RISCV_ISA_ZBB
+	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm (".option push\n"
+	     ".option arch,+zbb\n"
+	     CPOPW "%0, %0\n"
+	     ".option pop\n"
+	     : "+r" (w) : :);
+
+	return w;
+
+legacy:
+#endif
+	return __sw_hweight32(w);
+}
+
+static inline unsigned int __arch_hweight16(unsigned int w)
+{
+	return __arch_hweight32(w & 0xffff);
+}
+
+static inline unsigned int __arch_hweight8(unsigned int w)
+{
+	return __arch_hweight32(w & 0xff);
+}
+
+#if BITS_PER_LONG == 64
+static __always_inline unsigned long __arch_hweight64(__u64 w)
+{
+# ifdef CONFIG_RISCV_ISA_ZBB
+	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm (".option push\n"
+	     ".option arch,+zbb\n"
+	     "cpop %0, %0\n"
+	     ".option pop\n"
+	     : "+r" (w) : :);
+
+	return w;
+
+legacy:
+# endif
+	return __sw_hweight64(w);
+}
+#else /* BITS_PER_LONG == 64 */
+static inline unsigned long __arch_hweight64(__u64 w)
+{
+	return  __arch_hweight32((u32)w) +
+		__arch_hweight32((u32)(w >> 32));
+}
+#endif /* !(BITS_PER_LONG == 64) */
+
+#endif /* _ASM_RISCV_HWEIGHT_H */
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index b212c2708cda..f7c167646460 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -271,7 +271,9 @@ static __always_inline int variable_fls(unsigned int x)
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 
-#include <asm-generic/bitops/hweight.h>
+#include <asm/arch_hweight.h>
+
+#include <asm-generic/bitops/const_hweight.h>
 
 #if (BITS_PER_LONG == 64)
 #define __AMO(op)	"amo" #op ".d"
-- 
2.25.1

