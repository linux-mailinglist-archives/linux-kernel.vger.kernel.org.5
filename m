Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613BE7DE554
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjKAR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjKAR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:26:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5EEE4;
        Wed,  1 Nov 2023 10:26:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BDEC433C8;
        Wed,  1 Nov 2023 17:26:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qyEzR-00EZs7-0m;
        Wed, 01 Nov 2023 13:26:49 -0400
Message-ID: <20231101172649.049758712@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Nov 2023 13:25:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v6 1/8] eventfs: Remove "is_freed" union with rcu head
References: <20231101172541.971928390@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The eventfs_inode->is_freed was a union with the rcu_head with the
assumption that when it was on the srcu list the head would contain a
pointer which would make "is_freed" true. But that was a wrong assumption
as the rcu head is a single link list where the last element is NULL.

Instead, split the nr_entries integer so that "is_freed" is one bit and
the nr_entries is the next 31 bits. As there shouldn't be more than 10
(currently there's at most 5 to 7 depending on the config), this should
not be a problem.

Cc: stable@vger.kernel.org
Cc: Ajay Kaher <akaher@vmware.com>
Fixes: 63940449555e7 ("eventfs: Implement eventfs lookup, read, open functions")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://lkml.kernel.org/r/20231031223419.935276916@goodmis.org

- Resynced for this patch series

 fs/tracefs/event_inode.c | 2 ++
 fs/tracefs/internal.h    | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9f612a8f009d..1ce73acf3df0 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -824,6 +824,8 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head,
 		eventfs_remove_rec(ei_child, head, level + 1);
 	}
 
+	ei->is_freed = 1;
+
 	list_del_rcu(&ei->list);
 	list_add_tail(&ei->del_list, head);
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 64fde9490f52..c7d88aaa949f 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -23,6 +23,7 @@ struct tracefs_inode {
  * @d_parent:   pointer to the parent's dentry
  * @d_children: The array of dentries to represent the files when created
  * @data:	The private data to pass to the callbacks
+ * @is_freed:	Flag set if the eventfs is on its way to be freed
  * @nr_entries: The number of items in @entries
  */
 struct eventfs_inode {
@@ -38,14 +39,13 @@ struct eventfs_inode {
 	 * Union - used for deletion
 	 * @del_list:	list of eventfs_inode to delete
 	 * @rcu:	eventfs_inode to delete in RCU
-	 * @is_freed:	node is freed if one of the above is set
 	 */
 	union {
 		struct list_head	del_list;
 		struct rcu_head		rcu;
-		unsigned long		is_freed;
 	};
-	int				nr_entries;
+	unsigned int			is_freed:1;
+	unsigned int			nr_entries:31;
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
-- 
2.42.0
