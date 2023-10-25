Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEAC7D6790
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjJYJxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjJYJxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:53:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FD192
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:52:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d0e3d823fso3829688a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698227578; x=1698832378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+j017g3tatMpnGtHNzJ9Kcmrx8z0MmUnYgAG8PgHZs=;
        b=TdxEbDlvzEf41wqOCPpIEzE54wn16LUqvMTCpdIOlMe18E4nKT63coeXvMe7scZla5
         /pxAi0JEWCebbYAY35x8T1nCpQNjey1GG6tqrIqrukeSn4/Mhvkt6ytMVI/xM57JmQpz
         j6XcZQs9nC5o2KIr0UDVdStN7inF9TMHOlhNt5w/AZ7P5tjmGklnWHaQ98a2iGs22Rl1
         f2p0fpdIk3qUIeCKzKExTZDqFnNz50PQxkmyTfOUELBSUW6GA3H8TvUgxZRXqLOImXa0
         o8wJlN5DSzJ3KWolXYuxB3GBXYC41YmGDcrAJFjUcUfZW5SR+ah4Wg1EAx6nMnaIVKX4
         EC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698227578; x=1698832378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+j017g3tatMpnGtHNzJ9Kcmrx8z0MmUnYgAG8PgHZs=;
        b=mHT3n2NGs9IoZ5s3Jtr1eO+h/XSsTKtmI2Se4J1cELIbNia6zu4ADM/PSPDhfM1p2B
         wSxR6sreDUfTNQ2ULHjkso/6MUWSLzt+TviCPES7herubGaoRphKwgJ8gWRSoEsXMrxH
         DkTQb4JOl8t1p5YLoQXR8ycPOv5pRilrShZjMse1qog92t4jJqjXSKCYwQ1Rw8pgIyhd
         FynjXhySXk4AyPktG1Yo0C6TVH7kgrGHD1Wo9IsTq06+s97/98r+3JIf1RO4vJPuz6aK
         Azceuu+jJFWgp2BiE1ivABnKWkAEOtGiagDvIbbJ6yUk33REuHvX/klpCM+XDgy9fthf
         aZKw==
X-Gm-Message-State: AOJu0Yxk3B4qth+4JL4ducE8yzLUlWs22bU6+5FmK5B0+4uauAN9c6g2
        0l1nQxVEsokCfyQ8iS2QcJEn9Dq+wOMBupJHf+8=
X-Google-Smtp-Source: AGHT+IEEsb0TI4qSA136epJAkV4h841JNYtA/h7V0hxBD9EC3BJdsZDZEL5KnMs9HpyniuDwII6/JA==
X-Received: by 2002:a17:90b:51d0:b0:268:b0b:a084 with SMTP id sf16-20020a17090b51d000b002680b0ba084mr12471826pjb.46.1698227578332;
        Wed, 25 Oct 2023 02:52:58 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 63-20020a17090a09c500b00262eb0d141esm9267748pjo.28.2023.10.25.02.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:52:57 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH v2] zswap: add writeback_time_threshold interface to shrink zswap pool
Date:   Wed, 25 Oct 2023 17:52:48 +0800
Message-Id: <20231025095248.458789-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zswap does not have a suitable method to select objects that have not
been accessed for a long time, and just shrink the pool when the limit
is hit. There is a high probability of wasting memory in zswap if the
limit is too high.

This patch add a new interface writeback_time_threshold to shrink zswap
pool proactively based on the time threshold in second, e.g.::

echo 600 > /sys/module/zswap/parameters/writeback_time_threshold

If zswap_entrys have not been accessed for more than 600 seconds, they
will be swapout to swap. if set to 0, all of them will be swapout.

This patch provides more control by specifying the time at which to
start writing pages out.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
v2:
   - rename sto_time to last_ac_time (suggested by Nhat Pham)
   - update the access time when a page is read (reported by
     Yosry Ahmed and Nhat Pham)
   - add config option (suggested by Yosry Ahmed)
---
 Documentation/admin-guide/mm/zswap.rst |   9 +++
 mm/Kconfig                             |  11 +++
 mm/zswap.c                             | 104 +++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 45b98390e938..7aec245f89b4 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -153,6 +153,15 @@ attribute, e. g.::
 
 Setting this parameter to 100 will disable the hysteresis.
 
+When there is a lot of cold memory according to the last accessed time in the
+zswap, it can be swapout and save memory in userspace proactively. User can
+write writeback time threshold in second to enable it, e.g.::
+
+  echo 600 > /sys/module/zswap/parameters/writeback_time_threshold
+
+If zswap_entrys have not been accessed for more than 600 seconds, they will be
+swapout. if set to 0, all of them will be swapout.
+
 A debugfs interface is provided for various statistic about pool size, number
 of pages stored, same-value filled pages and various counters for the reasons
 pages are rejected.
diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..426358d2050b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -61,6 +61,17 @@ config ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON
 	  The cost is that if the page was never dirtied and needs to be
 	  swapped out again, it will be re-compressed.
 
+config ZSWAP_WRITEBACK_TIME_ON
+        bool "writeback zswap based on the last accessed time"
+        depends on ZSWAP
+        default n
+        help
+          If selected, the feature for tracking last accessed time  will be
+          enabled at boot, otherwise it will be disabled.
+
+          The zswap can be swapout and save memory in userspace proactively
+          by writing writeback_time_threshold in second.
+
 choice
 	prompt "Default compressor"
 	depends on ZSWAP
diff --git a/mm/zswap.c b/mm/zswap.c
index 0c5ca896edf2..331ee276afbd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -144,6 +144,19 @@ static bool zswap_exclusive_loads_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
 module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
 
+
+#ifdef CONFIG_ZSWAP_WRITEBACK_TIME_ON
+/* zswap writeback time threshold in second */
+static unsigned int  zswap_writeback_time_thr;
+static int zswap_writeback_time_thr_param_set(const char *, const struct kernel_param *);
+static const struct kernel_param_ops zswap_writeback_param_ops = {
+	.set =		zswap_writeback_time_thr_param_set,
+	.get =          param_get_uint,
+};
+module_param_cb(writeback_time_threshold, &zswap_writeback_param_ops,
+			&zswap_writeback_time_thr, 0644);
+#endif
+
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
 #define ZSWAP_NR_ZPOOLS 32
 
@@ -200,6 +213,7 @@ struct zswap_pool {
  * value - value of the same-value filled pages which have same content
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
+ * last_ac_time - the last accessed time of zswap_entry.
  */
 struct zswap_entry {
 	struct rb_node rbnode;
@@ -213,6 +227,9 @@ struct zswap_entry {
 	};
 	struct obj_cgroup *objcg;
 	struct list_head lru;
+#ifdef CONFIG_ZSWAP_WRITEBACK_TIME_ON
+	ktime_t last_ac_time;
+#endif
 };
 
 /*
@@ -291,6 +308,27 @@ static void zswap_update_total_size(void)
 	zswap_pool_total_size = total;
 }
 
+#ifdef CONFIG_ZSWAP_WRITEBACK_TIME_ON
+static void zswap_set_access_time(struct zswap_entry *entry)
+{
+	entry->last_ac_time = ktime_get_boottime();
+}
+
+static void zswap_clear_access_time(struct zswap_entry *entry)
+{
+	entry->last_ac_time = 0;
+}
+#else
+static void zswap_set_access_time(struct zswap_entry *entry)
+{
+}
+
+static void zswap_clear_access_time(struct zswap_entry *entry)
+{
+}
+#endif
+
+
 /*********************************
 * zswap entry functions
 **********************************/
@@ -398,6 +436,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	else {
 		spin_lock(&entry->pool->lru_lock);
 		list_del(&entry->lru);
+		zswap_clear_access_time(entry);
 		spin_unlock(&entry->pool->lru_lock);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
 		zswap_pool_put(entry->pool);
@@ -712,6 +751,52 @@ static void shrink_worker(struct work_struct *w)
 	zswap_pool_put(pool);
 }
 
+#ifdef CONFIG_ZSWAP_WRITEBACK_TIME_ON
+static bool zswap_reach_timethr(struct zswap_pool *pool)
+{
+	struct zswap_entry *entry;
+	ktime_t expire_time = 0;
+	bool ret = false;
+
+	spin_lock(&pool->lru_lock);
+
+	if (list_empty(&pool->lru))
+		goto out;
+
+	entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
+	expire_time = ktime_add(entry->last_ac_time,
+			ns_to_ktime(zswap_writeback_time_thr * NSEC_PER_SEC));
+
+	if (ktime_after(ktime_get_boottime(), expire_time))
+		ret = true;
+out:
+	spin_unlock(&pool->lru_lock);
+	return ret;
+}
+
+static void zswap_reclaim_entry_by_timethr(void)
+{
+	struct zswap_pool *pool = zswap_pool_current_get();
+	int ret, failures = 0;
+
+	if (!pool)
+		return;
+
+	while (zswap_reach_timethr(pool)) {
+		ret = zswap_reclaim_entry(pool);
+		if (ret) {
+			zswap_reject_reclaim_fail++;
+			if (ret != -EAGAIN)
+				break;
+			if (++failures == MAX_RECLAIM_RETRIES)
+				break;
+		}
+		cond_resched();
+	}
+	zswap_pool_put(pool);
+}
+#endif
+
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
 	int i;
@@ -1040,6 +1125,23 @@ static int zswap_enabled_param_set(const char *val,
 	return ret;
 }
 
+#ifdef CONFIG_ZSWAP_WRITEBACK_TIME_ON
+static int zswap_writeback_time_thr_param_set(const char *val,
+				const struct kernel_param *kp)
+{
+	int ret = -ENODEV;
+
+	/* if this is load-time (pre-init) param setting, just return. */
+	if (system_state != SYSTEM_RUNNING)
+		return ret;
+
+	ret = param_set_uint(val, kp);
+	if (!ret)
+		zswap_reclaim_entry_by_timethr();
+	return ret;
+}
+#endif
+
 /*********************************
 * writeback code
 **********************************/
@@ -1372,6 +1474,7 @@ bool zswap_store(struct folio *folio)
 	if (entry->length) {
 		spin_lock(&entry->pool->lru_lock);
 		list_add(&entry->lru, &entry->pool->lru);
+		zswap_set_access_time(entry);
 		spin_unlock(&entry->pool->lru_lock);
 	}
 	spin_unlock(&tree->lock);
@@ -1484,6 +1587,7 @@ bool zswap_load(struct folio *folio)
 		folio_mark_dirty(folio);
 	} else if (entry->length) {
 		spin_lock(&entry->pool->lru_lock);
+		zswap_set_access_time(entry);
 		list_move(&entry->lru, &entry->pool->lru);
 		spin_unlock(&entry->pool->lru_lock);
 	}
-- 
2.25.1

