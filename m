Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1651F7B439B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjI3Uha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjI3UhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:37:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB8EB
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 13:37:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8DAC43391;
        Sat, 30 Sep 2023 20:37:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qmgjG-004N19-0l;
        Sat, 30 Sep 2023 16:38:22 -0400
Message-ID: <20230930203822.053304721@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 30 Sep 2023 16:32:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 4/4] eventfs: Test for dentries array allocated in eventfs_release()
References: <20230930203213.826737400@goodmis.org>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The dcache_dir_open_wrapper() could be called when a dynamic event is
being deleted leaving a dentry with no children. In this case the
dlist->dentries array will never be allocated. This needs to be checked
for in eventfs_release(), otherwise it will trigger a NULL pointer
dereference.

Link: https://lore.kernel.org/linux-trace-kernel/20230930090106.1c3164e9@rorschach.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: ef36b4f92868 ("eventfs: Remember what dentries were created on dir open")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5f1714089884..8c8d64e76103 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -421,7 +421,7 @@ static int eventfs_release(struct inode *inode, struct file *file)
 	if (WARN_ON_ONCE(!dlist))
 		return -EINVAL;
 
-	for (i = 0; dlist->dentries[i]; i++) {
+	for (i = 0; dlist->dentries && dlist->dentries[i]; i++) {
 		dput(dlist->dentries[i]);
 	}
 
-- 
2.40.1
