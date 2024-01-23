Return-Path: <linux-kernel+bounces-35493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824948391FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E011F2552A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DC15FEEF;
	Tue, 23 Jan 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWXfw0+m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E85FF0B;
	Tue, 23 Jan 2024 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022177; cv=none; b=qLuXAcajt4uRIpnSLbXGhzyLHpjdDoU+BNi6DdedgPoIu4D+GXvLmxmJzZwDkoBl8gb+KcrRJLoKn2ocLJ/VeF6SelLK0S1b7P6uVaF5lKAv/r77YqB0M4Dvf7At/A646WLRMRLyLFm4KIJPleIi3di7xGRWO9YEquiup73+s80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022177; c=relaxed/simple;
	bh=zdIHKJVOlplezFr0uz3PNofWQ1uhtB4tw/QWhytbAQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FECqxt4h4dwXH5h0aGJhbuldcbaEMQdITipSaOx5YtLledC3z7USF1mgIpQfYZk8/Fdf9VrB3eL2tw36zubBqVIUCVBf6vC/3r9dT06hIyVNcErWc05S6LpWl83H0I6bMnIfU+0uXPZDn9Eyztj7/HLZ0xqzdhEm2IT7QCQSdRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWXfw0+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA37FC433C7;
	Tue, 23 Jan 2024 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022176;
	bh=zdIHKJVOlplezFr0uz3PNofWQ1uhtB4tw/QWhytbAQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWXfw0+m789NUxJmtFrZvrkib8DMiUt8NyTKfxFF0Yor0xtJGY7k55Rm1Q/f5DMyn
	 P0RTEYUHv0QVfup33NpQy1wz7KMJ8YcNd8f9q97eq3J5KeEsikQxot0R4WnjBZHUES
	 hTcbfS906sG5fRZNmUpf7OKjKdQNIVdCjt/TeyAE57qmPq+A5VaCOXzR8GePKvA22A
	 +musBmzF1RF2bz3u2tTF6MJXc4QUWhjHmmlpnNyXUUYvyT8KeedkpCIweoOwh4WW88
	 jALbfw4WghV19lx/EQd9lYDnB0uBRuTKC/nPjWaqBwhV9/HqCWpOrhVpaCUN5p7yT0
	 gn1A9FtZm6AXg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing/probes: Fix to show a parse error for bad type for $comm
Date: Wed, 24 Jan 2024 00:02:34 +0900
Message-Id: <170602215411.215583.2238016352271091852.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170602214309.215583.16731124846112910621.stgit@devnote2>
References: <170602214309.215583.16731124846112910621.stgit@devnote2>
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

Fix to show a parse error for bad type (non-string) for $comm/$COMM and
immediate-string. With this fix, error_log file shows appropriate error
message as below.

 /sys/kernel/tracing # echo 'p vfs_read $comm:u32' >> kprobe_events
sh: write error: Invalid argument
 /sys/kernel/tracing # echo 'p vfs_read \"hoge":u32' >> kprobe_events
sh: write error: Invalid argument
 /sys/kernel/tracing # cat error_log

[   30.144183] trace_kprobe: error: $comm and immediate-string only accepts string type
  Command: p vfs_read $comm:u32
                            ^
[   62.618500] trace_kprobe: error: $comm and immediate-string only accepts string type
  Command: p vfs_read \"hoge":u32
                              ^
Fixes: 3dd1f7f24f8c ("tracing: probeevent: Fix to make the type of $comm string")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    7 +++++--
 kernel/trace/trace_probe.h |    3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4dc74d73fc1d..c6da5923e5b9 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1159,9 +1159,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	if (!(ctx->flags & TPARG_FL_TEVENT) &&
 	    (strcmp(arg, "$comm") == 0 || strcmp(arg, "$COMM") == 0 ||
 	     strncmp(arg, "\\\"", 2) == 0)) {
-		/* The type of $comm must be "string", and not an array. */
-		if (parg->count || (t && strcmp(t, "string")))
+		/* The type of $comm must be "string", and not an array type. */
+		if (parg->count || (t && strcmp(t, "string"))) {
+			trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0),
+					NEED_STRING_TYPE);
 			goto out;
+		}
 		parg->type = find_fetch_type("string", ctx->flags);
 	} else
 		parg->type = find_fetch_type(t, ctx->flags);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 850d9ecb6765..c1877d018269 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -515,7 +515,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
 	C(NO_BTF_FIELD,		"This field is not found."),	\
 	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
-	C(BAD_TYPE4STR,		"This type does not fit for string."),
+	C(BAD_TYPE4STR,		"This type does not fit for string."),\
+	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a


