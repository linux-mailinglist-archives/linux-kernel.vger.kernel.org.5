Return-Path: <linux-kernel+bounces-74861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1351885DDAF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D781C237C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBEF80621;
	Wed, 21 Feb 2024 14:06:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ACE7F7FC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524400; cv=none; b=a4njMEfY0UIcz79nzxWfFUq6ec0AXv04f9xeNDz5DRnVaJxNhLpjMd6RkgmSqrcGb/GGVdk6FoGgtVVHyXflPg41DWDYaK0aZ1KrvWMAvdoNuItTYL+kDGpizLkHo/pl941seUlOnEvhzVX/U2QKcB/O/IjheSudIb1fsAFiZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524400; c=relaxed/simple;
	bh=kD7M7W5im/QqyD+BL+StSePiG4RjxVtgbKA8LCF5L70=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZYa2B0jqB5eXb6uU2XP9JNZl7V8D7UvAmlodLkf8xgj3W9rhpJDQs+5k9yU9GLotZgSyBRjNLGUzyFRIlTrbjus7GQivj70w6dXNIJ9gqjGqtlBqNSq0RuHJs0O0/0IuG39tN84xEQNwCOmnvstdEWnYbmzKWPX73AhYpNpHOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48A9C43609;
	Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rcnGu-00000002i9q-43P5;
	Wed, 21 Feb 2024 09:08:28 -0500
Message-ID: <20240221140828.828440398@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 21 Feb 2024 09:08:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 06/11] ring-buffer: Zero ring-buffer sub-buffers
References: <20240221140756.797572998@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

In preparation for the ring-buffer memory mapping where each subbuf will
be accessible to user-space, zero all the page allocations.

Link: https://lore.kernel.org/linux-trace-kernel/20240220202310.2489614-2-vdonnefort@google.com

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fd4bfe3ecf01..ca796675c0a1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1472,7 +1472,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
+					mflags | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1557,7 +1558,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -5525,7 +5527,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data)
 		goto out;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
+	page = alloc_pages_node(cpu_to_node(cpu),
+				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.43.0



