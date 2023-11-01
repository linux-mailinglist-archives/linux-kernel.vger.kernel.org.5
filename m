Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFB47DE798
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbjKAViH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbjKAViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:38:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA8119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:38:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1524C433C7;
        Wed,  1 Nov 2023 21:38:02 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qyIuX-00EdVy-2V;
        Wed, 01 Nov 2023 17:38:01 -0400
Message-ID: <20231101213718.381015321@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Nov 2023 17:37:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/12] tracing: Final (hopefully!) updates for v6.7
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 170fe9ddcde0cd3021a6b2207e0daad94c4388da


Steven Rostedt (Google) (12):
      tracing: Have trace_event_file have ref counters
      eventfs: Remove extra dget() in eventfs_create_events_dir()
      tracing: Have the user copy of synthetic event address use correct context
      eventfs: Fix kerneldoc of eventfs_remove_rec()
      eventfs: Remove "is_freed" union with rcu head
      eventfs: Have a free_ei() that just frees the eventfs_inode
      eventfs: Test for ei->is_freed when accessing ei->dentry
      eventfs: Save ownership and mode
      eventfs: Hold eventfs_mutex when calling callback functions
      eventfs: Delete eventfs_inode when the last dentry is freed
      eventfs: Remove special processing of dput() of events directory
      eventfs: Use simple_recursive_removal() to clean up dentries

----
 fs/tracefs/event_inode.c           | 427 +++++++++++++++++++++++++------------
 fs/tracefs/internal.h              |  29 ++-
 include/linux/trace_events.h       |   4 +
 include/linux/tracefs.h            |  43 ++++
 kernel/trace/trace.c               |  15 ++
 kernel/trace/trace.h               |   3 +
 kernel/trace/trace_events.c        |  31 ++-
 kernel/trace/trace_events_filter.c |   3 +
 kernel/trace/trace_events_synth.c  |   2 +-
 9 files changed, 413 insertions(+), 144 deletions(-)
