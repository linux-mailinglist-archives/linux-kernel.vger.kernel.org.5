Return-Path: <linux-kernel+bounces-123925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B53A890FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF81C2496C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1151428F;
	Fri, 29 Mar 2024 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XksI/xju"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97385FC1F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673302; cv=none; b=JB4sWQZ9yA+MWHYzH2QIj7w67ysZx4mKkNu60R0F8/AeDhdHgvE6XWZloj1sdA/+ey2Xv7qCyCsiyEcemneSiq25QUqizc7qrqzhuy3SeLESya+OKWX8vJyRjVq5H0X9cHlfTStHd5COUkCV9+hl8UgAquIVmX4cj6KUVvW7dsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673302; c=relaxed/simple;
	bh=vXOLrurzWw91h7eYCw90ZLDHh+I4uNd31lHySo7hGYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQMPS6KGfjJJwQzn0f5x5xxCTQDxET/IImAycx5yknfUchVnngYFQXgFte5EaW55AiDjnDrIp3yp4ozziZ1l/xcc+WdrVVyGVo4tBTqqTYchUA2TbH8a1EjDFwn1ELfwdWPvdo/qvMQXq5OXblc2v/VmuANhYIKW3DpAPmf2XkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XksI/xju; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso1633945276.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711673299; x=1712278099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nM2K0D/X61aNkdsdtPeKZ1y9TeOUsh6nA3RvZQfcaBY=;
        b=XksI/xjusH5lTWSlo6a7pWU9vtT/81z8sLBdJe2So4GPdaDTD+9w31hpSjsurT+qDR
         E82K1qw9P8572dlnJOcH/kDYBob135jlJ+1unmwwabuWihegBUBhciwK1fxXr+vmes0k
         AFUX/fc8BlXyrUFhCA6FuXzHjQ5LAxJFA+bfqufrUgyScJL4wQoiX8O2I1zT/07dgZHL
         cL3E2ZzCouEcYWHSAzEo5qb6/5T6GWFKPrWffZKOXZgn9Bsn7AdFETCgL8CpEZrt/PK6
         1TP19voiSdQLnIK7VuVRW6zvQ+XO4kGt6lq45h0W80EyekGuAqPDpuBIqzK2rkpvIGO3
         aYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711673299; x=1712278099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nM2K0D/X61aNkdsdtPeKZ1y9TeOUsh6nA3RvZQfcaBY=;
        b=RdBGkHyYiWPX2QBTbWCAxzPkuybuEgaRSE2lDP5JU+U1zKZDIh+FZ2mOt+1tqI2J2I
         gfTbBM4OQxL2KZP80v6hJ5a6kwv/ycNpaVToaS/k+GbosX0OYBktZjkstFjSRmsglZoR
         xSsRee/VYYHAIb+LEI1Mixte31QcB8D+/zNnC3x02LBmTlbz1DmTxJCE8x3pX3WLN9LM
         iDVTI3XvZskF3FC0SisC5rTnYJZ6VKFsr+xgehwuZexXCrJT8rYv3p3OGymTeeceBH5Z
         3Yz8U8xriCtp+m7QQNTXy6m/pMV1GGFG2UzUAvU8nrD7fbTTSs7wF/wKxOliQ3I5d4Cw
         gQMg==
X-Forwarded-Encrypted: i=1; AJvYcCXpcvsAaL2vFNo/2t6mgxDi2kuGXCT3ZyzBlI0jdQuZHpEJZBkvvAKnTccA/f9AfRqdgTI9HfLyYRKZktAz5Di528+aGUm3d6NitvGB
X-Gm-Message-State: AOJu0YzriYcd8CVP75oxtt45FXpW7bqiFmUWnlhitdi+k4GZ8gmuSeSQ
	6NG8MYMPaHNwJySN8R/7a1nLWAYIViQ4yx/x/7W0ctOh4LLGTaVHWdjle5Hlfps=
X-Google-Smtp-Source: AGHT+IEWc8MJ8W6U6KVvKlVOAwYm9Oc+qt201hxUZthUjnrGBEx4qZhRjNwiP6o45lr2jPQ2OBCapQ==
X-Received: by 2002:a5b:1c1:0:b0:dda:a9f7:4ec2 with SMTP id f1-20020a5b01c1000000b00ddaa9f74ec2mr1063844ybp.56.1711673299513;
        Thu, 28 Mar 2024 17:48:19 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac8749a000000b00430afbb6b50sm1102414qtq.51.2024.03.28.17.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:48:19 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
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
Subject: [PATCH v8 1/2] memory tier: dax/kmem: introduce an abstract layer for finding, allocating, and putting memory types
Date: Fri, 29 Mar 2024 00:48:13 +0000
Message-Id: <20240329004815.195476-2-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240329004815.195476-1-horenchuang@bytedance.com>
References: <20240329004815.195476-1-horenchuang@bytedance.com>
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
 drivers/dax/kmem.c           | 20 ++------------------
 include/linux/memory-tiers.h | 13 +++++++++++++
 mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 42ee360cf4e3..01399e5b53b2 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
 
 static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
 {
-	bool found = false;
 	struct memory_dev_type *mtype;
 
 	mutex_lock(&kmem_memory_type_lock);
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
+	mtype = mt_find_alloc_memory_type(adist, &kmem_memory_types);
 	mutex_unlock(&kmem_memory_type_lock);
 
 	return mtype;
@@ -77,13 +66,8 @@ static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
 
 static void kmem_put_memory_types(void)
 {
-	struct memory_dev_type *mtype, *mtn;
-
 	mutex_lock(&kmem_memory_type_lock);
-	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
-		list_del(&mtype->list);
-		put_memory_type(mtype);
-	}
+	mt_put_memory_types(&kmem_memory_types);
 	mutex_unlock(&kmem_memory_type_lock);
 }
 
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 69e781900082..a44c03c2ba3a 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
 int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
+struct memory_dev_type *mt_find_alloc_memory_type(int adist,
+							struct list_head *memory_types);
+void mt_put_memory_types(struct list_head *memory_types);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
 {
 	return -EIO;
 }
+
+struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
+{
+	return NULL;
+}
+
+void mt_put_memory_types(struct list_head *memory_types)
+{
+
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0537664620e5..974af10cfdd8 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -623,6 +623,38 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
+{
+	bool found = false;
+	struct memory_dev_type *mtype;
+
+	list_for_each_entry(mtype, memory_types, list) {
+		if (mtype->adistance == adist) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		mtype = alloc_memory_type(adist);
+		if (!IS_ERR(mtype))
+			list_add(&mtype->list, memory_types);
+	}
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


