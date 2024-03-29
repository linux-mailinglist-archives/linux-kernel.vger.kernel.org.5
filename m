Return-Path: <linux-kernel+bounces-124884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC8C891F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C5F2B28908
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6668021C183;
	Fri, 29 Mar 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmHSoc6C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827B21C177;
	Fri, 29 Mar 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716343; cv=none; b=oAvFc3gKPN3//xWXjDagKiVMBkUBGZtHunLtPg/BLXloxReu3RZH82f9OUjWdO0NhQUm/5QaQZJiHoq6WnCIOXDjcBE+y5VIrlAgJ4/r3i9gu58BFcoYlXYDtLN9PmHdtWaJPP/Olwm8xKsqsrxPWSGTJG5ZetRsBebp2fx4YAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716343; c=relaxed/simple;
	bh=S7tMWHWPalm7jOEL4BvFLD+RrDQ085rm20ckplEMUdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMoy172OrAnFcHvtJTaG97X+ltjOu7B2Nzij0WkAiay9KN8/3jJ+sWAbsYsPHdgS4Gr0d7GbHfL7lvUBz4xDVl7cTaqDsO04Kbc0VnbD2CHyFdt/HaxJshphwpQjP/zBdFKiCOCmgP6vkNqecsPpZAr7PoYIy0kS8UclEuHtNpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmHSoc6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4217DC433F1;
	Fri, 29 Mar 2024 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716343;
	bh=S7tMWHWPalm7jOEL4BvFLD+RrDQ085rm20ckplEMUdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmHSoc6CSM0/PagqwgDD2HgoOaL9ZYA+s4Sl4njBYGFdbk2EPM6YA93LK7i92k1DE
	 RB5QZYNH+tvgP2KJ7nDi+c58MN0tOjsIDAuZP3UaZdBd6L5uSO/W+KOLHOyGvsa9tg
	 h/f9S3fgmiKcbXlVfhwfCaeBGMm+YDpELIJy3NF5/sRHLO/xP44ZOb19fHlDxL8YjV
	 F/sft7iPRpBQIDHbUkV3AWnid7OdSFwBG4stTfJpdOtH6H5oRtBfD8vCxnJmSyQGl7
	 bj10fD/NxhWTvGpnxkULxivhuLlYuDaOKyjqdeLdp6qnxcJ+4QKL11MvHXLjBV0d0+
	 E4jWpTRM8IVGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: linke li <lilinke99@qq.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 75/75] ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment
Date: Fri, 29 Mar 2024 08:42:56 -0400
Message-ID: <20240329124330.3089520-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: linke li <lilinke99@qq.com>

[ Upstream commit f1e30cb6369251c03f63c564006f96a54197dcc4 ]

In function ring_buffer_iter_empty(), cpu_buffer->commit_page is read
while other threads may change it. It may cause the time_stamp that read
in the next line come from a different page. Use READ_ONCE() to avoid
having to reason about compiler optimizations now and in future.

Link: https://lore.kernel.org/linux-trace-kernel/tencent_DFF7D3561A0686B5E8FC079150A02505180A@qq.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: linke li <lilinke99@qq.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1ac6637895a44..0d98e847fd6c2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4389,7 +4389,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	cpu_buffer = iter->cpu_buffer;
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
-	commit_page = cpu_buffer->commit_page;
+	commit_page = READ_ONCE(cpu_buffer->commit_page);
 	commit_ts = commit_page->page->time_stamp;
 
 	/*
-- 
2.43.0


