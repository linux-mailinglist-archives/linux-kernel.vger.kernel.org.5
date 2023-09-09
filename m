Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02CA799609
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbjIIDXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjIIDXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:23:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859D1FE3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:23:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF37C433C8;
        Sat,  9 Sep 2023 03:23:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qeoZY-000YcL-0U;
        Fri, 08 Sep 2023 23:23:48 -0400
Message-ID: <20230909031615.047488015@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Sep 2023 23:16:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/15] tracing: Fixes for 6.6
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing fixes for 6.6:

- Add missing LOCKDOWN checks for eventfs callers
  When LOCKDOWN is active for tracing, it causes inconsistent state
  when some functions succeed and others fail. 

- Use dput() to free the top level eventfs descriptor
  There was a race between accesses and freeing it.

- Fix a long standing bug that eventfs exposed due to changing timings
  by dynamically creating files. That is, If a event file is opened
  for an instance, there's nothing preventing the instance from being
  removed which will make accessing the files cause use-after-free bugs.

- Fix a ring buffer race that happens when iterating over the ring
  buffer while writers are active. Check to make sure not to read
  the event meta data if it's beyond the end of the ring buffer sub buffer.

- Fix the print trigger that disappeared because the test to create it
  was looking for the event dir field being filled, but now it has the
  "ef" field filled for the eventfs structure.

- Remove the unused "dir" field from the event structure.

- Fix the order of the trace_dynamic_info as it had it backwards for the
  offset and len fields for which one was for which endianess.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 595efe1079cd38a5b7d2762bf6d3bd94105bae0f


Naveen N Rao (1):
      selftests/ftrace: Fix dependencies for some of the synthetic event tests

Steven Rostedt (Google) (13):
      tracefs: Add missing lockdown check to tracefs_create_dir()
      tracefs/eventfs: Add missing lockdown checks
      tracefs/eventfs: Use dput to free the toplevel events directory
      tracing: Increase trace array ref count on enable and filter files
      tracing: Have tracing_max_latency inc the trace array ref count
      tracing: Have current_trace inc the trace array ref count
      tracing: Have option files inc the trace array ref count
      tracing: Have event inject files inc the trace array ref count
      tracefs/eventfs: Free top level files on removal
      ring-buffer: Do not attempt to read past "commit"
      tracing: Use the new eventfs descriptor for print trigger
      tracing: Remove unused trace_event_file dir field
      tracing/synthetic: Fix order of struct trace_dynamic_info

Zheng Yejian (1):
      ring-buffer: Avoid softlockup in ring_buffer_resize()

----
 fs/tracefs/event_inode.c                           | 56 +++++++++++++++--
 fs/tracefs/inode.c                                 |  5 +-
 fs/tracefs/internal.h                              |  5 +-
 include/linux/trace_events.h                       |  7 +--
 kernel/trace/ring_buffer.c                         |  7 +++
 kernel/trace/trace.c                               | 72 +++++++++++++++++++---
 kernel/trace/trace.h                               |  2 +
 kernel/trace/trace_events.c                        | 19 ++----
 kernel/trace/trace_events_inject.c                 |  3 +-
 .../trigger-synthetic-event-dynstring.tc           |  2 +-
 .../trigger-synthetic_event_syntax_errors.tc       |  2 +-
 11 files changed, 140 insertions(+), 40 deletions(-)
