Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBB57D190E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjJTW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjJTW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:27:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A6FD5B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:27:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64385C433CC;
        Fri, 20 Oct 2023 22:27:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qtxy0-00AQZM-1C;
        Fri, 20 Oct 2023 18:27:40 -0400
Message-ID: <20231020222740.185464260@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Oct 2023 18:27:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [for-next][PATCH 3/6] tracing: Fix a NULL vs IS_ERR() bug in event_subsystem_dir()
References: <20231020222713.074741220@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

The eventfs_create_dir() function returns error pointers, it never returns
NULL.  Update the check to reflect that.

Link: https://lore.kernel.org/linux-trace-kernel/ff641474-84e2-46a7-9d7a-62b251a1050c@moroto.mountain

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index db46d2116500..f9e3e24d8796 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2354,7 +2354,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 		nr_entries = ARRAY_SIZE(system_entries);
 
 	ei = eventfs_create_dir(name, parent, system_entries, nr_entries, dir);
-	if (!ei) {
+	if (IS_ERR(ei)) {
 		pr_warn("Failed to create system directory %s\n", name);
 		__put_system(system);
 		goto out_free;
-- 
2.42.0
