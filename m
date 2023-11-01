Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72DB7DE797
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbjKAViK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345726AbjKAViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:38:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC8711D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:38:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E44BC433CB;
        Wed,  1 Nov 2023 21:38:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qyIuY-00EdX7-0g;
        Wed, 01 Nov 2023 17:38:02 -0400
Message-ID: <20231101213802.017038744@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Nov 2023 17:37:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 02/12] eventfs: Remove extra dget() in eventfs_create_events_dir()
References: <20231101213718.381015321@goodmis.org>
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

The creation of the top events directory does a dget() at the end of the
creation in eventfs_create_events_dir() with a comment saying the final
dput() will happen when it is removed. The problem is that a dget() is
already done on the dentry when it was created with tracefs_start_creating()!
The dget() now just causes a memory leak of that dentry.

Remove the extra dget() as the final dput() in the deletion of the events
directory actually matches the one in tracefs_start_creating().

Link: https://lore.kernel.org/linux-trace-kernel/20231031124229.4f2e3fa1@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 4d2da7480e5f..5536860eb2ff 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -774,9 +774,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	tracefs_end_creating(dentry);
 
-	/* Will call dput when the directory is removed */
-	dget(dentry);
-
 	return ei;
 
  fail:
-- 
2.42.0
