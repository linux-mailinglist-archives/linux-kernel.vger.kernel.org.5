Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1967C490B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjJKFLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjJKFLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:11:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7C0AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:11:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c735473d1aso44798885ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697001088; x=1697605888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YdumXqFECiIqGWe/cPAmhangKs7E2fmFDNCzZi3I4I=;
        b=eHWUXmxMG4/Wm5zcO4E1HjEqCrjjz/zqIHtIpSRoxdwlg7v93LbJ40iTc5zJq4NU5u
         3e1j62t9nO4/Nvj/x6xVBfXPW1kQidjngxVvzDAApAuVa1skO/l2EadOHqdGaMRmp0Hl
         SYTnPwCX+wvBk9vkVdeK/Uhn4i/FUJW0XFb1LJbjK8na5CxYsIMB7X9DArxpmd4POt9F
         pS1UGvnY/LtCEPWX1N/drZ7v5t/F4QYvxNoFpMWgi0/+OkkuuNgiGrNt+KXWRqmmiVme
         THwCxKsaYsiESQu4wgSFs4beXQ8R3GouMhV7kT3MPyhsZD47oaEAapnj01Wa8QwXaOkS
         k5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697001088; x=1697605888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YdumXqFECiIqGWe/cPAmhangKs7E2fmFDNCzZi3I4I=;
        b=u9fMu2+6aOw+J8stZwZET7e6hK3N4CvPzd5tyRNQ2AsWjcWvOlX6SSDepXhxEnsLHH
         KZ5UllTuju8QkFqX4JecFPNUcKpz/X3PUNRxM2z2ziUEaey7qvibA54yoFiBPKD6649f
         bZMfU0ZZ0IHIGD7Tte6xXe4CRDsL16aWGyjSqypk1gBQgltu9AoyIzHe2K6FksQrQMPS
         X95j7lba/fuf/mUo03McZG8mMOlzWKUDxfhniXkzPJNFlcWuyh7UlpYUc6o8KlJA3d6e
         spfuPKtVMY8y0iDE5+pYMA1o2KWFSsu6evLLKeC8NcOGIRDfc7iKFUiXErnDz3YTdly9
         zg9Q==
X-Gm-Message-State: AOJu0Ywj2iZG2gyOVTuOadZetGNd9Qodat2k3jPErCOG5Zwiy7BVlxcP
        WcQ9tDQ1HgZMvtpv9VY6EhcSBQ==
X-Google-Smtp-Source: AGHT+IH87J+fW2lRM0pJ0z3HScGPs556gHd0Vo58M/p4eeCdCb2C67udLQZaOW+Qet93ce4nOhvFxA==
X-Received: by 2002:a17:903:11c8:b0:1c7:23c9:a7e1 with SMTP id q8-20020a17090311c800b001c723c9a7e1mr20211376plh.26.1697001087763;
        Tue, 10 Oct 2023 22:11:27 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902d50e00b001bc6e6069a6sm12745399plg.122.2023.10.10.22.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 22:11:27 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH] zswap: add writeback_time_threshold interface to shrink zswap pool
Date:   Wed, 11 Oct 2023 13:11:17 +0800
Message-Id: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 Documentation/admin-guide/mm/zswap.rst |  9 +++
 mm/zswap.c                             | 76 ++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 45b98390e938..9ffaed26c3c0 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -153,6 +153,15 @@ attribute, e. g.::
 
 Setting this parameter to 100 will disable the hysteresis.
 
+When there is a lot of cold memory according to the store time in the zswap,
+it can be swapout and save memory in userspace proactively. User can write
+writeback time threshold in second to enable it, e.g.::
+
+  echo 600 > /sys/module/zswap/parameters/writeback_time_threshold
+
+If zswap_entrys have not been accessed for more than 600 seconds, they will be
+swapout. if set to 0, all of them will be swapout.
+
 A debugfs interface is provided for various statistic about pool size, number
 of pages stored, same-value filled pages and various counters for the reasons
 pages are rejected.
diff --git a/mm/zswap.c b/mm/zswap.c
index 083c693602b8..c3a19b56a29b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -141,6 +141,16 @@ static bool zswap_exclusive_loads_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
 module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
 
+/* zswap writeback time threshold in second */
+static unsigned int  zswap_writeback_time_thr;
+static int zswap_writeback_time_thr_param_set(const char *, const struct kernel_param *);
+static const struct kernel_param_ops zswap_writeback_param_ops = {
+	.set =		zswap_writeback_time_thr_param_set,
+	.get =          param_get_uint,
+};
+module_param_cb(writeback_time_threshold, &zswap_writeback_param_ops,
+			&zswap_writeback_time_thr, 0644);
+
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
 #define ZSWAP_NR_ZPOOLS 32
 
@@ -197,6 +207,7 @@ struct zswap_pool {
  * value - value of the same-value filled pages which have same content
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
+ * sto_time - the store time of zswap_entry.
  */
 struct zswap_entry {
 	struct rb_node rbnode;
@@ -210,6 +221,7 @@ struct zswap_entry {
 	};
 	struct obj_cgroup *objcg;
 	struct list_head lru;
+	ktime_t sto_time;
 };
 
 /*
@@ -288,6 +300,31 @@ static void zswap_update_total_size(void)
 	zswap_pool_total_size = total;
 }
 
+static void zswap_reclaim_entry_by_timethr(void);
+
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
+	expire_time = ktime_add(entry->sto_time,
+			ns_to_ktime(zswap_writeback_time_thr * NSEC_PER_SEC));
+
+	if (ktime_after(ktime_get_boottime(), expire_time))
+		ret = true;
+out:
+	spin_unlock(&pool->lru_lock);
+	return ret;
+}
+
+
 /*********************************
 * zswap entry functions
 **********************************/
@@ -395,6 +432,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	else {
 		spin_lock(&entry->pool->lru_lock);
 		list_del(&entry->lru);
+		entry->sto_time = 0;
 		spin_unlock(&entry->pool->lru_lock);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
 		zswap_pool_put(entry->pool);
@@ -709,6 +747,28 @@ static void shrink_worker(struct work_struct *w)
 	zswap_pool_put(pool);
 }
 
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
+
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
 	int i;
@@ -1037,6 +1097,21 @@ static int zswap_enabled_param_set(const char *val,
 	return ret;
 }
 
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
+
 /*********************************
 * writeback code
 **********************************/
@@ -1360,6 +1435,7 @@ bool zswap_store(struct folio *folio)
 	if (entry->length) {
 		spin_lock(&entry->pool->lru_lock);
 		list_add(&entry->lru, &entry->pool->lru);
+		entry->sto_time = ktime_get_boottime();
 		spin_unlock(&entry->pool->lru_lock);
 	}
 	spin_unlock(&tree->lock);
-- 
2.25.1

