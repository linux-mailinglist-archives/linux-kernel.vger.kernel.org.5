Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20AB78653B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbjHXCTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbjHXCSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3893CE6D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C590B633C6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462E0C433C8;
        Thu, 24 Aug 2023 02:18:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvx-001hWq-0g;
        Wed, 23 Aug 2023 22:18:53 -0400
Message-ID: <20230824021853.022987766@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sishuai Gong <sishuai.system@gmail.com>
Subject: [for-next][PATCH 13/14] tracefs: Avoid changing i_mode to a temp value
References: <20230824021812.938245293@goodmis.org>
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

From: Sishuai Gong <sishuai.system@gmail.com>

Right now inode->i_mode is updated twice to reach the desired value
in tracefs_apply_options(). Because there is no lock protecting the two
writes, other threads might read the intermediate value of inode->i_mode.

Thread-1			Thread-2
// tracefs_apply_options()	//e.g., acl_permission_check
inode->i_mode &= ~S_IALLUGO;
				unsigned int mode = inode->i_mode;
inode->i_mode |= opts->mode;

I think there is no need to introduce a lock but it is better to
only update inode->i_mode ONCE, so the readers will either see the old
or latest value, rather than an intermediate/temporary value.

Note, the race is not a security concern as the intermediate value is more
locked down than either the start or end version. This is more just to do
the conversion cleanly.

Link: https://lore.kernel.org/linux-trace-kernel/AB5B0A1C-75D9-4E82-A7F0-CF7D0715587B@gmail.com

Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index bb6de89eb446..c7a10f965602 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -310,6 +310,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	struct tracefs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = d_inode(sb->s_root);
 	struct tracefs_mount_opts *opts = &fsi->mount_opts;
+	umode_t tmp_mode;
 
 	/*
 	 * On remount, only reset mode/uid/gid if they were provided as mount
@@ -317,8 +318,9 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	 */
 
 	if (!remount || opts->opts & BIT(Opt_mode)) {
-		inode->i_mode &= ~S_IALLUGO;
-		inode->i_mode |= opts->mode;
+		tmp_mode = READ_ONCE(inode->i_mode) & ~S_IALLUGO;
+		tmp_mode |= opts->mode;
+		WRITE_ONCE(inode->i_mode, tmp_mode);
 	}
 
 	if (!remount || opts->opts & BIT(Opt_uid))
-- 
2.40.1
