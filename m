Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5407FC892
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376348AbjK1VJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376360AbjK1VIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:08:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9DA1FD7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85605C433CA;
        Tue, 28 Nov 2023 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205651;
        bh=NZTUjgALiPLwrAMWsEPQcegs3qq/KyxR2XaZBz8ElsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0QQzIz8FpEYGTh3oBhUStNoisS9QBKSOPc1SqP60S4hzZeS4I3/f+mgwHvwvY5yR
         PsFAg6L7lZgYUdnSTUor5O1Uqe/ktA2R2G/nVgGmQqbOMv2c4RZhOUCCqgJVCKeuX2
         GM4o5o30gg6FyFXNj071XRzD+IykrO3xeJuvXwktY78oBbTfXvFa3fERkXSRRltbqp
         uCq/K/E1/99yzRpBb0mVHxUCOVEHEvwQk8G3BbpBDnlqub5oCFhbDnAxAr0Zu6tRLr
         xBt8GrKCGlrO0nJV34O4EJlQrE2JADAFsd8U3qywfKW/8ZxBxdeFIGauaBSUc1jMyk
         QRtd+VeBRZKyw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 35/40] eventfs: Do not allow NULL parent to eventfs_start_creating()
Date:   Tue, 28 Nov 2023 16:05:41 -0500
Message-ID: <20231128210615.875085-35-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit fc4561226feaad5fcdcb55646c348d77b8ee69c5 ]

The eventfs directory is dynamically created via the meta data supplied by
the existing trace events. All files and directories in eventfs has a
parent. Do not allow NULL to be passed into eventfs_start_creating() as
the parent because that should never happen. Warn if it does.

Link: https://lkml.kernel.org/r/20231121231112.693841807@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/tracefs/inode.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 891653ba9cf35..0292c6a2bed9f 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -509,20 +509,15 @@ struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 	int error;
 
+	/* Must always have a parent. */
+	if (WARN_ON_ONCE(!parent))
+		return ERR_PTR(-EINVAL);
+
 	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
 			      &tracefs_mount_count);
 	if (error)
 		return ERR_PTR(error);
 
-	/*
-	 * If the parent is not specified, we create it in the root.
-	 * We need the root dentry to do this, which is in the super
-	 * block. A pointer to that is in the struct vfsmount that we
-	 * have around.
-	 */
-	if (!parent)
-		parent = tracefs_mount->mnt_root;
-
 	if (unlikely(IS_DEADDIR(parent->d_inode)))
 		dentry = ERR_PTR(-ENOENT);
 	else
-- 
2.42.0

