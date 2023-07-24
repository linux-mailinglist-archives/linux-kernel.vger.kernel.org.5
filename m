Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F7975EB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGXGWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXGWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:22:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED644E55
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:22:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bba2318546so5261195ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690179747; x=1690784547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ0+FHFKuAIc1z56nGRfE+KN8lTLE329HHeSqqWKPM0=;
        b=g8XFmi/Xu7Q/IPaOlyMdCeZDLC2qDIUrES87VDacv5L4RIvIl2r0gW/KhtEcTINWF6
         85uL6rrA8LQjGriLE4rjl7XVCGU8czhLCTXmr4/dBUFZmwaukf40MyoppTsVSXGPnMED
         yuLs+xCiBxSTLrm8Wp+vlyQRp022Dqdc5p/LMHi5gv8ZOTY7L8QxjhIb1B56LA/FH6ml
         b4vSr/xbX35wV5C08h/v8anQ2+KiEZecKkvJfOPAvGWtQd/3dA75o4GonVIh8w3yJFiC
         QQonyK5SW6Ifk7GmdSnw1GrPioh0+m5Mf///5dFHYd8C1LlCS2KyorB9zGkd8VXm/aPc
         Ge3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690179747; x=1690784547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQ0+FHFKuAIc1z56nGRfE+KN8lTLE329HHeSqqWKPM0=;
        b=CtGtSRIqJRppVGxrnDCLHt5q/1S0xQBS6MAnissE6AEeWH/lDtJ4KWz2zi3rMnw8tK
         Z7M5FQxFo9uAfgX8GBhTQtMVxoJReh9CCMucF1LoQ9OTgMTHHPQuMQx3JmVFGJZBH5jT
         00k9E1Q0RWuA7SAJTSfpF76B0Zab/on4dPgXF+9aVIU4PicrzK37ts23KHcJ649MQr+j
         1vZxinva0RGw5SHNC1SVjkNGuF5usM7aVXDLXSJ9JImwZK+bPO+HhLhu/Rxps5533deS
         avZktoQKRDMadP4Fh4CuKgSSfgUzcoUjMtXjFr3iAtnILJ7NV7pJzWp3viZsTUtud8AZ
         Qk9A==
X-Gm-Message-State: ABy/qLapGRgluAWOsy5D5JfYZWnfXnJsU3OSqjBbAPO1O+7HLPDJnxRd
        aN1da9Kln+5zd9noTy7NChq2JQ==
X-Google-Smtp-Source: APBJJlEolK+aUii1/yBS9Re9OkeH47TWX8ggnozCaLtCJpFpuy5aQEWLtvsSzNsXA7eaGPyusMtcLQ==
X-Received: by 2002:a17:902:d2cd:b0:1b8:a389:43ef with SMTP id n13-20020a170902d2cd00b001b8a38943efmr12250391plc.24.1690179747454;
        Sun, 23 Jul 2023 23:22:27 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id ix20-20020a170902f81400b001b80760fd04sm1443236plb.112.2023.07.23.23.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 23:22:26 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     david@redhat.com, yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH v2 2/2] zram: charge the compressed RAM to the page's memcgroup
Date:   Mon, 24 Jul 2023 14:22:19 +0800
Message-Id: <20230724062219.2244240-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/block/zram/zram_drv.c | 46 +++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5676e6dd5b16..1e685a430c95 100644
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
+					struct obj_cgroup *objcg)
+{
+	zram->table[index].objcg = objcg;
+}
+
+static inline struct obj_cgroup *zram_get_obj_cgroup(struct zram *zram,
+					u32 index)
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
+	if (objcg && obj_cgroup_charge_zram(objcg, comp_len)) {
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
@@ -1669,6 +1701,17 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
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
@@ -1683,6 +1726,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 			       __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle_new)) {
 		zcomp_stream_put(zram->comps[prio]);
+		obj_cgroup_uncharge_zram(objcg, comp_len_new);
+		obj_cgroup_put(objcg);
 		return PTR_ERR((void *)handle_new);
 	}
 
@@ -1696,6 +1741,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
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

