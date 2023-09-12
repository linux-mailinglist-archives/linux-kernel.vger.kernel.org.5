Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8D79D894
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbjILSWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbjILSW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:22:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AE210DF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:22:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DEEC433CA;
        Tue, 12 Sep 2023 18:22:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qg824-000JS3-1l;
        Tue, 12 Sep 2023 14:22:40 -0400
Message-ID: <20230912182240.361479245@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Sep 2023 14:22:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [for-linus][PATCH 2/3] tracefs/eventfs: Use list_for_each_srcu() in
 dcache_dir_open_wrapper()
References: <20230912182213.795801173@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Link: https://lore.kernel.org/linux-trace-kernel/20230911200654.71ce927c@gandalf.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ajay Kaher <akaher@vmware.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Reported-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 63940449555e7 ("eventfs: Implement eventfs lookup, read, open functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
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
