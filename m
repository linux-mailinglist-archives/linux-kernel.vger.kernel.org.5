Return-Path: <linux-kernel+bounces-35495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46F88391FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447A11F25526
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E2D60271;
	Tue, 23 Jan 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNjIOkfD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103CA6025A;
	Tue, 23 Jan 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022186; cv=none; b=k1JMIe8X33pn2NRv2DWNncVdF8ndRj7MHD15fPM/iSSWXv1JOYmnKv97EYBdKkelyd1B439DFZ0S6b047fnztxpTNaT4KmkoBLEuhgF5dADmj57yxR2NGATDpUVK8e/wuazBqrPlKyC6eQjE1+SNN5k+JKUp3JFMT0LLZHX0W70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022186; c=relaxed/simple;
	bh=DpFRKAv848BeIsEakfLzG1UGGofnWebodFFq+ZPLFzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3xt35VktEDTD1sT9biavm2dw2O15vv/FZUZKI2qfNs03JUIE/C7Cl09OVMzWbnKOn2cKTtV18RSaSxTzoF5ujA6NGJ8ihdExvMiezgiSKnHUQjvQG0wvO3INPR/HitIYqMQHFlmFjd6sxp/rgEhLTQ1huW3Bvjrg3QuTcXO8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNjIOkfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94777C433B2;
	Tue, 23 Jan 2024 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022185;
	bh=DpFRKAv848BeIsEakfLzG1UGGofnWebodFFq+ZPLFzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNjIOkfDtBPT8jY8NxQen69zTiSHDSrOVlENvRZEsyBxDj/tqwpecSTTDlPGvwiqj
	 CaEmyHGdx4QSwezjaYOSd2J7TrovAkX+KIwwVZ8YtH51JGB3jlT7zG2AB0O69y0itU
	 1F9jk7tbibrLFv2f9Q0eWt2Ymq16yKwws2VuTLBDEZRqjoWUbu/kzjI3Q6YpN5sbDU
	 MZT/yiiJ67R92QjBF1Ru+BRtxKk0gtWyteKgcS8MNJR2AEaiLDBMjcz+pLSHWVzuKq
	 IwVYlhRKQlu7B7QU698fY66kJNumSkY3PnDNgrJX4pS+qdEFUCkqdBEnAam2771XhQ
	 JsuVUz2gljaNA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing/probes: Fix to set arg size and fmt after setting type from BTF
Date: Wed, 24 Jan 2024 00:03:02 +0900
Message-Id: <170602218196.215583.6417859469540955777.stgit@devnote2>
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

Since the BTF type setting updates probe_arg::type, the type size
calculation and setting print-fmt should be done after that.
Without this fix, the argument size and print-fmt can be wrong.

Fixes: b576e09701c7 ("tracing/probes: Support function parameters if BTF is available")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index c6da5923e5b9..34289f9c6707 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1172,18 +1172,6 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0), BAD_TYPE);
 		goto out;
 	}
-	parg->offset = *size;
-	*size += parg->type->size * (parg->count ?: 1);
-
-	ret = -ENOMEM;
-	if (parg->count) {
-		len = strlen(parg->type->fmttype) + 6;
-		parg->fmt = kmalloc(len, GFP_KERNEL);
-		if (!parg->fmt)
-			goto out;
-		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
-			 parg->count);
-	}
 
 	code = tmp = kcalloc(FETCH_INSN_MAX, sizeof(*code), GFP_KERNEL);
 	if (!code)
@@ -1207,6 +1195,19 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 				goto fail;
 		}
 	}
+	parg->offset = *size;
+	*size += parg->type->size * (parg->count ?: 1);
+
+	if (parg->count) {
+		len = strlen(parg->type->fmttype) + 6;
+		parg->fmt = kmalloc(len, GFP_KERNEL);
+		if (!parg->fmt) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
+			 parg->count);
+	}
 
 	ret = -EINVAL;
 	/* Store operation */


