Return-Path: <linux-kernel+bounces-76462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6E185F788
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A782842B0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0DC4F885;
	Thu, 22 Feb 2024 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WvabO7Hp"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B4481B9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602678; cv=none; b=GiXlA7V619V2HSQymY151Arj53wTHOkng8a0WLifWS2LfRnXredzA8qTHmXJgD+cnNqTO+baAOyg7VeXO5VRcpm6atfQn0F0GYpiNVgNCDX7dYP6e04svUlyjQS8RtCscPVNtayTl9nuLXwZCjV2aAjOwf4wUUZEy/DuROu4NdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602678; c=relaxed/simple;
	bh=6lHFOBxOmXiBL1X6gyWvD/30KjkqW7REHaVOVl6TAHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIHeS8LdhIdAihduJ5ZVZX6CipxneVwpJSTyedLABBhAzB//JgNX0fKnlH2bkUBXNUUDkJ8gOmUeQAjb2kNOlKhRawH+VgJ0vx4sIYjBTp1h5lASQfz4GXssE2yzbpk+HlyrxV5tcHSKb/7QI5Ioc33UQULjlhC6mDty+3MJb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WvabO7Hp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41278553016so12338565e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602675; x=1709207475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FORSCnEJSDoW1xOoni46e3+631c/MspUPxiW79pGM2g=;
        b=WvabO7HpLa0OO8HsDYl6mhxMQLBuOjCz+c3ZIviTiMbZd/rNgrnL4N9iJfKooPcaoI
         tdWTyw5vq0mIXv0GrEwSGUKCmoY9oqhgqZBWkI40PYN1VBAIfHly/o+o+fKNKKcZsMPK
         ukHldpcWsUB0p7WWIZ+Qkz80FdHJzrcjShF6A8Wncy/2F4E73FSCVPghq/wcPVbdE6F7
         YQuI1bEuSSlrh4xxJkmWNxpykfBvjL4EiyOqZSJzl0x+G5e8Of/1Ov5RMDqkA9TfmbrM
         /P+SrUDBM05Mv1dx3LEoo7edzgMhnwWD3/FbZ4aZ/Ymy8SKybc49YkKq4FRcJSAuRyCR
         KloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602675; x=1709207475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FORSCnEJSDoW1xOoni46e3+631c/MspUPxiW79pGM2g=;
        b=er2u+QDJmPVWAv4ci56EqbWey3MVbs0DGOw3HHKiw/CQGGtOQOOmwbUuHx92i1kS/u
         18kiWNRx5nAQaR7/RX9YLEmgx2MjHJJHhebYOVIcamexsZhaGSf5qdF2ocwb7lOyZH+d
         zdAidkZxnexyBox6mllZO5jULCXkni3flg+HAtyVG8iMya+/paX+rYBSx+q6q4Uh0buY
         ACuRhUEe66HJfybhkp2L/elXbWTk0cXytOA3VUBt/hLlDjV8qQJPPhJU0yU4SQnLTuHR
         ujQyFTnWuUPPidp38KXlTqbPhnGiQ89g+yEtSLN/JXWlD/MzEJpS78LQjItIebsgY9ZD
         xvqg==
X-Forwarded-Encrypted: i=1; AJvYcCV/aeP2dW8kCzPoHm2HE771eXwwXzbCkXlnf1FdBLPhFbUJlq3G3qhsQMjajWAyVY5UXqgKteO2nUKy6EhYqX7LicQXpbhSvXKaQjKK
X-Gm-Message-State: AOJu0Yxaf9w84aU0+18Lt/lKus1yFqYYkDwp6S0ZOVRlDW2yk07VI84Z
	74+oHacjNOD2oKxaUTemvarRbAvBpOTOtJ0tE84QHeHzwC0O1x47Wyhd3tLV7sE=
X-Google-Smtp-Source: AGHT+IEnpTEGPoO8JHL0sqB2DmBhjMLtnhAh5loH7/awl6AZKhYcFoFELJghLaiQ/sOhlIdWSxDH3g==
X-Received: by 2002:a5d:64a7:0:b0:33d:ed4:5c86 with SMTP id m7-20020a5d64a7000000b0033d0ed45c86mr19274430wrp.63.1708602674795;
        Thu, 22 Feb 2024 03:51:14 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:14 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 14/14] include: reduce dependencies on linux/mm.h
Date: Thu, 22 Feb 2024 12:50:55 +0100
Message-Id: <20240222115055.1172877-15-max.kellermann@ionos.com>
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
index 28c7cb7ce251..06fedc08b998 100644
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


