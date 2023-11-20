Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA47F1E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjKTUgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjKTUgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:36:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211ACD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:36:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2022BC433C8;
        Mon, 20 Nov 2023 20:36:10 +0000 (UTC)
Date:   Mon, 20 Nov 2023 15:36:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, mark.rutland@arm.com, lkft@linaro.org
Subject: Re: selftests: ftrace: WARNING: __list_del_entry_valid_or_report
 (lib/list_debug.c:62 (discriminator 1))
Message-ID: <20231120153623.49c5119b@gandalf.local.home>
In-Reply-To: <20231116123016.140576-1-naresh.kamboju@linaro.org>
References: <20231116123016.140576-1-naresh.kamboju@linaro.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu, 16 Nov 2023 18:00:16 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Following kernel crash noticed while running selftests: ftrace on arm64 Juno-r2
> device running stable-rc linux-6.6.y kernel.
> 
> This kernel crash is hard to reproduce.
> 

Can you test this patch.

Note, there's a similar bug on 6.7-rc1 which I'll fix first. And when
that's accepted, I'll push this one for v6.6. This may be two patches as
one if the d_invalidate() issue, and another is a memory leak fix.

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5fcfb634fec2..b60048469df1 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -289,6 +289,8 @@ void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 		ef = dentry->d_fsdata;
 		if (ef)
 			free_ef(ef);
+		else
+			kfree(ei);
 		return;
 	}
 
@@ -342,7 +344,6 @@ static void eventfs_post_create_dir(struct eventfs_file *ef)
 static struct dentry *
 create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
 {
-	bool invalidate = false;
 	struct dentry *dentry;
 
 	mutex_lock(&eventfs_mutex);
@@ -387,23 +388,24 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
 			eventfs_post_create_dir(ef);
 		dentry->d_fsdata = ef;
 	} else {
-		/* A race here, should try again (unless freed) */
-		invalidate = true;
-
 		/*
+		 * If we are here then the directory is being freed.
+		 * The simple_recursive_removal() will get rid of the dentry
+		 * here.
+		 */
+		dentry = NULL;
+		 /*
 		 * Should never happen unless we get here due to being freed.
 		 * Otherwise it means two dentries exist with the same name.
 		 */
 		WARN_ON_ONCE(!ef->is_freed);
 	}
 	mutex_unlock(&eventfs_mutex);
-	if (invalidate)
-		d_invalidate(dentry);
 
-	if (lookup || invalidate)
+	if (lookup)
 		dput(dentry);
 
-	return invalidate ? NULL : dentry;
+	return dentry;
 }
 
 static bool match_event_file(struct eventfs_file *ef, const char *name)
-- 
2.42.0

