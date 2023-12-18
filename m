Return-Path: <linux-kernel+bounces-3664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7F9816F43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC233286DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439BA84D5C;
	Mon, 18 Dec 2023 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d16fI5Lk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF3D12720F;
	Mon, 18 Dec 2023 12:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DCAC433C8;
	Mon, 18 Dec 2023 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903631;
	bh=UQpx4WtzUsfwEVitexmM74jcEdxORfgte+9P1HAPvOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d16fI5LknWGNYZLzw+9dQEqIe5l02WTSjooRtOHRIb17WobXhCkRIVzQNZI5Y6LvT
	 NbpNtz5EQOGKPoGsoKHzS1BdOVGg58dulpPAnSgqBrkkI7ZE6H6EW11SiLlPdTuxEZ
	 Awn3Yvoc+pBP32k3M/zqXpV2G8C/zJJsrqwPUlktGwgilajHOzlGHE3/AgvQmQtwvP
	 p+4YVVhotuAdhNc588vzSMMBaf8oEDtX1ycn4Ae6asEkD6di1evhAGU/SjgO3T+2+D
	 yuWp0SIrEgPBkrxKrHOGnL2JttV/w7E0bkq5lpQbiDwYfgsxXQFb1H3UT14Q/rpB/Y
	 OJA4TkG5xe0Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 7/7] ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI
Date: Mon, 18 Dec 2023 07:46:52 -0500
Message-ID: <20231218124656.1381949-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124656.1381949-1-sashal@kernel.org>
References: <20231218124656.1381949-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.264
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
index 9d6ba38791961..983fc4475c273 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2969,6 +2969,12 @@ rb_reserve_next_event(struct ring_buffer *buffer,
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


