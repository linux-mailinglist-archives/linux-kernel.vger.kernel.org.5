Return-Path: <linux-kernel+bounces-106877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665E787F4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E81C21555
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D27A29;
	Tue, 19 Mar 2024 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwF5lE6n"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA63368
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710810580; cv=none; b=cE1gvbN8fgTfAzGGmkjuEhhYgeBlG/iQeM2NGchdEnR2qGwjYSHyYv0vLlhqKk16F7q3H0eSXomvGVKkJuUb0FXYcL/AIkRRld7+Dgx7JxDnTzaAVEtNzRWe7ECRwUAgt8+7vzmQZBEN2yLGs1zf5KQNdI15/zH3/irUQOyeHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710810580; c=relaxed/simple;
	bh=iH/Va4lhSjWEQmUKyh5XgrYZ7zJtSUapt7pUtMmrpOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uqaLGN67XjJ5E5smjXEo5IOfhbyeEnMbBwHB3tErjh3ZOcSSwaW897dCtPU41NNcchOM0YKGQu3HA9KQpiMOBgTi8/izqxe9qSJEaK2ODRSMIPe/EpZFDnlqvx19CXtVSarZJIRr0r6zNOYApbs4c4Q3CJadCU8/jRAmzRg0Baw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwF5lE6n; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e034607879so8951165ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710810578; x=1711415378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8mbehsps4a04gizN/SQlzKriMfP06r4mrdt2lBCcIEE=;
        b=mwF5lE6ngz30JcCS86vfzxkMeCUJr9HLYsYXmD3qU8BRRFITFUyqAH9OSc8tmLdpT1
         Zchji2iQUhbIU39/xigA/3B2A9blQ/2gr2jubb87yKLKUBy40QvtSfTKOi9KV00CuNo3
         W/o6kqjuFnzv8Mbte8iWjL5DHe9QbaTS2TweusVNBfS1vZ4JhEs33QYTs1ZtCDeSI6wG
         12yDU+5k3R6fYnu4CsLmr4UkVCLdHumkeslhn90/+2/shde0HskXQfQnY7dtAKlNJxX4
         FcBFGc0OMQnIQttCxo04dSDvd9dE+aMaDJ9U7dBqbce1XtdSicArgea6N91UuHdQp2IX
         x8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710810578; x=1711415378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mbehsps4a04gizN/SQlzKriMfP06r4mrdt2lBCcIEE=;
        b=Aok37Bqrqt5vDbZgrIpROX72gwhbJYWIT4VoI7EJGFi4l5SH7K8aLfnNABm8bc8bnJ
         jJQnCECPeXBxLjDxDOLqgqLaXL6FYzd9xPSPpKavZX1DtHH0p9MbBlES+9JPFLQpY0jA
         OzCvLXrZ4szICb6VT0i+U9yGtDfaJtkRUgOzdx6D0rtlzgkQMBgMq0zehLM1tMJcwvqX
         VH8WHxNtw+0h3aYZzY/9nz7vfXlO3n7KUpf+64mQ5L/D8ZGFlego7WM0pZC3yqtt9wW+
         t6r8R7J7yDLyG0hN6nL3COKOJVJJHw2s1BABgz5eDzWX8qcgNDdJtEPXVcZEjz9ht9lM
         g64w==
X-Forwarded-Encrypted: i=1; AJvYcCWVPb4qUCYlRmXI3ZBgfDm+dOu28LjAlwO3jk4IQnx5Ij922+hzJeAYpHK/L6LPyvp+dWvdSqzCCf01+UsmLPApj070DLB2iD99Lbzy
X-Gm-Message-State: AOJu0YzdLc1Sj6ofX4AFf2A4+6+cD/2BVSZXZ9P5w5eVQuV8bvMAI+an
	LD2Q0Q7qpZOwOu4sPyYmLJLdg2nmI5bIUfqUNPmj5RV0SFVY4Vx0
X-Google-Smtp-Source: AGHT+IH1UHgpWr7HSeo3cQkNBZ6n/wFv3dio6RUyyY6XHnZc1LKBRyJy3Ay45UIaSsjOKgph5erYlQ==
X-Received: by 2002:a17:902:e995:b0:1e0:3120:8c05 with SMTP id f21-20020a170902e99500b001e031208c05mr1291814plb.35.1710810577700;
        Mon, 18 Mar 2024 18:09:37 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001defa97c6basm6744920plk.235.2024.03.18.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 18:09:37 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: chris@zankel.net,
	jcmvbkbc@gmail.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	dennis@kernel.org,
	alexghiti@rivosinc.com,
	Barry Song <v-songbaohua@oppo.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	kernel test robot <lkp@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] xtensa: remove redundant flush_dcache_page and ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
Date: Tue, 19 Mar 2024 14:09:20 +1300
Message-Id: <20240319010920.125192-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

xtensa's flush_dcache_page() can be a no-op sometimes. There is a
generic implementation for this case in include/asm-generic/
cacheflush.h.
 #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
 static inline void flush_dcache_page(struct page *page)
 {
 }

 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
 #endif

So remove the superfluous flush_dcache_page() definition, which also
helps silence potential build warnings complaining the page variable
passed to flush_dcache_page() is not used.

   In file included from crypto/scompress.c:12:
   include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
   include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
      76 |                 struct page *page;
         |                              ^~~~
   crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
     174 |                         struct page *dst_page = sg_page(req->dst);
         |

The issue was originally reported on LoongArch by kernel test
robot (Huacai fixed it on LoongArch), then reported by Guenter
and me on xtensa.

This patch also removes lots of redundant macros which have
been defined by asm-generic/cacheflush.h.

Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp@intel.com/
Reported-by: Barry Song <v-songbaohua@oppo.com>
Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc9M5YOS1BobfDFXPA@mail.gmail.com/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/aaa8b7d7-5abe-47bf-93f6-407942436472@roeck-us.net/
Fixes: 77292bb8ca69 ("crypto: scomp - remove memcpy if sg_nents is 1 and pages are lowmem")
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2: include asm-generic/cacheflush.h and remove lots of redundant macros

 arch/xtensa/include/asm/cacheflush.h | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index 38bcecb0e457..a2b6bb5429f5 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -100,6 +100,10 @@ void flush_cache_range(struct vm_area_struct*, ulong, ulong);
 void flush_icache_range(unsigned long start, unsigned long end);
 void flush_cache_page(struct vm_area_struct*,
 			     unsigned long, unsigned long);
+#define flush_cache_all flush_cache_all
+#define flush_cache_range flush_cache_range
+#define flush_icache_range flush_icache_range
+#define flush_cache_page flush_cache_page
 #else
 #define flush_cache_all local_flush_cache_all
 #define flush_cache_range local_flush_cache_range
@@ -136,20 +140,7 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 
 #else
 
-#define flush_cache_all()				do { } while (0)
-#define flush_cache_mm(mm)				do { } while (0)
-#define flush_cache_dup_mm(mm)				do { } while (0)
-
-#define flush_cache_vmap(start,end)			do { } while (0)
-#define flush_cache_vmap_early(start,end)		do { } while (0)
-#define flush_cache_vunmap(start,end)			do { } while (0)
-
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)				do { } while (0)
-
 #define flush_icache_range local_flush_icache_range
-#define flush_cache_page(vma, addr, pfn)		do { } while (0)
-#define flush_cache_range(vma, start, end)		do { } while (0)
 
 #endif
 
@@ -162,15 +153,14 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 		__invalidate_icache_range(start,(end) - (start));	\
 	} while (0)
 
-#define flush_dcache_mmap_lock(mapping)			do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)		do { } while (0)
-
 #if defined(CONFIG_MMU) && (DCACHE_WAY_SIZE > PAGE_SIZE)
 
 extern void copy_to_user_page(struct vm_area_struct*, struct page*,
 		unsigned long, void*, const void*, unsigned long);
 extern void copy_from_user_page(struct vm_area_struct*, struct page*,
 		unsigned long, void*, const void*, unsigned long);
+#define copy_to_user_page copy_to_user_page
+#define copy_from_user_page copy_from_user_page
 
 #else
 
@@ -186,4 +176,6 @@ extern void copy_from_user_page(struct vm_area_struct*, struct page*,
 
 #endif
 
+#include <asm-generic/cacheflush.h>
+
 #endif /* _XTENSA_CACHEFLUSH_H */
-- 
2.34.1


