Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42BD77F1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348806AbjHQIJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348754AbjHQIJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:09:07 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8D0BE48
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:09:06 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-d9-64ddd5987e6f
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Subject: [RFC v2 6/6] mm, migrc: Implement internal allocator to minimize impact onto vm
Date:   Thu, 17 Aug 2023 17:05:59 +0900
Message-Id: <20230817080559.43200-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817080559.43200-1-byungchul@sk.com>
References: <20230817080559.43200-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsXC9ZZnoe6Mq3dTDA59MrOYs34Nm8WLDe2M
        Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsru96yGhxvPcAk8XvH0DZOVOsLE7O
        msziwOuxYFOpx+YVWh6L97xk8ti0qpPNY9OnSeweJ2b8ZvHY+dDSY97JQI/3+66yeWz9Zefx
        eZOcx7v5b9kCeKK4bFJSczLLUov07RK4MrYflSq4zlXxd9Uc5gbG3xxdjJwcEgImEnvfHWeD
        sVd/ec8OYrMJqEvcuPGTGcQWETCTONj6ByjOxcEssIxJ4u6Bc6wgCWGBCImmxyvAGlgEVCX2
        b1/LBGLzCphKnL7fCDVUXmL1hgNAgzg4OIEGbf6rChIWAir5sHcdK8hMCYEzbBLXb06EqpeU
        OLjiBssERt4FjAyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQJDeFntn+gdjJ8uBB9iFOBgVOLh
        ddh1J0WINbGsuDL3EKMEB7OSCG8P760UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATS
        E0tSs1NTC1KLYLJMHJxSDYzupm8kOrLjuMpUnr29FH1W+Pk1NmG3N8vzCpWfpnxq6N4s+Xbz
        65VWOhr1H58scXny6I0y05eL91YcXDKz5BzrHo7VzYcEqq84PEg7UvaAzUa/PXy21McvurcM
        0u37FRNVN5xjuVDq8FzdiO/rSYP+C0kme5/M7I6Yc9Cj7FqXzcWAsquLIqKUWIozEg21mIuK
        EwHEHSNIXQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsXC5WfdrDvj6t0Ug62/dSzmrF/DZvFiQzuj
        xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlc3/WQ0eJ47wEmi98/gLJz
        plhZnJw1mcWBz2PBplKPzSu0PBbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXHvJOBHu/3XWXz
        WPziA5PH1l92Hp83yXm8m/+WLYA3issmJTUnsyy1SN8ugStj+1GpgutcFX9XzWFuYPzN0cXI
        ySEhYCKx+st7dhCbTUBd4saNn8wgtoiAmcTB1j9AcS4OZoFlTBJ3D5xjBUkIC0RIND1eAdbA
        IqAqsX/7WiYQm1fAVOL0/UY2iKHyEqs3HAAaxMHBCTRo819VkLAQUMmHvetYJzByLWBkWMUo
        kplXlpuYmWOqV5ydUZmXWaGXnJ+7iREYkMtq/0zcwfjlsvshRgEORiUeXoddd1KEWBPLiitz
        DzFKcDArifD28N5KEeJNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl
        4uCUamAsajd6ekX0lL9J4j9+H/FX/ZcnJKy/1HbN4d/ZqQ/UJy1MUEuccv7a5ylv7yyK2Tmd
        nZk1y4bnwPePp5/OnvjT7xdXNZeLzYxHSqdWxdj6sTpqRTvs7jSyXbTnqbvq4plH77+PPdU+
        3eigzrK5wZytF9vPnpJ4zu9ysdN4S55o6m5eyw8THhzMU2Ipzkg01GIuKk4EAC4YsvFEAgAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Not sure if this patch works meaningfully. Ignore if not.)

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/migrate.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c57536a0b2a6..6b5113d5a1e2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -122,14 +122,33 @@ enum {
 	MIGRC_DST_PENDING,
 };
 
+#define MAX_MIGRC_REQ_NR	4096
+static struct migrc_req migrc_req_pool_static[MAX_MIGRC_REQ_NR];
+static atomic_t migrc_req_pool_idx = ATOMIC_INIT(-1);
+static LLIST_HEAD(migrc_req_pool_llist);
+static DEFINE_SPINLOCK(migrc_req_pool_lock);
+
 static struct migrc_req *alloc_migrc_req(void)
 {
-	return kmalloc(sizeof(struct migrc_req), GFP_KERNEL);
+	int idx = atomic_read(&migrc_req_pool_idx);
+	struct llist_node *n;
+
+	if (idx < MAX_MIGRC_REQ_NR - 1) {
+		idx = atomic_inc_return(&migrc_req_pool_idx);
+		if (idx < MAX_MIGRC_REQ_NR)
+			return migrc_req_pool_static + idx;
+	}
+
+	spin_lock(&migrc_req_pool_lock);
+	n = llist_del_first(&migrc_req_pool_llist);
+	spin_unlock(&migrc_req_pool_lock);
+
+	return n ? llist_entry(n, struct migrc_req, llnode) : NULL;
 }
 
 void free_migrc_req(struct migrc_req *req)
 {
-	kfree(req);
+	llist_add(&req->llnode, &migrc_req_pool_llist);
 }
 
 static bool migrc_is_full(int nid)
-- 
2.17.1

