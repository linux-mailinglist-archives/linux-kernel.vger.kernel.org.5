Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B76792F97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjIEUI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbjIEUIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD7912C;
        Tue,  5 Sep 2023 13:08:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF22EC433BB;
        Tue,  5 Sep 2023 18:26:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qdalc-000zOi-0H;
        Tue, 05 Sep 2023 14:27:12 -0400
Message-ID: <20230905182711.899724045@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Sep 2023 14:26:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        kernel test robot <oliver.sang@intel.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [PATCH 2/2] tracefs/eventfs: Add missing lockdown checks
References: <20230905182607.505212458@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

All the eventfs external functions do not check if TRACEFS_LOCKDOWN was
set or not. This can caused some functions to return success while others
fail, which can trigger unexpected errors.

Add the missing lockdown checks.

Link: https://lore.kernel.org/all/202309050916.58201dc6-oliver.sang@intel.com/

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 237c6f370ad9..fa1a1679a886 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -491,6 +491,9 @@ struct dentry *eventfs_create_events_dir(const char *name,
 	struct tracefs_inode *ti;
 	struct inode *inode;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	if (IS_ERR(dentry))
 		return dentry;
 
@@ -538,6 +541,9 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
 	struct eventfs_inode *ei_parent;
 	struct eventfs_file *ef;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	if (!parent)
 		return ERR_PTR(-EINVAL);
 
@@ -569,6 +575,9 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 {
 	struct eventfs_file *ef;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	if (!ef_parent)
 		return ERR_PTR(-EINVAL);
 
@@ -606,6 +615,9 @@ int eventfs_add_events_file(const char *name, umode_t mode,
 	struct eventfs_inode *ei;
 	struct eventfs_file *ef;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return -ENODEV;
+
 	if (!parent)
 		return -EINVAL;
 
@@ -654,6 +666,9 @@ int eventfs_add_file(const char *name, umode_t mode,
 {
 	struct eventfs_file *ef;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return -ENODEV;
+
 	if (!ef_parent)
 		return -EINVAL;
 
-- 
2.40.1
