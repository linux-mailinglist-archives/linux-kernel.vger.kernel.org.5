Return-Path: <linux-kernel+bounces-124809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980A891CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D864A283163
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4213199E9F;
	Fri, 29 Mar 2024 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAKG0q8S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE6199E8E;
	Fri, 29 Mar 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716172; cv=none; b=OsMdZlYDTrWrNm+MPZgRRYi2Lpk+V6/NfYKN3pqed3VMvm3TJV1/CWnfOD4FJpLDF9psVWjhYB4dbonAZSWXV8CsuIfsZ9+oneKDGuFPt5dCPMyBgnK4jCp866kIunWVQ7i2OBFr1+quc1FxkQKvVY586/68N539t2qRxycJDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716172; c=relaxed/simple;
	bh=cHQxS9eKOaxd8Sh2UiR3ItlynHa0OS46OHcIPltCVeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLx7VOpFGQvkdQ29Eor9H2lnmMSqdEXzA5nW2bLMs+H049N6+2kKjzdK+/pVSSd3EyQ+3RmuXSKHt5B5T6o7Wj14oNDH+DyYRdKkx5pNFisMXFRHIzAZc2LpkzEol2G50Bxzh9ZQTZJzNrZVsetut/Jb0SuqayHSJjWaBZqmze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAKG0q8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC108C43399;
	Fri, 29 Mar 2024 12:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716172;
	bh=cHQxS9eKOaxd8Sh2UiR3ItlynHa0OS46OHcIPltCVeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAKG0q8Sjmjfsl+b1D2/nIaVHURz/wo5LLe6LtEuQLxrkZUaivpxqfdXMDhsI18su
	 3PIe4JpXZ28qu9Ve4nH7sU4oOcgMD0EfpP4mger6C77UV7tOe2uc7uSGZyRfC7pANn
	 AN36698+VQNxxoRfTi3A6KKEH6964g/0rwvKsc4T18Naryv3h3BN9/tHKMi6dhNI9l
	 ns/az+xG5bMVePP+NOXhklUGJOPvADLrRj5i9L7pNvLGPWJIJn9PoMoCboznqTPwUz
	 1n2QnlSFJr3k735NTlDxDjDOG4urplGFzJUWe3XJ2zrW/JvPlyDL12l8xetasguyg3
	 UlUeG5hJJIdTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: linke li <lilinke99@qq.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 98/98] ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment
Date: Fri, 29 Mar 2024 08:38:09 -0400
Message-ID: <20240329123919.3087149-98-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index aa332ace108b1..54410c8cacbe8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4350,7 +4350,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	cpu_buffer = iter->cpu_buffer;
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
-	commit_page = cpu_buffer->commit_page;
+	commit_page = READ_ONCE(cpu_buffer->commit_page);
 	commit_ts = commit_page->page->time_stamp;
 
 	/*
-- 
2.43.0


