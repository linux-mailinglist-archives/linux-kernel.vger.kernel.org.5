Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE9783CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjHVJdU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 05:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjHVJdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:33:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4C31B2;
        Tue, 22 Aug 2023 02:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B826161A04;
        Tue, 22 Aug 2023 09:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222BBC433C8;
        Tue, 22 Aug 2023 09:33:16 +0000 (UTC)
Date:   Tue, 22 Aug 2023 05:33:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] tracefs: Remove kerneldoc from struct eventfs_file
Message-ID: <20230822053313.77aa3397@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d0d094090c093499380049c413b8f1c5b995ff52 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Tue, 22 Aug 2023 05:29:22 -0400
Subject: [PATCH] tracefs: Remove kerneldoc from struct eventfs_file

The struct eventfs_file is a local structure and should not be parsed by
kernel doc. It also does not fully follow the kerneldoc format and is
causing kerneldoc to spit out errors. Replace the /** to /* so that
kerneldoc no longer processes this structure.

Also format the comments of the delete union of the structure to be a bit
better.

Link: https://lore.kernel.org/linux-trace-kernel/20230818201414.2729745-1-willy@infradead.org/

Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index da8d2e73cc47..237c6f370ad9 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -27,7 +27,7 @@ struct eventfs_inode {
 	struct list_head	e_top_files;
 };
 
-/**
+/*
  * struct eventfs_file - hold the properties of the eventfs files and
  *                       directories.
  * @name:	the name of the file or directory to create
@@ -48,10 +48,16 @@ struct eventfs_file {
 	struct eventfs_inode		*ei;
 	const struct file_operations	*fop;
 	const struct inode_operations	*iop;
+	/*
+	 * Union - used for deletion
+	 * @del_list:	list of eventfs_file to delete
+	 * @rcu:	eventfs_file to delete in RCU
+	 * @is_freed:	node is freed if one of the above is set
+	 */
 	union {
-		struct list_head	del_list; /* list of eventfs_file to delete */
-		struct rcu_head		rcu; /* eventfs_file to delete */
-		unsigned long		is_freed; /* Freed if one of the above is set */
+		struct list_head	del_list;
+		struct rcu_head		rcu;
+		unsigned long		is_freed;
 	};
 	void				*data;
 	umode_t				mode;
-- 
2.40.1

