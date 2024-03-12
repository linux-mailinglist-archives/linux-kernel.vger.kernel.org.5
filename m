Return-Path: <linux-kernel+bounces-100054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C66787913C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA6428124E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49107D06B;
	Tue, 12 Mar 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LB8LaDCu"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E07BAF2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236526; cv=none; b=r4dWH4kLIf4f0GTpRV8F21688AVIamhZUKfUrC04enveYtN72TDM8PT/qUjZPCQEHu8sZN0WxVXWZ3yZdaNvqsxWgMGkRoN+UnMVNzYaeUSCeesrmV1DP75sKmSLjNwksz2Ps/z5OKIxHgSS2/YG16ONEHBk3kW++fadFlv1HwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236526; c=relaxed/simple;
	bh=tQ04io/+Nt7goSdFZ2lW5EdMWfpzf2N9Kt4X/6vn+vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zoe3htkjB9U3dFjI7LDaZHl0G/crfBiMgF5T+spzaY2AGmmoh5AirR+cKFNpo8snFRRGS6SEx4U8nMXOaf8izpiF8eqWjsIcshTd4tDT8VeC3IusvHkH3OMtN+ZV55HA7PXKOmm7Fu2vO8fFEugALH1OQKYEQuXJlRPDb9c6X4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LB8LaDCu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a45cdb790dfso545735166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236523; x=1710841323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H98hGtgyPjAfoBc3hVuyxWtvFj6EPdBcbjtg4+paKuk=;
        b=LB8LaDCuHEaS2MHtZse5RCO18/Ate72/27v+PddKIowX/i3hEEL69v37vBiWsOyjz2
         buH6FnzjSiTorABtBcJrb3dATsEDK1DaZtR3GbzBM7vbaEGoet6UzVMuGCBk6QaPidTi
         U5irUBP5+K2Ty+xpSHAwa+NBlcfAR1MEcWxdsMPExJYrWCregASYdFrvwkOlRlrZ10N+
         jjl7FKwwaZZcCKvn21g5HxNJU3t4HruXxFCDohnwV52yVh/D+a38JWMfBm2dr7AP1i7o
         MrDT7TJP8Sx2fJEP927+SodZv8Jxi+slN5K06/QM+NZZjYJOttw81y62zG7HpK2DPmOc
         uAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236523; x=1710841323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H98hGtgyPjAfoBc3hVuyxWtvFj6EPdBcbjtg4+paKuk=;
        b=GgjF3W26E8sWXPcw5tI0d/NrHMV7RQ+zurVJ1x1EFU4E3U9lqSFy0V7tyJGfUZiYxK
         h+UWe2tKXD3mkXyhb3ivjn2r7L2kAa/ORZqejNoFDhiPjXKdjlc9ZDxMM1p7C7Iq5y5j
         KFZfDhqXwINF6IW1Lh0z5V0GmWlSFw2p3LISPu+3EBS31LqsHTVCMNhHoUTXQQO72OMD
         1DQGibRm4HBKS6wK0DAuubp06WyYR/ujWPXDH2y0WH5b6bEI20oG/v5n+3/46jmKZ+Mz
         y+P+FgRcBlh9qxxNxjpq/8oJ9ZVCCnOJ7ac2ehzkRfsi4BrTLAg84gDco3AR2dVJ9iZH
         uAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+zIvnuZhQV2+lB/1Sjbqjux4voKlFBr0bZM5+YjXaNvoBZo2NpywwvTJtWqPco3cQczhgEifTwHgeOF5sPDcysJPGLh5qN5bJ9Kam
X-Gm-Message-State: AOJu0YzTdyCyCWY38gnylaiihjeBXvcEPUccf3z2ASAdcGazVopiixso
	OFybCO30kgwQ+RbB7Eg92fzsgfv7+F+Mph5e3bKMON+dvo5yQvOrOQ4QhoINob0=
X-Google-Smtp-Source: AGHT+IHpv90+P4zxSDURZ7ttG7/z0EYrKrLjaG5oEbvP3KEWBv4oQ9xKxdnYYEq8UAt6cIlNMDUY2g==
X-Received: by 2002:a17:906:a241:b0:a43:fd9e:2d44 with SMTP id bi1-20020a170906a24100b00a43fd9e2d44mr5256532ejb.42.1710236523257;
        Tue, 12 Mar 2024 02:42:03 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:42:02 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 14/15] linux/mm.h: move high_memory to mm/high_memory.h
Date: Tue, 12 Mar 2024 10:41:32 +0100
Message-Id: <20240312094133.2084996-15-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312094133.2084996-1-max.kellermann@ionos.com>
References: <20240312094133.2084996-1-max.kellermann@ionos.com>
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
index 80fc7df2856a..1d7b4c781995 100644
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
@@ -82,7 +83,6 @@ static inline void totalram_pages_add(long count)
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


