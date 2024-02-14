Return-Path: <linux-kernel+bounces-65271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C2B854A67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE011C224E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6D54BE8;
	Wed, 14 Feb 2024 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij33RRTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F455C04;
	Wed, 14 Feb 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916974; cv=none; b=NCCq7/W7ghNa/BUnidmE7qdfh5uZqOwg88t9vdLg+YY60+k0UJFZOMUZJUUSw/CnDQKUpEy81Nq1wiEmjFf+UMBMzEyld/uQQ657RW1ViDt81Qa/YuhIr83IvHTINuj5rymAex3LyYCNqrVK6VGdw34zzu8qmxd0lrTbd5fiUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916974; c=relaxed/simple;
	bh=KMkNYqwUm/DKFq2MqbwKymJ8CYTI6sIrbCfL1CVMecY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ic8nfIe32pcvcgCHD8KSytuz0Ry9zl9Ffa2quSHNnlW8Azn/4vao9ArIeSzhbd+SdvKEwL63ekby7goXBpJPTj/Gu1e8yiOmR84EkyBzg/JnLkbY7N07BRajoTaPZrD+27KUJKvaH6RE8OQsq4dIaujyYGeb5A1b+HYJT4rD4tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij33RRTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81625C433C7;
	Wed, 14 Feb 2024 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707916973;
	bh=KMkNYqwUm/DKFq2MqbwKymJ8CYTI6sIrbCfL1CVMecY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ij33RRTpQRk1InLaUJOruddEz2SgNCMcLWYimJeeBYOhIBydytZ66tmuLrgTEs6nV
	 7mxJ+iuuy7WSr6Fp9/0QWbL7nNhoMmUpuADkllhaB9D52OQ5fbUxOZcRWwvfpUDQef
	 xtiHMFJ0v8Zc1Nu1G+CVFoR/CLOvS25JRsdYa2BEU+HjqJr9rDE+j39fc5IfyXlok9
	 PZNZycfNbqNbvWJEjBsdNEAupcPSTDCgUlWgAsyHOUYrThn+hF/a1mqJvHXWNJ0H5N
	 2vlvTknOjURgzNEpB9+P13bnVQvfD1YdHaVFJ70fxZI6qk/Lug6jy2IZFIArjnVlGy
	 6YT6942OE855A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org
Subject: [PATCH RFC 4/5] tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init
Date: Wed, 14 Feb 2024 22:22:50 +0900
Message-Id: <170791697034.389532.9872760768297831357.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170791693437.389532.6816883363982512874.stgit@devnote2>
References: <170791693437.389532.6816883363982512874.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Instead of incrementing the trace_probe::nr_args, init it at trace_probe_init().
This is a cleanup, so the behavior is not changed.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |    2 +-
 kernel/trace/trace_probe.c  |   10 ++++++----
 kernel/trace/trace_probe.h  |    2 +-
 kernel/trace/trace_uprobe.c |    2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 03c851f57969..eb72def7410f 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -220,7 +220,7 @@ static struct trace_eprobe *alloc_event_probe(const char *group,
 	if (!ep->event_system)
 		goto error;
 
-	ret = trace_probe_init(&ep->tp, this_event, group, false);
+	ret = trace_probe_init(&ep->tp, this_event, group, false, nargs);
 	if (ret < 0)
 		goto error;
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 67a0b9cbb648..93f36f8a108e 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1423,9 +1423,6 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
 	struct probe_arg *parg = &tp->args[i];
 	const char *body;
 
-	/* Increment count for freeing args in error case */
-	tp->nr_args++;
-
 	body = strchr(arg, '=');
 	if (body) {
 		if (body - arg > MAX_ARG_NAME_LEN) {
@@ -1810,7 +1807,7 @@ void trace_probe_cleanup(struct trace_probe *tp)
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
-		     const char *group, bool alloc_filter)
+		     const char *group, bool alloc_filter, int nargs)
 {
 	struct trace_event_call *call;
 	size_t size = sizeof(struct trace_probe_event);
@@ -1846,6 +1843,11 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 		goto error;
 	}
 
+	tp->nr_args = nargs;
+	/* Make sure pointers in args[] are NULL */
+	if (nargs)
+		memset(tp->args, 0, sizeof(tp->args[0]) * nargs);
+
 	return 0;
 
 error:
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index c1877d018269..ed8d1052f8a7 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -338,7 +338,7 @@ static inline bool trace_probe_has_single_file(struct trace_probe *tp)
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
-		     const char *group, bool alloc_filter);
+		     const char *group, bool alloc_filter, int nargs);
 void trace_probe_cleanup(struct trace_probe *tp);
 int trace_probe_append(struct trace_probe *tp, struct trace_probe *to);
 void trace_probe_unlink(struct trace_probe *tp);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 99c051de412a..49d9af6d446e 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -337,7 +337,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	if (!tu)
 		return ERR_PTR(-ENOMEM);
 
-	ret = trace_probe_init(&tu->tp, event, group, true);
+	ret = trace_probe_init(&tu->tp, event, group, true, nargs);
 	if (ret < 0)
 		goto error;
 


