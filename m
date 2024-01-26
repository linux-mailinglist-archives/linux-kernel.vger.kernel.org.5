Return-Path: <linux-kernel+bounces-39549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9E383D2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47397290198
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFB28F54;
	Fri, 26 Jan 2024 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rx1CsyTW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B28C02
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236758; cv=none; b=mrP5Zqtc7rPEADIw+jCe6oqrAUAxUo/tW6QySzqwK4OIiFv7IPdlmvh1vhrXp0wG5hhYhBtiR+YvTYztsw3JT/L37+I5EB17Vl5AZNzSVA32nAGD7UkWZ79eGvE8MJXpuU/dIaVwqFnOaUyXpJvTDsDzUApJNciirgWPRx4+z20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236758; c=relaxed/simple;
	bh=+4tSwa8xEYSJtn8456UIP6EXLxlrRpE8qtbh+wOeVX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMEUUOjSh5ZzEO14y4GeLo9E0OY4cFbHm2Fv9O4YWqxPDhFCRozbc1eBO8TbQLUW/LsW0TzBbxZpBDXOQ3DgO9Aigo3xKcPHN7I6N4GWmksnRFdwoP2/VJmuCQM3YwixHByWXYd1/iRJaahmvX5z65s2m2ivQ/0I2exZpyds108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rx1CsyTW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706236756; x=1737772756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+4tSwa8xEYSJtn8456UIP6EXLxlrRpE8qtbh+wOeVX8=;
  b=Rx1CsyTWyWB05QeXP3tbjT5aK+0mRwWwZpBhV2L7jbbPzt5Feij0jqyY
   PEfxmMHYa2xPFF6sKls2W2arNzD0u4NZ7sh3w2Di2i03US7f+6rPkItWE
   b9wJ90ZJYgWC4QIbo4glMks7WBr3BN5JT4/8Rdq4OGf71bm2u+TZR/3dd
   yST+1kO9mGrT6CNlyMvs55O9EGNVDEYIB3MUEPngirVaZsfDjVf3DUAeP
   2I3lUuR86k/OXJComZPu4CjizjfCg1lxLr8dKE4vEiYlVwUR3mmvIKoxL
   DdQora/yB6stOiCaUXFcmtJbXTctsBymiI/a4Km73jpI2z7NaJ8A+v45x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2210702"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2210702"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 18:39:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28687353"
Received: from xiaoyudo-mobl.ccr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.255.29.83])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 18:39:08 -0800
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rafael@kernel.org,
	dan.j.williams@intel.com,
	hpa@zytor.com,
	geert@linux-m68k.org,
	bhe@redhat.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	frederic@kernel.org,
	dave.jiang@intel.com,
	xin3.li@intel.com,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	yuan.yao@intel.com
Subject: [RESEND PATCH] x86/asm: Remove the __iomem annotation of movdir64b()'s dst argument
Date: Fri, 26 Jan 2024 15:38:52 +1300
Message-ID: <20240126023852.11065-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all
packages") causes below sparse check warning:

  arch/x86/virt/vmx/tdx/tdx.c:683:27: warning: incorrect type in argument 1 (different address spaces)
  arch/x86/virt/vmx/tdx/tdx.c:683:27:    expected void [noderef] __iomem *dst
  arch/x86/virt/vmx/tdx/tdx.c:683:27:    got void *

The reason is TDX must use the MOVDIR64B instruction to convert TDX
private memory (which is normal RAM but not MMIO) back to normal.  The
TDX code uses existing movdir64b() helper to do that, but the first
argument @dst of movdir64b() is annotated with __iomem.

When movdir64b() was firstly introduced in commit 0888e1030d3e
("x86/asm: Carve out a generic movdir64b() helper for general usage"),
it didn't have the __iomem annotation.  But this commit also introduced
the same "incorrect type" sparse warning because the iosubmit_cmds512(),
which was the solo caller of movdir64b(), has the __iomem annotation.

This was later fixed by commit 6ae58d871319 ("x86/asm: Annotate
movdir64b()'s dst argument with __iomem").  That fix was reasonable
because until TDX code the movdir64b() was only used to move data to
MMIO location, as described by the commit message:

  ... The current usages send a 64-bytes command descriptor to an MMIO
  location (portal) on a device for consumption. When future usages for
  the MOVDIR64B instruction warrant a separate variant of a memory to
  memory operation, the argument annotation can be revisited.

Now TDX code uses MOVDIR64B to move data to normal memory so it's time
to revisit.

The SDM says the destination of MOVDIR64B is "memory location specified
in a general register", thus it's more reasonable that movdir64b() does
not have the __iomem annotation on the @dst.

Remove the __iomem annotation from the @dst argument of movdir64b() to
fix the sparse warning in TDX code.  Similar to memset_io(), introduce a
new movdir64b_io() to cover the case where the destination is an MMIO
location, and change the solo caller iosubmit_cmds512() to use the new
movdir64b_io().

In movdir64b_io() explicitly use __force in the type casting otherwise
there will be below sparse warning:

  warning: cast removes address space '__iomem' of expression

Fixes: e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all packages")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312311924.tGjsBIQD-lkp@intel.com/
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Yuan Yao <yuan.yao@intel.com>
---

Resend:
  - Added Reviewed-by tags from Dave J/Kirill/Yuan (Thanks!)
  - Regenerate the patch based on latest tip/master

---
 arch/x86/include/asm/io.h            | 2 +-
 arch/x86/include/asm/special_insns.h | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 3814a9263d64..294cd2a40818 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -379,7 +379,7 @@ static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
 	const u8 *end = from + count * 64;
 
 	while (from < end) {
-		movdir64b(dst, from);
+		movdir64b_io(dst, from);
 		from += 64;
 	}
 }
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index d6cd9344f6c7..f661277e52d6 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -224,10 +224,10 @@ static inline void serialize(void)
 }
 
 /* The dst parameter must be 64-bytes aligned */
-static inline void movdir64b(void __iomem *dst, const void *src)
+static inline void movdir64b(void *dst, const void *src)
 {
 	const struct { char _[64]; } *__src = src;
-	struct { char _[64]; } __iomem *__dst = dst;
+	struct { char _[64]; } *__dst = dst;
 
 	/*
 	 * MOVDIR64B %(rdx), rax.
@@ -245,6 +245,11 @@ static inline void movdir64b(void __iomem *dst, const void *src)
 		     :  "m" (*__src), "a" (__dst), "d" (__src));
 }
 
+static inline void movdir64b_io(void __iomem *dst, const void *src)
+{
+	movdir64b((void __force *)dst, src);
+}
+
 /**
  * enqcmds - Enqueue a command in supervisor (CPL0) mode
  * @dst: destination, in MMIO space (must be 512-bit aligned)

base-commit: 0d4f19418f067465b0a84a287d9a51e443a0bc3a
-- 
2.43.0


