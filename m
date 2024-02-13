Return-Path: <linux-kernel+bounces-64518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDC3853FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7CA1F245B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD11634E5;
	Tue, 13 Feb 2024 23:13:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6763409
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865989; cv=none; b=nQZpoc/x8g5vhQym71XDFESfjGO/g7F2g3zKGQutw5WPh03pO0Ynid73UftjjYTIEIyNf0GLw13wy6/XVO7rX/9+jkOzTu92xULKj2IiXE+KAEUiOzyTTkGotMfbInb0lmAwAzWtQNtZPBbk9jN+PrLWA6noJGQzZJQlDZJY0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865989; c=relaxed/simple;
	bh=ssoPuwJUTM4lhFHGGkAyrbCY4tQcJe89rC0tr/nMwQc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=g62B7lLEI23zkeIUfyYiR+5fTFMjpGcylZrx8GTIJwWupLyL9EOWiXGw/DYaqAW4qZIfoQMmFggjT8GsxEx+QaJdLxBhr38X8xsfEjepljs0vSmQW3Pgupi0f9+WPNLd/iyanJb1q4CjbBW02xLbCtNvqDCoeElG3xk6MkC0gXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691CBC433F1;
	Tue, 13 Feb 2024 23:13:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1ra1z5-000000009Dr-2S9j;
	Tue, 13 Feb 2024 18:14:39 -0500
Message-ID: <20240213231413.726507543@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 13 Feb 2024 18:14:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: A couple of fixes for v6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Two tracing fixes for v6.8:

- Fix the #ifndef that didn't have CONFIG_ on HAVE_DYNAMIC_FTRACE_WITH_REGS
  The fix to have dynamic trampolines work with x86 broke arm64 as
  the config used in the #ifdef was HAVE_DYNAMIC_FTRACE_WITH_REGS and not
  CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS which removed the fix that the
  previous fix was to fix.

- Fix tracing_on state
  The code to test if "tracing_on" is set used ring_buffer_record_is_on()
  which returns false if the ring buffer isn't able to be written to.
  But the ring buffer disable has several bits that disable it.
  One is internal disabling which is used for resizing and other
  modifications of the ring buffer. But the "tracing_on" user space
  visibile flag should only report if tracing is actually on and not
  internally disabled, as this can cause confusion as writing "1"
  when it is disabled will not enable it.

  Instead use ring_buffer_record_is_set_on() which shows the user space
  visible settings.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: a6eaa24f1cc2c7aecec6047556bdfe32042094c3


Petr Pavlu (1):
      tracing: Fix HAVE_DYNAMIC_FTRACE_WITH_REGS ifdef

Sven Schnelle (1):
      tracing: Use ring_buffer_record_is_set_on() in tracer_tracing_is_on()

----
 kernel/trace/ftrace.c | 2 +-
 kernel/trace/trace.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

