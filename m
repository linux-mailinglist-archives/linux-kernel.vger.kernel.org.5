Return-Path: <linux-kernel+bounces-39465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE39483D19A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C17B28FFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D8816;
	Fri, 26 Jan 2024 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+V9Fdzt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75021362;
	Fri, 26 Jan 2024 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706229782; cv=none; b=ZTuoZnshAkLyc1TVZYERVRz+/eYSBcBjMsuF5iUMeM0VT6695HMdouk/4DRIVbFCeBxZg8S0cpjpWQsPz9M00MDx8Pb5n9RiU0thsPyHCUWKlbHUJXbCX/T4l+lypDroWRdz/hRrsfidUFLsGWsEu6ZxL42F7YPszeDsZv3edak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706229782; c=relaxed/simple;
	bh=X9L0utqCp4JboXfTZ3Ic0wfzuMXKK/zwKNw+VR/crP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxWkbgw3oWdCvnS5NgxVQW5g7wdPbHa6wZB7qkqkWYHTGBZ7HmA7b6xqZrHB8CNqx8Yez2MyTyAKOBWntTwJwg4gVha6938ub5GThaWBs+oNzHR0LM8rt2HAvFWN0R2asd5C0d+YXzeSZ2ffFjeOyUxCPhIRxj3PDgQQ8SL+GnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+V9Fdzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C1AC433F1;
	Fri, 26 Jan 2024 00:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706229781;
	bh=X9L0utqCp4JboXfTZ3Ic0wfzuMXKK/zwKNw+VR/crP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+V9FdztrTPUZ5L6Gp2+UwD7KFnvs6cAP/SqYJXwzvCHx5MtI+LwSV89qw9cMgEhl
	 425QTVhmSovIXA1wcSuBJjB/Ns04JIqqCB9JoV419y8WZeojY1tXLlyJ5ULeiUVnJi
	 5qia9THO0WJgjkOJgiNNLg9sB90T9ZUg4+CjWpIriiwA+7fq27AnFUXC5tImK/dqQ3
	 1+cYprcMbxln+O0Jlwoa49Nmm4UKe1jwIr1CaD/pfmYX0hc4QYOdNElJe7gJY2IXed
	 BWJpK50Vct5D3V8N4gaR+q/bpmd1kKYNIXnhlqfmCJn7uxuFC0kga1ytPDHBAp9/sd
	 zOjXL8Fibng9g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	kernel-team@android.com
Subject: [PATCH] tracing/trigger: Fix to return error if failed to alloc snapshot
Date: Fri, 26 Jan 2024 09:42:58 +0900
Message-Id: <170622977792.270660.2789298642759362200.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZbJ19CF2Zv4d0R_Z@google.com>
References: <ZbJ19CF2Zv4d0R_Z@google.com>
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

Fix register_snapshot_trigger() to return error code if it failed to
allocate a snapshot instead of 0 (success). Unless that, it will register
snapshot trigger without an error.

Fixes: 0bbe7f719985 ("tracing: Fix the race between registering 'snapshot' event trigger and triggering 'snapshot' operation")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_trigger.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 46439e3bcec4..b33c3861fbbb 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1470,8 +1470,10 @@ register_snapshot_trigger(char *glob,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	if (tracing_alloc_snapshot_instance(file->tr) != 0)
-		return 0;
+	int ret = tracing_alloc_snapshot_instance(file->tr);
+
+	if (ret < 0)
+		return ret;
 
 	return register_trigger(glob, data, file);
 }


