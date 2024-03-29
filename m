Return-Path: <linux-kernel+bounces-124936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497D5891E05
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F1B1F2D904
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993C81A5D99;
	Fri, 29 Mar 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjMNluy3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED11A5D7F;
	Fri, 29 Mar 2024 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716453; cv=none; b=umSM+1WCyiBxbFgk6gMKHU8kHFW6BGwAEDQHCLXsjMbgjZAwUt9yYQEXIHJhO6tXC7uX101hISLBOVuu9d7s2aQpbd95ci+wFQ0f8Geo4uxo4V2biNBUdAx6GsOxR8OlX8O9a6onFdaMTmnc0wBf9/6uPM9XQUaUrXSnlgU9rR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716453; c=relaxed/simple;
	bh=/mV5g2u4Bgi3sJcKcC/duOfJ8yg/8UzMmXb6B1zUg2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsqXANjWCWVbKauEP3hEzP09J4g8Pp5PDKbGB0WIQF3sxxBmOk/vE/8rbQEE37+88AMWsvr7VTjQRVYzXWwm+X49JJB9WAx9G+sS6i8d5U1rCT73XqDEacKt1Jjp0ECcUTX6nZ45yOqYkJrHWpk4mYd2MqEFAYc0PsCq7Qpm49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjMNluy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8640C433A6;
	Fri, 29 Mar 2024 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716453;
	bh=/mV5g2u4Bgi3sJcKcC/duOfJ8yg/8UzMmXb6B1zUg2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjMNluy3d7NUA4pQVabD7zH6NDiqg6NQGA751XNQxFs/fDKhPYsdLcoyH2jXA2OwO
	 XCHxkTnTJRuCm2MZp5GFCVci9XjdggJNLOG09exBYaJ7x0nZOw+BqKH6g72Tm2y9cJ
	 mTbgfcG58KuaRaRKxh3IYC74SBRsYaopKh66gohXGDt6u+V+eNd+O2R1N1zwZ47aZ1
	 iiBvxSkkQ1qd3OGDxHSrV9tAmijHbpMqoenWkLhTPMZLVLUcbF76M2I5FxSufGu1Qy
	 0JlbROIYLTmOCg1pCsHSC2+ps22D65T1f6c/JMACPFhzMkYmUZUNv35LSACCTw7DI3
	 FAdKTHA3NttoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: linke li <lilinke99@qq.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 52/52] ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment
Date: Fri, 29 Mar 2024 08:45:46 -0400
Message-ID: <20240329124605.3091273-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index e019a9278794f..7ed92f311dc9b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4384,7 +4384,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	cpu_buffer = iter->cpu_buffer;
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
-	commit_page = cpu_buffer->commit_page;
+	commit_page = READ_ONCE(cpu_buffer->commit_page);
 	commit_ts = commit_page->page->time_stamp;
 
 	/*
-- 
2.43.0


