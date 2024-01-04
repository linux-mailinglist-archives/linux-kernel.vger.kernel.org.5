Return-Path: <linux-kernel+bounces-17276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 205E5824ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BCC1F22C33
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BA42C859;
	Thu,  4 Jan 2024 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzOxYd6w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2B2C850
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704406357; x=1735942357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i4Wnaosbtu6tWHnfINhnI1IZAXSgRJ8fGJuxG2b67PU=;
  b=nzOxYd6wNixfiECeZmLd+/fwSxRDhb60VcrgX3Ae+IhsIeGLDaT/lyBG
   rV8lTF5sODtgjdduQ9onAxYiFXGcYkC7SWyLM0Y1hH+CDapgs9qN1HFmO
   u8iKezdGOkHorOb2JgBmsbQHk3eL6AP1zvI58m96wkDEXAbkbJR+Pj3WZ
   mPUyLYrPcFchKjy1HzejyHHeYF1uObivdZ9rLTBpWoABNwUZvbMp527dE
   lEDRNeNRzYpUg5ScJ5IhnIR2oRFy3k1QnquzZoNAjkR4+3P59wWe1+xjE
   Q1FNGtwMmgAbC2W6Jf4sZdz7D5xW/YIf4f+ArMfq6FeuRYB4stDmXLIBq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382353674"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="382353674"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 14:12:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="953758695"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="953758695"
Received: from tkantar-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.21.206])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 14:12:32 -0800
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
Subject: [PATCH] x86/asm: Remove the __iomem annotation of movdir64b()'s dst argument
Date: Fri,  5 Jan 2024 11:12:19 +1300
Message-ID: <20240104221219.572258-1-kai.huang@intel.com>
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
---
 arch/x86/include/asm/io.h            | 2 +-
 arch/x86/include/asm/special_insns.h | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 76238842406a..de2dc9837f11 100644
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

base-commit: 83e1bdc94f32dcf52dfcd2025acc7a2b9376b1e8
-- 
2.43.0


