Return-Path: <linux-kernel+bounces-125002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05112891EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E211F26DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2C16DEBA;
	Fri, 29 Mar 2024 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV6ovQk3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75816DEAB;
	Fri, 29 Mar 2024 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716594; cv=none; b=lp1zsfih4qEJqmksjDkNgVhnTMRNaoueph+bBfJGkOcWb2lUmac/5RizTWiYCiEk54IC4GyI1lvMF2J98MdV+ZlXh73mL8cNS6RNQTz30RAxSzYzd+UOzSexXefUL5s4S9KEyygwl0puLxdDEXq7CuzTp6Yy+5FtfXbYkMt6Tio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716594; c=relaxed/simple;
	bh=Fi6yVVB6Z/n/Z3zZqPWLKyoNA00zs1e+JgIjJZ+Pwk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sL8epQr/h9jIg/IgXe7a/IMroG73i0My72cw/FJkZN7BQLqAO7Xm3tXnkZAirSWkKCBuOwvlX/KloxxQtMwZPFh+1Xw4wwRA/7vAhsBAuWAp/etXcuOOdHGupfS4GvUCZRIdYXN62DaZCW8L9BU5yukjGKg5iTO1pvlh56BgDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV6ovQk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB02C433F1;
	Fri, 29 Mar 2024 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716594;
	bh=Fi6yVVB6Z/n/Z3zZqPWLKyoNA00zs1e+JgIjJZ+Pwk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FV6ovQk3VvmF287IgU7LtnrqIHiAptc2cZCzJZLl1vV22ULsMuuMQ1uJRFu96Wr/0
	 EteM5Ja1byoA1H5RI4ctd1LiI32K8laU+wLokF8DgOt6nOQE7g3Da4lbuAvXqdxICv
	 LuCRRhrgBf05D/fvzKAlaLvI9Wr7HArL6lgIyk0t+ls4Vzvj3NfYw74rp+3ldjsp1Q
	 VlhZwHYhzmf99cWlmBDM9rZqmkqTaL70pUFhpFC0n3IypnN2XwRZuyNLmUN/YVK7al
	 KZfYPDDlo1SLAZ4FVNzyfQojPedwdcKyCcJfjRUOUgdQzu7PRbilEl3GGKSSOMOFkL
	 va4rmtA/fHpTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: linke li <lilinke99@qq.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 31/31] ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment
Date: Fri, 29 Mar 2024 08:48:48 -0400
Message-ID: <20240329124903.3093161-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 4a43b8846b49f..70b6cb6bfb56e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4184,7 +4184,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	cpu_buffer = iter->cpu_buffer;
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
-	commit_page = cpu_buffer->commit_page;
+	commit_page = READ_ONCE(cpu_buffer->commit_page);
 	commit_ts = commit_page->page->time_stamp;
 
 	/*
-- 
2.43.0


