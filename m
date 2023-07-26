Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71927632F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjGZJ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjGZJ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:58:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84130DE;
        Wed, 26 Jul 2023 02:57:55 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R9q5L3stVzLnrf;
        Wed, 26 Jul 2023 17:55:18 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 17:57:53 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] tracing: Fix warning in trace_buffered_event_disable()
Date:   Wed, 26 Jul 2023 17:58:04 +0800
Message-ID: <20230726095804.920457-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning happened in trace_buffered_event_disable() at
  WARN_ON_ONCE(!trace_buffered_event_ref)

  Call Trace:
   ? __warn+0xa5/0x1b0
   ? trace_buffered_event_disable+0x189/0x1b0
   __ftrace_event_enable_disable+0x19e/0x3e0
   free_probe_data+0x3b/0xa0
   unregister_ftrace_function_probe_func+0x6b8/0x800
   event_enable_func+0x2f0/0x3d0
   ftrace_process_regex.isra.0+0x12d/0x1b0
   ftrace_filter_write+0xe6/0x140
   vfs_write+0x1c9/0x6f0
   [...]

The cause of the warning is in __ftrace_event_enable_disable(),
trace_buffered_event_enable() was called once while
trace_buffered_event_disable() was called twice.
Reproduction script show as below, for analysis, see the comments:
 ```
 #!/bin/bash

 cd /sys/kernel/tracing/

 # 1. Register a 'disable_event' command, then:
 #    1) SOFT_DISABLED_BIT was set;
 #    2) trace_buffered_event_enable() was called first time;
 echo 'cmdline_proc_show:disable_event:initcall:initcall_finish' > \
     set_ftrace_filter

 # 2. Enable the event registered, then:
 #    1) SOFT_DISABLED_BIT was cleared;
 #    2) trace_buffered_event_disable() was called first time;
 echo 1 > events/initcall/initcall_finish/enable

 # 3. Try to call into cmdline_proc_show(), then SOFT_DISABLED_BIT was
 #    set again!!!
 cat /proc/cmdline

 # 4. Unregister the 'disable_event' command, then:
 #    1) SOFT_DISABLED_BIT was cleared again;
 #    2) trace_buffered_event_disable() was called second time!!!
 echo '!cmdline_proc_show:disable_event:initcall:initcall_finish' > \
     set_ftrace_filter
 ```

To fix it, IIUC, we can change to call trace_buffered_event_enable() at
fist time soft-mode enabled, and call trace_buffered_event_disable() at
last time soft-mode disabled.

Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/trace_events.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 5d6ae4eae510..578f1f7d49a6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -611,7 +611,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	unsigned long file_flags = file->flags;
 	int ret = 0;
 	int disable;
 
@@ -635,6 +634,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
 			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Disable use of trace_buffered_event */
+			trace_buffered_event_disable();
 		} else
 			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
 
@@ -673,6 +674,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
 			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Enable use of trace_buffered_event */
+			trace_buffered_event_enable();
 		}
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
@@ -712,15 +715,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		break;
 	}
 
-	/* Enable or disable use of trace_buffered_event */
-	if ((file_flags & EVENT_FILE_FL_SOFT_DISABLED) !=
-	    (file->flags & EVENT_FILE_FL_SOFT_DISABLED)) {
-		if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
-			trace_buffered_event_enable();
-		else
-			trace_buffered_event_disable();
-	}
-
 	return ret;
 }
 
-- 
2.25.1

