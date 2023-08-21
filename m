Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58546783466
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjHUUwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjHUUwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:52:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F44E1727
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0TDRpjnt3h85NYff/3U+8TfIQhuK6SlrkWQVnJ9yr4o=; b=aiiT88YK6Uq8pKYYh93LEy3hCo
        ajum08THddgPaTpbnBA3jfDAgrJJ5E79QHuouJ+U0j4Z/1E1CUN/BUnXceIybVt8GPL3Nu+B9PjzD
        AE0yomUGbAvwFIS2TFZPuFY1qBtBDW1m7tHXVozEnoS1/QH7ZAu+6nsWmQ59131mZAYmBC1PP1OnB
        gfEaUoDsI/W/CwDvz0kgSGufTriLT0IvyIVDV8y3oisW93lDCHIdxaFDKi1oyXkhEpZQxqzBXROWX
        ca6+SPI7sfqyPbDKo0gSkQ8ipUxXCD9KpFQkWChmtkVI406PQiDMBYZDV/twMf8te4IPV3GP4di19
        6qq////Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBlF-00CL0M-CQ; Mon, 21 Aug 2023 20:44:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 5/7] memcg: Add mem_cgroup_uncharge_batch()
Date:   Mon, 21 Aug 2023 21:44:23 +0100
Message-Id: <20230821204425.2940496-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230821204425.2940496-1-willy@infradead.org>
References: <ZOPMNyZ3gKb/bdjO@casper.infradead.org>
 <20230821204425.2940496-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost identical to mem_cgroup_uncharge_list(), except it takes a
folio_batch instead of a list_head.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 12 ++++++++++++
 mm/memcontrol.c            | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3bd00f224224..4ea6f8399b05 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -708,6 +708,14 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 	__mem_cgroup_uncharge_list(page_list);
 }
 
+void __mem_cgroup_uncharge_batch(struct folio_batch *fbatch);
+static inline void mem_cgroup_uncharge_batch(struct folio_batch *fbatch)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_uncharge_batch(fbatch);
+}
+
 void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
 /**
@@ -1269,6 +1277,10 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
 }
 
+static inline void mem_cgroup_uncharge_batch(struct folio_batch *fbatch)
+{
+}
+
 static inline void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 67bda1ceedbe..205aa28c2672 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -33,6 +33,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/hugetlb.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/vm_event_item.h>
 #include <linux/smp.h>
 #include <linux/page-flags.h>
@@ -7194,6 +7195,18 @@ void __mem_cgroup_uncharge_list(struct list_head *page_list)
 		uncharge_batch(&ug);
 }
 
+void __mem_cgroup_uncharge_batch(struct folio_batch *fbatch)
+{
+	struct uncharge_gather ug;
+	unsigned int i;
+
+	uncharge_gather_clear(&ug);
+	for (i = 0; i < fbatch->nr; i++)
+		uncharge_folio(fbatch->folios[i], &ug);
+	if (ug.memcg)
+		uncharge_batch(&ug);
+}
+
 /**
  * mem_cgroup_migrate - Charge a folio's replacement.
  * @old: Currently circulating folio.
-- 
2.40.1

