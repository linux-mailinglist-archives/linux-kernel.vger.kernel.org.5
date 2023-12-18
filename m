Return-Path: <linux-kernel+bounces-4303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DEF817B23
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB84D2846E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE172050;
	Mon, 18 Dec 2023 19:42:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433B71451;
	Mon, 18 Dec 2023 19:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC713C433C8;
	Mon, 18 Dec 2023 19:42:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFJWZ-000000038ki-3IfJ;
	Mon, 18 Dec 2023 14:43:35 -0500
Message-ID: <20231218194247.018725743@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 18 Dec 2023 14:42:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 0/2] tracing: Replace final 64-bit cmpxchg with compare and update if available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


With the introduction of a389d86f7fd09 ("ring-buffer: Have nested events
still record running time stamp"), the timestamps required needing 64-bit
cmpxchg. As some architectures do no even have a 64-bit cmpxchg, the code
for 32-bit architectures used 3 32-bit words that represented the 64-bit
timestamp and this also required performing 3 32-bit cmpxchg where a single
64-bit would do.

While debugging the ring-buffer, it was found that the locations of 3 of the
4 cmpxchg() were actually causing bugs, and the code was restructured to
remove them! See:

     https://lore.kernel.org/linux-trace-kernel/20231211114420.36dde01b@gandalf.local.home
     https://lore.kernel.org/linux-trace-kernel/20231214222921.193037a7@gandalf.local.home
     https://lore.kernel.org/linux-trace-kernel/20231215081810.1f4f38fe@rorschach.local.home

The only remaining cmpcxhg() is in a slow path that gets hit if an interrupt
were to come in during the allocation of an event and itself would right an
event to the same buffer. The interrupted event would detect this, and use
the cmpxchg for two purposes. One was to know if the interrupt happened
before it allocated its space (where it can use the timestamp that was
found), and the other is to set the write_stamp back to matching the
before_stamp, where the event after the interrupted event would not need to
add an absolute timestamp (it's 8 bytes added to the ring buffer).

The first purpose of the cmpxchg could also be done with a simple compare.
The second purpose (avoiding the addition of the absolute timestamp)
requires the cmpxchg. Considering the complexity of the 32-bit version of
the 64-bit cmpxchg, avoiding an added absolute timestamp doesn't justify it.

The first patch replaces the last 64-bit cmpxchg() with a
rb_time_cmp_and_update() that will return true if the timestamp matches the
expected result. It will optionally update the timestamp with the "set"
parameter if cmpxchg is available.

The second patch removes the 32-bit version of the 64-bit cmpxchg and simply
does the compare. This also removes the complex logic of that code. The
difference now is that 32-bit architectures will have to add an absolute
timestamp to an event that follows an event that suffered the race
condition.


Changes since v1: https://lore.kernel.org/all/20231215165512.280088765@goodmis.org/

- Restructured the rb_time_cmpxchg() to work the same for both 64-bit
  and 32-bit.

- Fixed reading t->time to use local64_read() and not READ_ONCE().

Steven Rostedt (Google) (2):
      ring-buffer: Replace rb_time_cmpxchg() with rb_time_cmp_and_update()
      ring-buffer: Remove 32bit timestamp logic

----
 kernel/trace/ring_buffer.c | 262 +++++++++------------------------------------
 1 file changed, 53 insertions(+), 209 deletions(-)

