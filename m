Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9347FB2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbjK1HfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343814AbjK1HfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:35:10 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBDC19B7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:35:07 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cc77e23218so52166877b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701156906; x=1701761706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkYXobmQORad3/hpJazSzxaZjqFiG7V4HM30XOOtlqU=;
        b=Wei5KdWt6COAubw+NNgbXg5tQnBd29H6QJX7Dofrk6R4zIP5tul8Fkun6CIa6JRsYB
         WiT+CnVUf+7AMsQhjmwR5ZG+7XgFft5FaD8ZiQKsE0URJg8v9r2SxZHLGcVl+2KZ20xt
         dRhxLXmi8yJ3SfbonkKRS86oOZaRM1M9eacqV/kt6Metx3BrXkvG5igjjrFodnuSExDx
         HIOr+ARqhQLbwB+nJSM6UtcVk2PFMZgtZi9PPmmfdR9spB/2IpmakkXQ5E/VFRm8HZyk
         ynv3MvtTlh70aZmYjgetwsyvZ9PbiyQx734sO6AK6tknYcU2KbJp875dVPLeavxvxYJ0
         KM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156906; x=1701761706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkYXobmQORad3/hpJazSzxaZjqFiG7V4HM30XOOtlqU=;
        b=HvWr4gfH4szweGgm1RyeUwqulQeO4Kt5vGH+//ciSjRprVkHyAHm0Y8DH73FAxpTKM
         gNYw9VbvW74TEVWQEalbZ6s5EYlJm1wfEpcGFEexcQn5XfN0m6NKYd1NuyNDqWPIE6Jy
         RL60omU3VagSPmPY6yWKrr+Ujros8EMdfq/TxG3O7cZeeRnfX9q4cgUh0rQ8B0c5o9KJ
         8413FY8txNJQRBI1r3tqoCuNgp21c3t+P1Hvws7lDobfMFgVX4mIHl5jHppPYSKRDyVK
         Hab/hqyuJ8G0lXX0ApZgmbMzFcC7JuaUbwnGsZjR9U52MfssmVrscLrYPfmRj7f9BOhT
         1TGQ==
X-Gm-Message-State: AOJu0YzeYmNxisvhRNFecHJMxqjSpW61FdzDKk0oCxu1PeW3hNXdZZsP
        I1fCHF6piOIoJgor0H+cumM=
X-Google-Smtp-Source: AGHT+IHY5XDAgMbNEpLvOxM9X1wUTOqLGATih0InMi8U33BF1AbXSRtWRTq3pq3Q+sVjwW2W4Qaz6w==
X-Received: by 2002:a81:af10:0:b0:5cd:f783:df03 with SMTP id n16-20020a81af10000000b005cdf783df03mr10556684ywh.23.1701156906369;
        Mon, 27 Nov 2023 23:35:06 -0800 (PST)
Received: from cuiyangpei.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cb4fa1174dsm8331333pfn.124.2023.11.27.23.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:35:06 -0800 (PST)
From:   cuiyangpei <cuiyangpei@gmail.com>
X-Google-Original-From: cuiyangpei <cuiyangpei@xiaomi.com>
To:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     cuiyangpei <cuiyangpei@xiaomi.com>
Subject: [PATCH 2/2] mm/damon/core: add sysfs nodes to set last_nr_accesses weight
Date:   Tue, 28 Nov 2023 15:34:40 +0800
Message-ID: <20231128073440.11894-2-cuiyangpei@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
References: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The date access frequency is cleared every time the aggregation
interval is reached. In order to refer to the past time access
frequency, the current access frequency can be calculated by
setting the weight of the last access frequency.

Signed-off-by: cuiyangpei <cuiyangpei@xiaomi.com>
---
 .../ABI/testing/sysfs-kernel-mm-damon         |  6 ++++
 include/linux/damon.h                         |  3 ++
 mm/damon/core.c                               | 29 +++++++++++++++++
 mm/damon/sysfs.c                              | 31 +++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 819534dcfb6c..8367e26bf4da 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -74,6 +74,12 @@ Description:	Writing a keyword for a monitoring operations set ('vaddr' for
 		Note that only the operations sets that listed in
 		'avail_operations' file are valid inputs.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/last_nr_accesses_weight
+Date:		Nov 2023
+Contact:	Ping Xiong <xiongping1@xiaomi.com>
+Description:	Writing a value to this file sets last_nr_accesses weight
+		of the DAMON context. Reading this file returns the value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6495513cc6de..71e67a9d0996 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -18,6 +18,8 @@
 #define DAMON_MIN_REGION	PAGE_SIZE
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
+/* set last_nr_accesses weight */
+#define LAST_NR_ACCESSES_WEIGHT	0
 
 #define MIN_RECORD_BUFFER_LEN	1024
 #define MAX_RECORD_BUFFER_LEN	(4 * 1024 * 1024)
@@ -522,6 +524,7 @@ struct damon_attrs {
 	unsigned long ops_update_interval;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
+	unsigned int last_nr_accesses_weight;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 630077d95dc6..230afcceea22 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1142,6 +1142,34 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 }
 
+static unsigned int __calculate_nr_accesses(struct damon_ctx *c, struct damon_region *r)
+{
+	unsigned int rem_old, rem_new;
+	unsigned int res;
+	unsigned int weight = c->attrs.last_nr_accesses_weight;
+
+	res = div_u64_rem(r->nr_accesses, 100, &rem_new) * (100 - weight)
+		+ div_u64_rem(r->last_nr_accesses, 100, &rem_old) * weight;
+
+	if (rem_new)
+		res += rem_new * (100 - weight) / 100;
+	if (rem_old)
+		res += rem_old * weight / 100;
+
+	return res;
+}
+
+static void kdamon_update_nr_accesses(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t)
+			r->nr_accesses = __calculate_nr_accesses(c, r);
+	}
+}
+
 /*
  * Merge two adjacent regions into one region
  */
@@ -1469,6 +1497,7 @@ static int kdamond_fn(void *data)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
 		if (ctx->passed_sample_intervals == next_aggregation_sis) {
+			kdamon_update_nr_accesses(ctx);
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7a7d41e609e3..2946b0e91ad8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -544,6 +544,7 @@ struct damon_sysfs_attrs {
 	struct kobject kobj;
 	struct damon_sysfs_intervals *intervals;
 	struct damon_sysfs_ul_range *nr_regions_range;
+	unsigned int last_nr_accesses_weight;
 };
 
 static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
@@ -553,6 +554,7 @@ static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
 	if (!attrs)
 		return NULL;
 	attrs->kobj = (struct kobject){};
+	attrs->last_nr_accesses_weight = LAST_NR_ACCESSES_WEIGHT;
 	return attrs;
 }
 
@@ -602,12 +604,40 @@ static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
 	kobject_put(&attrs->intervals->kobj);
 }
 
+static ssize_t last_nr_accesses_weight_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_attrs *attrs = container_of(kobj,
+			struct damon_sysfs_attrs, kobj);
+
+	return sysfs_emit(buf, "%u\n", attrs->last_nr_accesses_weight);
+}
+
+static ssize_t last_nr_accesses_weight_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_attrs *attrs = container_of(kobj,
+			struct damon_sysfs_attrs, kobj);
+	int err = kstrtoint(buf, 0, &attrs->last_nr_accesses_weight);
+
+	if (err)
+		return -EINVAL;
+	if (attrs->last_nr_accesses_weight > 100)
+		return -EINVAL;
+
+	return count;
+}
+
 static void damon_sysfs_attrs_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_attrs, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_attrs_last_nr_accesses_weight_attr =
+		__ATTR_RW_MODE(last_nr_accesses_weight, 0600);
+
 static struct attribute *damon_sysfs_attrs_attrs[] = {
+	&damon_sysfs_attrs_last_nr_accesses_weight_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_attrs);
@@ -1083,6 +1113,7 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 		.ops_update_interval = sys_intervals->update_us,
 		.min_nr_regions = sys_nr_regions->min,
 		.max_nr_regions = sys_nr_regions->max,
+		.last_nr_accesses_weight = sys_attrs->last_nr_accesses_weight,
 	};
 	return damon_set_attrs(ctx, &attrs);
 }
-- 
2.43.0

