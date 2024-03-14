Return-Path: <linux-kernel+bounces-103382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FF987BEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768871C2164A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DCD6FE36;
	Thu, 14 Mar 2024 14:21:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67CE6FE08
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426083; cv=none; b=CTSnqket8/36jmU93DPfFL4dAfy8IYIXeN6XKnXgamtz6BcPSn+sEEUxmvoOAYWiymxVk/8uQAC1IlUG+ug+UGG6gPQusPqflW73dr1KkKNtxcBH/A+SFsGfLezIwak8+ZKEfUkLiowRrOSaQMKfms3x9uO/ST6MCtrwz8tgfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426083; c=relaxed/simple;
	bh=1mgfHqHQOprRRjv3C2vVXdcd3tAm4IP5r+GoRG3Tj08=;
	h=Message-ID:Date:From:To:Cc:Subject; b=RjAJF71GAdfgw7samkzgsSAupK3lA3WwprbNDg8IFy1hyZ5kDT6VFz4pFe7cP5bTLjwhYBinlS7Sp/B04SL5zsd8HQcQdiGVuWaLf+/ge5mUEMYDZB3xR2h4Jd0TFXE3Of/S/rzldRytX1dgjQIUGj1e5pNw0LkWMAhCGAa4URA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B9DC433C7;
	Thu, 14 Mar 2024 14:21:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rklza-00000002dcU-2p5l;
	Thu, 14 Mar 2024 10:23:34 -0400
Message-ID: <20240314142301.170713485@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 14 Mar 2024 10:23:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/8] tracing: Final updates for 6.9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Chengming Zhou (1):
      tracefs: Remove SLAB_MEM_SPREAD flag usage

Huang Yiwei (1):
      tracing: Support to dump instance traces by ftrace_dump_on_oops

Steven Rostedt (Google) (4):
      tracepoints: Use WARN() and not WARN_ON() for warnings
      ring-buffer: Have mmapped ring buffer keep track of missed events
      net: hns3: tracing: fix hclgevf trace event strings
      tracing: Use strcmp() in __assign_str() WARN_ON() check

Thorsten Blum (1):
      tracing: Use div64_u64() instead of do_div()

linke li (1):
      ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment

----
 Documentation/admin-guide/kernel-parameters.txt    |  26 +++-
 Documentation/admin-guide/sysctl/kernel.rst        |  30 +++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |   8 +-
 fs/tracefs/inode.c                                 |   1 -
 include/linux/ftrace.h                             |   4 +-
 include/linux/kernel.h                             |   1 +
 include/linux/tracepoint.h                         |   6 +-
 include/trace/stages/stage6_event_callback.h       |   4 +-
 kernel/sysctl.c                                    |   4 +-
 kernel/trace/ring_buffer.c                         |  55 +++++++-
 kernel/trace/trace.c                               | 156 +++++++++++++++------
 kernel/trace/trace_benchmark.c                     |   5 +-
 kernel/trace/trace_selftest.c                      |   2 +-
 14 files changed, 233 insertions(+), 77 deletions(-)

