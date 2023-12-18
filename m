Return-Path: <linux-kernel+bounces-3655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B1816F23
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D771F2425D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E27CCE4;
	Mon, 18 Dec 2023 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw12uRO/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58207CCFD;
	Mon, 18 Dec 2023 12:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B938C433C9;
	Mon, 18 Dec 2023 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903611;
	bh=3F5ZTxNBkFlW/tOCdNalk8fTY560Df8zCrh14vAUju4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aw12uRO/6NADmiuilPPeeYCUVWVOWX4B7MJlV70mnGtSTYjnLAOX3UOrlKNxEGXN6
	 Ymol7fc1bV6CTLhlsSS8in5/GqRhXTSclSXeVRbMXDKJpCJNAtUoEWCrJjGpV65pss
	 T71ee2nVgIk7dG0M/936Jmu8EpcySDNTBllY51Z1A56RV4p76Fboh+5M4VdMZSNvO5
	 6J52B063YKxIiVJyAih04+vNRwwAq6QjWRvHH5tBG8Nv/ud+9BNMLa/4mHTDaHDFiq
	 +KwPKiPdLcyhXnhvZn/V5GBFgMsIPZW5Sf49E4XSa/qLxUvApH9sthxVcHUknSzW0c
	 34TJr180cSmqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 8/8] ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI
Date: Mon, 18 Dec 2023 07:46:29 -0500
Message-ID: <20231218124635.1381482-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124635.1381482-1-sashal@kernel.org>
References: <20231218124635.1381482-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.204
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
index 7e1148aafd284..e58eba8419b12 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3431,6 +3431,12 @@ rb_reserve_next_event(struct trace_buffer *buffer,
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


