Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463C7768100
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjG2SeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2SeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF330FA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 11:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8908606A0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 18:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30666C433C7;
        Sat, 29 Jul 2023 18:34:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qPolh-0035Hq-04;
        Sat, 29 Jul 2023 14:34:21 -0400
Message-ID: <20230729183333.357029101@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 29 Jul 2023 14:33:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/7] tracing: A few more fixes for 6.5
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing fixes for 6.5:

- Fix to /sys/kernel/tracing/per_cpu/cpu*/stats read and entries.
  If a resize shrinks the buffer it clears the read count to notify
  readers that they need to reset. But the read count is also used for
  accounting and this causes the numbers to be off. Instead, create a
  separate variable to use to notify readers to reset.

- Fix the ref counts of the "soft disable" mode. The wrong value was
  used for testing if soft disable mode should be enabled or disable,
  but instead, just change the logic to do the enable and disable
  in place when the SOFT_MODE is set or cleared.

- Several kernel-doc fixes

- Removal of unused external declarations

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: dea499781a1150d285c62b26659f62fb00824fce


Gaosheng Cui (4):
      ring-buffer: Fix kernel-doc warnings in ring_buffer.c
      tracing/synthetic: Fix kernel-doc warnings in trace_events_synth.c
      tracing: Fix kernel-doc warnings in trace_events_trigger.c
      tracing: Fix kernel-doc warnings in trace_seq.c

YueHaibing (1):
      ftrace: Remove unused extern declarations

Zheng Yejian (2):
      ring-buffer: Fix wrong stat of cpu_buffer->read
      tracing: Fix warning in trace_buffered_event_disable()

----
 include/linux/ftrace.h              |  4 ----
 kernel/trace/ring_buffer.c          | 25 +++++++++++++------------
 kernel/trace/trace_events.c         | 14 ++++----------
 kernel/trace/trace_events_synth.c   |  1 +
 kernel/trace/trace_events_trigger.c |  2 ++
 kernel/trace/trace_seq.c            |  1 +
 6 files changed, 21 insertions(+), 26 deletions(-)
