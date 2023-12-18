Return-Path: <linux-kernel+bounces-3670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F2816F55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EC01C23DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138C12877B;
	Mon, 18 Dec 2023 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQv1OeHb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38FD12875C;
	Mon, 18 Dec 2023 12:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8617CC433CB;
	Mon, 18 Dec 2023 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903643;
	bh=rKso6YWkWl1RNRQih0vmpvNpO29N4ATAAdlBKIb6p+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQv1OeHb3X4CQYY1ZxFnzEOSzFEcsA5kMzjvkBZKym5Bt43IVSAI8OxqF23MMYhxi
	 I4qyX87EK7MdApCOOLwz9iyo5mbhMJPAVAbz93SEycZVYq1V+VLKOoUxik4eAdv1oM
	 r6pS1GtfMJdI808JkoWDEhFW7Cyw51g7+yLu1hKIS4Lz00KAytTZhfSaIShfQAcRgw
	 +lCHR0xpLPCKoZxlROV8zFuZhHWeUu19qQuPRm5LtKO8BbGoWsCaz1F0HoDD6d1A98
	 4z2UWPsXIb+4pFYED7AhJ1BruOAX+nBnjokvs6JTLO3JT1afaDDYzLRLMmOULblqSH
	 OK+AuYh8dDCaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 6/6] ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI
Date: Mon, 18 Dec 2023 07:47:11 -0500
Message-ID: <20231218124713.1382373-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124713.1382373-1-sashal@kernel.org>
References: <20231218124713.1382373-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.302
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 712292308af2265cd9b126aedfa987f10f452a33 ]

As the ring buffer recording requires cmpxchg() to work, if the
architecture does not support cmpxchg in NMI, then do not do any recording
within an NMI.

Link: https://lore.kernel.org/linux-trace-kernel/20231213175403.6fc18540@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 320aa60664dc9..efa11c638c841 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2889,6 +2889,12 @@ rb_reserve_next_event(struct ring_buffer *buffer,
 	int nr_loops = 0;
 	u64 diff;
 
+	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
+	    (unlikely(in_nmi()))) {
+		return NULL;
+	}
+
 	rb_start_commit(cpu_buffer);
 
 #ifdef CONFIG_RING_BUFFER_ALLOW_SWAP
-- 
2.43.0


