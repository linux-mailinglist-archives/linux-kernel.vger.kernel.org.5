Return-Path: <linux-kernel+bounces-112939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B43887FE8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F511F22E65
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8D77580A;
	Sun, 24 Mar 2024 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7sj1L9Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2167EF05;
	Sun, 24 Mar 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319751; cv=none; b=HbyfKEEsLql/X4iD1MfI2J3pHsV7uLMReufGyg78r5NoNCxxH68R68SADj5N1pEDMQ9BfvlY41grqv2QneUoRLTPPkEt73AHMpxg+DMKTm1w/l/0jJ6YoLA4JSOmtIfKCNePWL2NWlWlL5qNcQaaC34yE+DWr2bgiIfo8JDO790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319751; c=relaxed/simple;
	bh=OYBxtdsfzusqnwQiK4p5xxJ3U+GQNmbFOaggNSEenBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7Pi7LJDFuMq+bXlq7KNa/zxhgYuxCLRtjlYbPBn/KLdLe5sN71V9FmN8YZisrp4L1rpZnyYYCbzzlSGQgrv8gP7KZO9ems39uHYm03bbpI5AvJY7vs1PDtoW6RyXxaa79DazOzAlDts/u21w3vw3XlT5mSWrc7aJdK5dQNr7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7sj1L9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EF1C43399;
	Sun, 24 Mar 2024 22:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319751;
	bh=OYBxtdsfzusqnwQiK4p5xxJ3U+GQNmbFOaggNSEenBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7sj1L9ZK3TuNT4/ao7fJTQOfVC6kOTCspr6hmC3uaMJDo4eca2yHhtArd4jZWHsc
	 71LE7nXKADKYLhLvPnsHVwYG5Z/CRhPclcCJHZRIwg98r9K7LX5rnaR48XmYNmUl6t
	 AVKPDP9sPPGqHccW2X5N1X+4kDHsehFdMosksd6KciTjg+J6oSXQEleDZ6ASsKrHi4
	 2ySm8XzfQT1JWZJW8k4tGa47rr1KYeB60SHS3ol9L1s/OGyJOBQufObgK656L0NxfC
	 Lz0V85HT3kUBC8B4iC0sK26hdhu4AotjpapFM9H+XBob/Dd2A5R5H1LgtiAvW5OUGQ
	 RukUIS2sGTAkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kai Huang <kai.huang@intel.com>,
	kernel test robot <lkp@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Yuan Yao <yuan.yao@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 052/715] x86/asm: Remove the __iomem annotation of movdir64b()'s dst argument
Date: Sun, 24 Mar 2024 18:23:51 -0400
Message-ID: <20240324223455.1342824-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kai Huang <kai.huang@intel.com>

[ Upstream commit 5bdd181821b2c65b074cfad07d7c7d5d3cfe20bf ]

Commit e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all
packages") causes a sparse warning:

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

[ dhansen: normal changelog tweaks ]

Closes: https://lore.kernel.org/oe-kbuild-all/202312311924.tGjsBIQD-lkp@intel.com/
Fixes: e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all packages")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Yuan Yao <yuan.yao@intel.com>
Link: https://lore.kernel.org/all/20240126023852.11065-1-kai.huang%40intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/io.h            | 2 +-
 arch/x86/include/asm/special_insns.h | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 3814a9263d64e..294cd2a408181 100644
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
index 48f8dd47cf688..09a5461d72439 100644
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
-- 
2.43.0


