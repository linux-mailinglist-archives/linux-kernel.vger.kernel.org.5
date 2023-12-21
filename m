Return-Path: <linux-kernel+bounces-8725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E481BB82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82041288FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E6655E62;
	Thu, 21 Dec 2023 16:09:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E455E4D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C032C433C8;
	Thu, 21 Dec 2023 16:09:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rGLdW-000000041G5-1XeU;
	Thu, 21 Dec 2023 11:11:02 -0500
Message-ID: <20231221161024.478795180@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 21 Dec 2023 11:10:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/16] tracing: Add dynamic sub-buffer size for 6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 3cb3091138ca0921c4569bcf7ffa062519639b6a


Steven Rostedt (Google) (11):
      ring-buffer: Clear pages on error in ring_buffer_subbuf_order_set() failure
      ring-buffer: Do no swap cpu buffers if order is different
      ring-buffer: Make sure the spare sub buffer used for reads has same size
      tracing: Update snapshot order along with main buffer order
      tracing: Stop the tracing while changing the ring buffer subbuf size
      ring-buffer: Keep the same size when updating the order
      ring-buffer: Just update the subbuffers when changing their allocation order
      ring-buffer: Add documentation on the buffer_subbuf_order file
      ringbuffer/selftest: Add basic selftest to test changing subbuf order
      tracing: Update subbuffer with kilobytes not page order
      ring-buffer: Use subbuf_order for buffer page masking

Tzvetomir Stoyanov (VMware) (5):
      ring-buffer: Have ring_buffer_print_page_header() be able to access ring_buffer_iter
      ring-buffer: Page size per ring buffer
      ring-buffer: Add interface for configuring trace sub buffer size
      ring-buffer: Set new size of the ring buffer sub page
      ring-buffer: Read and write to ring buffers with custom sub buffer size

----
 Documentation/trace/ftrace.rst                     |  21 +
 include/linux/ring_buffer.h                        |  17 +-
 kernel/trace/ring_buffer.c                         | 428 ++++++++++++++++-----
 kernel/trace/ring_buffer_benchmark.c               |  10 +-
 kernel/trace/trace.c                               | 155 +++++++-
 kernel/trace/trace.h                               |   1 +
 kernel/trace/trace_events.c                        |  59 ++-
 .../test.d/00basic/ringbuffer_subbuf_size.tc       |  95 +++++
 8 files changed, 658 insertions(+), 128 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc

