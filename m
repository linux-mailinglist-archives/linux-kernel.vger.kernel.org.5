Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77207D7A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjJZB2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjJZB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:27:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF71185
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:27:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C47AC43395;
        Thu, 26 Oct 2023 01:27:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qvpAA-00CqU5-05;
        Wed, 25 Oct 2023 21:27:54 -0400
Message-ID: <20231026012753.831438923@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Oct 2023 21:27:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 3/4] eventfs: Fix WARN_ON() in create_file_dentry()
References: <20231026012734.358814002@goodmis.org>
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

As the comment right above a WARN_ON() in create_file_dentry() states:

  * Note, with the mutex held, the e_dentry cannot have content
  * and the ei->is_freed be true at the same time.

But the WARN_ON() only has:

  WARN_ON_ONCE(ei->is_free);

Where to match the comment (and what it should actually do) is:

  dentry = *e_dentry;
  WARN_ON_ONCE(dentry && ei->is_free)

Also in that case, set dentry to NULL (although it should never happen).

Link: https://lore.kernel.org/linux-trace-kernel/20231024123628.62b88755@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 09ab93357957..4d2da7480e5f 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -264,8 +264,9 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
 		 * Note, with the mutex held, the e_dentry cannot have content
 		 * and the ei->is_freed be true at the same time.
 		 */
-		WARN_ON_ONCE(ei->is_freed);
 		dentry = *e_dentry;
+		if (WARN_ON_ONCE(dentry && ei->is_freed))
+			dentry = NULL;
 		/* The lookup does not need to up the dentry refcount */
 		if (dentry && !lookup)
 			dget(dentry);
-- 
2.42.0
