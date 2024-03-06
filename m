Return-Path: <linux-kernel+bounces-94437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 227CC873FD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8162B238D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23313E7D7;
	Wed,  6 Mar 2024 18:41:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBF136647
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750509; cv=none; b=gQNJIFDVUTrvj43jds2DwtSu0XjubyynjaFFPzQ032NPkgPrPraFodom5oNO2R05NkxaJl8/lhEA3Or+b80XQ1WsOiDZjKs20fleaBDQRzXwu7j7IJNC9BbZbW+D5h53v7H65u0hNRsn88e1LQNIUUDrnnwnH5HG3uW+JsMWSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750509; c=relaxed/simple;
	bh=rh3NBCsWYsDUflpMZYfEWR9/FWHXtIuVhRGaRqvFENo=;
	h=Message-ID:Date:From:To:Cc:Subject; b=dK9d0/Ab6/RBmCJh5Rd5vKVgAO5vcl9zMgV1Npg+cSOt7pdLcXoWlJdMCS1+y+ptd3pKc+XgNbkz7ne2/+EZDOqwEG/EBfxUfQilv170uRxxRXof89evFHHyc3m+pqNtbpijeIqJg0QK89Q4JFxTeRH4YPeDrrn84Jl7Eu7OKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6365AC433C7;
	Wed,  6 Mar 2024 18:41:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rhwEw-00000000Y9E-1okx;
	Wed, 06 Mar 2024 13:43:42 -0500
Message-ID: <20240306184244.754263547@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 06 Mar 2024 13:42:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: Fixes for v6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Tracing fixes for v6.8-rc7:

- The size of a string written into trace_marker was determined by
  the size of the sub-buffer in the ring buffer. That size is
  dependent on the PAGE_SIZE of the architecture as it can be mapped
  into user space. But on PowerPC, where PAGE_SIZE is 64K, that made
  the limit of the string of writing into trace_marker 64K.

  One of the selftests looks at the size of the ring buffer sub-buffers
  and writes that plus more into the trace_marker. The write will take
  what it can and report back what it consumed so that the user space
  application (like echo) will write the rest of the string. The string
  is stored in the ring buffer and can be read via the "trace" or
  "trace_pipe" files.

  The reading of the ring buffer uses vsnprintf(), which uses a precision
  "%.*s" to make sure it only reads what is stored in the buffer, as
  a bug could cause the string to be non terminated.

  With the combination of the precision change and the PAGE_SIZE of 64K
  allowing huge strings to be added into the ring buffer, plus the test
  that would actually stress that limit, a bug was reported that
  the precision used was too big for "%.*s" as the string was close to
  64K in size and the max precision of vsnprintf is 32K.

  Linus suggested not to have that precision as it could hide a bug
  if the string was again stored without a nul byte.

  Another issue that was brought up is that the trace_seq buffer is
  also based on PAGE_SIZE even though it is not tied to the architecture
  limit like the ring buffer sub-buffer is. Having it be 64K * 2 is
  simply just too big and wasting memory on systems with 64K page sizes.
  It is now hardcoded to 8K which is what all other architectures with
  4K PAGE_SIZE has.

  Finally, the write to trace_marker is now limited to 4K as there is no
  reason to write larger strings into trace_marker.

Steven Rostedt (Google) (3):
      tracing: Remove precision vsnprintf() check from print event
      tracing: Limit trace_seq size to just 8K and not depend on architecture PAGE_SIZE
      tracing: Limit trace_marker writes to just 4K

----
 include/linux/trace_seq.h   |  8 +++++++-
 kernel/trace/trace.c        | 10 +++++-----
 kernel/trace/trace_output.c |  6 ++----
 3 files changed, 14 insertions(+), 10 deletions(-)

