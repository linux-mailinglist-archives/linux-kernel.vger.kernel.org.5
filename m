Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2F76A4A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjGaXRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGaXRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACD41728
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E118461351
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1C0C433C8;
        Mon, 31 Jul 2023 23:17:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8P-003fJh-08;
        Mon, 31 Jul 2023 19:17:05 -0400
Message-ID: <20230731231634.031452225@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/15] tracing: Updates for v6.6
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/core

Head SHA1: 7c1130ea5cae215588e6d51242b877fd405e6c32


Ajay Kaher (9):
      eventfs: Implement tracefs_inode_cache
      tracefs: Rename and export some tracefs functions
      eventfs: Implement eventfs dir creation functions
      eventfs: Implement eventfs file add functions
      eventfs: Implement eventfs lookup, read, open functions
      eventfs: Implement functions to create files and dirs when accessed
      eventfs: Implement removal of meta data from eventfs
      eventfs: Move tracing/events to eventfs
      test: ftrace: Fix kprobe test for eventfs

Steven Rostedt (Google) (4):
      tracing: Add back FORTIFY_SOURCE logic to kernel_stack event structure
      tracing: Remove unnecessary copying of tr->current_trace
      tracing: Add free_trace_iter_content() helper function
      tracing: Require all trace events to have a TRACE_SYSTEM

Uros Bizjak (1):
      ring_buffer: Use try_cmpxchg instead of cmpxchg

Zheng Yejian (1):
      tracing: Set actual size after ring buffer resize

----
 fs/tracefs/Makefile                                |   1 +
 fs/tracefs/event_inode.c                           | 801 +++++++++++++++++++++
 fs/tracefs/inode.c                                 | 151 +++-
 fs/tracefs/internal.h                              |  29 +
 include/linux/trace_events.h                       |   1 +
 include/linux/tracefs.h                            |  23 +
 kernel/trace/ring_buffer.c                         |  20 +-
 kernel/trace/trace.c                               |  99 +--
 kernel/trace/trace.h                               |  12 +-
 kernel/trace/trace_entries.h                       |   2 +-
 kernel/trace/trace_events.c                        |  76 +-
 kernel/trace/trace_export.c                        |   9 +
 .../ftrace/test.d/kprobe/kprobe_args_char.tc       |   9 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   9 +-
 14 files changed, 1116 insertions(+), 126 deletions(-)
 create mode 100644 fs/tracefs/event_inode.c
 create mode 100644 fs/tracefs/internal.h
