Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0A7D190F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjJTW1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjJTW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:27:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997021A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:27:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400ABC433C9;
        Fri, 20 Oct 2023 22:27:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qtxxz-00AQYF-2w;
        Fri, 20 Oct 2023 18:27:39 -0400
Message-ID: <20231020222739.722516559@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Oct 2023 18:27:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [for-next][PATCH 1/6] eventfs: Use ERR_CAST() in eventfs_create_events_dir()
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

From: Nathan Chancellor <nathan@kernel.org>

When building with clang and CONFIG_RANDSTRUCT_FULL=y, there is an error
due to a cast in eventfs_create_events_dir():

  fs/tracefs/event_inode.c:734:10: error: casting from randomized structure pointer type 'struct dentry *' to 'struct eventfs_inode *'
    734 |                 return (struct eventfs_inode *)dentry;
        |                        ^
  1 error generated.

Use the ERR_CAST() function to resolve the error, as it was designed for
this exact situation (casting an error pointer to another type).

Link: https://lore.kernel.org/linux-trace-kernel/20231018-ftrace-fix-clang-randstruct-v1-1-338cb214abfb@kernel.org

Closes: https://github.com/ClangBuiltLinux/linux/issues/1947
Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1ccd100bc565..9f19b6608954 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -731,7 +731,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 		return NULL;
 
 	if (IS_ERR(dentry))
-		return (struct eventfs_inode *)dentry;
+		return ERR_CAST(dentry);
 
 	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
 	if (!ei)
-- 
2.42.0
