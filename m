Return-Path: <linux-kernel+bounces-48771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D13BA846100
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F79B26AD7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1828527D;
	Thu,  1 Feb 2024 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="hVjt/R+x"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397929B0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815821; cv=none; b=qzl5jxso+QSo/I8pZzcDiiexQ48YMLUM9aFTpeKNgPI6Tuh49ecfoNfdZEzIFZB2xn/O90OasLM48FZmVMAVFC6uGpQJEXPGWKQdwF9HPqrAIMCBxyX/ffJAuiKFY+itDWM5uVTwAwM/3KNz+OtrkTxAHzQ47nOr3U9yLJPIpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815821; c=relaxed/simple;
	bh=7loz5bo6hwRwp9fF34CU0TwzHWopBNAJLtAZsKpdYJY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C2UVjzx3+6CF8eTgzwv3kcgn3/tb8JgIHANizeEuSvAABZCymEaM2bkIup31xwYZVm3uQ9UYVfC9JGxMeacyWSLsECBWr/SYg8Mu5yEYxTkghwY2Dqq0pJY4OGqJHayNXsWmF6I8pwn8u+YDAwMR2ehSy5a3MnErVVF+A+nrTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=hVjt/R+x reason="key not found in DNS"; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-46b20b23ff7so495713137.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706815817; x=1707420617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BSEQBUwLYtDyX8SfM7b6fTPQYYyhCXu8tsAp9rUSiMw=;
        b=hVjt/R+xGXDvi83npwK1UtBz4RPQVC8TrNCJ1tZOnbhE+C+fo5eVGKBNK8xqesdoUP
         FBkCGhxj/yZkVoroWKYsDh0+ssD01BkiD7LTvlFai6SqH4a5GscgS/otLZFh/uYCySyS
         s1hu0cB/QVFgtV1IAe/xkxOgOIFZB5RNvsTlGUI7HC+fP9VnKf70Al8wvMR7ylFyTQf3
         f2hZy0qsMNLrfzweR8uIe7I5aecMYsFczBZQ+Oj0JstB06ZV8i+fogepPqrsWunMuZql
         6ZFkozCEZXDrIyPK3/keAn1XYTpZf2eDoiF1vxN+3I1CAIcmtt7XCSxrRmqkSVwSUv+y
         D+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815817; x=1707420617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSEQBUwLYtDyX8SfM7b6fTPQYYyhCXu8tsAp9rUSiMw=;
        b=KwA1JtlPiGGp+qxj9qRq0hmY9ZflE39b3EuHsqfdq7WCueedMMKFXpogJArVq0QJeh
         APtd9Y7VN4B7C9i72rsDcUEufHwlPNKnu68zDtFSP46z7vwiBbdeeqG2UKVhbH8rhR//
         IAP+0kZLs2KRFgT2K2CgVTvzPQtg0Q+4Fep8DyBxGz+P9bowWFY1Ca1lXKMtV0tX1a/M
         X6pVUrZYFiXk/CAe759pZafqqS6N+NQsWhVfXhxNlVH3pQGaXO4saNWbBJqswz0eoSKz
         tglmwkJLegKILEIDjJCaEsih/NbQiEQBUVK18TKu9ncATGCCvVMDXa7nOoDsSOSyQRB6
         DZGw==
X-Gm-Message-State: AOJu0Yy8wMBlvK19WJD5PpBpuoPPXVXP6uGcl4Qy024mI//8k0Qis+zT
	UyQZJ3YWZ+tZEBdMkS4YQv7982HQvmwBrCPeOMsYMaMsIbd+nav7N3709SYxD+8=
X-Google-Smtp-Source: AGHT+IET93Vs0eqCzQUdFrwgDKKIhEbJwk6iAT2cMBeQIiq6TG6SVpcwALrgdlhKSo1JBgLLU5iGkA==
X-Received: by 2002:a05:6102:316c:b0:46b:159e:bf04 with SMTP id l12-20020a056102316c00b0046b159ebf04mr6285592vsm.2.1706815816873;
        Thu, 01 Feb 2024 11:30:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbTUU/Nlcj6oufqZ9IAZI/9jykB57i+q5vJUcSyMfSXMQRX5nRq/VbOwv5We1qFiKsHSdD7s8/MjqeEFVGLMNwkff7T4Qgj0EeVt9bhyeAoHbv04nlO5LFzIBdsHmNbQf7Vfm2vhlhVWweFrQWRpVA2xQwu/P49MiyEL6Zh1pCk+/vUADBYM2rLeMH8HVCkvoXZJh06/iCgcSd+ue6+o/VG/zOyn/T3mgonWNQ2MjM7t3t27PsCbTZIWLixNH5U5jl/XZH76hxYbE=
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id r18-20020ad44052000000b0068c50dec857sm58648qvp.128.2024.02.01.11.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:30:16 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
X-Google-Original-From: Pasha Tatashin <tatashin@google.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	rientjes@google.com
Subject: [PATCH] iommu/iova: use named kmem_cache for iova magazines
Date: Thu,  1 Feb 2024 19:30:14 +0000
Message-ID: <20240201193014.2785570-1-tatashin@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pasha Tatashin <pasha.tatashin@soleen.com>

The magazine buffers can take gigabytes of kmem memory, dominating all
other allocations. For observability prurpose create named slab cache so
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
 drivers/iommu/iova.c | 57 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d30e453d0fb4..617bbc2b79f5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -630,6 +630,10 @@ EXPORT_SYMBOL_GPL(reserve_iova);
 
 #define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
 
+static struct kmem_cache *iova_magazine_cache;
+static unsigned int iova_magazine_cache_users;
+static DEFINE_MUTEX(iova_magazine_cache_mutex);
+
 struct iova_magazine {
 	union {
 		unsigned long size;
@@ -654,11 +658,51 @@ struct iova_rcache {
 	struct delayed_work work;
 };
 
+static int iova_magazine_cache_init(void)
+{
+	int ret = 0;
+
+	mutex_lock(&iova_magazine_cache_mutex);
+
+	iova_magazine_cache_users++;
+	if (iova_magazine_cache_users > 1)
+		goto out_unlock;
+
+	iova_magazine_cache = kmem_cache_create("iommu_iova_magazine",
+						sizeof(struct iova_magazine),
+						0, SLAB_HWCACHE_ALIGN, NULL);
+
+	if (!iova_magazine_cache) {
+		pr_err("Couldn't create iova magazine cache\n");
+		ret = -ENOMEM;
+	}
+
+out_unlock:
+	mutex_unlock(&iova_magazine_cache_mutex);
+
+	return ret;
+}
+
+static void iova_magazine_cache_fini(void)
+{
+	mutex_lock(&iova_magazine_cache_mutex);
+
+	if (WARN_ON(!iova_magazine_cache_users))
+		goto out_unlock;
+
+	iova_magazine_cache_users--;
+	if (!iova_magazine_cache_users)
+		kmem_cache_destroy(iova_magazine_cache);
+
+out_unlock:
+	mutex_unlock(&iova_magazine_cache_mutex);
+}
+
 static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 {
 	struct iova_magazine *mag;
 
-	mag = kmalloc(sizeof(*mag), flags);
+	mag = kmem_cache_alloc(iova_magazine_cache, flags);
 	if (mag)
 		mag->size = 0;
 
@@ -667,7 +711,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 
 static void iova_magazine_free(struct iova_magazine *mag)
 {
-	kfree(mag);
+	kmem_cache_free(iova_magazine_cache, mag);
 }
 
 static void
@@ -766,11 +810,17 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 	unsigned int cpu;
 	int i, ret;
 
+	ret = iova_magazine_cache_init();
+	if (ret)
+		return -ENOMEM;
+
 	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
 				 sizeof(struct iova_rcache),
 				 GFP_KERNEL);
-	if (!iovad->rcaches)
+	if (!iovad->rcaches) {
+		iova_magazine_cache_fini();
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
 		struct iova_cpu_rcache *cpu_rcache;
@@ -948,6 +998,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 
 	kfree(iovad->rcaches);
 	iovad->rcaches = NULL;
+	iova_magazine_cache_fini();
 }
 
 /*
-- 
2.43.0.594.gd9cf4e227d-goog


