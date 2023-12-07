Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C63807EA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443071AbjLGChs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjLGChn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:37:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F2D4B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 18:37:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1632BC433C8;
        Thu,  7 Dec 2023 02:37:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rB4HK-00000001aMD-2rIq;
        Wed, 06 Dec 2023 21:38:18 -0500
Message-ID: <20231207023752.712829638@goodmis.org>
User-Agent: quilt/0.67
Date:   Wed, 06 Dec 2023 21:37:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/8] tracing: Updates for v6.7-rc4
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


tracing fixes for v6.7-rc4:

- Snapshot buffer issues

  1. When instances started allowing latency tracers, it uses
     a snapshot buffer (another buffer that is not written to
     but swapped with the main buffer that is). The snapshot buffer
     needs to be the same size as the main buffer. But when the
     snapshot buffers were added to instances, the code to make
     the snapshot equal to the main buffer still was only doing it
     for the main buffer and not the instances.

  2. Need to stop the current tracer when resizing the buffers.
     Otherwise there can be a race if the tracer decides to make
     a snapshot between resizing the main buffer and the snapshot
     buffer.

  3. When a tracer is "stopped" in disables both the main buffer
     and the snapshot buffer. This needs to be done for instances
     and not only the main buffer, now that instances also have
     a snapshot buffer.

- Buffered event for filtering issues

  When filtering is enabled, because events can be dropped often,
  it is quicker to copy the event into a temp buffer and write that
  into the main buffer if it is not filtered or just drop the event
  if it is, than to write the event into the ring buffer and then
  try to discard it. This temp buffer is allocated and needs special
  synchronization to do so. But there were some issues with that:

  1. When disabling the filter and freeing the buffer, a call to all
     CPUs is required to stop each per_cpu usage. But the code
     called smp_call_function_many() which does not include the
     current CPU. If the task is migrated to another CPU when it
     enables the CPUs via smp_call_function_many(), it will not enable
     the one it is currently on and this causes issues later on.
     Use on_each_cpu_mask() instead, which includes the current CPU.

   2. When the allocation of the buffered event fails, it can give
      a warning. But the buffered event is just an optimization
      (it's still OK to write to the ring buffer and free it).
      Do not WARN in this case.

   3. The freeing of the buffer event requires synchronization.
      First a counter is decremented to zero so that no new uses
      of it will happen. Then it sets the buffered event to NULL,
      and finally it frees the buffered event. There's a synchronize_rcu()
      between the counter decrement and the setting the variable to
      NULL, but only a smp_wmb() between that and the freeing of the
      buffer. It is theoretically possible that a user missed seeing
      the decrement, but will use the buffer after it is free. Another
      synchronize_rcu() is needed in place of that smp_wmb().

- ring buffer timestamps on 32 bit machines

  The ring buffer timestamp on 32 bit machines has to break the 64 bit
  number into multiple values as cmpxchg is required on it, and a
  64 bit cmpxchg on 32 bit architectures is very slow. The code use
  to just use two 32 bit values and make it a 60 bit timestamp where
  the other 4 bits were used as counters for synchronization. It later
  came known that the timestamp on 32 bit still need all 64 bits in
  some cases. So 3 words were created to handle the 64 bits. But issues
  arised with this:

   1. The synchronization logic still only compared the counter
      with the first two, but not with the third number, so the
      synchronization could fail unknowingly.

   2. A check on discard of an event could race if an event happened
      between the discard and updating one of the counters. The
      counter needs to be updated (forcing an absolute timestamp
      and not to use a delta) before the actual discard happens.


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: f458a1453424e03462b5bb539673c9a3cddda480


Petr Pavlu (3):
      tracing: Fix incomplete locking when disabling buffered events
      tracing: Fix a warning when allocating buffered events fails
      tracing: Fix a possible race when disabling buffered events

Steven Rostedt (Google) (5):
      tracing: Always update snapshot buffer size
      tracing: Stop current tracer when resizing buffer
      tracing: Disable snapshot buffer when stopping instance tracers
      ring-buffer: Force absolute timestamp on discard of event
      ring-buffer: Test last update in 32bit version of __rb_time_read()

----
 kernel/trace/ring_buffer.c |  23 +++----
 kernel/trace/trace.c       | 158 +++++++++++++++++----------------------------
 2 files changed, 69 insertions(+), 112 deletions(-)
