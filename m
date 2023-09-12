Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1B679C14C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjILArN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjILArM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:47:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0E0144E9A;
        Mon, 11 Sep 2023 17:35:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D738C32789;
        Tue, 12 Sep 2023 00:06:38 +0000 (UTC)
Date:   Mon, 11 Sep 2023 20:06:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] tracefs/eventfs: Use list_for_each_srcu() in
 dcache_dir_open_wrapper()
Message-ID: <20230911200654.71ce927c@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The eventfs files list is protected by SRCU. In earlier iterations it was
protected with just RCU, but because it needed to also call sleepable
code, it had to be switch to SRCU. The dcache_dir_open_wrapper()
list_for_each_rcu() was missed and did not get converted over to
list_for_each_srcu(). That needs to be fixed.

Link: https://lore.kernel.org/linux-trace-kernel/20230911120053.ca82f545e7f46ea753deda18@kernel.org/

Reported-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 63940449555e7 ("eventfs: Implement eventfs lookup, read, open functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

[ Resend to see if it gets through the mailing list backlog! ]

 fs/tracefs/event_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f168aca45458..9f64e7332796 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -452,7 +452,8 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 
 	ei = ti->private;
 	idx = srcu_read_lock(&eventfs_srcu);
-	list_for_each_entry_rcu(ef, &ei->e_top_files, list) {
+	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
 		create_dentry(ef, dentry, false);
 	}
 	srcu_read_unlock(&eventfs_srcu, idx);
-- 
2.40.1

