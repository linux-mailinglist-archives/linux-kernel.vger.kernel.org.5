Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576267E1433
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjKEQBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKEQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:01:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D9EDE;
        Sun,  5 Nov 2023 08:01:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ECBC433C9;
        Sun,  5 Nov 2023 16:01:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1qzfZD-00000000CgE-1KNY;
        Sun, 05 Nov 2023 11:01:39 -0500
Message-ID: <20231105155630.925114107@goodmis.org>
User-Agent: quilt/0.67
Date:   Sun, 05 Nov 2023 10:56:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        <gregkh@linuxfoundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [v6.6][PATCH 0/5] tracing: Backport of eventfs fixes for v6.6
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

Friday before the merge window opened, I received a bug report
for the eventfs code that was in linux-next. I spent the next
5 days debugging it and not only fixing it, but it led to finding
other bugs in the code. Several of these other bugs happen to
also affect the 6.6 kernel.

The eventfs code was written in two parts to lower the complexity.
The first part added just the dynamic creation of the eventfs
file system and that was added to 6.6.

The second part went further and removed the one-to-one mapping between
dentry/inode and meta data, as all events have the same files. It replaced
the meta data for each file with callbacks, which caused quite a bit of
code churn.

As the merge window was already open, when I finished all the fixes
I just sent those fixes on top of the linux-next changes along with
my pull request. That means, there are 5 commits that are marked
stable (or should be marked for stable) that need to be applied to
6.6 but require a bit of tweaking or even a new way of implementing the fix!

After sending the pull request, I then checked out 6.6 an took those
5 changes and fixed them up on top of it. I ran them through all my
tests that I use to send to Linus.

So these should be as good as the versions of the patches in Linus's tree.
I waited until Linus pulled in those changes to send this series out.

-- Steve


Steven Rostedt (Google) (5):
      tracing: Have trace_event_file have ref counters
      eventfs: Remove "is_freed" union with rcu head
      eventfs: Save ownership and mode
      eventfs: Delete eventfs_inode when the last dentry is freed
      eventfs: Use simple_recursive_removal() to clean up dentries

----
 fs/tracefs/event_inode.c           | 288 +++++++++++++++++++++++--------------
 include/linux/trace_events.h       |   4 +
 kernel/trace/trace.c               |  15 ++
 kernel/trace/trace.h               |   3 +
 kernel/trace/trace_events.c        |  31 +++-
 kernel/trace/trace_events_filter.c |   3 +
 6 files changed, 231 insertions(+), 113 deletions(-)
