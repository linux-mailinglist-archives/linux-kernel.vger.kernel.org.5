Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E9C7524DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjGMOPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbjGMOOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:14:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAFA30EC;
        Thu, 13 Jul 2023 07:14:41 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R1xR76DjmzVhlr;
        Thu, 13 Jul 2023 22:13:23 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 22:14:38 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] traing: Fix memory leak of iter->temp when reading trace_pipe
Date:   Thu, 13 Jul 2023 22:14:35 +0800
Message-ID: <20230713141435.1133021-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak reports:
  unreferenced object 0xffff88814d14e200 (size 256):
    comm "cat", pid 336, jiffies 4294871818 (age 779.490s)
    hex dump (first 32 bytes):
      04 00 01 03 00 00 00 00 08 00 00 00 00 00 00 00  ................
      0c d8 c8 9b ff ff ff ff 04 5a ca 9b ff ff ff ff  .........Z......
    backtrace:
      [<ffffffff9bdff18f>] __kmalloc+0x4f/0x140
      [<ffffffff9bc9238b>] trace_find_next_entry+0xbb/0x1d0
      [<ffffffff9bc9caef>] trace_print_lat_context+0xaf/0x4e0
      [<ffffffff9bc94490>] print_trace_line+0x3e0/0x950
      [<ffffffff9bc95499>] tracing_read_pipe+0x2d9/0x5a0
      [<ffffffff9bf03a43>] vfs_read+0x143/0x520
      [<ffffffff9bf04c2d>] ksys_read+0xbd/0x160
      [<ffffffff9d0f0edf>] do_syscall_64+0x3f/0x90
      [<ffffffff9d2000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8

when reading file 'trace_pipe', 'iter->temp' is allocated or relocated
in trace_find_next_entry() but not freed before 'trace_pipe' is closed.

To fix it, free 'iter->temp' in tracing_release_pipe().

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4529e264cb86..94cfaa884578 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6764,6 +6764,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 
 	free_cpumask_var(iter->started);
 	kfree(iter->fmt);
+	kfree(iter->temp);
 	mutex_destroy(&iter->mutex);
 	kfree(iter);
 
-- 
2.25.1

