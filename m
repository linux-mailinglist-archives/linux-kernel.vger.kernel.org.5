Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A3177F1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348779AbjHQIJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348752AbjHQIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:09:06 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20819210E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:09:04 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-d5-64ddd598af46
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Subject: [RFC v2 5/6] mm, migrc: Add a sysctl knob to enable/disable MIGRC mechanism
Date:   Thu, 17 Aug 2023 17:05:58 +0900
Message-Id: <20230817080559.43200-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817080559.43200-1-byungchul@sk.com>
References: <20230817080559.43200-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsXC9ZZnke6Mq3dTDNrmGVnMWb+GzeLFhnZG
        i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwW13c9ZLQ43nuAyeL3D6DsnClWFidn
        TWZx4PVYsKnUY/MKLY/Fe14yeWxa1cnmsenTJHaPEzN+s3jsfGjpMe9koMf7fVfZPLb+svP4
        vEnO4938t2wBPFFcNimpOZllqUX6dglcGXf/GRccEKrYMmEvcwPje74uRk4OCQETieN35zHB
        2Ldm7mMDsdkE1CVu3PjJDGKLCJhJHGz9w97FyMXBLLCMSeLugXOsIAlhgRCJnw9awGwWAVWJ
        J93XwWxeAVOJ35sbmCGGykus3nAAyObg4AQatPmvKkhYCKjkw951rCAzJQTOsElcnvKQHaJe
        UuLgihssExh5FzAyrGIUyswry03MzDHRy6jMy6zQS87P3cQIDOFltX+idzB+uhB8iFGAg1GJ
        h9dh150UIdbEsuLK3EOMEhzMSiK8Pby3UoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxES
        SE8sSc1OTS1ILYLJMnFwSjUwztn16LDMdu7/Ycu1d3hUcljkZDFn+jWF3jJcNevB5GdSv2oK
        lp1qjIpo+SffzJmQuj62+u5O+VfBfV2qc7bsitTfENnsPnV/Z27Lb4eLL9bcWno1XnXVoVCz
        Ey5G25t6Kw+vmae4W1Dk8+qLqwwT+S+k7VPhT03aHLniSjfTky0PvgYYGGhkK7EUZyQaajEX
        FScCADd7b45dAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsXC5WfdrDvj6t0UgyN7NCzmrF/DZvFiQzuj
        xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlc3/WQ0eJ47wEmi98/gLJz
        plhZnJw1mcWBz2PBplKPzSu0PBbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXHvJOBHu/3XWXz
        WPziA5PH1l92Hp83yXm8m/+WLYA3issmJTUnsyy1SN8ugSvj7j/jggNCFVsm7GVuYHzP18XI
        ySEhYCJxa+Y+NhCbTUBd4saNn8wgtoiAmcTB1j/sXYxcHMwCy5gk7h44xwqSEBYIkfj5oAXM
        ZhFQlXjSfR3M5hUwlfi9uYEZYqi8xOoNB4BsDg5OoEGb/6qChIWASj7sXcc6gZFrASPDKkaR
        zLyy3MTMHFO94uyMyrzMCr3k/NxNjMCAXFb7Z+IOxi+X3Q8xCnAwKvHwOuy6kyLEmlhWXJl7
        iFGCg1lJhLeH91aKEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwT
        B6dUA2P3ZhuRjPWfy9UDL9z26D014an2cSOOpjOvI+OntWtMrQ+p2SNpWPVj2QsVLiutoiXX
        qjN3Ws1XdrSZJ3J4XdK6yXb2ZReTAuYZTZC5uetgx6lJb+9tT352WbFr53kbN+6wxQrll3s3
        a7MJVh1adddld+L01eIGKb61jSeeFpRGPJjxOOjbRSYlluKMREMt5qLiRAD0GJvFRAIAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sysctl knob, '/proc/sys/vm/migrc_enable' to switch on/off migrc.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/migrate.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index badef3d89c6c..c57536a0b2a6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -59,6 +59,48 @@
 #include "internal.h"
 
 #ifdef CONFIG_MIGRC
+static int sysctl_migrc_enable = 1;
+#ifdef CONFIG_SYSCTL
+static int sysctl_migrc_enable_handler(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table t;
+	int err;
+	int enabled = sysctl_migrc_enable;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	t = *table;
+	t.data = &enabled;
+	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+	if (err < 0)
+		return err;
+	if (write)
+		sysctl_migrc_enable = enabled;
+	return err;
+}
+
+static struct ctl_table migrc_sysctls[] = {
+	{
+		.procname	= "migrc_enable",
+		.data		= NULL, /* filled in by handler */
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_migrc_enable_handler,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static int __init migrc_sysctl_init(void)
+{
+	register_sysctl_init("vm", migrc_sysctls);
+	return 0;
+}
+late_initcall(migrc_sysctl_init);
+#endif
 
 /*
  * TODO: Yeah, it's a non-sense magic number. This simple value manages
@@ -288,6 +330,7 @@ int migrc_pending_nr_in_zone(struct zone *z)
 
 }
 #else
+static const int sysctl_migrc_enable;
 static inline bool migrc_src_pending(struct folio *f) { return false; }
 static inline bool migrc_dst_pending(struct folio *f) { return false; }
 static inline bool migrc_is_full(int nid) { return true; }
@@ -1878,8 +1921,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
 			!list_empty(from) && !list_is_singular(from));
 
-	migrc_cond1 = (reason == MR_DEMOTION && current_is_kswapd()) ||
-		      (reason == MR_NUMA_MISPLACED);
+	migrc_cond1 = sysctl_migrc_enable &&
+		      ((reason == MR_DEMOTION && current_is_kswapd()) ||
+		      (reason == MR_NUMA_MISPLACED));
 
 	if (migrc_cond1)
 		migrc_req_start();
-- 
2.17.1

