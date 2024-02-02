Return-Path: <linux-kernel+bounces-49094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD08465D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491001C22FD1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D9CC8C2;
	Fri,  2 Feb 2024 02:30:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786DBA48;
	Fri,  2 Feb 2024 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841004; cv=none; b=YZ2mMcNnxxjcLrxVkWgdyX5mfNj7nCUpKAUvPzWSpH6n4oE7y9B4nh63+h3rkINMAmYbi9lbs5EB1kPXBA3uliIlrCFxlIDjzepR8DCiZzOJDszb5h7e+4X3KIXikjFAeYr1NF4hbxaNqZvM8ZXtUnfWm1sB92l7zUBbALrFZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841004; c=relaxed/simple;
	bh=xGDj3nGkIf9G4tPuNhBHZGlYOdiazfs12CRgZPhGO4w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=K8xKM065BFtKVUjmY89nKWGfIRPH8CLzcWpt2UXUSnKF8xG4pxApi/xqWXp6jdonfp7fe9bekAymmFIQ/YtOv09ui98SW/5VtwOx2Ve0IoHQFTttgybGDUwufOne7KKdLJV6UHPzwUjFquhgg2aCsM33vm4X1yqfbAkW7Qu1OF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441DAC43394;
	Fri,  2 Feb 2024 02:30:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVjJu-00000005k6A-0vDf;
	Thu, 01 Feb 2024 21:30:22 -0500
Message-ID: <20240202023022.088387401@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 21:30:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 01/13] ring-buffer: Clean ring_buffer_poll_wait() error return
References: <20240202022959.515961549@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

The return type for ring_buffer_poll_wait() is __poll_t. This is behind
the scenes an unsigned where we can set event bits. In case of a
non-allocated CPU, we do return instead -EINVAL (0xffffffea). Lucky us,
this ends up setting few error bits (EPOLLERR | EPOLLHUP | EPOLLNVAL), so
user-space at least is aware something went wrong.

Nonetheless, this is an incorrect code. Replace that -EINVAL with a
proper EPOLLERR to clean that output. As this doesn't change the
behaviour, there's no need to treat this change as a bug fix.

Link: https://lore.kernel.org/linux-trace-kernel/20240131140955.3322792-1-vdonnefort@google.com

Cc: stable@vger.kernel.org
Fixes: 6721cb6002262 ("ring-buffer: Do not poll non allocated cpu buffers")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 13aaf5e85b81..fd4bfe3ecf01 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -944,7 +944,7 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			return -EINVAL;
+			return EPOLLERR;
 
 		cpu_buffer = buffer->buffers[cpu];
 		work = &cpu_buffer->irq_work;
-- 
2.43.0



