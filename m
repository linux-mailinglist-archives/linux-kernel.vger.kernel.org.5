Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602E477FE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354195AbjHQTB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354640AbjHQTBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:01:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473BD358A;
        Thu, 17 Aug 2023 12:01:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf0b24d925so977105ad.3;
        Thu, 17 Aug 2023 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692298888; x=1692903688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnN9tn3E+lZE3Z+gBA1oF4t/xLxiuc+Fa8cmsOnhTHQ=;
        b=nOZ7OKlv2PWOQNbv4PSKJZ70Jyp3VyAYMSkj0iJHy+1r0+09v4yifOEk2dfxdJumsr
         Cv//QWru6lCLzj4g8Ktk4c4DVuiu/TlEirPJuj/5RKEKahM//XtOLHjGE03R12qG6ezU
         tWtRsolMny7MwHR1+pslK2LGidi0O1gDs4wLLMyHwE2EuLTI909gQ1olTTOHd+XHM65q
         r5GtMmNjmgjuaJjyEnguY1pswL8Ic48Q1ykQOzL5lgTzV1sMGJYgLD55i4zypYsWTa24
         Y49EFaus514RBgeo4Jsse1xOhGRQ4+b2jxY5XYv9vOZOQxfVqnxmJhdT+hifJ7MW7mx8
         ndow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692298888; x=1692903688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnN9tn3E+lZE3Z+gBA1oF4t/xLxiuc+Fa8cmsOnhTHQ=;
        b=E5Wzkros/XoC/7OQXnLmcQw+yQs7Rmj0vqliyVO2ZvwSkvHIIgklKtScCc7ZjCkB31
         bk8fhDyzp5KoqzHhT9sT/tPgBQaoeTeoAWd32TA7dwOsKUFqnkF2TZ1bPtnRLg67yyi8
         P3SsDsmcitXo4v/gJj7J48yN02YrgKOcoYXi4UsMRFkmVxQYYlfBQ4HjcuB0D13dOPxy
         vycEpPRkoA89zMooGPdJaHShM/86KLZ1dhszpaHum7pM1zfc7v9oHlPA7WmUIKNksKb2
         nw7OksLb9iu4eZ+wE07p7xjsK9aEQRotBU8s+i+L/LUokQKqDjHR/8gobSqQEQgozshx
         UbrA==
X-Gm-Message-State: AOJu0Yxtty2dc3KKwdELAl+/9ZPItODzF8jZZDwG5pwW/r04QyWEekNC
        WkxxnJHTsae9w7J07vDZenE=
X-Google-Smtp-Source: AGHT+IEN3HhQw6hpzirmqQkGWxP0XW0xqs84MdRI2ViESw+CWI91mX+Tdr92devtl037fFtDqHYBJQ==
X-Received: by 2002:a17:902:ce84:b0:1bd:f1ae:309d with SMTP id f4-20020a170902ce8400b001bdf1ae309dmr353147plg.9.1692298887462;
        Thu, 17 Aug 2023 12:01:27 -0700 (PDT)
Received: from localhost (fwdproxy-prn-117.fbsv.net. [2a03:2880:ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id v4-20020a170902b7c400b001bdcd4b1616sm99005plz.260.2023.08.17.12.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 12:01:27 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, kernel-team@meta.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        yosryahmed@google.com
Subject: [PATCH v2] workingset: ensure memcg is valid for recency check
Date:   Thu, 17 Aug 2023 12:01:26 -0700
Message-Id: <20230817190126.3155299-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817164733.2475092-1-nphamcs@gmail.com>
References: <20230817164733.2475092-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In eviction recency check, we are currently not holding a local
reference to the memcg that the refaulted folio belonged to when it was
evicted. This could cause serious memcg lifetime issues, for e.g in the
memcg hierarchy traversal done in mem_cgroup_get_nr_swap_pages(). This
has occurred in production:

[ 155757.793456] BUG: kernel NULL pointer dereference, address: 00000000000000c0
[ 155757.807568] #PF: supervisor read access in kernel mode
[ 155757.818024] #PF: error_code(0x0000) - not-present page
[ 155757.828482] PGD 401f77067 P4D 401f77067 PUD 401f76067 PMD 0
[ 155757.839985] Oops: 0000 [#1] SMP
[ 155757.846444] CPU: 7 PID: 1380944 Comm: ThriftSrv-pri3- Kdump: loaded Tainted: G S                 6.4.3-0_fbk1_rc0_594_g8d0cbcaa67ba #1
[ 155757.870808] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM16 05/24/2021
[ 155757.887870] RIP: 0010:mem_cgroup_get_nr_swap_pages+0x3d/0xb0
[ 155757.899377] Code: 29 19 4a 02 48 39 f9 74 63 48 8b 97 c0 00 00 00 48 8b b7 58 02 00 00 48 2b b7 c0 01 00 00 48 39 f0 48 0f 4d c6 48 39 d1 74 42 <48> 8b b2 c0 00 00 00 48 8b ba 58 02 00 00 48 2b ba c0 01 00 00 48
[ 155757.937125] RSP: 0018:ffffc9002ecdfbc8 EFLAGS: 00010286
[ 155757.947755] RAX: 00000000003a3b1c RBX: 000007ffffffffff RCX: ffff888280183000
[ 155757.962202] RDX: 0000000000000000 RSI: 0007ffffffffffff RDI: ffff888bbc2d1000
[ 155757.976648] RBP: 0000000000000001 R08: 000000000000000b R09: ffff888ad9cedba0
[ 155757.991094] R10: ffffea0039c07900 R11: 0000000000000010 R12: ffff888b23a7b000
[ 155758.005540] R13: 0000000000000000 R14: ffff888bbc2d1000 R15: 000007ffffc71354
[ 155758.019991] FS:  00007f6234c68640(0000) GS:ffff88903f9c0000(0000) knlGS:0000000000000000
[ 155758.036356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 155758.048023] CR2: 00000000000000c0 CR3: 0000000a83eb8004 CR4: 00000000007706e0
[ 155758.062473] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 155758.076924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 155758.091376] PKRU: 55555554
[ 155758.096957] Call Trace:
[ 155758.102016]  <TASK>
[ 155758.106502]  ? __die+0x78/0xc0
[ 155758.112793]  ? page_fault_oops+0x286/0x380
[ 155758.121175]  ? exc_page_fault+0x5d/0x110
[ 155758.129209]  ? asm_exc_page_fault+0x22/0x30
[ 155758.137763]  ? mem_cgroup_get_nr_swap_pages+0x3d/0xb0
[ 155758.148060]  workingset_test_recent+0xda/0x1b0
[ 155758.157133]  workingset_refault+0xca/0x1e0
[ 155758.165508]  filemap_add_folio+0x4d/0x70
[ 155758.173538]  page_cache_ra_unbounded+0xed/0x190
[ 155758.182919]  page_cache_sync_ra+0xd6/0x1e0
[ 155758.191738]  filemap_read+0x68d/0xdf0
[ 155758.199495]  ? mlx5e_napi_poll+0x123/0x940
[ 155758.207981]  ? __napi_schedule+0x55/0x90
[ 155758.216095]  __x64_sys_pread64+0x1d6/0x2c0
[ 155758.224601]  do_syscall_64+0x3d/0x80
[ 155758.232058]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 155758.242473] RIP: 0033:0x7f62c29153b5
[ 155758.249938] Code: e8 48 89 75 f0 89 7d f8 48 89 4d e0 e8 b4 e6 f7 ff 41 89 c0 4c 8b 55 e0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 e7 e6 f7 ff 48 8b
[ 155758.288005] RSP: 002b:00007f6234c5ffd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
[ 155758.303474] RAX: ffffffffffffffda RBX: 00007f628c4e70c0 RCX: 00007f62c29153b5
[ 155758.318075] RDX: 000000000003c041 RSI: 00007f61d2986000 RDI: 0000000000000076
[ 155758.332678] RBP: 00007f6234c5fff0 R08: 0000000000000000 R09: 0000000064d5230c
[ 155758.347452] R10: 000000000027d450 R11: 0000000000000293 R12: 000000000003c041
[ 155758.362044] R13: 00007f61d2986000 R14: 00007f629e11b060 R15: 000000000027d450
[ 155758.376661]  </TASK>

This patch fixes the issue by getting a local reference inside
unpack_shadow().

Fixes: f78dfc7b77d5 ("workingset: fix confusion around eviction vs refault container")
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Cc: stable@vger.kernel.org
---
 mm/workingset.c | 65 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index da58a26d0d4d..03cadad4e484 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -206,10 +206,19 @@ static void *pack_shadow(int memcgid, pg_data_t *pgdat, unsigned long eviction,
 	return xa_mk_value(eviction);
 }
 
-static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
-			  unsigned long *evictionp, bool *workingsetp)
+/*
+ * Unpacks the stored fields of a shadow entry into the given pointers.
+ *
+ * The memcg pointer is only populated if the memcg recorded in the shadow
+ * entry is valid. In this case, a reference to the memcg will be acquired,
+ * and a corresponding mem_cgroup_put() will be needed when we no longer
+ * need the memcg.
+ */
+static void unpack_shadow(void *shadow, struct mem_cgroup **memcgp,
+			pg_data_t **pgdat, unsigned long *evictionp, bool *workingsetp)
 {
 	unsigned long entry = xa_to_value(shadow);
+	struct mem_cgroup *memcg;
 	int memcgid, nid;
 	bool workingset;
 
@@ -220,7 +229,24 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 	memcgid = entry & ((1UL << MEM_CGROUP_ID_SHIFT) - 1);
 	entry >>= MEM_CGROUP_ID_SHIFT;
 
-	*memcgidp = memcgid;
+	/*
+	 * Look up the memcg associated with the stored ID. It might
+	 * have been deleted since the folio's eviction.
+	 *
+	 * Note that in rare events the ID could have been recycled
+	 * for a new cgroup that refaults a shared folio. This is
+	 * impossible to tell from the available data. However, this
+	 * should be a rare and limited disturbance, and activations
+	 * are always speculative anyway. Ultimately, it's the aging
+	 * algorithm's job to shake out the minimum access frequency
+	 * for the active cache.
+	 */
+	memcg = mem_cgroup_from_id(memcgid);
+	if (memcg && css_tryget(&memcg->css))
+		*memcgp = memcg;
+	else
+		*memcgp = NULL;
+
 	*pgdat = NODE_DATA(nid);
 	*evictionp = entry;
 	*workingsetp = workingset;
@@ -262,15 +288,16 @@ static void *lru_gen_eviction(struct folio *folio)
 static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
 				unsigned long *token, bool *workingset)
 {
-	int memcg_id;
 	unsigned long min_seq;
 	struct mem_cgroup *memcg;
 	struct pglist_data *pgdat;
 
-	unpack_shadow(shadow, &memcg_id, &pgdat, token, workingset);
+	unpack_shadow(shadow, &memcg, &pgdat, token, workingset);
+	if (!mem_cgroup_disabled() && !memcg)
+		return false;
 
-	memcg = mem_cgroup_from_id(memcg_id);
 	*lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	mem_cgroup_put(memcg);
 
 	min_seq = READ_ONCE((*lruvec)->lrugen.min_seq[file]);
 	return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
@@ -421,36 +448,29 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	unsigned long refault_distance;
 	unsigned long workingset_size;
 	unsigned long refault;
-	int memcgid;
 	struct pglist_data *pgdat;
 	unsigned long eviction;
 
 	if (lru_gen_enabled())
 		return lru_gen_test_recent(shadow, file, &eviction_lruvec, &eviction, workingset);
 
-	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
-	eviction <<= bucket_order;
-
+	unpack_shadow(shadow, &eviction_memcg, &pgdat, &eviction, workingset);
 	/*
-	 * Look up the memcg associated with the stored ID. It might
-	 * have been deleted since the folio's eviction.
+	 * When memcg is enabled, we only get !memcg here if the
+	 * eviction group has been deleted. In that case, ignore
+	 * the refault.
 	 *
-	 * Note that in rare events the ID could have been recycled
-	 * for a new cgroup that refaults a shared folio. This is
-	 * impossible to tell from the available data. However, this
-	 * should be a rare and limited disturbance, and activations
-	 * are always speculative anyway. Ultimately, it's the aging
-	 * algorithm's job to shake out the minimum access frequency
-	 * for the active cache.
+	 * When memcg is disabled, we always get NULL since there
+	 * is no root_mem_cgroup for !CONFIG_MEMCG. Continue; the
+	 * mem_cgroup_lruvec() will get us the global lruvec.
 	 *
-	 * XXX: On !CONFIG_MEMCG, this will always return NULL; it
-	 * would be better if the root_mem_cgroup existed in all
+	 * XXX: It would be better if the root_mem_cgroup existed in all
 	 * configurations instead.
 	 */
-	eviction_memcg = mem_cgroup_from_id(memcgid);
 	if (!mem_cgroup_disabled() && !eviction_memcg)
 		return false;
 
+	eviction <<= bucket_order;
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
 
@@ -493,6 +513,7 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 		}
 	}
 
+	mem_cgroup_put(eviction_memcg);
 	return refault_distance <= workingset_size;
 }
 
-- 
2.34.1
