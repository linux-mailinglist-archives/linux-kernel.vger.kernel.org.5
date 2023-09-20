Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895CB7A8C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjITTDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjITTDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:03:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E710114
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so102325b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695236596; x=1695841396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXDXLfwQ0rN/NkRQHGcA+48P9cgCCQ47pt4nGg6amro=;
        b=RJ1kj3AYzz2QIU/bwzofj+d1kQ2pKduwjLvL5WXNyEGsaCvlz70hIxigGzPKTVe+by
         KVqTTMG2SZE7R0CT3cppjf1ig1PxwPF6W8EcJFvZ12kS1k70XCeCDhBxH3M3kyH4HgY8
         C1aKCRSUeUavnWPPnoNpSCvBnVZbXQeyaidTi7F+Txq9RUL60FHMWNYnbpWfENeClX3W
         QS3mkchiczt9JyggWgPi+rhZCEkgP6SqkILUYyrdz5kylbJliI8qYOeprf8LdFGPhsFX
         TL+QXby9omSt8bJ5vEx4c2CtPh9SxQkweEDhMPfW8WSAeY+FBf5JuO7NaBbGBS/Xw3P8
         tEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695236596; x=1695841396;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXDXLfwQ0rN/NkRQHGcA+48P9cgCCQ47pt4nGg6amro=;
        b=FIBnWVjZfJRl/uDMu1kLXqRgq6KncufZO5IBFt1Q7KWmlGjEXRtcimwM2rdUwSY3g+
         qQdMvPsjiuxJuToMXPFmnA/m3vimixgMDT6Xd2i7OqxjsbFtGPSWLEOTXsIitaBXhKA6
         7DO7qxxoZw5wClXFfgQ33xENPSFeWD/nj0CuennlItzLPL/eR2YC69yfXoH7Zdkt63oE
         sOgYT4c1Jv03l0lq3p+dLP9X1c/dIbsi0XoKDs1NaaUVxRBzqmBVUqMhgRpLs8hzi7Rb
         IC/PZC9/eCBwLPgVfofnLuVY1Neny653Bf1u4RrH2/zgO3Wab5g73tv9IXjljDugRrSF
         WMAQ==
X-Gm-Message-State: AOJu0Yyi2mChiOv0OL4DxlVynuRpt7BDglxjjUwYfDvw1ROPtIpzK8U2
        k5Zkq84Cb3gMc+b8+cUd3W/FeZ+YfIoy9uVJ
X-Google-Smtp-Source: AGHT+IHFEuC6SGjGqdSNIHcpHwYS0ynMnc6+JDELyo8UC6MldIkjr9cwZSbjF96jMoK0A+wcrc6SDA==
X-Received: by 2002:a05:6a20:1002:b0:141:d640:794a with SMTP id gs2-20020a056a20100200b00141d640794amr2885144pzc.39.1695236595707;
        Wed, 20 Sep 2023 12:03:15 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([124.127.145.18])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006871fdde2c7sm423935pfa.110.2023.09.20.12.03.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Sep 2023 12:03:15 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Yuanchu Xie <yuanchu@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH v3 4/6] workingset: simplify lru_gen_test_recent
Date:   Thu, 21 Sep 2023 03:02:42 +0800
Message-ID: <20230920190244.16839-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920190244.16839-1-ryncsn@gmail.com>
References: <20230920190244.16839-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

Simplify the code, move some common path into its caller, prepare for
following commits.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/workingset.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 278c3b9eb549..87a16b6158e5 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -323,42 +323,38 @@ static void *lru_gen_eviction(struct folio *folio)
  * Tests if the shadow entry is for a folio that was recently evicted.
  * Fills in @lruvec, @token, @workingset with the values unpacked from shadow.
  */
-static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
-				unsigned long *token, bool *workingset)
+static bool lru_gen_test_recent(struct lruvec *lruvec, bool file,
+				unsigned long token)
 {
-	int memcg_id;
 	unsigned long min_seq;
-	struct mem_cgroup *memcg;
-	struct pglist_data *pgdat;
 
-	unpack_shadow(shadow, &memcg_id, &pgdat, token, workingset);
-
-	memcg = mem_cgroup_from_id(memcg_id);
-	*lruvec = mem_cgroup_lruvec(memcg, pgdat);
-
-	min_seq = READ_ONCE((*lruvec)->lrugen.min_seq[file]);
-	return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
+	min_seq = READ_ONCE(lruvec->lrugen.min_seq[file]);
+	return (token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
 }
 
 static void lru_gen_refault(struct folio *folio, void *shadow)
 {
+	int memcgid;
 	bool recent;
-	int hist, tier, refs;
 	bool workingset;
 	unsigned long token;
+	int hist, tier, refs;
 	struct lruvec *lruvec;
+	struct pglist_data *pgdat;
 	struct lru_gen_folio *lrugen;
 	int type = folio_is_file_lru(folio);
 	int delta = folio_nr_pages(folio);
 
 	rcu_read_lock();
 
-	recent = lru_gen_test_recent(shadow, type, &lruvec, &token, &workingset);
+	unpack_shadow(shadow, &memcgid, &pgdat, &token, &workingset);
+	lruvec = mem_cgroup_lruvec(mem_cgroup_from_id(memcgid), pgdat);
 	if (lruvec != folio_lruvec(folio))
 		goto unlock;
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + type, delta);
 
+	recent = lru_gen_test_recent(lruvec, type, token);
 	if (!recent)
 		goto unlock;
 
@@ -485,9 +481,6 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	struct pglist_data *pgdat;
 	unsigned long eviction;
 
-	if (lru_gen_enabled())
-		return lru_gen_test_recent(shadow, file, &eviction_lruvec, &eviction, workingset);
-
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
 
 	/*
@@ -511,6 +504,9 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 		return false;
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 
+	if (lru_gen_enabled())
+		return lru_gen_test_recent(eviction_lruvec, file, eviction);
+
 	return lru_test_refault(eviction_memcg, eviction_lruvec, eviction,
 				file, EVICTION_BITS, bucket_order);
 }
-- 
2.41.0

