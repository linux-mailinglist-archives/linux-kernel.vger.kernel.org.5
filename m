Return-Path: <linux-kernel+bounces-124036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA389116F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8580D1C29E80
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086CB39FC3;
	Fri, 29 Mar 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miLMt+Ye"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC5D23758;
	Fri, 29 Mar 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678183; cv=none; b=BYX69Og22gqx1aXReF79itqDX55Dx0Sf6hsyhbHfaVg/JUAODKS6bkIlvsAJeZdzqieW0Mln1KSLH1x4Vihvp/X9R0TOOW64jZQMNZqjwR6eZwa+8T/ptIbjaQ/HGcDGcfaN+oFEVvs0IgIZArQ1Yzpk4zOn7pemDu77ibBnBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678183; c=relaxed/simple;
	bh=K9Qk8pSUsltL7/8lG3y5liCiSXgfEq5ZpFkBVaabd6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Klc4rMj8bWjPwAg63Ep0hblmV/cbVXNu4Sp6o9Kzbv5NPk9vlSR7dbddCX9BNdP6EuCk1m4YCza4O8eyQzZKjOVEapzXcovJ9RycGgODk40f4N9b/uWIylaFHwnSl72slQNAouUG6xcfC4x3P6z2ZjaAKY0L0cF4RIlbxP67HCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miLMt+Ye; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678181; x=1743214181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K9Qk8pSUsltL7/8lG3y5liCiSXgfEq5ZpFkBVaabd6g=;
  b=miLMt+Yeu+tm2YLmwr4Gv+XK1plff/SZm9FmoeIt8ECM5VgKQiiN8vyI
   csQ0KPU2HOouqkFonfJRmepvmRgRWPJcamJnJlN45O/ke3gGrN+X595uq
   HQETb1VMDj9FBBd9kul4CXFWqAbS2pkP52n6wAq+IaR+3McH4uNPaq+A7
   2qk75oy4qPmQ4yoaEe1lzc2GNKZboutZQ5QIaJwI5vbnozMWVcyiAlA9c
   V7oQ5IQVa+4R5OnaLjkOnS4zlSfOOYipFYtkMtIHcsIVwAJh30D83c0Oh
   Rb9HEIEg/3pd2FlPguRPUVjQw5um9jkRMq+CsC34Gn1ba2nELSPmZPmHh
   w==;
X-CSE-ConnectionGUID: qYWiYffcSGafgreiA5J0HA==
X-CSE-MsgGUID: rwlPr3+YRFC+HLoSQs55Vw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700048"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700048"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301389"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:40 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dm-devel@redhat.com
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 04/14] x86/asm: Add a wrapper function for the LOADIWKEY instruction
Date: Thu, 28 Mar 2024 18:53:36 -0700
Message-Id: <20240329015346.635933-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015346.635933-1-chang.seok.bae@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Key Locker introduces a CPU-internal wrapping key to encode a user key
to a key handle. Then a key handle is referenced instead of the plain
text key.

LOADIWKEY loads a wrapping key in the software-inaccessible CPU state.
It operates only in kernel mode.

The kernel will use this to load a new key at boot time. Establish an
accessor for the feature setup, and define struct iwkey to pass a key
value.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
Changes from v6:
* Massage the changelog -- clarify the reason and the changes a bit.

Changes from v5:
* Fix a typo: kernel_cpu_begin() -> kernel_fpu_begin()

Changes from RFC v2:
* Separate out the code as a new patch.
* Improve the usability with the new struct as an argument. (Dan
  Williams)

Previously, Dan questioned the necessity of 'WARN_ON(!irq_fpu_usable())'
in the load_xmm_iwkey() function. However, it's worth noting that the
function comment emphasizes the caller's responsibility for invoking
kernel_fpu_begin(), which effectively performs the sanity check through
kernel_fpu_begin_mask().
---
 arch/x86/include/asm/keylocker.h     | 25 +++++++++++++++++++++++++
 arch/x86/include/asm/special_insns.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/x86/include/asm/keylocker.h

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
new file mode 100644
index 000000000000..4e731f577c50
--- /dev/null
+++ b/arch/x86/include/asm/keylocker.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_KEYLOCKER_H
+#define _ASM_KEYLOCKER_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/fpu/types.h>
+
+/**
+ * struct iwkey - A temporary wrapping key storage.
+ * @integrity_key:	A 128-bit key used to verify the integrity of
+ *			key handles
+ * @encryption_key:	A 256-bit encryption key used for wrapping and
+ *			unwrapping clear text keys.
+ *
+ * This storage should be flushed immediately after being loaded.
+ */
+struct iwkey {
+	struct reg_128_bit integrity_key;
+	struct reg_128_bit encryption_key[2];
+};
+
+#endif /*__ASSEMBLY__ */
+#endif /* _ASM_KEYLOCKER_H */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2e9fc5c400cd..65267013f1e1 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/irqflags.h>
 #include <linux/jump_label.h>
+#include <asm/keylocker.h>
 
 /*
  * The compiler should not reorder volatile asm statements with respect to each
@@ -301,6 +302,33 @@ static __always_inline void tile_release(void)
 	asm volatile(".byte 0xc4, 0xe2, 0x78, 0x49, 0xc0");
 }
 
+/**
+ * load_xmm_iwkey - Load a CPU-internal wrapping key into XMM registers.
+ * @key:	A pointer to a struct iwkey containing the key data.
+ *
+ * The caller is responsible for invoking kernel_fpu_begin() before.
+ */
+static inline void load_xmm_iwkey(struct iwkey *key)
+{
+	struct reg_128_bit zeros = { 0 };
+
+	asm volatile ("movdqu %0, %%xmm0; movdqu %1, %%xmm1; movdqu %2, %%xmm2;"
+		      :: "m"(key->integrity_key), "m"(key->encryption_key[0]),
+			 "m"(key->encryption_key[1]));
+
+	/*
+	 * 'LOADIWKEY %xmm1,%xmm2' loads a key from XMM0-2 into a
+	 * software-invisible CPU state. With zero in EAX, CPU does not
+	 * perform hardware randomization and allows key backup.
+	 *
+	 * This instruction is supported by binutils >= 2.36.
+	 */
+	asm volatile (".byte 0xf3,0x0f,0x38,0xdc,0xd1" :: "a"(0));
+
+	asm volatile ("movdqu %0, %%xmm0; movdqu %0, %%xmm1; movdqu %0, %%xmm2;"
+		      :: "m"(zeros));
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
-- 
2.34.1


