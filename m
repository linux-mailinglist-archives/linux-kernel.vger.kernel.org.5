Return-Path: <linux-kernel+bounces-100055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E988A87913D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78042B21EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A87D08E;
	Tue, 12 Mar 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="a7t0xL1+"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D47C0BC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236527; cv=none; b=DqJWLGTQrcBJPGHM8+svPN7ufpktWGiQH9VlznfNbPP21Kl1rifBybt4ysqpS54Uz0GNzTdqqHpO4WkQDBvwT0F64rkFwqzDqkATzDPgCZ5kxjXKaOdDcX+riyrMvW9YLIvkBRg9MJE54qUUAMkMcM2PWknw/rva/Ne6FZ+KPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236527; c=relaxed/simple;
	bh=zLQTClvlEzGI/x44WBlT/FrIRLpjouIvXQ6mUIYW7FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGtSTYZGBJ/v/UAJw5AtNBVJ5K6TUCxqwGb4L4WlzCl59WZbMVrYnmVufeMIiDjIFz6WIVMx7PsqCFJ775OYWP5qnnT66BrMdA8fGmfEDBqaLDA75CZWHMDmi5yaq20mblmKcpSQ1zURA9nNjnpZ7sJkgHU0IIjCNMmffWBmHWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=a7t0xL1+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a446b5a08f0so949702666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236524; x=1710841324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jrscdt21PtPY517djC+TvV15g1fCQxv1c3sR3dIsMR0=;
        b=a7t0xL1+yZpk3D/c4AXn/nqxuiH7M95uXiteXoVAtvHKtYwP+fFa8XJbQvUjizIG/g
         UCylibaS+aaraSxx4crrWL9Via55L0IWuyG5ENGUCgjuaqs4jPugMF9qjielVnO8l4g1
         LnpOifUiYgPGXDxIs9PNB7YYzx9EjqMvyVwWiidSkGHvOHUHvgf0WM+59HGQ4lqZAZfi
         aTCjB+SIWHvZwDPgSIPwwx8bMv08qjVOpo5Qpt9WARPt/S40Qh+YaXryns05KVL4paQd
         dqDrxMuMY2jB2amcrDxIgGZFQrO8pEynL54SSkUf1572nx2/Jd0/mdIIcpQNtYkiU83H
         BJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236524; x=1710841324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jrscdt21PtPY517djC+TvV15g1fCQxv1c3sR3dIsMR0=;
        b=I5lRzyRf9Ka3ksbvgiX9tQSLfy6yMzGd87i6O+UBJOlXGN2XgbkYfSvBXIWvRcBSXX
         rRY3Y0eG7HlGC5juzZ/GL9sVvIYgIlgumej8N8L8nCY2qaitPzQYroC+KO9ewEsTQH+L
         FSTsZDGaOZwd5JRmMd3ehs1o2jEYyHEc4nIQOvZMxq4bFiSOBR7UjZ31zynsND/CyVjY
         t+tcBJK3yaaVoM1KPlfJEB1f7iUSnm6h3SQETFnnKMo40NSUXvP2sJ2bshAgq+xM24/k
         TiQ5GrD1uxfMkw3u0JcnZgQLhmjxalRxX3PVMV69wPJOcLT+uuobchAGHtEUjgN00Tji
         dH+A==
X-Forwarded-Encrypted: i=1; AJvYcCX8K5qqwNqMRz0Duw3Bf80itvWPAwVOvxawV+QxEswamX4s82KIxfUvklyrjNtMjedv0couLQooGWvnk2N1noRG+eXAAMtozhz5e6yf
X-Gm-Message-State: AOJu0Yzvmcz0KF0Otm/XHtFzgobNqfmWICBkAXYGWr4+0FuVoy7dMTw/
	NuUf3YS83nDvrhjl11e09WXNpvJKCM4KHy+LPS1s6DdtM923a4+k2Zmpe1MEyJo=
X-Google-Smtp-Source: AGHT+IH+55sS4D1Wofdn/P5aBaDbVhmB1/EaSYmDeSmBmhB/cebupf3IhOpDFPGmtUJAfiNuT3MXBw==
X-Received: by 2002:a17:907:d50a:b0:a43:ffe1:7d1 with SMTP id wb10-20020a170907d50a00b00a43ffe107d1mr8979316ejc.17.1710236524165;
        Tue, 12 Mar 2024 02:42:04 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:42:03 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 15/15] include: reduce dependencies on linux/mm.h
Date: Tue, 12 Mar 2024 10:41:33 +0100
Message-Id: <20240312094133.2084996-16-max.kellermann@ionos.com>
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

Replace <linux/mm.h> with the smaller pieces that were just splitted
out.  This affects a few headers that are included by many, e.g. bio.h
and highmem.h, which now no longer depend on the fat <linux/mm.h>
header.

For this, several missing includes need to be added because they are
no longer indirectly included, e.g. <linux/fs.h>.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/bio.h              | 2 ++
 include/linux/dma-mapping.h      | 1 +
 include/linux/highmem-internal.h | 2 ++
 include/linux/highmem.h          | 4 +++-
 include/linux/scatterlist.h      | 2 +-
 include/linux/skbuff.h           | 4 ++++
 lib/scatterlist.c                | 1 +
 7 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 875d792bffff..e2f24d7235d3 100644
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
index 3023bc2be6a1..7b61eac3baa4 100644
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
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 68b45c82c37a..03599396f15d 100644
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


