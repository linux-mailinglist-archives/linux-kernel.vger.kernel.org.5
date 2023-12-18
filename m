Return-Path: <linux-kernel+bounces-3619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF22816E88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAA61C24645
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F111F42394;
	Mon, 18 Dec 2023 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olVWplEs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC53D55F;
	Mon, 18 Dec 2023 12:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46598C433C9;
	Mon, 18 Dec 2023 12:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903501;
	bh=wEAQwEs3TAqhqtbRz+sEjGpOSuDxnPLkYICZfklPgaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=olVWplEs8AzhhGX7UP8qsYczUh0kqfu4Evct6l0rISTMwdtUa5olpmtPstFLsnUwX
	 F1yvHTo0hNxAN12aHA+Ic2+qzqI0TXzAjtKPsan6ti3jSrcIUrXOx9l0m4uzRROk6j
	 0ubV0c19XJC9GlRcpARlDhxbo4ziGwfQbFW181KisTT2FtTBSSdzCrfX9IQE+E0guS
	 NzOI9PznoM8b3XagXvimUD61r76JR7a4wCTVRBPB18ZyV8FLCZMILLiARUUSZDpGfD
	 aixAlHPACz1t2fFkhiFGnhZp//+YJNjPwENxzoSjtnpcr2Blm2umOfR/JERJJGVZ1R
	 //mHf1zLPKH4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/18] ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI
Date: Mon, 18 Dec 2023 07:43:52 -0500
Message-ID: <20231218124415.1379060-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124415.1379060-1-sashal@kernel.org>
References: <20231218124415.1379060-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.7
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
index f1ef4329343bf..30c8d01a4d08b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3714,6 +3714,12 @@ rb_reserve_next_event(struct trace_buffer *buffer,
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


