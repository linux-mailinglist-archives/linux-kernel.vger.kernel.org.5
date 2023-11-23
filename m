Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37F27F5CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344448AbjKWKk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjKWKkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:40:25 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94802D4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:40:30 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4SbZQ345BBzCh3M
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:40:27 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4SbZQ03GbFzBRjZH
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:40:24 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4SbZPx1LXdz4xPYm;
        Thu, 23 Nov 2023 18:40:21 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 3ANAeEas066399;
        Thu, 23 Nov 2023 18:40:14 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 23 Nov 2023 18:40:18 +0800 (CST)
Date:   Thu, 23 Nov 2023 18:40:18 +0800 (CST)
X-Zmail-TransId: 2b03655f2c124cb-d546e
X-Mailer: Zmail v1.0
Message-ID: <202311231840181856667@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <hughd@google.com>, <hannes@cmpxchg.org>, <wang.yong12@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <jiang.xuexin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdbW0sIG9vbTpkdW1wX3Rhc2tzIGFkZCByc3MgZGV0YWlsZWQgaW5mb3JtYXRpb24gcHJpbnRpbmc=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3ANAeEas066399
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 655F2C1A.001/4SbZQ345BBzCh3M
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Wang <wang.yong12@zte.com.cn>

When the system is under oom, it prints out the RSS information of
each process. However, we don't know the size of rss_anon, rss_file,
and rss_shmem.

To distinguish the memory occupied by anonymous or file mappings
or shmem, could help us identify the root cause of the oom.

So this patch adds RSS details, which refers to the /proc/<pid>/status[1].
It can help us know more about process memory usage.

Example of oom including the new rss_* fields:
[ 1630.902466] Tasks state (memory values in pages):
[ 1630.902870] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[ 1630.903619] [    149]     0   149      486      288        0      288         0    36864        0             0 ash
[ 1630.904210] [    156]     0   156   153531   153345   153345        0         0  1269760        0             0 mm_test

[1] commit 8cee852ec53f ("mm, procfs: breakdown RSS for anon, shmem and file in /proc/pid/status").

Signed-off-by: Yong Wang <wang.yong12@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/oom_kill.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9e6071fde34a..91ccd82097c2 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -399,10 +399,11 @@ static int dump_task(struct task_struct *p, void *arg)
 		return 0;
 	}

-	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
+	pr_info("[%7d] %5d %5d %8lu %8lu %8lu %8lu %9lu %8ld %8lu         %5hd %s\n",
 		task->pid, from_kuid(&init_user_ns, task_uid(task)),
 		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
-		mm_pgtables_bytes(task->mm),
+		get_mm_counter(task->mm, MM_ANONPAGES), get_mm_counter(task->mm, MM_FILEPAGES),
+		get_mm_counter(task->mm, MM_SHMEMPAGES), mm_pgtables_bytes(task->mm),
 		get_mm_counter(task->mm, MM_SWAPENTS),
 		task->signal->oom_score_adj, task->comm);
 	task_unlock(task);
@@ -423,7 +424,7 @@ static int dump_task(struct task_struct *p, void *arg)
 static void dump_tasks(struct oom_control *oc)
 {
 	pr_info("Tasks state (memory values in pages):\n");
-	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
+	pr_info("[  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name\n");

 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
-- 
2.15.2
