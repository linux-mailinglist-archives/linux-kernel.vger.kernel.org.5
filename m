Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7039C7DD6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjJaTee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjJaTeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:34:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDBAA3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:34:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BE7C433C8;
        Tue, 31 Oct 2023 19:34:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qxuVQ-00EK8O-13;
        Tue, 31 Oct 2023 15:34:28 -0400
Message-ID: <20231031193428.133533311@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 31 Oct 2023 15:31:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 1/3] eventfs: Have a free_ei() that just frees the eventfs_inode
References: <20231031193109.018322397@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

As the eventfs_inode is freed in two different locations, make a helper
function free_ei() to make sure all the allocated fields of the
eventfs_inode is freed.

This requires renaming the existing free_ei() which is called by the srcu
handler to free_rcu_ei() and have free_ei() just do the freeing, where
free_rcu_ei() will call it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 754885dfe71c..76323f48d5f0 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -129,6 +129,13 @@ static struct dentry *create_dir(const char *name, struct dentry *parent)
 	return eventfs_end_creating(dentry);
 }
 
+static void free_ei(struct eventfs_inode *ei)
+{
+	kfree_const(ei->name);
+	kfree(ei->d_children);
+	kfree(ei);
+}
+
 /**
  * eventfs_set_ei_status_free - remove the dentry reference from an eventfs_inode
  * @ti: the tracefs_inode of the dentry
@@ -168,9 +175,7 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 			eventfs_remove_dir(ei_child);
 		}
 
-		kfree_const(ei->name);
-		kfree(ei->d_children);
-		kfree(ei);
+		free_ei(ei);
 		return;
 	}
 
@@ -784,13 +789,11 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ERR_PTR(-ENOMEM);
 }
 
-static void free_ei(struct rcu_head *head)
+static void free_rcu_ei(struct rcu_head *head)
 {
 	struct eventfs_inode *ei = container_of(head, struct eventfs_inode, rcu);
 
-	kfree_const(ei->name);
-	kfree(ei->d_children);
-	kfree(ei);
+	free_ei(ei);
 }
 
 /**
@@ -881,7 +884,7 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 		for (i = 0; i < ei->nr_entries; i++)
 			unhook_dentry(&ei->d_children[i], &dentry_list);
 		unhook_dentry(&ei->dentry, &dentry_list);
-		call_srcu(&eventfs_srcu, &ei->rcu, free_ei);
+		call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
 	}
 	mutex_unlock(&eventfs_mutex);
 
-- 
2.42.0
