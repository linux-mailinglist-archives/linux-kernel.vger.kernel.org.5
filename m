Return-Path: <linux-kernel+bounces-111044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B206D886746
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27EB01F22954
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1651A15AD0;
	Fri, 22 Mar 2024 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O2l6Pt95"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC5712E5E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711091051; cv=none; b=iqnHoI20v9kG4/TR4CtZYNT8lm060UDJGJSlAhvLsRMuh+2oNZEaorjNHb+i6d90wBqlGemZpoE+L4gRxtyPyKJRMv75pfpRdzxIjSZBeK1/PtaeM2v+/Vui9Atmr9n2/5gQzDDW326F2MI6b+pHcEhWCTdCTQ4MjrXQ17sTBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711091051; c=relaxed/simple;
	bh=vFF0xl5uC5TkFV+VvhVksXaBFVN1XObnMprIpkcV0NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2N64Qp0Ow0AVTgBjEEhvgV00DUj+uUPDZ0zwqtIuxwe/1NwgbcKm64klkykGo5SFsHm1HFoRMNa4jQDFwa8pxDR+cTvWn+SZHwRBahRjRIjBWj1icmA9lCrCK5cszL8T6fTfB8vjswcFft15c0iioQxZuVu+CQRRdDNu/3gNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O2l6Pt95; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e68d358974so878180a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711091048; x=1711695848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvdqGcDUWp3D4k7+aVnVSTSeWYL78OJhC3HPSf53QMU=;
        b=O2l6Pt952Ja6i7VdqSCk2LvKn/bhycNNRo4dP85zZpW00OdAtTCCEfWIMZgkKZUpeC
         6TIUzvN82aRhmqMPbgVMt/pDMUKkYHx1lNVts7UVseFOJzeMqfF6SMvkZ+2j/02YjlH6
         oxKlP3oQA9EiAa8fnDDuJrIY2TFszCxHj6ST/zWJsH0QBjNINiWvipj0IzzwG9xLNSEi
         MpGuGTaxDQ0wYt4MxcHTQBD+c6B9l8SBif7KUfMdhbmqevFv2gdT2u49LWEVdmCkSv1/
         kkoewDFmeaahpPJm4PkJJnH8OgXq/zmsAl+TFGCe+YHQ/0vzSCOO6gUyc8tw8wwa0//J
         cd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711091048; x=1711695848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvdqGcDUWp3D4k7+aVnVSTSeWYL78OJhC3HPSf53QMU=;
        b=rPlwrDSeGX45IahZ8Rio3CelXQzYlHDmFbMD0NeIGOuxIT1nJM2RCHqvBkJ2H4GHcA
         s1pjkU+Yi+D6UeeIqE7esQ/4SlTbowk8nbmUHrrTAPUskaqJMX7f/yWU00HMlRMIXBFE
         RFrrXbOyUlYRzGFUMG8hJ0VHYq7EgQHoIgHTUYfZsOipsp8Gn2bT193NVniQpyPwL8/t
         ZIXSXB/rdtHjgc0SDTInIKFDUD6rjPVys/DX/1yHsSpYzKu1r76wGxOMqmkzDv7Tt7va
         E1eafxgkw2EMavNfBUBqsaDfXwI+Dt/xLVTc7vvUY0psL7FM8IILw7kd2meb/Zg8+rf3
         BlBA==
X-Forwarded-Encrypted: i=1; AJvYcCX2u6pg5ArsnjnsCv7Fo35l+w5thG048Z0qQNWwt5HK/TvSa8+SFi/I96E9ohUXM2vxWCrr3GVBI6HsQ8yW+vMmwOf1uelQ6wHMUOtV
X-Gm-Message-State: AOJu0YwVj7xuQ2S9NlZSlNhq6SJ3E5/KqSd6BH9HevWaiadi5lq8dufD
	eZBHUkRNjQjEyNWyoTwpZDVMUoxdKEDyEbhyNizFDjQTGyRUs5D3rSZvD1ietS0=
X-Google-Smtp-Source: AGHT+IExMx82G1L/gVZ6jXrs/MSYhc9K/oqB/ubjzqHOlRbMAoe/h5NMx7SZB1F0B8mlmh4A9A/ppg==
X-Received: by 2002:a9d:6e90:0:b0:6e6:a66e:842e with SMTP id a16-20020a9d6e90000000b006e6a66e842emr1756946otr.21.1711091048480;
        Fri, 22 Mar 2024 00:04:08 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.215.108])
        by smtp.gmail.com with ESMTPSA id k1-20020ae9f101000000b00789fc794dbesm553974qkg.45.2024.03.22.00.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 00:04:08 -0700 (PDT)
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
Subject: [PATCH v4 1/2] memory tier: dax/kmem: introduce an abstract layer for finding, allocating, and putting memory types
Date: Fri, 22 Mar 2024 07:03:54 +0000
Message-Id: <20240322070356.315922-2-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240322070356.315922-1-horenchuang@bytedance.com>
References: <20240322070356.315922-1-horenchuang@bytedance.com>
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


