Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A857F656C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345666AbjKWRaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjKWRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:30:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0142D44
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:30:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC91C43391;
        Thu, 23 Nov 2023 17:30:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r6DX9-0000000367c-0sgZ;
        Thu, 23 Nov 2023 12:30:35 -0500
Message-ID: <20231123173035.075321171@goodmis.org>
User-Agent: quilt/0.67
Date:   Thu, 23 Nov 2023 12:25:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [for-linus][PATCH 4/5] eventfs: Make sure that parent->d_inode is locked in creating
 files/dirs
References: <20231123172539.582640797@goodmis.org>
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

Since the locking of the parent->d_inode has been moved outside the
creation of the files and directories (as it use to be locked via a
conditional), add a WARN_ON_ONCE() to the case that it's not locked.

Link: https://lkml.kernel.org/r/20231121231112.853962542@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 590e8176449b..0b90869fd805 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -327,6 +327,8 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 	struct dentry **e_dentry = &ei->d_children[idx];
 	struct dentry *dentry;
 
+	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
+
 	mutex_lock(&eventfs_mutex);
 	if (ei->is_freed) {
 		mutex_unlock(&eventfs_mutex);
@@ -430,6 +432,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 {
 	struct dentry *dentry = NULL;
 
+	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
+
 	mutex_lock(&eventfs_mutex);
 	if (pei->is_freed || ei->is_freed) {
 		mutex_unlock(&eventfs_mutex);
-- 
2.42.0


