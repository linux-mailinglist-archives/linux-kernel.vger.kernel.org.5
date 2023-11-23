Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6677F6569
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbjKWRaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKWRaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:30:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E01B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:30:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB46C433CA;
        Thu, 23 Nov 2023 17:30:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r6DX8-0000000365q-36UQ;
        Thu, 23 Nov 2023 12:30:34 -0500
Message-ID: <20231123173034.605245865@goodmis.org>
User-Agent: quilt/0.67
Date:   Thu, 23 Nov 2023 12:25:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [for-linus][PATCH 1/5] eventfs: Use GFP_NOFS for allocation when eventfs_mutex is held
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

If memory reclaim happens, it can reclaim file system pages. The file
system pages from eventfs may take the eventfs_mutex on reclaim. This
means that allocation while holding the eventfs_mutex must not call into
filesystem reclaim. A lockdep splat uncovered this.

Link: https://lkml.kernel.org/r/20231121231112.373501894@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 28e12c09f5aa0 ("eventfs: Save ownership and mode")
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 3eb6c622a74d..56d192f0ead8 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -95,7 +95,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
 		if (!ei->entry_attrs) {
 			ei->entry_attrs = kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
-						  GFP_KERNEL);
+						  GFP_NOFS);
 			if (!ei->entry_attrs) {
 				ret = -ENOMEM;
 				goto out;
@@ -627,7 +627,7 @@ static int add_dentries(struct dentry ***dentries, struct dentry *d, int cnt)
 {
 	struct dentry **tmp;
 
-	tmp = krealloc(*dentries, sizeof(d) * (cnt + 2), GFP_KERNEL);
+	tmp = krealloc(*dentries, sizeof(d) * (cnt + 2), GFP_NOFS);
 	if (!tmp)
 		return -1;
 	tmp[cnt] = d;
-- 
2.42.0


