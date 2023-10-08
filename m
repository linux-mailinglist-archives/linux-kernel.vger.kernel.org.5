Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6317BCDB4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbjJHJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344609AbjJHJ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:59:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC101C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 02:59:48 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2894831a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=transsion-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1696759188; x=1697363988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SChUNcWFLO06mB7MjDh24sWW8FnMNVexunJGIAKn/hI=;
        b=RMbov2/+iQBLTwpWE4LNxRpztGh9MT3md8dDlRv6KKvOyG72eM/F36x5lxoa6Vasl8
         d793nfJ/V5TSe+HfMmY8GRtrNRFZFLVGTzpq9KbDAdxuEPgVowBbYixBbnm/bUg22Wef
         fS2mcXZzxARdOomoM/8WuPGBkM76lio9vQWROp5R0jeXtf8ZYz/RS8cjhUkYKhmD1LMH
         MzXHqRUBMxVGnQ/tb2fwU3q9rzClHaOhLv7DrfV8E6fcXG6md+HMZ1YnLwK/aX5fjIwH
         DOgD7eE1Ct9O8eI6xUzboe6byyiCzY4gasXNkzcgi8C7X/Q+OvfpPzzwiRcIfHg0K9li
         qjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696759188; x=1697363988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SChUNcWFLO06mB7MjDh24sWW8FnMNVexunJGIAKn/hI=;
        b=OElwJX+sjPkSTXbkC39i7nW0/mAlNs1ghlcO2zbXMxm3utToYISlEmcAttvOfqOQCs
         fQWLFkjtfJgWd+pxLMMXct4ZZnYijfhcqe1hnbxAhOge+07y3WabngME8kMfkWhhXx2T
         +MkhTGgT6TkSEfaZEBxrvewa6rtOq/ZtqijB7fK0AOa2QXRHp1CjCQAQkUrOgGScBMmh
         pPmYG9E2+u3MA2nfCpifA2pAXc7dRVPqND4g8NqYikpV09srbDHUzGYRgv+DZKreidRy
         zTrCQso5b5UTRkZh8/9KYxBtr1DvI7DUELKQQEeQ87k+SCk7DeodmmJVkvTN7NZKZg/p
         oqIg==
X-Gm-Message-State: AOJu0Yy/T8v9gxr9A/8duMPx5laFqPV6jvH6+OU5/h9hnr9nKoX3AMS6
        Z3CHUFY5eejUmUwH0svXSseKPQ==
X-Google-Smtp-Source: AGHT+IHWj5ieXF51u86WtnTGUmM97ximEOSq/JAnuFIVLNU+TG0E7YJgYgcAod7pxCcPBQbkiZ8ecw==
X-Received: by 2002:a17:902:ec91:b0:1c8:9d32:3395 with SMTP id x17-20020a170902ec9100b001c89d323395mr3850640plg.41.1696759188247;
        Sun, 08 Oct 2023 02:59:48 -0700 (PDT)
Received: from linchengyang-VB.. ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b001c72c07c9d9sm7126343plz.308.2023.10.08.02.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 02:59:48 -0700 (PDT)
From:   Lincheng Yang <lincheng.yang@transsion.corp-partner.google.com>
X-Google-Original-From: Lincheng Yang <lincheng.yang@transsion.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, willy@infradead.org, hughd@google.com,
        peterx@redhat.com, mike.kravetz@oracle.com, jgg@ziepe.ca,
        surenb@google.com, steven.price@arm.com, pasha.tatashin@soleen.com,
        kirill.shutemov@linux.intel.com, yuanchu@google.com,
        david@redhat.com, mathieu.desnoyers@efficios.com,
        dhowells@redhat.com, shakeelb@google.com, pcc@google.com,
        tytso@mit.edu, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        catalin.marinas@arm.com, lrh2000@pku.edu.cn, ying.huang@intel.com,
        mhocko@suse.com, vishal.moola@gmail.com, yosryahmed@google.com,
        findns94@gmail.com, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        wanbin.wang@transsion.com, chunlei.zhuang@transsion.com,
        jinsheng.zhao@transsion.com, jiajun.ling@transsion.com,
        dongyun.liu@transsion.com,
        Lincheng Yang <lincheng.yang@transsion.com>
Subject: [RFC PATCH 1/5] mm/swap_slots: cleanup swap slot cache
Date:   Sun,  8 Oct 2023 17:59:20 +0800
Message-Id: <20231008095924.1165106-2-lincheng.yang@transsion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008095924.1165106-1-lincheng.yang@transsion.com>
References: <20231008095924.1165106-1-lincheng.yang@transsion.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function of the swap slot cache will be cleaned to prepare for
subsequent modifications.

Signed-off-by: Lincheng Yang <lincheng.yang@transsion.com>
---
 mm/swap_slots.c | 111 ++++++++++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 45 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0bec1f705f8e..bb41c8460b62 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -110,11 +110,13 @@ static bool check_cache_active(void)
 	return swap_slot_cache_active;
 }
 
-static int alloc_swap_slot_cache(unsigned int cpu)
+static int __alloc_swap_slot_cache(struct swap_slots_cache *cache)
 {
-	struct swap_slots_cache *cache;
 	swp_entry_t *slots, *slots_ret;
 
+	if (!cache)
+		return 0;
+
 	/*
 	 * Do allocation outside swap_slots_cache_mutex
 	 * as kvzalloc could trigger reclaim and folio_alloc_swap,
@@ -133,17 +135,6 @@ static int alloc_swap_slot_cache(unsigned int cpu)
 	}
 
 	mutex_lock(&swap_slots_cache_mutex);
-	cache = &per_cpu(swp_slots, cpu);
-	if (cache->slots || cache->slots_ret) {
-		/* cache already allocated */
-		mutex_unlock(&swap_slots_cache_mutex);
-
-		kvfree(slots);
-		kvfree(slots_ret);
-
-		return 0;
-	}
-
 	if (!cache->lock_initialized) {
 		mutex_init(&cache->alloc_lock);
 		spin_lock_init(&cache->free_lock);
@@ -165,13 +156,26 @@ static int alloc_swap_slot_cache(unsigned int cpu)
 	return 0;
 }
 
-static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
-				  bool free_slots)
+static int alloc_swap_slot_cache(unsigned int cpu)
 {
 	struct swap_slots_cache *cache;
-	swp_entry_t *slots = NULL;
 
+	mutex_lock(&swap_slots_cache_mutex);
 	cache = &per_cpu(swp_slots, cpu);
+	if (cache->slots || cache->slots_ret)   /* cache already allocated */
+		cache = NULL;
+	mutex_unlock(&swap_slots_cache_mutex);
+
+	__alloc_swap_slot_cache(cache);
+
+	return 0;
+}
+
+static void __drain_slots_cache_cpu(struct swap_slots_cache *cache,
+				    unsigned int type, bool free_slots)
+{
+	swp_entry_t *slots = NULL;
+
 	if ((type & SLOTS_CACHE) && cache->slots) {
 		mutex_lock(&cache->alloc_lock);
 		swapcache_free_entries(cache->slots + cache->cur, cache->nr);
@@ -196,6 +200,15 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
 	}
 }
 
+static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
+				  bool free_slots)
+{
+	struct swap_slots_cache *cache;
+
+	cache = &per_cpu(swp_slots, cpu);
+	__drain_slots_cache_cpu(cache, type, free_slots);
+}
+
 static void __drain_swap_slots_cache(unsigned int type)
 {
 	unsigned int cpu;
@@ -269,11 +282,8 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 	return cache->nr;
 }
 
-void free_swap_slot(swp_entry_t entry)
+static void __free_swap_slot(struct swap_slots_cache *cache, swp_entry_t entry)
 {
-	struct swap_slots_cache *cache;
-
-	cache = raw_cpu_ptr(&swp_slots);
 	if (likely(use_swap_slot_cache && cache->slots_ret)) {
 		spin_lock_irq(&cache->free_lock);
 		/* Swap slots cache may be deactivated before acquiring lock */
@@ -299,18 +309,18 @@ void free_swap_slot(swp_entry_t entry)
 	}
 }
 
-swp_entry_t folio_alloc_swap(struct folio *folio)
+void free_swap_slot(swp_entry_t entry)
 {
-	swp_entry_t entry;
 	struct swap_slots_cache *cache;
 
-	entry.val = 0;
+	cache = raw_cpu_ptr(&swp_slots);
+	__free_swap_slot(cache, entry);
+}
 
-	if (folio_test_large(folio)) {
-		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
-			get_swap_pages(1, &entry, folio_nr_pages(folio));
-		goto out;
-	}
+static int __folio_alloc_swap(struct swap_slots_cache *cache, swp_entry_t *entry)
+{
+	if (unlikely(!check_cache_active() || !cache->slots))
+		return -EINVAL;
 
 	/*
 	 * Preemption is allowed here, because we may sleep
@@ -321,26 +331,37 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 	 * The alloc path here does not touch cache->slots_ret
 	 * so cache->free_lock is not taken.
 	 */
-	cache = raw_cpu_ptr(&swp_slots);
-
-	if (likely(check_cache_active() && cache->slots)) {
-		mutex_lock(&cache->alloc_lock);
-		if (cache->slots) {
+	mutex_lock(&cache->alloc_lock);
 repeat:
-			if (cache->nr) {
-				entry = cache->slots[cache->cur];
-				cache->slots[cache->cur++].val = 0;
-				cache->nr--;
-			} else if (refill_swap_slots_cache(cache)) {
-				goto repeat;
-			}
-		}
-		mutex_unlock(&cache->alloc_lock);
-		if (entry.val)
-			goto out;
+	if (cache->nr) {
+		*entry = cache->slots[cache->cur];
+		cache->slots[cache->cur++].val = 0;
+		cache->nr--;
+	} else if (refill_swap_slots_cache(cache)) {
+		goto repeat;
 	}
+	mutex_unlock(&cache->alloc_lock);
+
+	return !!entry->val;
+}
+
+swp_entry_t folio_alloc_swap(struct folio *folio)
+{
+	swp_entry_t entry;
+	struct swap_slots_cache *cache;
+
+	entry.val = 0;
+
+	if (folio_test_large(folio)) {
+		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
+			get_swap_pages(1, &entry, folio_nr_pages(folio));
+		goto out;
+	}
+
+	cache = raw_cpu_ptr(&swp_slots);
+	if (__folio_alloc_swap(cache, &entry))
+		get_swap_pages(1, &entry, 1);
 
-	get_swap_pages(1, &entry, 1);
 out:
 	if (mem_cgroup_try_charge_swap(folio, entry)) {
 		put_swap_folio(folio, entry);
-- 
2.34.1

