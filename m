Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E67C7778AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjHJMjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHJMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:39:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE85212F;
        Thu, 10 Aug 2023 05:39:36 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RM60Z2SKrz1L9wc;
        Thu, 10 Aug 2023 20:38:22 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 20:39:34 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <laijs@cn.fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] tracing: Fix race when concurrently splice_read trace_pipe
Date:   Thu, 10 Aug 2023 20:39:05 +0800
Message-ID: <20230810123905.1531061-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When concurrently splice_read file trace_pipe and per_cpu/cpu*/trace_pipe,
there are more data being read out than expected.

The root cause is that in tracing_splice_read_pipe(), an entry is found
outside locks, it may be read by multiple readers or consumed by other
reader as starting printing it.

To fix it, change to find entry after holding locks.

Fixes: 7e53bd42d14c ("tracing: Consolidate protection of reader access to the ring buffer")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/trace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8870078ef58..f169d33b948f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7054,14 +7054,16 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 	if (ret <= 0)
 		goto out_err;
 
-	if (!iter->ent && !trace_find_next_entry_inc(iter)) {
+	trace_event_read_lock();
+	trace_access_lock(iter->cpu_file);
+
+	if (!trace_find_next_entry_inc(iter)) {
+		trace_access_unlock(iter->cpu_file);
+		trace_event_read_unlock();
 		ret = -EFAULT;
 		goto out_err;
 	}
 
-	trace_event_read_lock();
-	trace_access_lock(iter->cpu_file);
-
 	/* Fill as many pages as possible. */
 	for (i = 0, rem = len; i < spd.nr_pages_max && rem; i++) {
 		spd.pages[i] = alloc_page(GFP_KERNEL);
-- 
2.25.1

