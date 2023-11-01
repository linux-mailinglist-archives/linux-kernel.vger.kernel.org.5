Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F427DE54E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbjKAR0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:26:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E15A6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:26:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20062C433C7;
        Wed,  1 Nov 2023 17:26:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qyEzR-00EZrW-04;
        Wed, 01 Nov 2023 13:26:49 -0400
Message-ID: <20231101172541.971928390@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Nov 2023 13:25:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 0/8] eventfs: Fixing dynamic creation
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes since v5: https://lore.kernel.org/all/20231031223326.794680978@goodmis.org/

This was originally based on:

  [PATCH] eventfs: Process deletion of dentry more thoroughly
  https://lore.kernel.org/linux-trace-kernel/20231031144703.71eef3a0@gandalf.local.home/

But Al Viro asked why I do not use use simple_recursive_removal()?
Which at first I thought I could not, but after playing with it
more I realized I could (with a little addition of dget()'s to
balance the dput()s). This simplifies the code. But to do this, it
really needs to be done *after* these changes. Hence, I moved that
patch to after this series and to handle this rebase, I'm reposting
all the patches and including the above mentioned patch at the end
and renamed to:

  eventfs: Use simple_recursive_removal() to clean up dentries

I hope this is the last series, as this *is* for this merge window!

Steven Rostedt (Google) (8):
      eventfs: Remove "is_freed" union with rcu head
      eventfs: Have a free_ei() that just frees the eventfs_inode
      eventfs: Test for ei->is_freed when accessing ei->dentry
      eventfs: Save ownership and mode
      eventfs: Hold eventfs_mutex when calling callback functions
      eventfs: Delete eventfs_inode when the last dentry is freed
      eventfs: Remove special processing of dput() of events directory
      eventfs: Use simple_recursive_removal() to clean up dentries

----
 fs/tracefs/event_inode.c | 420 ++++++++++++++++++++++++++++++++---------------
 fs/tracefs/internal.h    |  29 +++-
 include/linux/tracefs.h  |  43 +++++
 3 files changed, 357 insertions(+), 135 deletions(-)
