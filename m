Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B4B7E9131
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 15:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjKLO0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 09:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLO0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 09:26:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE252D57
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 06:26:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A2FC433C8;
        Sun, 12 Nov 2023 14:26:28 +0000 (UTC)
Date:   Sun, 12 Nov 2023 09:26:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     akaher@vmware.com, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org
Subject: Re: NULL pointer dereference regression when running `chmod -R
 root:tracing /sys/kernel/debug/tracing`
Message-ID: <20231112092626.5a93e49d@rorschach.local.home>
In-Reply-To: <20231112071439.188bcf4e@gandalf.local.home>
References: <20231105160139.660634360@goodmis.org>
        <20231112104158.6638-1-milian.wolff@kdab.com>
        <20231112071439.188bcf4e@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2023 07:14:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:
> > With 6.6.1 and 9aaee3eebc91dd9ccebf6b6bc8a5f59d04ef718b reverted,
> > the above `chmod` command works. With a normal 6.6.1 build, or re-applying
> > the patch again, the command fails and `dmesg` shows:  
> 
> Thanks for the report. I'll work on it on my way to Plumbers.

Can you test this patch?

Note, this code was rewritten for 6.7 so it probably doesn't affect
that tree, but I'm going to test to make sure, just in case.

Also, this shows I need to add a selftest to cover this case.

Thanks,

-- Steve

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
