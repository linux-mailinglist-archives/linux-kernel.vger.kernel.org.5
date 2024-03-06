Return-Path: <linux-kernel+bounces-93211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FA2872C66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D022896C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17325DDD4;
	Wed,  6 Mar 2024 01:58:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269E7475;
	Wed,  6 Mar 2024 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690294; cv=none; b=OYMVrooHQZubeeUu/TCGz19I1n8IxTOff59nqFIM2cYq61e+SzEUWORiyjUIFTQbhQTXh41kgK7oZKJKzM4E4rtiA4EPGaInHQHUsFvQY+dwhQfb7069TfuCLy27MAZP5JrQiA7pwkQhYgajtAm/U3SJjWXsRKmUt909EL746H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690294; c=relaxed/simple;
	bh=N4Ees7iya5usqGesrtJuSIFeHK7U2bfQot6aaUcpFmA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=npI32z3JFixrYb9shdqkHty71uEozQj2CGjjnIdJJSDOUeOjrPxi7fvfts/vMoQaMMtKDCfDgrXyEHLhoVo2sXuiDd8HCCJYW3psnq8cHSA8vcErSKMObNQK8Fw6ZJ0f+VuelglXNj4WK6Eu3JQICZjPwvpGxM2u9R7vvshYe70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2A6C43390;
	Wed,  6 Mar 2024 01:58:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rhgZh-00000000T9u-1oSf;
	Tue, 05 Mar 2024 21:00:05 -0500
Message-ID: <20240306015910.766510873@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 05 Mar 2024 20:59:10 -0500
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
Subject: [PATCH 0/8] tracing: Persistent traces across a reboot or crash
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

The idea is that you can reserve a memory region and save it in two
special variables:

  trace_buffer_start and trace_buffer_size

If these are set by fs_initcall() then a "boot_mapped" instance
is created. The memory that was reserved is used by the ring buffer
of this instance. It acts like a memory mapped instance so it has
some limitations. It does not allow snapshots nor does it allow
tracers which use a snapshot buffer (like irqsoff and wakeup tracers).

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

One idea is to just print the raw fields and not process the print formats
for this instance, as the print formats may do some crazy things with
data that does not match.

Another limitation is any print format that has "%pS" will likely not work.
That's because the pointer in the old ring buffer is for an address that
may be different than the function points to now. I was thinking of
adding a file in the boot_mapped instance that holds the delta of the
old mapping to the new mapping, so that trace-cmd and perf could
calculate the current kallsyms from the old pointers.

Finally, this is still a proof of concept. How to create this memory
mapping isn't decided yet. In this patch set I simply hacked into
kexec crash code and hard coded an address that worked for one of my
machines (for the other machine I had to play around to find another
address). Perhaps we could add a kernel command line parameter that
lets people decided, or an option where it could possibly look at
the ACPI (for intel) tables to come up with an address on its own.

Anyway, I plan on using this for debugging, as it already is pretty
featureful but there's much more that can be done.

Basically, all you need to do is:

  echo 1 > /sys/kernel/tracing/instances/boot_mapped/events/enable

Do what ever you want and the system crashes (and boots to the same
kernel). Then:

  cat /sys/kernel/tracing/instances/boot_mapped/trace

and it will have the trace.

I'm sure there's still some gotchas here, which is why this is currently
still just a POC.

Enjoy...

Steven Rostedt (Google) (8):
      ring-buffer: Allow mapped field to be set without mapping
      ring-buffer: Add ring_buffer_alloc_range()
      tracing: Create "boot_mapped" instance for memory mapped buffer
      HACK: Hard code in mapped tracing buffer address
      ring-buffer: Add ring_buffer_meta data
      ring-buffer: Add output of ring buffer meta page
      ring-buffer: Add test if range of boot buffer is valid
      ring-buffer: Validate boot range memory events

----
 arch/x86/kernel/setup.c     |  20 ++
 include/linux/ring_buffer.h |  17 +
 include/linux/trace.h       |   7 +
 kernel/trace/ring_buffer.c  | 826 ++++++++++++++++++++++++++++++++++++++------
 kernel/trace/trace.c        |  95 ++++-
 kernel/trace/trace.h        |   5 +
 6 files changed, 856 insertions(+), 114 deletions(-)

