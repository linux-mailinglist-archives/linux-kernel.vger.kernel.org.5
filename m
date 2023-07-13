Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730F5751518
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjGMASz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjGMASk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:18:40 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769571FD2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:18:39 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262e0c70e8eso16444a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689207519; x=1691799519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8FNetjBnnWs4aWcoESXEPv5EQNod9M4H8ra/lwVlWng=;
        b=OYL0bSj4G5DjZWuCKYJh1mgYYyb7btYF2LGzKY9Bk+oN0orukveShF4mERnDT12wOV
         59jdagioq6JUZlITmhCB22KSsxcpFF6nRLpZZr2dAeg1q60Px50PCZI4BiVQB4x4I1Nv
         D7UtKoG3pLXisajm6f5fiIvw4mAM/GvHvlla0HmYIzBfJMVspK8P3f7Zh2oU4gWLY038
         pzkJZ7lT76qFOdxc22MN7AWRmoNR4Jxt1plUazR3Kx2CHPPAlPjFhmATOWQzVnQ1H54p
         mEraCl7FGtI0EzT6W0V7qICdMdx0dnTi3JpZXGu/u6Ttzha9Zt0Uc8uTuZemcL9A24wm
         4ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689207519; x=1691799519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FNetjBnnWs4aWcoESXEPv5EQNod9M4H8ra/lwVlWng=;
        b=KwrFxlgIjJ4CE2JXLm7tFmLiGYuB72JZLEQaMRDjpaGt3cYVvHtx/5Tc9M9af73Wbo
         dtKD5Tx5NPV8P0/FzBsPyKprl+mFDxSc8EkjgBT9z+sLpbCmRuf2xh0dlWvxMWp3rXMU
         DOc+mrzxgxtDth3dMmxRxo+nzjQKb7s1lMrmYm93IfVvn7SsiYgPV2i0tM+65ghlGLtV
         htrXrzkSAQzgW8GHrPSBHHusOlfCMP7sd1+0d3WynF1/St1NwCOBSdfzRVVg6vBNG1fc
         6zX6dGcpcFQDz2ChuSZrnXWFyl/L9qU9ySeGsWIFO/SqI/oqHHIcHuGzxE3fbD3k5Lct
         wo6g==
X-Gm-Message-State: ABy/qLbaf9c8bT/ZeYGtdBZa1fakX5ITqlc9XqofqTuLGanHBRDB6NN+
        9WlS610fcd2qLzqBskSrcvt8vlM//7IP8Q==
X-Google-Smtp-Source: APBJJlHqRdIoAACpRH8a6t9G+zRijJgrhccuFIBvQtuMsvEmpFO+C6Om+9Yz4ShU/cZRQoH/R02E4OT9ko/qNQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:8bcb:b0:1ab:18eb:17c8 with SMTP
 id r11-20020a1709028bcb00b001ab18eb17c8mr720plo.2.1689207518956; Wed, 12 Jul
 2023 17:18:38 -0700 (PDT)
Date:   Thu, 13 Jul 2023 00:18:30 +0000
In-Reply-To: <20230713001833.3778937-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230713001833.3778937-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713001833.3778937-2-jiaqiyan@google.com>
Subject: [PATCH v4 1/4] mm/hwpoison: delete all entries before traversal in __folio_free_raw_hwp
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

Traversal on llist (e.g. llist_for_each_safe) is only safe AFTER entries
are deleted from the llist. Correct the way __folio_free_raw_hwp deletes
and frees raw_hwp_page entries in raw_hwp_list: first llist_del_all, then
kfree within llist_for_each_safe.

As of today, concurrent adding, deleting, and traversal on raw_hwp_list
from hugetlb.c and/or memory-failure.c are fine with each other. Note
this is guaranteed partly by the lock-free nature of llist, and partly
by holding hugetlb_lock and/or mf_mutex. For example, as llist_del_all
is lock-free with itself, folio_clear_hugetlb_hwpoison()s from
__update_and_free_hugetlb_folio and memory_failure won't need explicit
locking when freeing the raw_hwp_list. New code that manipulates
raw_hwp_list must be careful to ensure the concurrency correctness.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 mm/memory-failure.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e245191e6b04..a08677dcf953 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1829,12 +1829,11 @@ static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
 
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
-	struct llist_head *head;
-	struct llist_node *t, *tnode;
+	struct llist_node *t, *tnode, *head;
 	unsigned long count = 0;
 
-	head = raw_hwp_list_head(folio);
-	llist_for_each_safe(tnode, t, head->first) {
+	head = llist_del_all(raw_hwp_list_head(folio));
+	llist_for_each_safe(tnode, t, head) {
 		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
 
 		if (move_flag)
@@ -1844,7 +1843,6 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 		kfree(p);
 		count++;
 	}
-	llist_del_all(head);
 	return count;
 }
 
-- 
2.41.0.255.g8b1d071c50-goog

