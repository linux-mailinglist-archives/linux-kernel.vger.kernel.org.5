Return-Path: <linux-kernel+bounces-67125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 695EB8566AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86E11F21334
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689381350D5;
	Thu, 15 Feb 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZUNiT+mB"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EAE13398A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008988; cv=none; b=tr/mTwvY1gokxhcDEPO/htm0JSGmI3HfIXchc2dKBrbwPBqk7ARV92+L/pu2ZGfG1GPM7u8NfzyUL8EtoJIGHVpO+abxPLUwBsaRnWy/AtEQ8GKzejdQ8SPpfVKzYLqyzOoMMDlrrt4B6PIwORGASFRdK/ULSjoQDLfKUM5px9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008988; c=relaxed/simple;
	bh=99abj94cdBtHWVGTVg4oNZ+VC7s2b8Dvb4V+r0FrVoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gC4AGqwYMtqzUxUoBJ1SWCGjhiVsEIXaEePfCwkT7oK7XWGHob0Sr6slHnqhhaNi5MW69ML/4FUp2aoaKbtVoQy+TvOJU+5wIXaJM6NjtzyWc1LTo4ZNryww1F+SzjmIvniysDGYUP+Kd18aBtDhBE5momts3orJAQ+LClOC6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZUNiT+mB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5116ec49081so1125243e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008984; x=1708613784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5bNFuP+26n2WAnHi+toNNvLtJ00uY1JoGlCS6SUUmE=;
        b=ZUNiT+mBSOWniI42pndDtvF09ox6f75QaOJD40J8jpHr4ipe8HrfmKrGrsymVKZjF1
         nN0IdTbrAlksw74gDKDlznGuK7M5N0WPZuksSj3qkD24FLY9R4nWg7d7w4GCPFdTdaKQ
         XmI916qGi+TSRF8yebdVBcPfIhoSHsxBEVvoR5hA8VIacFxIGUsLr/XO5SAHwfSPjMjo
         8chq/cLNd1IQ6pzassYtl6NKf7CMGcDpnu0Hu5F+H31Gv3UcxM/Sg3anWou0F7qU4kaw
         5EfnwC0eovGJBjVuxjlMVDXlvp2f5l4LMfMk98u/JIcdmj/hHMFJRTunl0jsvTBG8Odn
         igQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008984; x=1708613784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5bNFuP+26n2WAnHi+toNNvLtJ00uY1JoGlCS6SUUmE=;
        b=eSfpWAaK8JJxsFaTKlkrrMwb6yjwq1qQI7KxtIzrwxvBOiLsxMzdV+Apb1aJ/Smkts
         KrGelEdMAelgUwuCPDQCzByI4wd6dGKFNqnngvjxb5D6JTBtVraqiwWB8lpcLGxkRO42
         g7c3xN/9TaOfCvGvrVG2MX5VnmoEjW+1i8qxHtRJsmN3iaV5VXpjlv9QM7jRYrFJxDe5
         UNvyDvwS+ds5p9KT45S59EYqpUIZaqtAQcKBD0o3ZHEc8sCpkUQWogBOr7lnosk37Oce
         k6hzjzFkGd6yFwRslgZxzY3TNmdgL0gvxQtLbSFURH52ZuoBrGjP0z3g4Fw/OS4GKRs4
         BTGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvFWjE6vnFTqyl4dzkoF1GXko5DDIIZH5gNjE7nIF75q2uZAxIQYXWE3luR9jIpXDsGWYfMX1sqsTDuaYdmNI0PRWoUhUvNhehuq7c
X-Gm-Message-State: AOJu0YyYWtqaud2095wB0ccdpxrU6Z7KsliHrq6BWmwaATr5W/T20yQm
	kC+aGnhKn7vwYqLICd+mS1dxwdXTcnhBQLgQ2LbzB+LrSCsF/b90UL93WLfOxCpJJ5t8wj7+CdV
	P
X-Google-Smtp-Source: AGHT+IGTejOtFQSkxWlTe5pM1Jt/3IY1ChHH3rRQyQWLJsBYWozwuVRPQn/QL5Lsca+6dY2PXq0OmA==
X-Received: by 2002:ac2:58f3:0:b0:511:986e:671e with SMTP id v19-20020ac258f3000000b00511986e671emr1726945lfo.10.1708008984131;
        Thu, 15 Feb 2024 06:56:24 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:23 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 14/14] include: reduce dependencies on linux/mm.h
Date: Thu, 15 Feb 2024 15:56:02 +0100
Message-Id: <20240215145602.1371274-15-max.kellermann@ionos.com>
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
 6 files changed, 13 insertions(+), 2 deletions(-)

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
index 00341b56d291..b9dd5dd915c3 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -7,7 +7,9 @@
 #include <linux/bug.h>
 #include <linux/cacheflush.h>
 #include <linux/kmsan.h>
-#include <linux/mm.h>
+#include <linux/mm/page_address.h>
+#include <linux/mm/page_size.h>
+#include <linux/mm/page_usage.h> // for folio_put()
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 77df3d7b18a6..d55cfcde1b09 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -5,7 +5,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/bug.h>
-#include <linux/mm.h>
+#include <linux/mm/page_address.h>
 #include <asm/io.h>
 
 struct scatterlist {
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 696e7680656f..5bd89f0f7e7e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -16,6 +16,10 @@
 #include <linux/bug.h>
 #include <linux/bvec.h>
 #include <linux/cache.h>
+#include <linux/gfp.h> // for alloc_pages_node()
+#include <linux/mm/page_usage.h> // for get_page(), put_page()
+#include <linux/mm/page_zone.h> // for page_to_nid()
+#include <linux/mm/pfmemalloc.h> // for page_is_pfmemalloc()
 #include <linux/rbtree.h>
 #include <linux/socket.h>
 #include <linux/refcount.h>
-- 
2.39.2


