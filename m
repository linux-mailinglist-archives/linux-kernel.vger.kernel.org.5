Return-Path: <linux-kernel+bounces-139619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D9D8A056F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71DD1C22994
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B12627E2;
	Thu, 11 Apr 2024 01:26:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8120360DD3;
	Thu, 11 Apr 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798786; cv=none; b=n3SPRQPdOzsDA/r4BS/ofxTuzXghLEcQFsmbVAvmzAt29sAqNapWT+N+G8TIyeWiTAGPFOpBYffO7POA4DTQK1H2r7e1Zw6cTIYFmuUF8fZwjJIXgjR7jD1meUGQonnTQU3+K0tjCkkQdg/qmslNsLPlo89Jx9hZNpgqOesGvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798786; c=relaxed/simple;
	bh=KPoDWQ9hvCZiBeldTjLP52gzqCk/sQ42RdM0IR1xDk0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=J8Hk5INFDvTzMT6RuGOcgRvWAEfnzsCEy0lh+P78QaK++AuJyeT0+U89WLxWmzYxwR2WYnUewXiDOCdtfwqu0Cux9IA4yQvnRJ5Htd+sQm/Hu73aHKyBzadsUB1zCdLss4CHwz/yF6eFfufNSWBVBspQpN2uW3qh35V2ZNLfCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01537C433F1;
	Thu, 11 Apr 2024 01:26:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rujFQ-00000000nTy-0sQj;
	Wed, 10 Apr 2024 21:29:04 -0400
Message-ID: <20240411012541.285904543@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 10 Apr 2024 21:25:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>
Subject: [PATCH v2 00/11] tracing: Persistent traces across a reboot or crash
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


This is a way to map a ring buffer instance across reboots.
The requirement is that you have a memory region that is not erased.
I tested this on a Debian VM running on qemu on a Debian server,
and even tested it on a baremetal box running Fedora. I was
surprised that it worked on the baremetal box, but it does so
surprisingly consistently.

I changed things up since the POC version (which this is no longer
a proof of concept, but now a serious patch set).

  https://lore.kernel.org/linux-trace-kernel/20240306015910.766510873@goodmis.org/

I got rid of the variables that needed to be set:

  trace_buffer_start and trace_buffer_size

The allocation of the mapping require a new interface (not in this
patch set yet, as it will be added for pstore or the wildcard
memmap that is under RFC). That is, either a new patch will be
added to connect pstore, or if the new wildcard memmap option is
accepted, it can be created with:

  memmap=12M*4096:trace  trace_instance=boot_mapped@trace

But that is to come later. If you want to test this code, I have
the command line version available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  branch: trace/ring-buffer-prealloc

The name of the instance no longer defined by the kernel but by
the calling code.

The memory reserved is used by the ring buffer of this instance.
It acts like a memory mapped instance so it has some limitations. It does not
allow snapshots nor does it allow tracers which use a snapshot buffer (like
irqsoff and wakeup tracers).

On boot up, when setting up the ring buffer, it looks at the current
content and does a vigorous test to see if the content is valid.
It even walks the events in all the sub-buffers to make sure the
ring buffer meta data is correct. If it determines that the content
is valid, it will reconstruct the ring buffer to use the content
it has found.

If the buffer is valid, on the next boot, the boot_mapped instance
will contain the data from the previous boot. You can cat the
trace or trace_pipe file, or even run trace-cmd extract on it to
make a trace.dat file that holds the date. This is much better than
dealing with a ftrace_dump_on_opps (I wish I had this a decade ago!)

There are still some limitations of this buffer. One is that it assumes
that the kernel you are booting back into is the same one that crashed.
At least the trace_events (like sched_switch and friends) all have the
same ids. This would be true with the same kernel as the ids are determined
at link time.

Module events could possible be a problem as the ids may not match.

This version of the patch series saves a text function and a data
string address in the persistent memory, and this is used to calculate
the delta between text and data addresses of the new boot up. Now
function tracing and "%pS" still work across boots. Even the RCU
trace events that point to static strings work as well!

The delta is exported by a new file in the instance called "last_boot_info"
that has something like this:

     # cat last_boot_info
     text delta:    -268435456
     data delta:    -268435456

This can be used by trace-cmd that reads the trace_pipe_raw data and
now can figure out how to map the print_formats and kallsyms to the raw
data in the buffers.

This is no longer a POC as it seems to be working as expected.

This is based on top of Vincent Donnefort's ring buffer user space mapping code:

  https://lore.kernel.org/linux-trace-kernel/20240406173649.3210836-1-vdonnefort@google.com/

Enjoy...


Steven Rostedt (Google) (11):
      ring-buffer: Allow mapped field to be set without mapping
      ring-buffer: Add ring_buffer_alloc_range()
      ring-buffer: Add ring_buffer_meta data
      tracing: Implement creating an instance based on a given memory region
      ring-buffer: Add output of ring buffer meta page
      ring-buffer: Add test if range of boot buffer is valid
      ring-buffer: Validate boot range memory events
      ring-buffer: Save text and data locations in mapped meta data
      tracing/ring-buffer: Add last_boot_info file to boot instance
      tracing: Handle old buffer mappings for event strings and functions
      tracing: Update function tracing output for previous boot buffer

----
 include/linux/ring_buffer.h |  20 ++
 kernel/trace/ring_buffer.c  | 837 ++++++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.c        | 167 ++++++++-
 kernel/trace/trace.h        |   7 +
 kernel/trace/trace_output.c |   9 +-
 5 files changed, 953 insertions(+), 87 deletions(-)

