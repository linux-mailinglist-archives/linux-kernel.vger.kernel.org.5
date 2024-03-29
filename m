Return-Path: <linux-kernel+bounces-124970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB7892077
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84F9B27B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967611ACBA9;
	Fri, 29 Mar 2024 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHzsGqs+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D665216CCFC;
	Fri, 29 Mar 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716526; cv=none; b=M6z8+LNVet3HZwX55v7RMILm0ZDp3/nKU71R55UL3COryT8Ixzw+yRuwTzRZwm9JSKj7XjGX3abPNmGUFaR+xMjo8P+5N9FXyxLAdObE86KAFO7W0UX4QEFNxezV9BCXqPs23pJfxNDqSLiYrfBxtfPL10D/uYK0bqeJWcfOERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716526; c=relaxed/simple;
	bh=tMQO/fg27rjZSTpk5zwZgWbnqjoNr/uW+lcI/B8sdCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KS4v3LfynYMmAc1GC4HtsmeeSSJaF76O4nOkcSMpkzy/p6GDXixAC/NYcbQMR2LWbrvKsWKzCzkvzSyj1IwGVt0uSu9F8VXADm9i2No/KKyNIULhFgpGdHYkIcFeny0EEYxGugFHXpABSTcfcdoVeEmV1NAUTStHhQ3GNAnM6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHzsGqs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E8FC433F1;
	Fri, 29 Mar 2024 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716526;
	bh=tMQO/fg27rjZSTpk5zwZgWbnqjoNr/uW+lcI/B8sdCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHzsGqs+o2FvnJotNDeYEaxBktZhIzkA/YEyUVLGfkaCD94W648l9SF2cw5UPCYoO
	 D5TacyY8lHiz8k1T/fXDixdPe3gCepQXxuDaI/hSIupdV6ffBIkWIbdw2+raXX9ziI
	 yFKrUfh0ghuLy6IA3Pa0uul4+cJ48VcPyXmRpaGkWteiPAwvfqhNIe1LSRTzy5I7RL
	 Z5qnUxAXwpWjSxQhCM1azcJBzJF+11eNMW+VHPeegiJ6vwqvKH4Wz9aiAoVKR9UFa6
	 uSKTPyzwLE+BRbUf99u3svL3BbS2JuTVkgpkcqejR/kaxNxdXkbS7WFt7aGi+VSMUq
	 0kkc03u48VbpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: linke li <lilinke99@qq.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 34/34] ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment
Date: Fri, 29 Mar 2024 08:47:35 -0400
Message-ID: <20240329124750.3092394-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index d9bed77f96c1f..2b46c66fb132d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4343,7 +4343,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	cpu_buffer = iter->cpu_buffer;
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
-	commit_page = cpu_buffer->commit_page;
+	commit_page = READ_ONCE(cpu_buffer->commit_page);
 	commit_ts = commit_page->page->time_stamp;
 
 	/*
-- 
2.43.0


