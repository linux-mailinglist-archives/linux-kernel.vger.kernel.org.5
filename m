Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F2E7F3A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjKUXLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjKUXLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:11:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFA4A4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:10:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5607C433C7;
        Tue, 21 Nov 2023 23:10:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r5Ztg-00000002dF5-4BCs;
        Tue, 21 Nov 2023 18:11:12 -0500
Message-ID: <20231121231112.853962542@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 21 Nov 2023 18:10:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/4] eventfs: Make sure that parent->d_inode is locked in creating
 files/dirs
References: <20231121231003.516999942@goodmis.org>
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

Since the locking of the parent->d_inode has been moved outside the
creation of the files and directories (as it use to be locked via a
conditional), add a WARN_ON_ONCE() to the case that it's not locked.

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


