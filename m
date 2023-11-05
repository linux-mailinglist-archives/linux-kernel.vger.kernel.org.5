Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63A47E1438
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjKEQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKEQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:01:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526BBE1;
        Sun,  5 Nov 2023 08:01:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DECC433C8;
        Sun,  5 Nov 2023 16:01:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1qzfZD-00000000ChE-2gI6;
        Sun, 05 Nov 2023 11:01:39 -0500
Message-ID: <20231105160139.498444992@goodmis.org>
User-Agent: quilt/0.67
Date:   Sun, 05 Nov 2023 10:56:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        <gregkh@linuxfoundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [v6.6][PATCH 2/5] eventfs: Remove "is_freed" union with rcu head
References: <20231105155630.925114107@goodmis.org>
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

commit f2f496370afcbc5227d7002da28c74b91fed12ff upstream

The eventfs_inode->is_freed was a union with the rcu_head with the
assumption that when it was on the srcu list the head would contain a
pointer which would make "is_freed" true. But that was a wrong assumption
as the rcu head is a single link list where the last element is NULL.

Instead, split the nr_entries integer so that "is_freed" is one bit and
the nr_entries is the next 31 bits. As there shouldn't be more than 10
(currently there's at most 5 to 7 depending on the config), this should
not be a problem.

Link: https://lkml.kernel.org/r/20231101172649.049758712@goodmis.org

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ajay Kaher <akaher@vmware.com>
Fixes: 63940449555e7 ("eventfs: Implement eventfs lookup, read, open functions")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8c8d64e76103..a64d8fa39e54 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -38,6 +38,7 @@ struct eventfs_inode {
  * @fop:	file_operations for file or directory
  * @iop:	inode_operations for file or directory
  * @data:	something that the caller will want to get to later on
+ * @is_freed:	Flag set if the eventfs is on its way to be freed
  * @mode:	the permission that the file or directory should have
  */
 struct eventfs_file {
@@ -52,15 +53,14 @@ struct eventfs_file {
 	 * Union - used for deletion
 	 * @del_list:	list of eventfs_file to delete
 	 * @rcu:	eventfs_file to delete in RCU
-	 * @is_freed:	node is freed if one of the above is set
 	 */
 	union {
 		struct list_head	del_list;
 		struct rcu_head		rcu;
-		unsigned long		is_freed;
 	};
 	void				*data;
-	umode_t				mode;
+	unsigned int			is_freed:1;
+	unsigned int			mode:31;
 };
 
 static DEFINE_MUTEX(eventfs_mutex);
@@ -814,6 +814,8 @@ static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head,
 		}
 	}
 
+	ef->is_freed = 1;
+
 	list_del_rcu(&ef->list);
 	list_add_tail(&ef->del_list, head);
 }
-- 
2.42.0


