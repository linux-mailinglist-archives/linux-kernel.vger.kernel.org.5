Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A73B751519
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjGMAS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGMASl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:18:41 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC71995
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:18:40 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8b30f781cso838175ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689207520; x=1691799520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz4QSmIvTSTUsAdxwi3pCBw4pt8RugCrQx5KDc9ZhJs=;
        b=OxVY6Z7lXNfLpGGQxHTUt1swejOIFF85FUW0wE2VE8vdLB5aDIEaplEBhJovE6UIuU
         K4MI2omqzLcf0878ohV/qbCyn1o1btoxNO1zmo4XpzgNCwhqbsR5g9lPMhF/oc6c5OSH
         FLFQ8rcC3HlG6YKuWPQCFnkeyENr45NxeouUwj5SMJayn/oY+aa5qTUD8r4awoQKd282
         07sAZWdt7BPtWzt9aI4AGI/dz9iMygnhJ+O+zdqcVmDbmZTctgty2teAKbz/LapOZrLR
         jUhKEwIXQ2hO2jhE5Geirl2yikNH3XAhBveTKUwqbOhLRH3RICugfJqK+TjpYtt4DoV1
         LizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689207520; x=1691799520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz4QSmIvTSTUsAdxwi3pCBw4pt8RugCrQx5KDc9ZhJs=;
        b=Iubx0nKWgbDpGT3weyygBNegPOfNihpz52Ui9wVFOwNZ12vzMtQo+k7mvRjqqLDEZA
         AC/fLiwxYoltMpv/g3Mb13gxr/TSOZ6kKEnCJh/a6ab6WbGpZeinaZHuzylNLWFGQ1yn
         k+mIHTx/7jpRtuYf4dt55JmlpOKMh2mG5v2v/o27kIemNiCa2XP1Tg///XBTzeHcS1ue
         6f4m4b//lvkahdb9RDZuC3MUtpwSR8G29pD9ypNyMZc237AdwYJeQdUrn31eC7af+3XN
         eAKKaVD37Z9qtflGFSFA/pFPVODT2ze4EQjWcsxOaRvsHc1p6g7dUtZWoPabcV/QX6wM
         2Vww==
X-Gm-Message-State: ABy/qLY98/OSWlMbnIGUGsmMuVUpsEiamOfSpvxOUFy08CoZLyvVgPmG
        qzJIAqIj4dU/KvAjS2AHJtfKZe1GgSV/Gw==
X-Google-Smtp-Source: APBJJlFBNAQ4nTEEROlscxAMFHxffimTCXNSjblZZoYT2wX9TgjL8pV7vT6yXRoYce4lKt7cw6slHJX3L0xABg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:e54e:b0:1b5:1fe8:a91 with SMTP id
 n14-20020a170902e54e00b001b51fe80a91mr611plf.3.1689207520379; Wed, 12 Jul
 2023 17:18:40 -0700 (PDT)
Date:   Thu, 13 Jul 2023 00:18:31 +0000
In-Reply-To: <20230713001833.3778937-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230713001833.3778937-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713001833.3778937-3-jiaqiyan@google.com>
Subject: [PATCH v4 2/4] mm/hwpoison: check if a raw page in a hugetlb folio is
 raw HWPOISON
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     linmiaohe@huawei.com, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jthoughton@google.com,
        Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the functionality, is_raw_hwpoison_page_in_hugepage, to tell if a
raw page in a hugetlb folio is HWPOISON. This functionality relies on
RawHwpUnreliable to be not set; otherwise hugepage's raw HWPOISON list
becomes meaningless.

is_raw_hwpoison_page_in_hugepage holds mf_mutex in order to synchronize
with folio_set_hugetlb_hwpoison and folio_free_raw_hwp who iterate,
insert, or delete entry in raw_hwp_list. llist itself doesn't ensure
insertion and removal are synchornized with the llist_for_each_entry
used by is_raw_hwpoison_page_in_hugepage (unless iterated entries are
already deleted from the list). Caller can minimize the overhead of
lock cycles by first checking HWPOISON flag of the folio.

Exports this functionality to be immediately used in the read operation
for hugetlbfs.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/hugetlb.h |  5 +++++
 mm/memory-failure.c     | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ca3c8e10f24a..0a96cfacb746 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1007,6 +1007,11 @@ void hugetlb_register_node(struct node *node);
 void hugetlb_unregister_node(struct node *node);
 #endif
 
+/*
+ * Check if a given raw @page in a hugepage is HWPOISON.
+ */
+bool is_raw_hwpoison_page_in_hugepage(struct page *page);
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a08677dcf953..d610d8f03f69 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -75,6 +75,8 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
 
+static DEFINE_MUTEX(mf_mutex);
+
 inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 	atomic_long_inc(&num_poisoned_pages);
@@ -1813,6 +1815,7 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
 #endif /* CONFIG_FS_DAX */
 
 #ifdef CONFIG_HUGETLB_PAGE
+
 /*
  * Struct raw_hwp_page represents information about "raw error page",
  * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
@@ -1827,6 +1830,41 @@ static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
 	return (struct llist_head *)&folio->_hugetlb_hwpoison;
 }
 
+bool is_raw_hwpoison_page_in_hugepage(struct page *page)
+{
+	struct llist_head *raw_hwp_head;
+	struct raw_hwp_page *p;
+	struct folio *folio = page_folio(page);
+	bool ret = false;
+
+	if (!folio_test_hwpoison(folio))
+		return false;
+
+	if (!folio_test_hugetlb(folio))
+		return PageHWPoison(page);
+
+	/*
+	 * When RawHwpUnreliable is set, kernel lost track of which subpages
+	 * are HWPOISON. So return as if ALL subpages are HWPOISONed.
+	 */
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
+		return true;
+
+	mutex_lock(&mf_mutex);
+
+	raw_hwp_head = raw_hwp_list_head(folio);
+	llist_for_each_entry(p, raw_hwp_head->first, node) {
+		if (page == p->page) {
+			ret = true;
+			break;
+		}
+	}
+
+	mutex_unlock(&mf_mutex);
+
+	return ret;
+}
+
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
 	struct llist_node *t, *tnode, *head;
@@ -2106,8 +2144,6 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
-static DEFINE_MUTEX(mf_mutex);
-
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
-- 
2.41.0.255.g8b1d071c50-goog

