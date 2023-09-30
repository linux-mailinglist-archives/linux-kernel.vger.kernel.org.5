Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B37B4399
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjI3UhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjI3UhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:37:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E301C4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 13:37:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE71C433C7;
        Sat, 30 Sep 2023 20:37:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qmgjF-004Myu-1G;
        Sat, 30 Sep 2023 16:38:21 -0400
Message-ID: <20230930203213.826737400@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 30 Sep 2023 16:32:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: Fixes for v6.6-rc3
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing fixes for v6.6-rc3:

- Make sure 32 bit applications using user events have aligned access when
  running on a 64 bit kernel.

- Add cond_resched in the loop that handles converting enums in print_fmt
  string is trace events.

- Fix premature wake ups of polling processes in the tracing ring buffer. When
  a task polls waiting for a percentage of the ring buffer to be filled, the
  writer still will wake it up at every event. Add the polling's percentage to
  the "shortest_full" list to tell the writer when to wake it up.

- For eventfs dir lookups on dynamic events, an event system's only event could
  be removed, leaving its dentry with no children. This is totally legitimate.
  But on eventfs_release() it must not access the children array, as it is only
  allocated when the dentry has children.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 2598bd3ca8dcf5bbca1161ee5b271b432398da37


Beau Belgrave (1):
      tracing/user_events: Align set_bit() address for all archs

Clément Léger (1):
      tracing: relax trace_event_eval_update() execution with cond_resched()

Steven Rostedt (Google) (2):
      ring-buffer: Update "shortest_full" in polling
      eventfs: Test for dentries array allocated in eventfs_release()

----
 fs/tracefs/event_inode.c         |  2 +-
 kernel/trace/ring_buffer.c       |  3 +++
 kernel/trace/trace_events.c      |  1 +
 kernel/trace/trace_events_user.c | 58 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 8 deletions(-)
