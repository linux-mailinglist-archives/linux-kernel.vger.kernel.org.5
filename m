Return-Path: <linux-kernel+bounces-108480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A69E3880B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AA2282751
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0654B1EF18;
	Wed, 20 Mar 2024 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QApSrugh"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941761D52C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915051; cv=none; b=lFIS8JIn8GcDnYAnZxJzQd0MVIn1f7SnUst01/2tIyhJz1BaNY3EPg0/Is+EIZyUdriIaPm2Aigfh346C4OA6bDGz9QBMeqkkUnsCQAue8UVS+iTTB7Jnj7UqaPWRiopHRJQDggJGMES5JrHSds03bmY3b2AsICBwdwKT/zQuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915051; c=relaxed/simple;
	bh=J8aboBH2NNf/knR7707BomgJdaL1PmX4mVybR7fdxQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1NwHg2rGZawHRUNz/iezJaiSlYjVHEHCXARVFXXjMlK34AgkQw0cOGFHA2AhdskSdpYQrlObKzjU3oPW/6KtKzl8dJduBxCZ3VRukKpVYwzSGembomu5VIFSst38mk29LVtmGtj6rMf8ed4/WRqhflEoaxeklV18H8zlkLlGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QApSrugh; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-789e2bf854dso273609385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710915048; x=1711519848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwGW4X7oulIIcxRnBbYYicnOB+KsMIm/U2BqanKa/fk=;
        b=QApSrughB8bNRoVI7ESz5xpm7w+O0Rvl6SWYFVjloNX/ZFs9k8RBK4X6mDEKpz4zdk
         sm9OoPRe/mUSITvsiUH6hwG2i9z55RkN/DWnb8VocsWpXlHMQBJ2TnwkGzu5B9ddEQmk
         hRPEi7v8AtGUDz6NlRHoWfjIIMOE67fpN35rqljXQOFSgJ4WY04zhIljDslt8AmkZE+J
         6l90rr7xUC4ULA8FoRlyEIaFI5Ku1tJZUMGr3l56daicjoduHtCF8a5cnWzTo+pa+zWX
         w014nvMZh5QKthcZrKaoAZFt1KFqlQ2aCzTa5D8tA5NBxaWthhipIyXh95P0wTW68Bs7
         9oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710915048; x=1711519848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwGW4X7oulIIcxRnBbYYicnOB+KsMIm/U2BqanKa/fk=;
        b=TFD/8kWWIO7LFXkWfQktzGuPfWU+X6KS+bLHPQcDbYTglFFG5spdnswIsiUsYKC86d
         d7uyFxAt4+pLZ0ZTBp1xgFWkuk8cDU/XORh33ZWwue5SucecRg/jyYip6XB1BuFElY1J
         PUDx3Eti9eeanDoZaB8Z/Xq2xl3F9wt2ptSPaAyxJZ8hu1WK43ViBeqVmOUYyrfB7Ums
         nFdTh6MXS/zSMHXcbZSxxa9BblUkepsTSF73E7TsdkIl98KPIQgcCOkEdiN36Xapaso6
         WMRlHuaa+Z/9Zjyoz/g6s3uEUUvFf613R0GSmc3sSG80IgDoN7Fevi9pjMymZRLVaJ8K
         kbqg==
X-Forwarded-Encrypted: i=1; AJvYcCUC20WS7t+iR9+6trTkkfFaiiVQ0F+OsaSizYG1rboupmzSUYSurWuBk/rPgz8aiPNvLWgrt7ctPM78iNjhaTypXsQADqAxhfdYWGC3
X-Gm-Message-State: AOJu0YwQwHCCqjFuXcF5tdh8wTz+g4PgAU/PzGxpldi+V8OknebbE3qs
	6EvamTVZ1ojChevwKK6jFfk9ltD4giGc1dm36vhIu7+8hsZUfXYfQ41rNHJL35A=
X-Google-Smtp-Source: AGHT+IHdkJX6NQs9WDxlJlRWWOdNZMk+MQxYM/ZXt6WuZ6YnuVS9Rv2sdEvJFxxXOqmF9Wn7sJFtAA==
X-Received: by 2002:a05:620a:884:b0:78a:4d4:92f1 with SMTP id b4-20020a05620a088400b0078a04d492f1mr4703702qka.72.1710915048681;
        Tue, 19 Mar 2024 23:10:48 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.215.123])
        by smtp.gmail.com with ESMTPSA id r15-20020a05620a03cf00b0078a042376absm2295914qkm.22.2024.03.19.23.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 23:10:48 -0700 (PDT)
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
Subject: [PATCH v3 2/2] memory tier: dax/kmem: abstract memory types put
Date: Wed, 20 Mar 2024 06:10:40 +0000
Message-Id: <20240320061041.3246828-3-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240320061041.3246828-1-horenchuang@bytedance.com>
References: <20240320061041.3246828-1-horenchuang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Abstract `kmem_put_memory_types()` into `mt_put_memory_types()` to
accommodate various memory types and enhance flexibility,
similar to `mt_find_alloc_memory_type()`.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
---
 drivers/dax/kmem.c           |  7 +------
 include/linux/memory-tiers.h |  6 ++++++
 mm/memory-tiers.c            | 12 ++++++++++++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index de1333aa7b3e..01399e5b53b2 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -66,13 +66,8 @@ static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
 
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
index b2135334ac18..a44c03c2ba3a 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -50,6 +50,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
 struct memory_dev_type *mt_find_alloc_memory_type(int adist,
 							struct list_head *memory_types);
+void mt_put_memory_types(struct list_head *memory_types);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -143,5 +144,10 @@ struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *m
 {
 	return NULL;
 }
+
+void mt_put_memory_types(struct list_head *memory_types)
+{
+
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index d9b96b21b65a..6246c28546ba 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -662,6 +662,18 @@ struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *m
 }
 EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
 
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
 /*
  * This is invoked via late_initcall() to create
  * CPUless memory tiers after HMAT info is ready or
-- 
Ho-Ren (Jack) Chuang


