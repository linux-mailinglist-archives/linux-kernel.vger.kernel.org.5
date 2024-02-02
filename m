Return-Path: <linux-kernel+bounces-50478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071B28479A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713271F263ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DCC15E5D4;
	Fri,  2 Feb 2024 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="DKbwbbaq"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17115E5BB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902105; cv=none; b=DoXOzHeqMBHY9DSyus/JcWX+zLFS1JzYP+H7cudu/+k/vQscAqBUtBRf0ZJ2PIE3P2qyr6Xm1ZdzsQfIf6GwESQsVYfVqvOHLMdvQAiHZNzz1oLl9mDACJZZYoH6QPD0X1yNMQiZYUYYLZjJCNbwsW8LId4dO8YA2rVEH7EDFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902105; c=relaxed/simple;
	bh=gc2XYLfIyCsHCOJHXIq7dBy4uHsQ0CvidMyB8n+URYo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lViOz+koVrNjgI///N3Vp+3d3XJi1GswKlPq7AmnCH5OrYsoAqc5fXy3IjPsXPY8wUf2CG3lJj2JIUVFolz+tV2EOOVTFSD4JP97wQRNamhX9BuD1tgWYZsr86+y1Tc5254jakmIOgaVyedTaE79FAoyJ9wSorx8jlzMWi08tfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=DKbwbbaq reason="key not found in DNS"; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783d8e09a1cso143005485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706902103; x=1707506903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRMVoXUIDhsqk2wauqeaSYS0KJTLFWCGjlI236Qz/TI=;
        b=DKbwbbaqNYOeo2dRvBGCzoxSHwcODZ+Xt64aUOGHKc61eUpZbMRlnkl3+nm5R9r92K
         Ot8uqs8npdVfPY+blogThvbLawMYKAQqqgxnWZvUPMyERIFzpgBi3fOpdY3JCxeztFFS
         lskrSGd5mIQLZKraw8u2Qh79PTMwcCMvRqiZzMvXTn5Z0LVNCOuwHjG8whziR1hbwLii
         VCbvKRCoTcUePfZ3t1it8KJJzbalzl3p9DXeW1AlzTuyx7bnLKRQfgZHy5Mq2U0r1904
         A7RFQaOjeDZdDu783roa5BvzFQiHadriYjpWBLYvmxZ6ZmnN/WZc5FLCn06Ws0lUn0ZU
         BJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706902103; x=1707506903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRMVoXUIDhsqk2wauqeaSYS0KJTLFWCGjlI236Qz/TI=;
        b=Xp9DZ4FKk06snO9aZXpC02exeXXJR/15HvYdLXogTjFL7yrlmMPv7GN6y7CN104CLb
         xDXJ7bi1goZ8YoWGpbdpWt4VPrvxaxdFNm0tJo3UzoY7CNUULwLTTDDb/pYHi+Odq7Pi
         xg2C0VAWv0kJgwEs8EHvqg+muuo8o1T/zumiAm/eT6HopBsEeNfefGG+hoFsXAQEMjpE
         KcAnGem5zGwLpsEjxH9CmUOtGi/PStOk4Ub6+NGRzCWbgQam7n7/+nwowmmKdVvQus29
         jc8+Di1Df7hlpyFIVYTwYJH5SMzeev38tug81Ag5WDcuPterqG/4zCtU2oQq8UsilP2D
         uTlA==
X-Gm-Message-State: AOJu0YzG8yiRpN52G9jhSYuA3o9UZpVMAMs1BfmTNqKuzf46VNoRs/bl
	FnXheWkWBskxL8Z1tc6XYAX0b4NkWRky289st+MqI27Ax281+hDVa8Y1WbumJritI80bVgkQMIG
	T
X-Google-Smtp-Source: AGHT+IE2j+F9W4BLBuGDUanXeAR8Q/iu6EVu8yI5R6ISNqSNldAm4ZHYxxJTdJtaLcdM+zS8CiYtWg==
X-Received: by 2002:a05:620a:3885:b0:783:9a16:307f with SMTP id qp5-20020a05620a388500b007839a16307fmr6694812qkn.18.1706902102702;
        Fri, 02 Feb 2024 11:28:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUs3qHpOZ2c1uil71kD5W+kCecGQrkbnV/5pNfTp0xVi4h70AJfW4s6lXExDKn+ZZvmTqY5ubjqxI4VzYMk/i0p6bUaKx7KP84/W4cV/5ND5LFV421tdfdVbtHZxKYHoxSEikm3zZBNStesA/22yIK4C6ldTfg8cuPtBgE6U9bI0Y2s854k+somdy0gB6JrbGuBSgfoRUg0ko43jhZbebMVmLMiT/IfJ2BsBYF2RoEMioBoXqGDXh1K0tExwURHX1A5O57CndtgqpSBDh/IuPaU/fG2tfFqCoxMkYB2n5spwg==
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a022500b007831f8c5aeasm902250qkm.55.2024.02.02.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:28:22 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	yosryahmed@google.com
Subject: [PATCH v2] iommu/iova: use named kmem_cache for iova magazines
Date: Fri,  2 Feb 2024 19:28:20 +0000
Message-ID: <20240202192820.536408-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The magazine buffers can take gigabytes of kmem memory, dominating all
other allocations. For observability purpose create named slab cache so
the iova magazine memory overhead can be clearly observed.

With this change:

> slabtop -o | head
 Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
 Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
 Active / Total Caches (% used)     : 135 / 211 (64.0%)
 Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
 Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K

OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
 91636  88343 96%    0.03K    739     124      2956K kmalloc-32
 75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache

On this machine it is now clear that magazine use 242M of kmem memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/iova.c | 70 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

Changelog:
v2: - Use iova_cache_get/iova_cache_put to allocate/free
      "iova_magazine_cache" as suggested by Robin Murphy
    - Minor fix in the commit log.

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d30e453d0fb4..88255f9443b5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -237,6 +237,35 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	return -ENOMEM;
 }
 
+/*
+ * Magazine caches for IOVA ranges.  For an introduction to magazines,
+ * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
+ * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
+ * For simplicity, we use a static magazine size and don't implement the
+ * dynamic size tuning described in the paper.
+ */
+
+/*
+ * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
+ * assure size of 'iova_magazine' to be 1024 bytes, so that no memory
+ * will be wasted. Since only full magazines are inserted into the depot,
+ * we don't need to waste PFN capacity on a separate list head either.
+ */
+#define IOVA_MAG_SIZE 127
+
+#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
+
+struct iova_magazine {
+	union {
+		unsigned long size;
+		struct iova_magazine *next;
+	};
+	unsigned long pfns[IOVA_MAG_SIZE];
+};
+
+static_assert(!(sizeof(struct iova_magazine) & (sizeof(struct iova_magazine) - 1)));
+
+static struct kmem_cache *iova_magazine_cache;
 static struct kmem_cache *iova_cache;
 static unsigned int iova_cache_users;
 static DEFINE_MUTEX(iova_cache_mutex);
@@ -275,6 +304,16 @@ int iova_cache_get(void)
 			pr_err("Couldn't create iova cache\n");
 			return -ENOMEM;
 		}
+
+		iova_magazine_cache = kmem_cache_create("iommu_iova_magazine",
+							sizeof(struct iova_magazine),
+							0, SLAB_HWCACHE_ALIGN, NULL);
+		if (!iova_magazine_cache) {
+			cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
+			mutex_unlock(&iova_cache_mutex);
+			pr_err("Couldn't create iova magazine cache\n");
+			return -ENOMEM;
+		}
 	}
 
 	iova_cache_users++;
@@ -295,6 +334,7 @@ void iova_cache_put(void)
 	if (!iova_cache_users) {
 		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
 		kmem_cache_destroy(iova_cache);
+		kmem_cache_destroy(iova_magazine_cache);
 	}
 	mutex_unlock(&iova_cache_mutex);
 }
@@ -612,32 +652,6 @@ reserve_iova(struct iova_domain *iovad,
 }
 EXPORT_SYMBOL_GPL(reserve_iova);
 
-/*
- * Magazine caches for IOVA ranges.  For an introduction to magazines,
- * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
- * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
- * For simplicity, we use a static magazine size and don't implement the
- * dynamic size tuning described in the paper.
- */
-
-/*
- * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
- * assure size of 'iova_magazine' to be 1024 bytes, so that no memory
- * will be wasted. Since only full magazines are inserted into the depot,
- * we don't need to waste PFN capacity on a separate list head either.
- */
-#define IOVA_MAG_SIZE 127
-
-#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
-
-struct iova_magazine {
-	union {
-		unsigned long size;
-		struct iova_magazine *next;
-	};
-	unsigned long pfns[IOVA_MAG_SIZE];
-};
-static_assert(!(sizeof(struct iova_magazine) & (sizeof(struct iova_magazine) - 1)));
 
 struct iova_cpu_rcache {
 	spinlock_t lock;
@@ -658,7 +672,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 {
 	struct iova_magazine *mag;
 
-	mag = kmalloc(sizeof(*mag), flags);
+	mag = kmem_cache_alloc(iova_magazine_cache, flags);
 	if (mag)
 		mag->size = 0;
 
@@ -667,7 +681,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 
 static void iova_magazine_free(struct iova_magazine *mag)
 {
-	kfree(mag);
+	kmem_cache_free(iova_magazine_cache, mag);
 }
 
 static void
-- 
2.43.0.594.gd9cf4e227d-goog


