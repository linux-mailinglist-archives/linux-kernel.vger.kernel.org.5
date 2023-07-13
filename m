Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F07519A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjGMHSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjGMHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:18:31 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B62E75
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:18:28 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36D7HIYx035713;
        Thu, 13 Jul 2023 15:17:18 +0800 (+08)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4R1m9p6Sg7z2MDcHl;
        Thu, 13 Jul 2023 15:16:14 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.72) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 13 Jul 2023 15:17:16 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <brauner@kernel.org>, <jack@suse.cz>, <keescook@chromium.org>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <xuewen.yan@unisoc.com>,
        <di.shen@unisoc.com>
Subject: [PATCH] pid: Add the judgment of whether ns is NULL in the find_pid_ns
Date:   Thu, 13 Jul 2023 15:17:13 +0800
Message-ID: <20230713071713.5762-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.72]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 36D7HIYx035713
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no the judgment of whether namspace is NULL in find_pid_ns.
But there is a corner case when ns is null, for example: if user
call find_get_pid when current is in exiting, the following stack would
set thread_id be null:
release_task
    __exit_signal(p);
        __unhash_process(tsk, group_dead);
              detach_pid(p, PIDTYPE_PID);
                  __change_pid(task, type, NULL);

If user call find_get_pid at now, in find_vpid function, the
task_active_pid_ns would return NULL. As a result, it would be
error when access the ns in find_pid_ns.

So add the judgment of whether ns is NULL in the find_pid_ns to
prevent this case happen.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/pid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/pid.c b/kernel/pid.c
index 6a1d23a11026..d4a9cb6f3eb9 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -308,6 +308,9 @@ void disable_pid_allocation(struct pid_namespace *ns)
 
 struct pid *find_pid_ns(int nr, struct pid_namespace *ns)
 {
+	if (!ns)
+		return NULL;
+
 	return idr_find(&ns->idr, nr);
 }
 EXPORT_SYMBOL_GPL(find_pid_ns);
-- 
2.25.1

