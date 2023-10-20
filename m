Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF87D05E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346793AbjJTAli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJTAlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:41:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88BFC0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:41:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFF9C433C7;
        Fri, 20 Oct 2023 00:41:34 +0000 (UTC)
Date:   Thu, 19 Oct 2023 20:41:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] eventfs: Fix failure path in eventfs_create_events_dir()
Message-ID: <20231019204132.6662fef0@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The failure path of allocating ei goes to a path that dereferences ei.
Add another label that skips over the ei dereferences to do the rest of
the clean up.

Link: https://lore.kernel.org/all/70e7bace-561c-95f-1117-706c2c220bc@inria.fr/

Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9f19b6608954..1885f1f1f339 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -735,7 +735,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 
 	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
 	if (!ei)
-		goto fail;
+		goto fail_ei;
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
@@ -781,6 +781,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
  fail:
 	kfree(ei->d_children);
 	kfree(ei);
+ fail_ei:
 	tracefs_failed_creating(dentry);
 	return ERR_PTR(-ENOMEM);
 }
-- 
2.42.0

