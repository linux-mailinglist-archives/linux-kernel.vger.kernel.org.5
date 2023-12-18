Return-Path: <linux-kernel+bounces-3634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634D7816EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820201C22A05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30BC73460;
	Mon, 18 Dec 2023 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvQ5qAOU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998E7207A;
	Mon, 18 Dec 2023 12:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA73AC433C8;
	Mon, 18 Dec 2023 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903544;
	bh=iHyai20E/r86yJPGPdiYPXOfuNCXzvwNV8ooESph5J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BvQ5qAOURx+VjDivTJHMQFmmmQKrfMWaJilqix0XG6uLpcH68rrCC12gEbyhfDfZI
	 xPsEFyxXDVK7Li1OAUvL3Mna1FftkXzttaXt0sU+UR8xZM6fsJlM5DGQ4V0r7pZa2B
	 xy8I8kj12iwpD/ZJSigDKi9D7vva5/EvSjIgDSPXldQa7EnMJjauWuXprMh7Bu+L/J
	 d9FLCvioX7OvxbzSKtC4KMb7pZ5KIeYU/dKvL12jUooTQiX4r7+qfkczPmfvfqHwnN
	 VzRIzTZspMUxOPl4LQ8VJFXrEDUgz8USE+tengSBJiPnsEH5DzmMQmj82Qq6ATPQY1
	 hQOIR6PtSgaPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 15/15] ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI
Date: Mon, 18 Dec 2023 07:45:02 -0500
Message-ID: <20231218124513.1380056-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124513.1380056-1-sashal@kernel.org>
References: <20231218124513.1380056-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.68
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
index c02a4cb879913..c821b618a622f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3711,6 +3711,12 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	int nr_loops = 0;
 	int add_ts_default;
 
+	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
+	    (unlikely(in_nmi()))) {
+		return NULL;
+	}
+
 	rb_start_commit(cpu_buffer);
 	/* The commit page can not change after this */
 
-- 
2.43.0


