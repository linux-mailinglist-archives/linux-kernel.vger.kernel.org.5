Return-Path: <linux-kernel+bounces-132281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC889926D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C6F1C227F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC134C6D;
	Fri,  5 Apr 2024 00:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AQ2V6PMd"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF9632
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275634; cv=none; b=tnSDYW8q3O2fHM3pEdDHgYV4emti2VEmcdor/1pLG797BRe9g3nObcZT7co9bxgOSA30VV1lliXNE95UMypVGsHCA3WIqOrMb0eH4eoWbNL+AGjh3ZNdvM9hjvolSKrwpV80/YHf/olAzzuEwY4zUuo9pbPDJTb0tYYxBoFIgHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275634; c=relaxed/simple;
	bh=RQp1bEatwWWIK0ClFSSneTFZEk9z+LRSaOBqfpoW5DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0BH4UErimkC9HCT+EnJFKsBEWtq5loSYYxujNcaWzc/0m2z12BGDXs5VfLulMrLntyWKtudi4q+fb2u1cFiUPKuTXzlyVggAyZPDstI/ozHup87pd5336LbhqGnDSP6gjRh8+DiGQeox6gZK0kZGsasysKQISdmFaQ4MNlcbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AQ2V6PMd; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2228c4c5ac3so924559fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712275631; x=1712880431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6McIYZbsLclE8SOPWcjX3CynsQ0RAlONuKXKFdsbWI=;
        b=AQ2V6PMd/DggJbqOCwYK4enIJAbbd9F0xkbxtjZkydJX5C5HH4CiphPrOINvzVcgdt
         9kbQ9FfRh7rlXN3V19S3EFzx5esjvZ5gsk66LcECH46YU2QyCjUIpfh1aOnaYaLAReXp
         T5Wn/J5BXzz1frukOONY/6GPHoT8tOhDvow0QP+n9BUHQ+abkowy7cV7u1+U9CdHgk7U
         JzMFNFb7ylTrvGe1g2jTzk9QOSOJw4zLB9o2PlD092BSC+z13d7qCTwSVTirjDNOQx9l
         QVmrfkfNqgYkWGl571Gbk5t4GufT62jk7hiHHI/5uvkydATcm1dWahlaigXPFJfwjxiT
         CahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275631; x=1712880431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6McIYZbsLclE8SOPWcjX3CynsQ0RAlONuKXKFdsbWI=;
        b=cpUVY7mcpgPVgQ1ubzZA2BgowKy8/ofLKz9++0oJfN3LUP/5Wpz9eMgHoLj1dTImB3
         w8tSwDasOR3/ozw/HcPcCPd5YMdqUrVu+R+lL8bmzGJZg7yxB/0J/5R11G4PmTda37dj
         npeAjlfg5wNATi5xYYgDMLgIYogz7xyj4cUQaeg7N/dLHshZvPtaQKNZXiq5i/5gAB18
         nYuwzQQj4+d+YWOyEj8GBk4z07THsydcJEmtMqSwQ1oMFsiE8zkl9iPTiWnw/RqqffsR
         kvwpjDSacQT2angJLkplJvq8rc/KknjQRH80MT16LP4CBN2mYy8gloDVDcyz2T9P2nTt
         PRdg==
X-Forwarded-Encrypted: i=1; AJvYcCV34yySZJWDuMiLfWx7Vj3Mpuc6LQ5N7rKwIHjOsUfYKXAsmeds0kas/xlZBkApkjAJqEgE435l3i77ZdxnIH2i0nUI7JaKzFnx/G1c
X-Gm-Message-State: AOJu0YwoZ0xPI2WhKqzX9MXuvryHya3IXpYQFLzhW1eeFNJYwV7cYFdZ
	CPozy5Xk4Y688LgvvmB1yTVSKLbAdnJPRhgSJapFgH4GQl8PKibYrK7uc8bvIvM=
X-Google-Smtp-Source: AGHT+IETdG/JDjD1LulGxhxX7zA4HNJ1/USqVA9s7rf27ac8j8DzM+mrGRQqRxmrtXI7tO369pGm5Q==
X-Received: by 2002:a05:6870:80cc:b0:22e:8fe3:a9f3 with SMTP id r12-20020a05687080cc00b0022e8fe3a9f3mr4500124oab.17.1712275631507;
        Thu, 04 Apr 2024 17:07:11 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.118])
        by smtp.gmail.com with ESMTPSA id d4-20020a37c404000000b0078835bfddb8sm191433qki.84.2024.04.04.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:07:11 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Srinivasulu Thanneeru" <sthanneeru@micron.com>,
	"SeongJae Park" <sj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v11 1/2] memory tier: dax/kmem: introduce an abstract layer for finding, allocating, and putting memory types
Date: Fri,  5 Apr 2024 00:07:05 +0000
Message-Id: <20240405000707.2670063-2-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240405000707.2670063-1-horenchuang@bytedance.com>
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since different memory devices require finding, allocating, and putting
memory types, these common steps are abstracted in this patch,
enhancing the scalability and conciseness of the code.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 drivers/dax/kmem.c           | 30 ++++--------------------------
 include/linux/memory-tiers.h | 13 +++++++++++++
 mm/memory-tiers.c            | 29 +++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 42ee360cf4e3..4fe9d040e375 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -55,36 +55,14 @@ static LIST_HEAD(kmem_memory_types);
 
 static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
 {
-	bool found = false;
-	struct memory_dev_type *mtype;
-
-	mutex_lock(&kmem_memory_type_lock);
-	list_for_each_entry(mtype, &kmem_memory_types, list) {
-		if (mtype->adistance == adist) {
-			found = true;
-			break;
-		}
-	}
-	if (!found) {
-		mtype = alloc_memory_type(adist);
-		if (!IS_ERR(mtype))
-			list_add(&mtype->list, &kmem_memory_types);
-	}
-	mutex_unlock(&kmem_memory_type_lock);
-
-	return mtype;
+	guard(mutex)(&kmem_memory_type_lock);
+	return mt_find_alloc_memory_type(adist, &kmem_memory_types);
 }
 
 static void kmem_put_memory_types(void)
 {
-	struct memory_dev_type *mtype, *mtn;
-
-	mutex_lock(&kmem_memory_type_lock);
-	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
-		list_del(&mtype->list);
-		put_memory_type(mtype);
-	}
-	mutex_unlock(&kmem_memory_type_lock);
+	guard(mutex)(&kmem_memory_type_lock);
+	mt_put_memory_types(&kmem_memory_types);
 }
 
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 69e781900082..0d70788558f4 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
 int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
+struct memory_dev_type *mt_find_alloc_memory_type(int adist,
+						  struct list_head *memory_types);
+void mt_put_memory_types(struct list_head *memory_types);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
 {
 	return -EIO;
 }
+
+static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
+								struct list_head *memory_types)
+{
+	return NULL;
+}
+
+static inline void mt_put_memory_types(struct list_head *memory_types)
+{
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0537664620e5..516b144fd45a 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -623,6 +623,35 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
+{
+	struct memory_dev_type *mtype;
+
+	list_for_each_entry(mtype, memory_types, list)
+		if (mtype->adistance == adist)
+			return mtype;
+
+	mtype = alloc_memory_type(adist);
+	if (IS_ERR(mtype))
+		return mtype;
+
+	list_add(&mtype->list, memory_types);
+
+	return mtype;
+}
+EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
+
+void mt_put_memory_types(struct list_head *memory_types)
+{
+	struct memory_dev_type *mtype, *mtn;
+
+	list_for_each_entry_safe(mtype, mtn, memory_types, list) {
+		list_del(&mtype->list);
+		put_memory_type(mtype);
+	}
+}
+EXPORT_SYMBOL_GPL(mt_put_memory_types);
+
 static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 {
 	pr_info(
-- 
Ho-Ren (Jack) Chuang


