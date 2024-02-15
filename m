Return-Path: <linux-kernel+bounces-67124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4328566AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684451C21A10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F81350CB;
	Thu, 15 Feb 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KLj+s59V"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491713473F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008987; cv=none; b=LwG1j05Ntk/p4WsB0wOrtpN7qpSJTATfwceRdyq6Wyu+gSTd+9Hmcq+KmP1ascFSN0GNIUW1nTf743CwDVyU2wirLnXQMs01WgPPydq+lKM+xzEPULLqf1mGNWPf7AXCzeERZ8mgDUGoei7jvmAskq0emSR5xqphTHp2z7ikhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008987; c=relaxed/simple;
	bh=qL4DR4wz2fFAx8PAq9Sk1DQylS4SyIzfyxgi/LjNHjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVYZR8Gx/g/NCGomGg9Jgg2MT8yUmm6DMPsstnunPZ45GYrhn3alq8CiUByWDurxE7ge7sKXnMR/Y/iDbnCw2ok+XlDBLXTh74u0RbRqMZPyS+K7GAF1NucsYepvwX5mjZFXWjzWey/odpmteBS17w1MO4zxNZWDRyEqeRGaVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KLj+s59V; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d208d0b282so9304281fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008983; x=1708613783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMOhGrGj8ZKb8QpbixTkN6L6ZFBU6wOv0Z5Y6TlRvLQ=;
        b=KLj+s59VYTi3pWx2M4pfO9dpOROkz6jIls83+fNZsVrE1WteEQNv7EX3lKI4587paD
         ug5t5wQzyZurrUpQ05CORjLEeG4iSWZrj5Qy2fcRHzdDMeRm7gLFeyYYW6jceaTQzcra
         hFrjVVqjB/IXvXyycHzg7IMKpik1W8/MZaX/DBftiodzHn+33Z0qlVob8JHt7XblKc41
         nnbrObIJOpkzGZGwrsvxWXBkiJgadsnEBqW7G5nY1IrKS5XiITEGL6Ll/7yMv8KWxEvh
         BEWi4h8EnKTAdJcLf6qppE6dZ4qYAcij6xOSq7ZQhTxzgzpYayk4Byz+8+xEj7HHQIQD
         HTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008983; x=1708613783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMOhGrGj8ZKb8QpbixTkN6L6ZFBU6wOv0Z5Y6TlRvLQ=;
        b=GiV8hqu5mWwv7o3hIaPDkbTLo+n6XH8M6xl50HhtsJMRqwhQQzzqX84Shg0kivQPKI
         yxwRrK0qVL8gTa0LtGOW0zSVCM90v0i1zTmoc+nL7edhmQ1qO9kn6U80Bio9yNLGUN/0
         GiyFKiRpsvfCQCgsf76BQRte2oBnfXvY6SJnwV0TqQjneuP+gzvrZjKuLFtXTLqkOZF/
         N6XVFy053HCKh2lkvAz+G7MxhZC/NM7rJzNbseqTDWcraNsg5krqP4Ow7WVqdWc4ASjj
         u9Y7nO16PI3Fygc+9MvNKuawqBZlNAKJ3fvZpt8JFKxIp7g6Bu85HDIJcQRBlF5hc6Dy
         ZFaA==
X-Forwarded-Encrypted: i=1; AJvYcCV6oB9M4t/7Akcfmo34ROU+ly5klWXMf1zxksgYHrpx7ALTEuTugeZ41EH6jgM7ZwGQHAbce003wSlp+7olFOxb51OtxXbARyAWbkRj
X-Gm-Message-State: AOJu0YxKuYq89qRAgC9/W8eUHfEYfZ8cdVinMeWNmf+mstt/GS8dYIHQ
	eZOK1HUIzGP9/qAQhRxJ0QwXq73zxINtuk0zmSM1gMJ3qvaMleMpUaHM9RE1ymy5KJ2iTQeZyzl
	N
X-Google-Smtp-Source: AGHT+IGssagBUW9WG3R8udwSe8E59JAyI3n0tWwsK5KvLhyaYjenK+BbQ5sQbNFHE9hVJClBWwkozA==
X-Received: by 2002:a19:5e12:0:b0:511:7746:5687 with SMTP id s18-20020a195e12000000b0051177465687mr1519101lfb.24.1708008983414;
        Thu, 15 Feb 2024 06:56:23 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:23 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 13/14] linux/mm.h: move high_memory to mm/high_memory.h
Date: Thu, 15 Feb 2024 15:56:01 +0100
Message-Id: <20240215145602.1371274-14-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215145602.1371274-1-max.kellermann@ionos.com>
References: <20240215145602.1371274-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variable is used by lots of arch/*/include/asm/ headers, but
these do not (and should not) include the huge linux/mm.h header.
Let's move this "extern" variable to a separate header and include
this one in arch/.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm/include/asm/memory.h                | 4 ++++
 arch/arm/include/asm/pgtable.h               | 2 ++
 arch/csky/include/asm/page.h                 | 1 +
 arch/hexagon/include/asm/mem-layout.h        | 4 ++++
 arch/m68k/include/asm/page_mm.h              | 1 +
 arch/m68k/include/asm/pgtable_mm.h           | 1 +
 arch/parisc/include/asm/floppy.h             | 1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h | 4 ++++
 arch/powerpc/include/asm/nohash/32/pgtable.h | 1 +
 arch/powerpc/include/asm/page.h              | 1 +
 arch/x86/include/asm/floppy.h                | 1 +
 arch/x86/include/asm/pgtable_32_areas.h      | 4 ++++
 include/linux/mm.h                           | 2 +-
 include/linux/mm/high_memory.h               | 7 +++++++
 14 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/mm/high_memory.h

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index ef2aa79ece5a..a67afb213e2e 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -387,6 +387,10 @@ static inline unsigned long __virt_to_idmap(unsigned long x)
  */
 #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
 
+#ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
+#endif
+
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory) \
 					&& pfn_valid(virt_to_pfn(kaddr)))
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index be91e376df79..eb80f6a65619 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -11,6 +11,8 @@
 #include <asm/proc-fns.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 4a0502e324a6..016f722fbe43 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -32,6 +32,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/mm/high_memory.h>
 #include <linux/pfn.h>
 
 #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && \
diff --git a/arch/hexagon/include/asm/mem-layout.h b/arch/hexagon/include/asm/mem-layout.h
index e2f99413fe56..a09116c50043 100644
--- a/arch/hexagon/include/asm/mem-layout.h
+++ b/arch/hexagon/include/asm/mem-layout.h
@@ -10,6 +10,10 @@
 
 #include <linux/const.h>
 
+#ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
+#endif
+
 /*
  * Have to do this for ginormous numbers, else they get printed as
  * negative numbers, which the linker no likey when you try to
diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index e0ae4d5fc985..f958655d1931 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -5,6 +5,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler.h>
+#include <linux/mm/high_memory.h>
 #include <asm/module.h>
 
 /*
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index dbdf1c2b2f66..ec593656bdc5 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -13,6 +13,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
+#include <linux/mm/high_memory.h>
 #include <linux/sched.h>
 #include <linux/threads.h>
 
diff --git a/arch/parisc/include/asm/floppy.h b/arch/parisc/include/asm/floppy.h
index b318a7df52f6..98ed37c5dc59 100644
--- a/arch/parisc/include/asm/floppy.h
+++ b/arch/parisc/include/asm/floppy.h
@@ -8,6 +8,7 @@
 #ifndef __ASM_PARISC_FLOPPY_H
 #define __ASM_PARISC_FLOPPY_H
 
+#include <linux/mm/high_memory.h>
 #include <linux/vmalloc.h>
 
 
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 52971ee30717..03e0a32e1c2c 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -4,6 +4,10 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
+#ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
+#endif
+
 /*
  * The "classic" 32-bit implementation of the PowerPC MMU uses a hash
  * table containing PTEs, together with a set of 16 segment registers,
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 9164a9e41b02..8a9f5b546e4a 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -5,6 +5,7 @@
 #include <asm-generic/pgtable-nopmd.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
 #include <linux/sched.h>
 #include <linux/threads.h>
 #include <asm/mmu.h>			/* For sub-arch specific PPC_PIN_SIZE */
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index e5fcc79b5bfb..c541e71d3d5c 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -7,6 +7,7 @@
  */
 
 #ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/bug.h>
diff --git a/arch/x86/include/asm/floppy.h b/arch/x86/include/asm/floppy.h
index 6ec3fc969ad5..7756e984f146 100644
--- a/arch/x86/include/asm/floppy.h
+++ b/arch/x86/include/asm/floppy.h
@@ -10,6 +10,7 @@
 #ifndef _ASM_X86_FLOPPY_H
 #define _ASM_X86_FLOPPY_H
 
+#include <linux/mm/high_memory.h>
 #include <linux/vmalloc.h>
 
 /*
diff --git a/arch/x86/include/asm/pgtable_32_areas.h b/arch/x86/include/asm/pgtable_32_areas.h
index b6355416a15a..b339137b4f4e 100644
--- a/arch/x86/include/asm/pgtable_32_areas.h
+++ b/arch/x86/include/asm/pgtable_32_areas.h
@@ -3,6 +3,10 @@
 
 #include <asm/cpu_entry_area.h>
 
+#ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
+#endif
+
 /*
  * Just any arbitrary offset to the start of the vmalloc VM area: the
  * current 8MB value just means that there will be a 8MB "hole" after the
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d4624940923f..75ab0144656c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,6 +3,7 @@
 #define _LINUX_MM_H
 
 #include <linux/mm/folio_next.h>
+#include <linux/mm/high_memory.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/mm/page_size.h>
@@ -81,7 +82,6 @@ static inline void totalram_pages_add(long count)
 	atomic_long_add(count, &_totalram_pages);
 }
 
-extern void * high_memory;
 extern int page_cluster;
 extern const int page_cluster_max;
 
diff --git a/include/linux/mm/high_memory.h b/include/linux/mm/high_memory.h
new file mode 100644
index 000000000000..e504aafd0d48
--- /dev/null
+++ b/include/linux/mm/high_memory.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_HIGH_MEMORY_H
+#define _LINUX_MM_HIGH_MEMORY_H
+
+extern void * high_memory;
+
+#endif /* _LINUX_MM_HIGH_MEMORY_H */
-- 
2.39.2


