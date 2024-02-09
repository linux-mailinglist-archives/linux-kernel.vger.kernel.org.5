Return-Path: <linux-kernel+bounces-59213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789A984F34C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094E61F22220
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E921C69DF1;
	Fri,  9 Feb 2024 10:22:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5B6997E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474140; cv=none; b=NvcEcPRJFJEEudK3c40mb1sJl7Sru3djYEzcFe47p80zurFPo9MLxfdCpuHo4sgBFIZCifppBL7ppO0duFu0jqwPrM1x59//NykLVHy4x8TVFIJCg0JeLNt/9rWIvb3DPeBUSUymkrB0MY2Hqq3s0I7s9uDYySBE/XObE0BYgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474140; c=relaxed/simple;
	bh=N1e1atRgXwaq/L5TMXa6EH0wBYUWwdIwD8g4qAp4gnY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=EqNk1wi1VWEiahKf6D+2jlF6ZjAhBLT5L8QS0xoDJy0t8iFsIQxuRxQDZn3FQwWxRVXxaS5Xe5e0C8KNnw9tryrApfugASuaEPAsTMyP0p5QISzT2JyRPzJLQrCcQkRXBJdKJ/CBbep5cWvC+3svH0hRlws1XvDQSSwf/9USO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D44C433C7;
	Fri,  9 Feb 2024 10:22:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rYO23-00000006pw1-18by;
	Fri, 09 Feb 2024 05:22:55 -0500
Message-ID: <20240209102220.255052617@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 09 Feb 2024 05:22:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: Fixes for v6.8-rc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Tracing fixes for v6.8-rc3:

- Fix broken direct trampolines being called when another callback is
  attached the same function. ARM 64 does not support FTRACE_WITH_REGS, and
  when it added direct trampoline calls from ftrace, it removed the
  "WITH_REGS" flag from the ftrace_ops for direct trampolines. This broke
  x86 as x86 requires direct trampolines to have WITH_REGS. This wasn't
  noticed because direct trampolines work as long as the function it is
  attached to is not shared with other callbacks (like the function tracer).
  When there's other callbacks, a helper trampoline is called, to call all
  the non direct callbacks and when it returns, the direct trampoline is
  called. For x86, the direct trampoline sets a flag in the regs field to
  tell the x86 specific code to call the direct trampoline. But this only
  works if the ftrace_ops had WITH_REGS set. ARM does things differently
  that does not require this. For now, set WITH_REGS if the arch supports
  WITH_REGS (which ARM does not), and this makes it work for both ARM64 and
  x86.

- Fix wasted memory in the saved_cmdlines logic.

  The saved_cmdlines is a cache that maps PIDs to COMMs that tracing can
  use. Most trace events only save the PID in the event. The saved_cmdlines
  file lists PIDs to COMMs so that the tracing tools can show an actual name
  and not just a PID for each event. There's an array of PIDs that map to a
  small set of saved COMM strings. The array is set to PID_MAX_DEFAULT which
  is usually set to 32768. When a PID comes in, it will add itself to this
  array along with the index into the COMM array (note if the system allows
  more than PID_MAX_DEFAULT, this cache is similar to cache lines as an
  update of a PID that has the same PID_MAX_DEFAULT bits set will flush out
  another task with the same matching bits set).

  A while ago, the size of this cache was changed to be dynamic and the
  array was moved into a structure and created with kmalloc(). But this
  new structure had the size of 131104 bytes, or 0x20020 in hex. As kmalloc
  allocates in powers of two, it was actually allocating 0x40000 bytes
  (262144) leaving 131040 bytes of wasted memory. The last element of this
  structure was a pointer to the COMM string array which defaulted to just
  saving 128 COMMS.

  By changing the last field of this structure to a variable length string,
  and just having it round up to fill the allocated memory, the default
  size of the saved COMM cache is now 8190. This not only uses the wasted
  space, but actually saves space by removing the extra allocation for the
  COMM names.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: f2d3d1fa979e0a8e418a03e96902a9e6b4a6e9ae


Masami Hiramatsu (Google) (1):
      ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default

Steven Rostedt (Google) (1):
      tracing: Fix wasted memory in saved_cmdlines logic

----
 kernel/trace/ftrace.c | 10 +++++++
 kernel/trace/trace.c  | 73 ++++++++++++++++++++++++---------------------------
 2 files changed, 44 insertions(+), 39 deletions(-)

