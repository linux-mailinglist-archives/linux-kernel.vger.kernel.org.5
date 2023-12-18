Return-Path: <linux-kernel+bounces-3675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A8C816F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AC51C2094B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FCA12911E;
	Mon, 18 Dec 2023 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9biQ4QJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372441297F0;
	Mon, 18 Dec 2023 12:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B89C433CA;
	Mon, 18 Dec 2023 12:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903655;
	bh=W86H2j/admdtpITtY5Jn2huyO56hJHR2Zf5N0N/wJlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9biQ4QJv9FU2ZJO7vkMTDb5g4jMm4waNqsQJk+2VexPUVvljG+96/dWh+cOGVNV+
	 ltCHDFI0QUxgyTBKt62D4P2iQR+BPk+SrDBTkaffthXElyyEYtLNWZ/KSDIVwwbWVE
	 wOcdlxzMlcBhaxc/bSpwFoOZ6UY3SYFx1HxtKxDOXBYs5P6JVkIxZB6XRSWsVD720j
	 FGU5SA19T11TuoyN1whtVAvmkvUB6v3ClueNXoROiwG69QCtzwpQ7eaxDNkXWOKblH
	 4eSyJ6q6wAOwPEY3J5HP+LuyWBiqOB946TlyWgLZslddvE5NGjsynQ30CHvJQ9PuRF
	 vJ7QseB1NkQ3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 5/6] tracing: Add size check when printing trace_marker output
Date: Mon, 18 Dec 2023 07:47:22 -0500
Message-ID: <20231218124725.1382738-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124725.1382738-1-sashal@kernel.org>
References: <20231218124725.1382738-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.333
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 60be76eeabb3d83858cc6577fc65c7d0f36ffd42 ]

If for some reason the trace_marker write does not have a nul byte for the
string, it will overflow the print:

  trace_seq_printf(s, ": %s", field->buf);

The field->buf could be missing the nul byte. To prevent overflow, add the
max size that the buf can be by using the event size and the field
location.

  int max = iter->ent_size - offsetof(struct print_entry, buf);

  trace_seq_printf(s, ": %*.s", max, field->buf);

Link: https://lore.kernel.org/linux-trace-kernel/20231212084444.4619b8ce@gandalf.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_output.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index e3ab66e6fd85c..3ca9ddfef2b8f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1319,11 +1319,12 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
+	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %s", field->buf);
+	trace_seq_printf(s, ": %.*s", max, field->buf);
 
 	return trace_handle_return(s);
 }
@@ -1332,10 +1333,11 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 					 struct trace_event *event)
 {
 	struct print_entry *field;
+	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
+	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
 
 	return trace_handle_return(&iter->seq);
 }
-- 
2.43.0


