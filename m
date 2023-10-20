Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AA37D1911
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjJTW1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJTW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:27:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D5DD5A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:27:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5E9C433CA;
        Fri, 20 Oct 2023 22:27:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qtxy0-00AQYo-0V;
        Fri, 20 Oct 2023 18:27:40 -0400
Message-ID: <20231020222739.960696059@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Oct 2023 18:27:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [for-next][PATCH 2/6] eventfs: Fix failure path in eventfs_create_events_dir()
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The failure path of allocating ei goes to a path that dereferences ei.
Add another label that skips over the ei dereferences to do the rest of
the clean up.

Link: https://lore.kernel.org/all/70e7bace-561c-95f-1117-706c2c220bc@inria.fr/
Link: https://lore.kernel.org/linux-trace-kernel/20231019204132.6662fef0@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
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
