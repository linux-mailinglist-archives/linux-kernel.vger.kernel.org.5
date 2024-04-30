Return-Path: <linux-kernel+bounces-164282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1267B8B7BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DBB1F256FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6521802D4;
	Tue, 30 Apr 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RJXscFaT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77717BB10
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491002; cv=none; b=b7+sMI3bHN/5nSCOZsApAjc+eSJp7JK0pKXTJ9ea9nXaV3mwH7wS6tAwOneFHncWInU6WLtoaztlK08mWXRrbopOraSsIW6CFE/9xnVS8Sh9VPQ33MJkm4NFYHlwv4Ldqk2bbl4QtOtjH53cjNykOkKIMrWls2xwKuWovRsrKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491002; c=relaxed/simple;
	bh=R0gNH4FY3l8frbO+OI9zC6V4Pw3DwcSG874MuJyzJls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kLjhSEhpNzl9fA0f/DVIZabmjDf6Q2MFLOsAAGgsfSuzyvXlO7gzZ2b+KurAp9OedLQWUuOzrvsKyzWkujOVUWsGK7dRXZNEozVqELsg+S/VvIUzT/V3j3PLGJ9+tMDlHuiuqhnf5tMAYgAEcCH7hlPpMslTEE6YtIZIpHO+LdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RJXscFaT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58989cd1f8so750876866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490999; x=1715095799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABURn/IPwvg3QaF1L8Bp+WsdBt1sVzfYO2Rbl7rbJjA=;
        b=RJXscFaT5jLrc4Gkm1pNfloijN2gqzpFKpGRAyqBKPzNOzyLIbrRvNHxU5tna6SSSH
         NriO0HPpwlg3gPu8vSp5v+74FYPksS7GUpjFKpmD7FSG/Z7fYw8EAIyY1S9MXOJqJrk8
         Dq8WGCcQimSJGGVxdnZKg3CP/UrvhphEyxEtxUaQ+EZoGTxLSH+cdUhKpxsI5AakQMp2
         UDVjd4LPM4l1awdbH5rHtcK7YjUj2R8hI/6cmfhU3zCrovU/8+QjeMc0OpWCrclHY08B
         ecQAi6mQxx+eG21flKf4MM/yl48zu9BRwXFeRpl6C9ITbB84wQ0HVao/06Pp0coI8Gn9
         FQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490999; x=1715095799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABURn/IPwvg3QaF1L8Bp+WsdBt1sVzfYO2Rbl7rbJjA=;
        b=S0qimmqtoMs+A82ixp7ZLIughzxVqHbWWYJxIr3+fRH/T6DZwEbS6mGSJR4+iyBfnC
         NP225q/q65f06S/w30mEXYiVkwmeaevcQNUS5SIDD2Zr2Q7WtyrP27qOZY10AwcHpgWu
         jk936ERb+4BiwBYkk0+tV2CDb4x4+EnWCPw2FX/uqVaYzIiRX5j3ECb74DjJXGPoaH6F
         wMGIZy0978oWFtkyJ4GtavFKB660UMDzA3u+HyA49gBa39aC5jObuP1FlUFKzo+wxOWv
         GtWkViTZhCVsGlYWtiJT5QPVTHIqHzVGsf2tFRDpUL4aS6HzH2BBwjY2Ra5BHvPr00WO
         9fxg==
X-Forwarded-Encrypted: i=1; AJvYcCUrU3ZZNhfp7dAJXfAGZs9z3NL15ITTlEXBjgOaNQIyzM9+olALE3UoZNlulwAG1BVG5upkroWLGXfGQslDrA3RkyrooIRIIWkMD4b8
X-Gm-Message-State: AOJu0YyoCsXWSNO4tLPUrz/T68kO6FDZYTLxy4xhQ81E+bFH/w34JKw+
	gynFH49Grpi9+flOIH9FpTEuCmilGnyBPWtUfPWIyqRF62mFyy1E9gMhpRxHcis=
X-Google-Smtp-Source: AGHT+IEEPk94Z5otGXu5AVv4jv/eA3k6lhp9Jv+Ax1/QpcdsQCefXoecEzyhsr379ksLAWsEww8rYw==
X-Received: by 2002:a17:906:3810:b0:a55:41fd:a013 with SMTP id v16-20020a170906381000b00a5541fda013mr54422ejc.23.1714490998935;
        Tue, 30 Apr 2024 08:29:58 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:58 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 15/15] include: reduce dependencies on linux/mm.h
Date: Tue, 30 Apr 2024 17:29:31 +0200
Message-Id: <20240430152931.1137975-16-max.kellermann@ionos.com>
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

Replace <linux/mm.h> with the smaller pieces that were just splitted
out.  This affects a few headers that are included by many, e.g. bio.h
and highmem.h, which now no longer depend on the fat <linux/mm.h>
header.

For this, several missing includes need to be added because they are
no longer indirectly included, e.g. <linux/fs.h>.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/bio.h              | 2 ++
 include/linux/bpfptr.h           | 1 -
 include/linux/dma-mapping.h      | 1 +
 include/linux/highmem-internal.h | 2 ++
 include/linux/highmem.h          | 4 +++-
 include/linux/net.h              | 2 +-
 include/linux/oom.h              | 2 +-
 include/linux/pagemap.h          | 2 +-
 include/linux/scatterlist.h      | 2 +-
 include/linux/skbuff.h           | 4 ++++
 include/linux/vmstat.h           | 3 ++-
 lib/scatterlist.c                | 1 +
 12 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9b8a369f44bc..9b9b8b40f1e7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -5,7 +5,9 @@
 #ifndef __LINUX_BIO_H
 #define __LINUX_BIO_H
 
+#include <linux/fs.h> // for struct kiocb, IOCB_NOWAIT
 #include <linux/mempool.h>
+#include <linux/mm/folio_next.h>
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
 #include <linux/uio.h>
diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
index 1af241525a17..19967a0e510c 100644
--- a/include/linux/bpfptr.h
+++ b/include/linux/bpfptr.h
@@ -3,7 +3,6 @@
 #ifndef _LINUX_BPFPTR_H
 #define _LINUX_BPFPTR_H
 
-#include <linux/mm.h>
 #include <linux/sockptr.h>
 
 typedef sockptr_t bpfptr_t;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a658de44ee9..37d5591039c7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -11,6 +11,7 @@
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
 #include <linux/mem_encrypt.h>
+#include <linux/mm/vmalloc_addr.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index a3028e400a9c..a479e6b7c54c 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_HIGHMEM_INTERNAL_H
 #define _LINUX_HIGHMEM_INTERNAL_H
 
+#include <linux/mm/page_address.h>
+
 /*
  * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
  */
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 00341b56d291..10a165a913ad 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -7,7 +7,9 @@
 #include <linux/bug.h>
 #include <linux/cacheflush.h>
 #include <linux/kmsan.h>
-#include <linux/mm.h>
+#include <linux/mm/folio_size.h> // for page_size()
+#include <linux/mm/folio_usage.h> // for folio_put()
+#include <linux/mm/page_address.h>
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 
diff --git a/include/linux/net.h b/include/linux/net.h
index 15df6d5f27a7..7c04b3124366 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -21,7 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/once.h>
 #include <linux/fs.h>
-#include <linux/mm.h>
+#include <linux/page_ref.h> // for page_count()
 #include <linux/sockptr.h>
 
 #include <uapi/linux/net.h>
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7d0c9c48a0c5..518426e092d0 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -8,7 +8,7 @@
 #include <linux/nodemask.h>
 #include <uapi/linux/oom.h>
 #include <linux/sched/coredump.h> /* MMF_* */
-#include <linux/mm.h> /* VM_FAULT* */
+#include <linux/mm_types.h> /* VM_FAULT* */
 
 struct zonelist;
 struct notifier_block;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 850d32057939..70a99d7ebe10 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -5,7 +5,7 @@
 /*
  * Copyright 1995 Linus Torvalds
  */
-#include <linux/mm.h>
+#include <linux/mm_types.h>
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 0516e64dc03e..9221bba82b23 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -5,7 +5,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/bug.h>
-#include <linux/mm.h>
+#include <linux/mm/page_address.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_UML
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c43d6afebd50..4c8fe40fe1eb 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -16,6 +16,10 @@
 #include <linux/bug.h>
 #include <linux/bvec.h>
 #include <linux/cache.h>
+#include <linux/gfp.h> // for alloc_pages_node()
+#include <linux/mm/folio_usage.h> // for get_page(), put_page()
+#include <linux/mm/folio_zone.h> // for page_to_nid()
+#include <linux/mm/pfmemalloc.h> // for page_is_pfmemalloc()
 #include <linux/rbtree.h>
 #include <linux/socket.h>
 #include <linux/refcount.h>
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 86bdcfe319ae..2cd9c921d516 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -4,7 +4,8 @@
 
 #include <linux/types.h>
 #include <linux/percpu.h>
-#include <linux/mm.h> // for folio_zone(), folio_nr_pages()
+#include <linux/mm/folio_size.h> // for folio_nr_pages()
+#include <linux/mm/folio_zone.h> // for folio_zone()
 #include <linux/mmzone.h>
 #include <linux/vm_event_item.h>
 #include <linux/atomic.h>
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 7bc2220fea80..775bad99fcd9 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -9,6 +9,7 @@
 #include <linux/scatterlist.h>
 #include <linux/highmem.h>
 #include <linux/kmemleak.h>
+#include <linux/mm.h>
 #include <linux/bvec.h>
 #include <linux/uio.h>
 
-- 
2.39.2


