Return-Path: <linux-kernel+bounces-164281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1099F8B7BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313C71C23F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A91802C8;
	Tue, 30 Apr 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="c8QYsGFj"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AE17B507
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491002; cv=none; b=r2XKAb3IBX5gXYB/3sOLv1nNKtpkzYJSgjsAx/HqpbVFhCjpC4ZrTHWnb/qNRMNu5626ftV4R7im/A8Scqtx9xZtYVRetMGqW8PIY/WGkoxL/xeeinF0zuxGbaeGf44+o4KyO3zon+8pp4Y6gAvfJuuYWLwwVAyhZlt2HHbVImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491002; c=relaxed/simple;
	bh=a61V/JLL5yE4mlKafM5/E3jZonbk+ucnYZr1bkoNmRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDBqRNnwPlxNY5Q+iPMojLZ7bfjfN16JTrbqpTFFA9xTYqhZP1TZ4IbmZMDsP936GEax0H0GyrsBe8KUriB1VXY6pnwH7YOWMSYKuMnBUXb+lV2O6JeAbarI0o4//Yep6+VvoR7WRCidNCbX6Xi1RsxfgLTp64PI0wAmJCimkdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=c8QYsGFj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so11321023a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490998; x=1715095798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmTw1fgf4V6Kt/hU40fj2rViCghREVZa56h5T5XnfTE=;
        b=c8QYsGFjLh0Yr6mZhPyCkjdCJ0S2gsG4XJeip6CkwJqOgdaeqvzST5C47FivRM8Geg
         VbXbMyTYdScIlBGYGf7Fh3TX+bLeU1Xh7PyPVK9xr+vpyp5/QeEtF7P63gHfSe4FP/Rm
         bseKSi6hBmspTuAel8218U+xnP8SQuHvbFqXrIl2F5iQaEwPvNw4hE7fdXE3o4d/VOkS
         v37Eq0bU2vNZ/ALTcu4mqtOy7dnTm3Pb6gAxJitdT5Puo01nSwvhhOV81aoZzakqQiHt
         nd2zY2mrLY180Y1CcG6fWMH/1z3GP7zsj7tRvUdRST/mXV5XExhu+PBt2ita88BMhuwM
         ZKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490998; x=1715095798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmTw1fgf4V6Kt/hU40fj2rViCghREVZa56h5T5XnfTE=;
        b=D0CS7o+F0FVG7WD8QORhpEcfOuaVt5SHi4shJnPIExVpztUxY8eJXnCD7sUJk/gU1n
         zE/4a4OHVZ8n83PTf0PpiKEo0l1nmZzk8544L5gm+PVXGmBPvgaIgtyOb8i52NTwoYo6
         KUEpzZ6qK1GwAcBg6DmCz9br7eM4YR2ZJzEd3owQUdjtK4MzLww9BXJP3CC2UiGUwq9E
         f7A6jl1DsYJlJm8g2qVVJhKkfbsp08yBTaGNnAqrp/ibAwQSUmwgtX445fTPSTX/wICy
         9rFgce9rmonKt3S1nN7eeguE6pe6GGpknOkT18nNGKNALLzE5tU862kcYN2Rkd9BS6xE
         Ic2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVF1nM/b+Rrwrv7+pqSWdGNUNtDAn+HMpUSjNMZmMx2qvYYY3LHz/7uN6p2EK4fQAbRQh5cSpZROVM2kYttb7LQCe6njS7YpDuXs4a0
X-Gm-Message-State: AOJu0YzRHIRL1iDIycm0WP5wOr3632NB6j6xYuk1f9W4W49dSdFkrVmX
	mi1dtLs+twwOp+csKWa9qqL5qI3QpD4L52qX+GNLT/oyGjwqruurY8pKQxU42Ts=
X-Google-Smtp-Source: AGHT+IFD66p0xJw0Q/JpPxUfYiq2Gl0hHWlUSUDJyAX2bmA9f0IipRbf65AqBkjk79FfuWXnDQdU3A==
X-Received: by 2002:a17:906:c791:b0:a58:eac2:a54f with SMTP id cw17-20020a170906c79100b00a58eac2a54fmr99871ejb.18.1714490998231;
        Tue, 30 Apr 2024 08:29:58 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:57 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 14/15] linux/mm.h: move high_memory to mm/high_memory.h
Date: Tue, 30 Apr 2024 17:29:30 +0200
Message-Id: <20240430152931.1137975-15-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430152931.1137975-1-max.kellermann@ionos.com>
References: <20240430152931.1137975-1-max.kellermann@ionos.com>
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
index 0ca6c408c07f..17ccc91c3cd6 100644
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
index e411e5a70ea3..9ae87fc2c648 100644
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
index 5681fd5dbbbe..db6cc1e0900b 100644
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
@@ -83,7 +84,6 @@ static inline void totalram_pages_add(long count)
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


