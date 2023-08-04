Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DE076FB85
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjHDH6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjHDH6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:58:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4BD1B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:58:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so15535895ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691135880; x=1691740680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z802CX/jhRxr4i7C0Kq8FNtLQD0asQherflJFZ/9BtY=;
        b=lCi7sEZaWt6+fEBpNPAu+/u1pxqMPkL9EUjiIKr2BYY5B8ttIBXJF78aA9AS+vBMc5
         8lXOg0V+i6Y9jrpLdS8sdTZiMEYD8JAiQJSfcj7I5ZNPtaqyTvUqcGX74AVy/bIGXlOn
         lM7guK0QY9FGsSsGw8Bb8xjpjqnRgdTQ/knqfcu6iFRVEarlV0dzqNJYtu8Fd7i1X7+r
         vaMRa8oJkxBmT1iMVJb864MVy0fQdGblOvBIw4ONNZcg8rV61BlsUZNI8HzwDbs1CczS
         ph5ck4WD5ulsLnWc8AavPNJvvlfMgiR8KNh8WKuLBWB2hPs9lGHg4MI5qozYgCAVQ8J4
         osdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691135880; x=1691740680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z802CX/jhRxr4i7C0Kq8FNtLQD0asQherflJFZ/9BtY=;
        b=QderayL4/IAbYGhnIOhCMxQ21AIxIbTl87IwVP0eDm5aKmZxcKNySTwo+S0wLojo8q
         sv46QxgIbdaCkW4rwb1iRe9hZ/KARgVNZzU2IBFkRZnskVMD4ACEMMN8dKQhcczfSgWk
         LaECigVeqXjnkFvlYBcW2QR0/Vs3KnvhGNDc+QdagnLQB6tGvevFolfw3fDxx3fg0Zsc
         Fn5yKpAqPh6fSw2Qwr2cLTuGh9980HvDaNQFRZrFzeocIYsZIC7Mrh07g3ssrlN8cx5l
         a9MmwLk+I/q+YSynRm+7Y3+H7qyMF22LDuUoQy6OArvTLGbFL+hi18LvILqb2f5jU2uV
         8MBg==
X-Gm-Message-State: AOJu0YyoyfpRy3TtNGccNcSHXIEDd8E+dNmGCZFs6t1pc71o0gJ/Wpxt
        ePLlo0Yiqk1zDWL0nUkDmahRDQ==
X-Google-Smtp-Source: AGHT+IEO3s/e3Y8sbKb+ObPEL8ybDjUD9tl+Yl9hlHtUssuaKBKvlY1JRW9qf8IMCVxcEFmBwKBBWA==
X-Received: by 2002:a17:902:f7c1:b0:1bc:41e4:af57 with SMTP id h1-20020a170902f7c100b001bc41e4af57mr1056464plw.48.1691135880054;
        Fri, 04 Aug 2023 00:58:00 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902dad100b001bb9aadfb04sm1093113plx.220.2023.08.04.00.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 00:57:59 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     david@redhat.com, yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH RESEND v2 2/2] zram: charge the compressed RAM to the page's memcgroup
Date:   Fri,  4 Aug 2023 15:57:51 +0800
Message-Id: <20230804075751.208045-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compressed RAM is currently charged to kernel, not to
any memory cgroup. This patch can charge the pages
regardless of direct or indirect zram usage.

Direct zram usage by process within a cgroup will fail
to charge if there is no memory. Indirect zram usage by
process within a cgroup via swap in PF_MEMALLOC context,
wqwill charge successfully.

This allows some limit overrun, but not enough to matter
in practice.Charge compressed page once, mean a page will
be freed.the size of compressed page is less than or equal
to the page to be freed. The numbers of excess depend on the
compression ratio only. The maximum amount will not exceed
400KB, and will be smaller than the hard limit finally,
So not an unbounded way.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 drivers/block/zram/zram_drv.c | 45 +++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5676e6dd5b16..3aa352940b9b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
+#include <linux/memcontrol.h>
 
 #include "zram_drv.h"
 
@@ -135,6 +136,18 @@ static void zram_set_obj_size(struct zram *zram,
 	zram->table[index].flags = (flags << ZRAM_FLAG_SHIFT) | size;
 }
 
+static inline void zram_set_obj_cgroup(struct zram *zram, u32 index,
+		struct obj_cgroup *objcg)
+{
+	zram->table[index].objcg = objcg;
+}
+
+static inline struct obj_cgroup *zram_get_obj_cgroup(struct zram *zram,
+		u32 index)
+{
+	return zram->table[index].objcg;
+}
+
 static inline bool zram_allocated(struct zram *zram, u32 index)
 {
 	return zram_get_obj_size(zram, index) ||
@@ -1256,6 +1269,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 static void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
+	struct obj_cgroup *objcg;
 
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	zram->table[index].ac_time = 0;
@@ -1289,6 +1303,13 @@ static void zram_free_page(struct zram *zram, size_t index)
 		goto out;
 	}
 
+	objcg = zram_get_obj_cgroup(zram, index);
+	if (objcg) {
+		obj_cgroup_uncharge_zram(objcg, zram_get_obj_size(zram, index));
+		obj_cgroup_put(objcg);
+		zram_set_obj_cgroup(zram, index, NULL);
+	}
+
 	handle = zram_get_handle(zram, index);
 	if (!handle)
 		return;
@@ -1419,6 +1440,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
+	struct obj_cgroup *objcg;
 
 	mem = kmap_atomic(page);
 	if (page_same_filled(mem, &element)) {
@@ -1494,6 +1516,14 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return -ENOMEM;
 	}
 
+	objcg = get_obj_cgroup_from_page(page);
+	if (objcg && obj_cgroup_charge_zram(objcg, GFP_KERNEL, comp_len)) {
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zs_free(zram->mem_pool, handle);
+		obj_cgroup_put(objcg);
+		return -ENOMEM;
+	}
+
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
 	src = zstrm->buffer;
@@ -1526,6 +1556,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	}  else {
 		zram_set_handle(zram, index, handle);
 		zram_set_obj_size(zram, index, comp_len);
+		zram_set_obj_cgroup(zram, index, objcg);
 	}
 	zram_slot_unlock(zram, index);
 
@@ -1575,6 +1606,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 			   u32 threshold, u32 prio, u32 prio_max)
 {
 	struct zcomp_strm *zstrm = NULL;
+	struct obj_cgroup *objcg;
 	unsigned long handle_old;
 	unsigned long handle_new;
 	unsigned int comp_len_old;
@@ -1669,6 +1701,16 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	if (threshold && comp_len_new >= threshold)
 		return 0;
 
+	objcg  = zram_get_obj_cgroup(zram, index);
+	if (objcg) {
+		obj_cgroup_get(objcg);
+		if (obj_cgroup_charge_zram(objcg, GFP_KERNEL, comp_len_new)) {
+			zcomp_stream_put(zram->comps[prio]);
+			obj_cgroup_put(objcg);
+			return -ENOMEM;
+		}
+	}
+
 	/*
 	 * No direct reclaim (slow path) for handle allocation and no
 	 * re-compression attempt (unlike in zram_write_bvec()) since
@@ -1683,6 +1725,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 			       __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle_new)) {
 		zcomp_stream_put(zram->comps[prio]);
+		obj_cgroup_uncharge_zram(objcg, comp_len_new);
+		obj_cgroup_put(objcg);
 		return PTR_ERR((void *)handle_new);
 	}
 
@@ -1696,6 +1740,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	zram_set_handle(zram, index, handle_new);
 	zram_set_obj_size(zram, index, comp_len_new);
 	zram_set_priority(zram, index, prio);
+	zram_set_obj_cgroup(zram, index, objcg);
 
 	atomic64_add(comp_len_new, &zram->stats.compr_data_size);
 	atomic64_inc(&zram->stats.pages_stored);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index ca7a15bd4845..959d721d5474 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -72,6 +72,7 @@ struct zram_table_entry {
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	ktime_t ac_time;
 #endif
+	struct obj_cgroup *objcg;
 };
 
 struct zram_stats {
-- 
2.25.1

