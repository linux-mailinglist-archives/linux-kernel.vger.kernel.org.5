Return-Path: <linux-kernel+bounces-65267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BBC854A60
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676561F24799
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7DA54BC3;
	Wed, 14 Feb 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhlP+mtw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7754670;
	Wed, 14 Feb 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916948; cv=none; b=KSvdU+fsRkmncM0lJZHgBxD9835P8RrjGeJQKTt5mUNQgM1XQCNNYERzxprzGdHK0Yw3DlRWTaqov9dbhX8gJUvJTNtFFTUF38z0SAxs1DZxjzFTlwFQXxmXHNaVMUUJF3RMIjzgQLze+5cB8F4qFMpBQJ9rX/D/5d735yiCzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916948; c=relaxed/simple;
	bh=VG0MktVwabnUwipPLIf3jQPx5AW1d8Ms9iB0R5HsZLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpK0buTCf2ZXq4VtVWJJ20nvMQYAyCTk4KbU47unmgScskGHtmPCJy8edS3mCexj5HD+1ASoVfj3f+gTiJxuD7qzMVJuweIkVTQcpi5plZ5DPymYu0trzya1DLUGgFdfpPh5mecgkVA0MPC3zu5XAKH1pRsFmllmRTLY3faGikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhlP+mtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B9DC433F1;
	Wed, 14 Feb 2024 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707916947;
	bh=VG0MktVwabnUwipPLIf3jQPx5AW1d8Ms9iB0R5HsZLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhlP+mtw5Bf4V+dPyp3lg0cekg2L2ynWetLOiRWpvw9Abm+7ips+UHJ7N2BI6Sl71
	 FdarhNIIPmOPBISl3ZDC0DFRfXj+xWD1UKSdsNj4522KYs4QZ+GT7Zp8O5E0UDbFDS
	 qHxEWBTEqRlU78XLQkqvE0fD3p2zSZ+fhoTjodO4V8KLzL93rOvevt6CgwE3hpwA4Q
	 Q5R89ZDItmQW/IL2L8cJwPrGn+xWPIIYTCxuq0R0JCDJ8tIHqzPbnFUW8RSHeZrrI6
	 hmSB8tFbE7JvC8xjOOoKqdTSUbkdPvhT+85hYdY3tHBKqYgEDY+dofCHR4UKJ7dzp0
	 uTzQMvb3K+uog==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org
Subject: [PATCH RFC 1/5] tracing/probes: Fix to search structure fields correctly
Date: Wed, 14 Feb 2024 22:22:23 +0900
Message-Id: <170791694361.389532.10047514554799419688.stgit@devnote2>
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

Fix to search a field from the structure which has anonymous union
correctly.
Since the reference `type` pointer was updated in the loop, the search
loop suddenly aborted where it hits an anonymous union. Thus it can not
find the field after the anonymous union. This avoids updating the
cursor `type` pointer in the loop.

Fixes: 302db0f5b3d8 ("tracing/probes: Add a function to search a member of a struct/union")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_btf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index ca224d53bfdc..5bbdbcbbde3c 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -91,8 +91,8 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 	for_each_member(i, type, member) {
 		if (!member->name_off) {
 			/* Anonymous union/struct: push it for later use */
-			type = btf_type_skip_modifiers(btf, member->type, &tid);
-			if (type && top < BTF_ANON_STACK_MAX) {
+			if (btf_type_skip_modifiers(btf, member->type, &tid) &&
+			    top < BTF_ANON_STACK_MAX) {
 				anon_stack[top].tid = tid;
 				anon_stack[top++].offset =
 					cur_offset + member->offset;


