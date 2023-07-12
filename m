Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E1675131C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjGLWBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGLWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADCE1FD8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:00:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7050F61926
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FD3C433C8;
        Wed, 12 Jul 2023 22:00:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qJhtI-000Qhi-2n;
        Wed, 12 Jul 2023 18:00:56 -0400
Message-ID: <20230712215044.496021196@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Jul 2023 17:50:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: Some more fixes for 6.5
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing fixes for 6.5:

- Update to fix of prototypes (my merge of Arnd's patch caused another
  warning).

- Add selftest to struct sizes for user events

- Quiet false positive of FORTIFY_SOURCE
  Due to backward compatibilty, the structure used to save stack traces
  in the kernel had a fixed size of 8. This structure is exported to
  user space via the tracing format file. A change was made to allow
  more than 8 functions to be recorded, and user space now uses the
  size field to know how many functions are actually in the stack.
  But the structure still has size of 8 (even though it points into
  the ring buffer that has the required amount allocated to hold a
  full stack. This was fine until the fortifier noticed that the
  memcpy(&entry->caller, stack, size) was greater than the 8 functions
  and would complain at runtime about it. Hide this by using a pointer
  to the stack location on the ring buffer instead of using the address
  of the entry structure caller field.

- Fix a deadloop in reading trace_pipe that was caused by a mismatch
  between ring_buffer_empty() returning false which then asked to
  read the data, but the read code uses rb_num_of_entries() that
  returned zero, and causing a infinite "retry".

- Fix a warning caused by not using all pages allocated to store
  ftrace functions, where this can happen if the linker inserts a bunch of
  "NULL" entries, causing the accounting of how many pages needed
  to be off.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: bec3c25c247c4f88a33d79675a09e1644c9a3114


Arnd Bergmann (1):
      tracing: arm64: Avoid missing-prototype warnings

Beau Belgrave (1):
      selftests/user_events: Test struct size match cases

Steven Rostedt (Google) (1):
      tracing: Stop FORTIFY_SOURCE complaining about stack trace caller

Zheng Yejian (2):
      ring-buffer: Fix deadloop issue on reading trace_pipe
      ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()

----
 arch/arm64/include/asm/ftrace.h                |  4 +++
 arch/arm64/include/asm/syscall.h               |  3 ++
 arch/arm64/kernel/syscall.c                    |  3 --
 include/linux/ftrace.h                         |  9 ++++++
 kernel/trace/fgraph.c                          |  1 +
 kernel/trace/ftrace.c                          | 45 ++++++++++++++++++--------
 kernel/trace/ftrace_internal.h                 |  5 +--
 kernel/trace/ring_buffer.c                     | 24 ++++++++------
 kernel/trace/trace.c                           | 21 ++++++++++--
 kernel/trace/trace_kprobe_selftest.c           |  3 ++
 tools/testing/selftests/user_events/dyn_test.c | 12 +++++++
 11 files changed, 100 insertions(+), 30 deletions(-)
