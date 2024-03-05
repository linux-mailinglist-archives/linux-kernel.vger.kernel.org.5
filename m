Return-Path: <linux-kernel+bounces-91946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D08F8718D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4561F222C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2858225;
	Tue,  5 Mar 2024 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WboVTnRH"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E056B8A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629194; cv=none; b=YUWTs9X/trrBwbbNnmsqxiFpECxVlMk0v/mO5BD/Wcj6aD6HXlItdVDqSUBp9gKMiWMKHz2Qc4q1/BNdcSaadtKM2le/GHo6NAxAqQorTHRerqih2n1bR9GuqDw3nicmFbTyqqJeIpsgJi9MPxYRwmdTa4u66gdKChwJgWZXENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629194; c=relaxed/simple;
	bh=a6yUlj9K/s9w4PWmNlaDvHMam1xAfTG1bDm7NR+5dP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtV5ytuu7lbcntbmZmfF5J2i/060/3lvlySEeugaQr+TEL1Dc5CAO6eLtHCePlJNj56Xhe8xGaFyGEktw1Jrs6o/jlPql3YEZmhwu7BjTOsXQYu62JVl3EPLGGcIiz0SS+OEmDh6XkEysszQj4BKiDvb6M4ILy8A0/WfghmMUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WboVTnRH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so1063753466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629190; x=1710233990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg2bpXGSRrzoISiqX7O1pb+MwUieZ+xnjYvseU34GPw=;
        b=WboVTnRHUMpEJswQT0aG/FyO6+oh80kbqqNlnl+GWnQ4g2JhyQMKPABxcYkVpimC9o
         0ZnR8ZmKyfw0uWp+t1u8u7ChmmOA5uOZuQUATtWcDvOhH7vdjNq9e5dEgJa3XNWFmXpa
         BsOJLUdQaXAte64aXUchJv1heho6+isJv/hyYpF19VGfaJx1e2Pld6+JPMo4fMZqq8ca
         BK/8mUMWBthqz9gi8qEwSyxHTF8kyEVTt9DfiYaWZfFknlthm8AeSXO2WA45/USl8gqg
         4zYEOOG3nSS5+9nL08blNCq/QgvJa/dvTgA1Q4cLKKl5CFmbusroH2blr9XLcxaF9v0S
         zlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629190; x=1710233990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kg2bpXGSRrzoISiqX7O1pb+MwUieZ+xnjYvseU34GPw=;
        b=uC7IhLlhgYy7Sppy+bQDY/pqICUVX17uLX0qWQCXeLopcDxAgpuzC5dWt1Fb4hegCe
         07nfEyhOqPK4ndqlWlDgCd1sMccYzSweSPqZRT8h4q7UYpMD/oqvkNYyoylA8PHpy6OF
         bf8Q7F71TWdDEr/bOnIfxqFy8RF+8kRNk693qzf5HkovCLQwbP5vlTAPnArkd/vDCcWK
         WNmbK17IFuoW+sUSC1CvlA8MoYol21Ai6y1JwGaZ81N6QxoHAgfc2ibuLOCl6x6nNc6c
         13TW2yQ5v6G4d+JLP4IuXWLdtEVlCcPNRxvWNXDEXZJGlOdzUzXXUDfsDF8QmIVsgzPI
         iBfw==
X-Forwarded-Encrypted: i=1; AJvYcCVLB1sB42ROly5zTlHZk3gOstPk57v8Xzf5j9LG6asViCWPXy2F5WN9/53NWHCuKOwsSP+egAwN3j9QyLcdnnh9PIH9aHbnxAnyGon+
X-Gm-Message-State: AOJu0YzKcEn4ab7eqs2QnNjTVkcEspkd2BNjo8Sfec95t3NrHqkBPx30
	J48VZYtqGEUrJ3bskm0pJdBx8t7bP5VE980/mPaRlDyff0GGRsOMrYNSBF7iQqo=
X-Google-Smtp-Source: AGHT+IEzQL7M2UuAo9MnJ/pbyNhFbLssWyCiOGjpuRhDJu5ujpFN+An9p4+sh1nmIhJdXaRA1x3R/g==
X-Received: by 2002:a17:906:190e:b0:a43:ab6f:ef6b with SMTP id a14-20020a170906190e00b00a43ab6fef6bmr1942409eje.32.1709629190675;
        Tue, 05 Mar 2024 00:59:50 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:50 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 14/14] include: reduce dependencies on linux/mm.h
Date: Tue,  5 Mar 2024 09:59:19 +0100
Message-Id: <20240305085919.1601395-15-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305085919.1601395-1-max.kellermann@ionos.com>
References: <20240305085919.1601395-1-max.kellermann@ionos.com>
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
index d577e0bee18d..ac121262bedb 100644
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


