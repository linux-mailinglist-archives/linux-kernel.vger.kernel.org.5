Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13799799605
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbjIIDXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjIIDXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:23:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4939E1FE5;
        Fri,  8 Sep 2023 20:23:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D55C433CA;
        Sat,  9 Sep 2023 03:23:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qeoZY-000Ycx-1C;
        Fri, 08 Sep 2023 23:23:48 -0400
Message-ID: <20230909032348.185808168@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Sep 2023 23:16:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Ajay Kaher <akaher@vmware.com>,
        Ching-lin Yu <chinglinyu@google.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [for-linus][PATCH 01/15] tracefs: Add missing lockdown check to tracefs_create_dir()
References: <20230909031615.047488015@goodmis.org>
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

The function tracefs_create_dir() was missing a lockdown check and was
called by the RV code. This gave an inconsistent behavior of this function
returning success while other tracefs functions failed. This caused the
inode being freed by the wrong kmem_cache.

Link: https://lkml.kernel.org/r/20230905182711.692687042@goodmis.org
Link: https://lore.kernel.org/all/202309050916.58201dc6-oliver.sang@intel.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ajay Kaher <akaher@vmware.com>
Cc: Ching-lin Yu <chinglinyu@google.com>
Fixes: bf8e602186ec4 ("tracing: Do not create tracefs files if tracefs lockdown is in effect")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index de5b72216b1a..3b8dd938b1c8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -673,6 +673,9 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
  */
 struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
 {
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	return __create_dir(name, parent, &simple_dir_inode_operations);
 }
 
-- 
2.40.1
