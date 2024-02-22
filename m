Return-Path: <linux-kernel+bounces-76461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7B285F786
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318161C2249C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AED4F5EC;
	Thu, 22 Feb 2024 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IANuR/ae"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3B40BEE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602678; cv=none; b=mLIKyKoEsLFsUUDE2LK+ihRB+6vwSqJx6axkALsFL5vw5fmZeBY7fV+FRDdg1X0HN+ellfqMiq6MuuOaVQOfmjtD9Yi55wKEMmhSOY68h+Scoo2B+b5Ym7XI63z4iGTyvM/8xbej7h+5on9RuNWmFhhqRcneRl+NNclzjU4DO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602678; c=relaxed/simple;
	bh=daz2rq6rFV2eHut/CqMGAgO7JV6tA0j6PgEXIH1uJ3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V15Rc4C5llrlYgvbLhfIceypUkCb6YizYTGc04w8DofNTnHqeigcjVcxGp+xyBvD1N2SCVWanHG3WiPxXp8laG+VDOGrVnSljwpF7LQTXOKcbYjIt4pwV/I7NrNxqwq3EVXmWZbX5mBDQWsCoRQnEEPIh89daGQnkMM1/uwVLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IANuR/ae; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4128cfb6c1aso1724245e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602674; x=1709207474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnyD5PxkKV5o19zNsO0L5tf/fTdRWviw2NTc0WpmPto=;
        b=IANuR/aehwOTPGBYD5nwExGsqLGHpEIuy8W0edvY50gfmS+4q2wDuvj6CnW80IlW1n
         VLiaJCUqD1DR47sHqDjCmss+/xfbdgPmUnmjACIa9kybjvYSVKe7Ftv4CjYXaVH5KjSg
         bz8O+mbykdeZDfE+urerkO2v5yBOZaiG/Bx+R9PQcj989RnL/nFHEerZS/LLGZBKmewH
         ey0n+Zvsydq7RASkqmzardIi4KgfyXTxFfSZbs7DrT4taAFdJnYaKSrDrnPKMLwkS7LA
         FEVREuOH34xSf4mzp2h7HvUxQrZdiy70+Eha49dV1sOIUBhj7WsSmKrPVAgwGrDS8sQb
         re7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602674; x=1709207474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnyD5PxkKV5o19zNsO0L5tf/fTdRWviw2NTc0WpmPto=;
        b=D1PE2BHbgiKcu3M/GunzYBm09IZ/P+Jb6bYtEiL8dzZ+7Uw6EucyTn1Ey8VcJu6Mkb
         Km2G7RQaQUaLn/9Sqqv+A8wcyQ59PDWAA5Lnh2Tzd/Cly+z86B4vWDECzS6Fguvh/2i7
         Um9Fz/qf+IRdy6EjzLMkBhzEwQfXI/+PfRdqtdeXQdxbpXjCVR6jiEWNQ6lnxe4eKara
         JhQtppYY+QBdg5drDvbGbrx7Sl18M5J06+rR0nxIcdZZxAlcaY7BRTK4RLr9Qh+I/89B
         1AqASsDjytN+OvUE+0g26xhis6Q/ed6PsxvuE0udJW2uN4uQTjlxnecn9HJhMUXfa0jH
         uh0g==
X-Forwarded-Encrypted: i=1; AJvYcCVastPb5EFGbFqvwaqdtdV8OTq8DIktheWeKD/f2kpUKLS2dQsT8AGWeoAZU2vfb4He6pNZOCIRJK52v4Y61Ilo+Vl70QDoDX+45Y64
X-Gm-Message-State: AOJu0YztuUr98ItC31w6KdjpdaEpIlNg5wy9rE7M5UXf8WDmlC9Ylzw8
	/KdtE9rJ97QwTV5DiBbIUYQa5RJSvp6NTURPezUgwTdEKlv3DuN+qPZjyh/i1yFYUTZptH6ka+M
	1
X-Google-Smtp-Source: AGHT+IFfueNkE9tnjKhfFyaIv+QALqBUvLT98iMXV3rV/HToXDFD1IoXBeXq5yhH3kCVsjL9LprabQ==
X-Received: by 2002:a05:600c:444a:b0:411:c8a7:7b09 with SMTP id v10-20020a05600c444a00b00411c8a77b09mr1966316wmn.10.1708602674092;
        Thu, 22 Feb 2024 03:51:14 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:13 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 13/14] linux/mm.h: move high_memory to mm/high_memory.h
Date: Thu, 22 Feb 2024 12:50:54 +0100
Message-Id: <20240222115055.1172877-14-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222115055.1172877-1-max.kellermann@ionos.com>
References: <20240222115055.1172877-1-max.kellermann@ionos.com>
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
 drivers/mtd/nand/onenand/onenand_samsung.c   | 1 +
 include/linux/mm.h                           | 2 +-
 include/linux/mm/high_memory.h               | 7 +++++++
 15 files changed, 34 insertions(+), 1 deletion(-)
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
diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index fd6890a03d55..7c3cc270386d 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/mm/high_memory.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad5971219ef6..b5cfe35ee7f2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -6,6 +6,7 @@
 #include <linux/mm/folio_size.h>
 #include <linux/mm/folio_usage.h>
 #include <linux/mm/folio_zone.h>
+#include <linux/mm/high_memory.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/mm/pfmemalloc.h>
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


