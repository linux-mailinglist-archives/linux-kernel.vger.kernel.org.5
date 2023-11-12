Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2AE7E91C3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 18:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjKLRSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 12:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKLRSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 12:18:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6BD1FF6;
        Sun, 12 Nov 2023 09:18:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47788C433C7;
        Sun, 12 Nov 2023 17:18:19 +0000 (UTC)
Date:   Sun, 12 Nov 2023 12:18:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Milian Wolff <milian.wolff@kdab.com>, akaher@vmware.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [v6.6][PATCH] eventfs: Check for NULL ef in eventfs_set_attr()
Message-ID: <20231112121817.2713c150@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

The top level events directory dentry does not have a d_fsdata set to a
eventfs_file pointer. This dentry is still passed to eventfs_set_attr().
It can not assume that the d_fsdata is set. Check for that.

Link: https://lore.kernel.org/all/20231112104158.6638-1-milian.wolff@kdab.com/

Fixes: 9aaee3eebc91 ("eventfs: Save ownership and mode")
Reported-by: Milian Wolff <milian.wolff@kdab.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

Note: This only affects 6.6 as the code in 6.7 here was rewritten.
   I tested 6.7 and it does not have this bug.

 fs/tracefs/event_inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5fcfb634fec2..efbdc47c74dc 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -113,14 +113,14 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	mutex_lock(&eventfs_mutex);
 	ef = dentry->d_fsdata;
-	if (ef->is_freed) {
+	if (ef && ef->is_freed) {
 		/* Do not allow changes if the event is about to be removed. */
 		mutex_unlock(&eventfs_mutex);
 		return -ENODEV;
 	}
 
 	ret = simple_setattr(idmap, dentry, iattr);
-	if (!ret)
+	if (!ret && ef)
 		update_attr(ef, iattr);
 	mutex_unlock(&eventfs_mutex);
 	return ret;
-- 
2.42.0

