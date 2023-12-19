Return-Path: <linux-kernel+bounces-5834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2F1819002
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EB91F249B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B838FA8;
	Tue, 19 Dec 2023 18:55:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176D38DFA;
	Tue, 19 Dec 2023 18:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481CBC433C7;
	Tue, 19 Dec 2023 18:55:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFfGV-00000003QzN-2fpf;
	Tue, 19 Dec 2023 13:56:27 -0500
Message-ID: <20231219185414.474197117@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 13:54:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v5 00/15] ring-buffer/tracing: Allow ring buffer to have bigger sub buffers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Note, this has been on my todo list since the ring buffer was created back
in 2008.

Tzvetomir last worked on this in 2021 and I need to finally get it in.

His last series was:

  https://lore.kernel.org/linux-trace-devel/20211213094825.61876-1-tz.stoyanov@gmail.com/

With the description of:

   Currently the size of one sub buffer page is global for all buffers and
   it is hard coded to one system page. The patch set introduces configurable
   ring buffer sub page size, per ring buffer. A new user space interface is
   introduced, which allows to change the sub page size of the ftrace buffer,
   per ftrace instance.

I'm pulling in his patches mostly untouched, except that I had to tweak
a few things to forward port them.

The issues I found I added as the last 7 patches to the series, and then
I added documentation and a selftest, and then changed the UI file
from buffer_subbuf_order to buffer_subbuf_size_kb.

Basically, events to the tracing subsystem are limited to just under a
PAGE_SIZE, as the ring buffer is split into "sub buffers" of one page
size, and an event can not be bigger than a sub buffer. This allows users
to change the size of a sub buffer by the order:

  echo 3 > /sys/kernel/tracing/buffer_subbuf_order

[
  last patch updates this to:

  echo 32 > /sys/kernel/tracing/buffer_subbuf_size_kb

]
  

Will make each sub buffer a size of 8 pages (32KB), allowing events to be
almost as big as 8 pages in size (sub buffers do have meta data on them as
well, keeping an event from reaching the same size as a sub buffer).

Changes since v4: https://lore.kernel.org/linux-trace-kernel/20231215175502.106587604@goodmis.org/

- Rebase on latest trace/core

- Fixed a kerneldoc issues reported by kernel test robot


Changes since v3: https://lore.kernel.org/all/20231213181737.791847466@goodmis.org/

- Rebase on trace/core:

  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=trace/core&id=59c28cc95f0a9f5556561e2416af4ecf86184b71

Changes since v2: https://lore.kernel.org/all/20231213021914.361709558@goodmis.org/

- Fixed up the subbuf tests to ignore multiple spaces after before the
  'buf' string (same fix as was done for the trace_marker test).

- This time include Cc'ing linux-trace-kernel :-p

Changes since v1: https://lore.kernel.org/all/20231210040448.569462486@goodmis.org/

- Add the last patch that changes the ABI from a file called:

  buffer_subbuf_order  to   buffer_subbuf_size_kb

  That is, I kept the old interface the same, but then added the last
  patch that converts the interface into the one that makes more sense.
  I like keeping this in the git history, especially because of the
  way the implemantion is.

- I rebased on top of trace/core in the:

    git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

- I made the tests a bit more advanced. Still a smoke test, but it
  now checks if the string written is the same as the string read.


