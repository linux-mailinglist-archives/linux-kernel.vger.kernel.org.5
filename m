Return-Path: <linux-kernel+bounces-109075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3462788145C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614A41C21180
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1234F88A;
	Wed, 20 Mar 2024 15:19:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568F4D9E4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947991; cv=none; b=uW9ziolpSZ8J7dZlrE3I/g4WhmL1tWsb2EPF57W5iXvrzkTrFy5uXVo1igMcGLrFo+VcAK8rwdfsoXUot5uWVT2bGkTrKsW9DEVX2j+UUhdxvBAr+VILBe/FTVCu8eXlH62WhFgcBFZU37ak8Ao1XgEykM4I4/rFtT5zqkYv5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947991; c=relaxed/simple;
	bh=w6Ct3C1JvPunEIqAGDEqVOnbhaD1962ZTtDotzWiW7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TzVTXEczcR5n7+R+k39j0QseiL144d7Lu0x04SBzHVDvi6JpA+cuNvJmJocqYonunGo9e4ZGbg3oAWZCLOzTjYW6AYhPwugiZBWYTz7MFSNr78h3xk03t93mJ1/QPZPv8lPdGXr5JQO29Fk+4OF/8TSSvkeNIo0uA0sMdO6Rlmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E012AC433F1;
	Wed, 20 Mar 2024 15:19:49 +0000 (UTC)
Date: Wed, 20 Mar 2024 11:22:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [GIT PULL] tracing/tools: Updates for v6.9
Message-ID: <20240320112214.01bc5339@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

[
  Note, the biggest change here is the restructuring of the Makefiles to
  warn about missing libraries that you asked us to do last merge window.
  It follows perf in which you don't have the libraries, you now get:

  Auto-detecting system features:
  ...                           libtraceevent: [ OFF ]
  ...                              libtracefs: [ OFF ]

  libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel
  libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
]

Updates to tools/tracing and verification for 6.9:

Tracing:

- Update makefiles for latency-collector and RTLA, using tools/build/
  makefiles like perf does, inheriting its benefits. For example, having a
  proper way to handle library dependencies.

- The timerlat tracer has an interface for any tool to use.  rtla timerlat
  tool uses this interface dispatching its own threads as workload. But,
  rtla timerlat could also be used for any other process. So, add 'rtla
  timerlat -U' option, allowing the timerlat tool to measure the latency of
  any task using the timerlat tracer interface.

Verification:

- Update makefiles for verification/rv, using tools/build/ makefiles like
  perf does, inheriting its benefits.  For example, having a proper way to
  handle dependencies.


Please pull the latest trace-tools-v6.9 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.9

Tag SHA1: 8f0b372605bfba01ab03a1201f93e655bc401fc5
Head SHA1: a23c05fd76cf4ad27e0c74f7a93e7b089e94a55c


Daniel Bristot de Oliveira (4):
      tools/tracing: Use tools/build makefiles on latency-collector
      tools/rtla: Use tools/build makefiles to build rtla
      tools/verification: Use tools/build makefiles on rv
      tools/rtla: Add -U/--user-load option to timerlat

----
 .../tools/rtla/common_timerlat_options.rst         |   6 +
 tools/tracing/latency/.gitignore                   |   5 +-
 tools/tracing/latency/Build                        |   1 +
 tools/tracing/latency/Makefile                     | 105 ++++++++--
 tools/tracing/latency/Makefile.config              |  30 +++
 tools/tracing/rtla/.gitignore                      |   7 +-
 tools/tracing/rtla/Build                           |   1 +
 tools/tracing/rtla/Makefile                        | 217 +++++++--------------
 tools/tracing/rtla/Makefile.config                 |  47 +++++
 tools/tracing/rtla/Makefile.rtla                   |  80 ++++++++
 tools/tracing/rtla/Makefile.standalone             |  26 +++
 tools/tracing/rtla/sample/timerlat_load.py         |  74 +++++++
 tools/tracing/rtla/src/Build                       |  11 ++
 tools/tracing/rtla/src/timerlat_hist.c             |  16 +-
 tools/tracing/rtla/src/timerlat_top.c              |  14 +-
 tools/verification/rv/.gitignore                   |   6 +
 tools/verification/rv/Build                        |   1 +
 tools/verification/rv/Makefile                     | 207 +++++++-------------
 tools/verification/rv/Makefile.config              |  47 +++++
 tools/verification/rv/Makefile.rv                  |  51 +++++
 tools/verification/rv/src/Build                    |   4 +
 21 files changed, 650 insertions(+), 306 deletions(-)
 create mode 100644 tools/tracing/latency/Build
 create mode 100644 tools/tracing/latency/Makefile.config
 create mode 100644 tools/tracing/rtla/Build
 create mode 100644 tools/tracing/rtla/Makefile.config
 create mode 100644 tools/tracing/rtla/Makefile.rtla
 create mode 100644 tools/tracing/rtla/Makefile.standalone
 create mode 100644 tools/tracing/rtla/sample/timerlat_load.py
 create mode 100644 tools/tracing/rtla/src/Build
 create mode 100644 tools/verification/rv/.gitignore
 create mode 100644 tools/verification/rv/Build
 create mode 100644 tools/verification/rv/Makefile.config
 create mode 100644 tools/verification/rv/Makefile.rv
 create mode 100644 tools/verification/rv/src/Build
---------------------------

