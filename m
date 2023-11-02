Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BE17DFB2B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377362AbjKBUCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:02:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA64DC;
        Thu,  2 Nov 2023 13:02:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c3077984e8so1313825b3a.0;
        Thu, 02 Nov 2023 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698955323; x=1699560123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuHikmRqCjHm13by+oAQr/aA53zai8UWN0Q4ojl/okQ=;
        b=l3B3ZxDZcdaVcn0eGTNf9YOXQ5jo3OMKMzOg4DnUzcFYdoJvK85rY9bkC/tuwHph+I
         1mX35LGMituZrEKq4OGy3I/SD7wUTBgkN7Mu70QiJBLG303mQMAreN535kJ4V4gVwETN
         iQn70QPSy7zlaEd3yjuc+w71kfU5zemYrC/MwpV6wHAr3t4Ojmh1eP3IxD/ZzgVhZsw+
         960fW0AGL9D6GOeaM4Bmy+r/xFWLXLvpXkTnJZ8YUScqE++v/TNQul7VJtKqgW9Cuynd
         iytWwpYbEgQIhTErEYoCVBSp00rgkCJeq5oVYaEFnyBSwuh/qz/7A8QrpLv3aNzJrRr7
         jNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698955323; x=1699560123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuHikmRqCjHm13by+oAQr/aA53zai8UWN0Q4ojl/okQ=;
        b=U8Tu/ViXjL3iS7mL5/xD6h0gbNl+ngDYUHlYcW6gXfBIcz7xqZ0hIxMk7dp6FXIb1B
         EoKFFVTS3XK3xauwldGhhGywBuT18FHqZv0UZk0L/ygjwkvClI93fSWOnKBONH8cgJby
         VzFA0Oaar0+ndq6tmsf8diGeOFUM1FTN26FzYDDvY4dsAfPm0lSITq6ilSpE7HGCjOpL
         0+tODjFuSDEV1ta9HXmDM5gC1zjNT/g2WzHr4KaZtVVvreTd1CoJSAwsY4HEckGOsdOr
         ave9foevyTETpVkDWkEAgj8jiJaoNs6LivihJMyktNIJm3aFzQerMFPwJmfMj1qfMPes
         T02g==
X-Gm-Message-State: AOJu0Ywy+b/sksovSoB9SCDijraWvOKEukmAhaZalIAFm61tZQ4E9aO5
        C1qrQ2nwOQFom7Y+218W2O4=
X-Google-Smtp-Source: AGHT+IGh0NPW9G4Gl6NZHVh96UIpJkOaC5QTzf5jtxemRwXtmKKMWA/99myN8VpWsfw0G4aEXKNrBg==
X-Received: by 2002:a05:6a20:9189:b0:156:e1ce:d4a1 with SMTP id v9-20020a056a20918900b00156e1ced4a1mr20346801pzd.9.1698955322912;
        Thu, 02 Nov 2023 13:02:02 -0700 (PDT)
Received: from localhost (fwdproxy-prn-019.fbsv.net. [2a03:2880:ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id k13-20020a056a00134d00b006c34274f66asm129637pfu.102.2023.11.02.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:02:02 -0700 (PDT)
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
Subject: [RFC PATCH v2] zswap: memcontrol: implement zswap writeback disabling
Date:   Thu,  2 Nov 2023 13:02:02 -0700
Message-Id: <20231102200202.920461-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
the previous behavior.

Note that this is subtly different from setting memory.swap.max to 0, as
it still allows for pages to be stored in the zswap pool (which itself
consumes swap space in its current form).

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 11 +++++++
 Documentation/admin-guide/mm/zswap.rst  |  6 ++++
 include/linux/memcontrol.h              | 17 +++++++++++
 mm/memcontrol.c                         | 38 +++++++++++++++++++++++++
 mm/page_io.c                            |  6 ++++
 mm/shmem.c                              |  3 +-
 mm/zswap.c                              |  9 ++++++
 7 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 606b2e0eac4b..18c4171392ea 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1672,6 +1672,17 @@ PAGE_SIZE multiple when read back.
 	limit, it will refuse to take any more stores before existing
 	entries fault back in or are written out to disk.
 
+  memory.zswap.writeback
+	A read-write single value file which exists on non-root
+	cgroups.  The default value is "1".
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
index 95f6c9e60ed1..e3a3a06727dc 100644
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
@@ -1615,6 +1621,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 {
 	return 0;
 }
+
+static inline bool mem_cgroup_swap_disk_enabled(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
 #endif /* CONFIG_MEMCG */
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
@@ -1931,6 +1943,7 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
 void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
+bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
 #else
 static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
@@ -1944,6 +1957,10 @@ static inline void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg,
 					     size_t size)
 {
 }
+static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
+{
+	return false;
+}
 #endif
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e43b5aba8efc..b68c613c23a9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5545,6 +5545,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	memcg->zswap_max = PAGE_COUNTER_MAX;
+	WRITE_ONCE(memcg->zswap_writeback, true);
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
@@ -8177,6 +8178,12 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 	rcu_read_unlock();
 }
 
+bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
+{
+	return cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg
+			&& READ_ONCE(memcg->zswap_writeback);
+}
+
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
@@ -8209,6 +8216,31 @@ static ssize_t zswap_max_write(struct kernfs_open_file *of,
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
@@ -8221,6 +8253,12 @@ static struct cftype zswap_files[] = {
 		.seq_show = zswap_max_show,
 		.write = zswap_max_write,
 	},
+	{
+		.name = "zswap.writeback",
+		.flags = CFTYPE_NOT_ON_ROOT,
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
index 260e01180ee0..42a478d1a21f 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -590,6 +590,9 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 	struct zswap_pool *pool = shrinker->private_data;
 	bool encountered_page_in_swapcache = false;
 
+	if (!mem_cgroup_zswap_writeback_enabled(sc->memcg))
+		return SHRINK_STOP;
+
 	nr_protected =
 		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
 	lru_size = list_lru_shrink_count(&pool->list_lru, sc);
@@ -620,6 +623,9 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
 	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
 
+	if (!mem_cgroup_zswap_writeback_enabled(memcg))
+		return 0;
+
 #ifdef CONFIG_MEMCG_KMEM
 	cgroup_rstat_flush(memcg->css.cgroup);
 	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
@@ -935,6 +941,9 @@ static int shrink_memcg(struct mem_cgroup *memcg)
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
