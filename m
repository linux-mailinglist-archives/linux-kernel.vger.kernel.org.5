Return-Path: <linux-kernel+bounces-73195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4892085BF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137BAB222F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5366BFB8;
	Tue, 20 Feb 2024 14:49:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F4A4C60;
	Tue, 20 Feb 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440568; cv=none; b=ckPovDbskSujhNS5+rKWj60UQgh3XzcWQDZxCRRRP/H1umk1Ovf0OewxmCWwSvd2DG7odNG2d9wVr2R0r8SQQZ4THtEofpj0NNjRvfN47NLMCJ5gizBGfy8ZtNJg/dsPtlblSnFs9QcbsRWLdgTdRGOIoZxTGBeAFq5QfB/nEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440568; c=relaxed/simple;
	bh=a8t1iPdBa56JOkXzwJ9TrVm3w5eJG4iLEzNgpIdy/e8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TeXwDnhb0yW9GdUXCtHxxS6ZQD+hEyD9shNBiggy6R2JnaSdmz1JQmefJBQLH8gC8NrAaJJsymmOdwXf+059q/5Snyl/t8QNDLofY3XI2l7qM+TatWemGjEk4FPfl1kbGANlTGfwxV0JSHEJxlW1JdrxgWORbVK+T2UD/+DD1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733EAC433C7;
	Tue, 20 Feb 2024 14:49:27 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:51:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Do not let subbuf be bigger than write mask
Message-ID: <20240220095112.77e9cb81@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The data on the subbuffer is measured by a write variable that also
contains status flags. The counter is just 20 bits in length. If the
subbuffer is bigger than then counter, it will fail.

Make sure that the subbuffer can not be set to greater than the counter
that keeps track of the data on the subbuffer.

Fixes: 2808e31ec12e5 ("ring-buffer: Add interface for configuring trace sub buffer size")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index aa54266f5e1f..3852f3b001cc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5878,6 +5878,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
 
+	/* Size of a subbuf cannot be greater than the write counter */
+	if (psize > RB_WRITE_MASK + 1)
+		return -EINVAL;
+
 	old_order = buffer->subbuf_order;
 	old_size = buffer->subbuf_size;
 
-- 
2.43.0


