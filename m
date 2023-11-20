Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC197F1E40
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjKTUy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjKTUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:54:48 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E76D9;
        Mon, 20 Nov 2023 12:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700513679;
        bh=Mwcrf7oCSr2SVBqlstcAk4xBZt9a0mnoM+Aqfdmqy4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=oYwtD125nVYe+W0MB6r2XUkNf2OqQfo1fdqm1SiyZ1g8prH/T3lehBW6dvqWaJxLg
         Ya4de9QXlqN5ZN+WKw7LNhiX+032moApXuo7G5jt7iCmg2H+STvj+x46s/uzM5nU6l
         iWsX/oOQx1ud0tfJmObypf9XhvuWlh6l/vF9T6VCyUB8uxSV+vKc8SCD6TutnciQpR
         /MVFp6Y7lVCQHd8SqoSBycvGvLrvk4pGX0xEU8d5ABjm77/Kw4hWtbCR7wN0DLZiXM
         0ZNkIhsgmq5ImQSC4KMj3kgLGtjL6AX60svcEAQtnXU1clDXSJx239MljyUiIc+wZk
         k9ro2z+tJWnjw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZ0B7031Nz1cX5;
        Mon, 20 Nov 2023 15:54:38 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v4 0/5] Faultable Tracepoints
Date:   Mon, 20 Nov 2023 15:54:13 -0500
Message-Id: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the system call tracepoints with Tasks Trace RCU to allow
the ftrace, perf, and eBPF tracers to handle page faults.

This series does the initial wire-up allowing tracers to handle page
faults, but leaves out the actual handling of said page faults as future
work.

I have tested this against a feature branch of lttng-modules which
implements handling of page faults for the filename argument of the
openat(2) system call.

This series is based on kernel v6.6.2.

Thanks,

Mathieu

Mathieu Desnoyers (5):
  tracing: Introduce faultable tracepoints (v4)
  tracing/ftrace: Add support for faultable tracepoints
  tracing/bpf-trace: add support for faultable tracepoints
  tracing/perf: add support for faultable tracepoints
  tracing: convert sys_enter/exit to faultable tracepoints

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>

 include/linux/tracepoint-defs.h | 14 +++++
 include/linux/tracepoint.h      | 88 ++++++++++++++++++++++---------
 include/trace/bpf_probe.h       | 21 ++++++--
 include/trace/define_trace.h    |  7 +++
 include/trace/events/syscalls.h |  4 +-
 include/trace/perf.h            | 27 ++++++++--
 include/trace/trace_events.h    | 73 ++++++++++++++++++++++++--
 init/Kconfig                    |  1 +
 kernel/trace/bpf_trace.c        | 10 +++-
 kernel/trace/trace_events.c     | 26 +++++++---
 kernel/trace/trace_fprobe.c     |  5 +-
 kernel/trace/trace_syscalls.c   | 92 +++++++++++++++++++++++----------
 kernel/tracepoint.c             | 58 +++++++++++----------
 13 files changed, 325 insertions(+), 101 deletions(-)

-- 
2.25.1

