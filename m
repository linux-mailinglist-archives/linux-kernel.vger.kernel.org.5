Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922727E30C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjKFXMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjKFXME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:12:04 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C95192;
        Mon,  6 Nov 2023 15:12:00 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b40d5ea323so3008348b6e.0;
        Mon, 06 Nov 2023 15:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699312320; x=1699917120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AgAxCnqHSCbhu2l82ch3Qbwz+0S8FVvz1I/p/e9eTQ=;
        b=aD/w/GO1AjHHR7hKaXu2RftEOYigMwlZ2p5vP2d1JAiprs99YvdMwu1t1jRtvXhznt
         fONep1oKZ7OKZX/NH1JFAryv2Wgbjl29DYPtaQ4rACj4PMKUkZdCnO9gLayD5QAjrQOi
         UWDPxaMcVeZzah64cKz9UFmggYgqoIE+jOCUPR4gc1yzje0rGaJ5/96gscN0HhMXL2Z6
         8sJBHSYNXu5gN7lX7JPUv5CXlaGXiWXPC2KQp583inXMCs3YJxJlap6NODDlWVNkRAh5
         roOTPv3kjxZ97p5As5PvQx9TENnKxoiSeovgYXsqg76dA+Pof4OmfiGC9IfzqP/3QqrK
         c8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699312320; x=1699917120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AgAxCnqHSCbhu2l82ch3Qbwz+0S8FVvz1I/p/e9eTQ=;
        b=pT46+hS6kGyfX87g97xRhUAJa7SU8SS5J68L2tdW55r8KhgejvUbM9MVZmtTDc47do
         LHeeOc710shaB33N60zj/jRyJjaOgUX5Y3nwr+NuuhKt4MkAcsh721f1sdWYoH6IdCom
         TQQ9nEaULsoNZ16rLq+Mg2c5+7FtE8xIe1nyzAtiTGK+eZx3FuDB6nzoTi0jOjWfKzjS
         QJhHp3bYOdWh3h868RbGKuZoqRE8REkT+rWJTuaKPEZ08v161zLxfi4qIH1izZDdnHsN
         wjbbZr14t2izRFI38M9457/PNsW3PTGYQj2k4GqCiCQ6W8baHRCL0DMAGgN8V9GKwxo0
         q06w==
X-Gm-Message-State: AOJu0YzfqtT+HmayyDlh+ZEJrnrG9Q30RYGqjTGE9c1n513Bn/9rFPbK
        6Tt0AOA+oSYFHr1j85+XjP0=
X-Google-Smtp-Source: AGHT+IEkH4gSYwuaYo8Qq0rj8LuQ2tFYsy0RhnE4WabPD6656bH19h5X4INeyPMOILQpQ0UP30uq3g==
X-Received: by 2002:a05:6808:6cf:b0:3a7:55f2:552d with SMTP id m15-20020a05680806cf00b003a755f2552dmr30041560oih.58.1699312319617;
        Mon, 06 Nov 2023 15:11:59 -0800 (PST)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id d19-20020aa78693000000b006be2f4105d0sm6268079pfo.175.2023.11.06.15.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 15:11:59 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Subject: [PATCH v4] zswap: memcontrol: implement zswap writeback disabling
Date:   Mon,  6 Nov 2023 15:11:58 -0800
Message-Id: <20231106231158.380730-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

During our experiment with zswap, we sometimes observe swap IOs due to
occasional zswap store failures and writebacks-to-swap. These swapping
IOs prevent many users who cannot tolerate swapping from adopting zswap
to save memory and improve performance where possible.

This patch adds the option to disable this behavior entirely: do not
writeback to backing swapping device when a zswap store attempt fail,
and do not write pages in the zswap pool back to the backing swap
device (both when the pool is full, and when the new zswap shrinker is
called).

This new behavior can be opted-in/out on a per-cgroup basis via a new
cgroup file. By default, writebacks to swap device is enabled, which is
the previous behavior. Initially, writeback is enabled for the root
cgroup, and a newly created cgroup will inherit the current setting of
its parent.

Note that this is subtly different from setting memory.swap.max to 0, as
it still allows for pages to be stored in the zswap pool (which itself
consumes swap space in its current form).

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 12 ++++++++
 Documentation/admin-guide/mm/zswap.rst  |  6 ++++
 include/linux/memcontrol.h              | 12 ++++++++
 include/linux/zswap.h                   |  6 ++++
 mm/memcontrol.c                         | 41 +++++++++++++++++++++++++
 mm/page_io.c                            |  6 ++++
 mm/shmem.c                              |  3 +-
 mm/zswap.c                              | 14 +++++++++
 8 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 606b2e0eac4b..eefccfffdff7 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1672,6 +1672,18 @@ PAGE_SIZE multiple when read back.
 	limit, it will refuse to take any more stores before existing
 	entries fault back in or are written out to disk.
 
+  memory.zswap.writeback
+	A read-write single value file. The default value is "1". The
+	initial value of the root cgroup is 1, and when a new cgroup is
+	created, it inherits the current value of its parent.
+
+	When this is set to 0, all swapping attempts to swapping devices
+	are disabled. This included both zswap writebacks, and swapping due
+	to zswap store failure.
+
+	Note that this is subtly different from setting memory.swap.max to
+	0, as it still allows for pages to be written to the zswap pool.
+
   memory.pressure
 	A read-only nested-keyed file.
 
diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 522ae22ccb84..b987e58edb70 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -153,6 +153,12 @@ attribute, e. g.::
 
 Setting this parameter to 100 will disable the hysteresis.
 
+Some users cannot tolerate the swapping that comes with zswap store failures
+and zswap writebacks. Swapping can be disabled entirely (without disabling
+zswap itself) on a cgroup-basis as follows:
+
+	echo 0 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.writeback
+
 When there is a sizable amount of cold memory residing in the zswap pool, it
 can be advantageous to proactively write these cold pages to swap and reclaim
 the memory for other use cases. By default, the zswap shrinker is disabled.
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 95f6c9e60ed1..e51eafdf2a15 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -219,6 +219,12 @@ struct mem_cgroup {
 
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	unsigned long zswap_max;
+
+	/*
+	 * Prevent pages from this memcg from being written back from zswap to
+	 * swap, and from being swapped out on zswap store failures.
+	 */
+	bool zswap_writeback;
 #endif
 
 	unsigned long soft_limit;
@@ -1931,6 +1937,7 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
 void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
+bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
 #else
 static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
@@ -1944,6 +1951,11 @@ static inline void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg,
 					     size_t size)
 {
 }
+static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
+{
+	/* if zswap is disabled, do not block pages going to the swapping device */
+	return true;
+}
 #endif
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index cbd373ba88d2..b4997e27a74b 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -35,6 +35,7 @@ void zswap_swapoff(int type);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_lruvec_swapin(struct page *page);
+bool is_zswap_enabled(void);
 #else
 
 struct zswap_lruvec_state {};
@@ -55,6 +56,11 @@ static inline void zswap_swapoff(int type) {}
 static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 static inline void zswap_lruvec_init(struct lruvec *lruvec) {}
 static inline void zswap_lruvec_swapin(struct page *page) {}
+
+static inline bool is_zswap_enabled(void)
+{
+	return false;
+}
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e43b5aba8efc..9cb3ea912cbe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5545,6 +5545,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	memcg->zswap_max = PAGE_COUNTER_MAX;
+
+	if (parent)
+		WRITE_ONCE(memcg->zswap_writeback, READ_ONCE(parent->zswap_writeback));
+	else
+		WRITE_ONCE(memcg->zswap_writeback, true);
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
@@ -8177,6 +8182,12 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 	rcu_read_unlock();
 }
 
+bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
+{
+	/* if zswap is disabled, do not block pages going to the swapping device */
+	return !is_zswap_enabled() || !memcg || READ_ONCE(memcg->zswap_writeback);
+}
+
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
@@ -8209,6 +8220,31 @@ static ssize_t zswap_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int zswap_writeback_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%d\n", READ_ONCE(memcg->zswap_writeback));
+	return 0;
+}
+
+static ssize_t zswap_writeback_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int zswap_writeback;
+	ssize_t parse_ret = kstrtoint(strstrip(buf), 0, &zswap_writeback);
+
+	if (parse_ret)
+		return parse_ret;
+
+	if (zswap_writeback != 0 && zswap_writeback != 1)
+		return -EINVAL;
+
+	WRITE_ONCE(memcg->zswap_writeback, zswap_writeback);
+	return nbytes;
+}
+
 static struct cftype zswap_files[] = {
 	{
 		.name = "zswap.current",
@@ -8221,6 +8257,11 @@ static struct cftype zswap_files[] = {
 		.seq_show = zswap_max_show,
 		.write = zswap_max_write,
 	},
+	{
+		.name = "zswap.writeback",
+		.seq_show = zswap_writeback_show,
+		.write = zswap_writeback_write,
+	},
 	{ }	/* terminate */
 };
 #endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
diff --git a/mm/page_io.c b/mm/page_io.c
index cb559ae324c6..5e606f1aa2f6 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -201,6 +201,12 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_end_writeback(folio);
 		return 0;
 	}
+
+	if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {
+		folio_mark_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
 	__swap_writepage(&folio->page, wbc);
 	return 0;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index cab053831fea..e5044678de8b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1514,8 +1514,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 
 		mutex_unlock(&shmem_swaplist_mutex);
 		BUG_ON(folio_mapped(folio));
-		swap_writepage(&folio->page, wbc);
-		return 0;
+		return swap_writepage(&folio->page, wbc);
 	}
 
 	mutex_unlock(&shmem_swaplist_mutex);
diff --git a/mm/zswap.c b/mm/zswap.c
index 260e01180ee0..051f4487c9ab 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -150,6 +150,11 @@ module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
 static bool zswap_shrinker_enabled;
 module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
 
+bool is_zswap_enabled(void)
+{
+	return zswap_enabled;
+}
+
 /*********************************
 * data structures
 **********************************/
@@ -590,6 +595,9 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 	struct zswap_pool *pool = shrinker->private_data;
 	bool encountered_page_in_swapcache = false;
 
+	if (!mem_cgroup_zswap_writeback_enabled(sc->memcg))
+		return SHRINK_STOP;
+
 	nr_protected =
 		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
 	lru_size = list_lru_shrink_count(&pool->list_lru, sc);
@@ -620,6 +628,9 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
 	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
 
+	if (!mem_cgroup_zswap_writeback_enabled(memcg))
+		return 0;
+
 #ifdef CONFIG_MEMCG_KMEM
 	cgroup_rstat_flush(memcg->css.cgroup);
 	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
@@ -935,6 +946,9 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 	struct zswap_pool *pool;
 	int nid, shrunk = 0;
 
+	if (!mem_cgroup_zswap_writeback_enabled(memcg))
+		return -EINVAL;
+
 	/*
 	 * Skip zombies because their LRUs are reparented and we would be
 	 * reclaiming from the parent instead of the dead memcg.
-- 
2.34.1
