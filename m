Return-Path: <linux-kernel+bounces-132527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1A899643
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF77E1C21CA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDBC2C694;
	Fri,  5 Apr 2024 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aC8A6Eze"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD12D606
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300986; cv=none; b=nN7ML8mG3OVesxyawjm3rBV3VG8dDMwV3BkaUfjqYtzdR7lhWc15nAJS6qf36/DTyQvBRo9o/2ymBjHN9ldGrPCH8V4tr8R8xSekxyk3/BdMEmVtCMIfZI1Sv4UJE48SuoKX+hFIAe0eORnVPZohWOjxQR9UkR440oYUBkkZlGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300986; c=relaxed/simple;
	bh=8e9KWBvPyofUY9y0WRoCSTVhc7X7fvbk4pxXNNYyPx4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=VgBjL0XIdkgaLTapmxFIxK4c829SEhkvB0mLVaZBUU/sNqOfYUP93SagD1GQTTxrgci38woegZEZVleD/rgntZFiSPZrnzVB2nC3rPJO/O5ce9aJecrQudIUtu0HLBTjmBxZ7WV8C6Fsg8atga53OzQXAI+8+SuG86E39N+Ow/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aC8A6Eze; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6f571so30343837b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712300983; x=1712905783; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Ob7TzpDpTM9SCKkDzrXTBQ/YxjYsrPaKVbzk6RxhdE=;
        b=aC8A6Eze0FwSxcNzfpl74IOV4pdnzvKZxVFE+o1WOI78aTVuBY/0stL97OPGyqFZPP
         mjCLJ6l/BZFLfE+C6OH4X1+sRCLtwEiIXPs39/Q3Cyv0b6QcOdubSCeyLB1E7Ge5ky7Q
         CmEySy6/2NqIYNxxKeEFvikHpxGq0HCh1UVPqBNe0QDACuD6v0USzJVcsl3utQIbRe6Q
         GUphOIaBE3xD1fURRctceDQmcyE3t3vUUDXGK5mTyUcJvcXVbiCRHePZiFdMNncPXKNs
         zjog8j9PIBaJlr74R0BZe4VaRl9L6qVJuZdLu+wJYeGexQBCOJCHJMhJwwFm1Pd6l2GG
         Q3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300983; x=1712905783;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Ob7TzpDpTM9SCKkDzrXTBQ/YxjYsrPaKVbzk6RxhdE=;
        b=mBEa5jLdfp0la+S/ZUC8U91hT81uY2ipDw02Ti0LHarvbQSpn4FgrN3EdfMJikhBwI
         RR54zcnU3ksm+FGlmPcfkGh4RLiTXm122ZueJOht4vYaB0e4FsZaA/1QIFiXFgNtbQqM
         Q6uYO7s7ngq7afxxtUcB33nOvCCnb9wyTEfzOgsel29iSdYoc3VQMzkU/6Xqy8dOYYyp
         JL3Af2gRmrJPiVaVd2Q0/crq2PUuLBN14qxvDk4Ifp1wVQfN+lg4e81kaJXpUMhi3YkE
         D15DXGmjQX7k2pLDiDqLtcGW6nWhrLAtRbh4uJcpbeyyuLVWM628V3HXUGn0B0Qycz+Y
         FdVw==
X-Forwarded-Encrypted: i=1; AJvYcCWEBjYQa99kixQr4oBMUyl3dLRyAPj8/WRXWHTT0gryiv9tljB1d8JXy2TAjEIeLgFYt0Z5cHsK4OuyfrcZSPtwtznr25jS5cQmFr0L
X-Gm-Message-State: AOJu0Yy5fr+IeCt8UPloHQZT+LNZMpQfQwfrApUIit1iOO19bLYLzims
	XMSo3/uZQDf45BTybYNyRyfwdzD4i9JnXmhxIqooozjEpjNe6iICkfgQ2/n3p+wFH33uf+WfU58
	6kUV/nw==
X-Google-Smtp-Source: AGHT+IFcU9sQHia2Mb0d3O/yCjE4MOE0iAyf7ZUHX4r565opxam1MGsSvxr6cU2YG4krjMG3mQrf4pd+2jk6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6765:20d3:72cb:f573])
 (user=irogers job=sendgmr) by 2002:a81:fe0c:0:b0:611:747a:daac with SMTP id
 j12-20020a81fe0c000000b00611747adaacmr162273ywn.0.1712300983701; Fri, 05 Apr
 2024 00:09:43 -0700 (PDT)
Date: Fri,  5 Apr 2024 00:09:30 -0700
Message-Id: <20240405070931.1231245-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 1/2] tools subcmd: Add check_if_command_finished
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add non-blocking function to check if a child_process has
completed. If the process has completed the exit code is stored in the
child_process so that finish_command returns it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 70 ++++++++++++++++++++++------------
 tools/lib/subcmd/run-command.h |  3 ++
 2 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index d435eb42354b..4e3a557a2f37 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -165,43 +165,65 @@ int start_command(struct child_process *cmd)
 	return 0;
 }
 
-static int wait_or_whine(pid_t pid)
+static int wait_or_whine(struct child_process *cmd, bool block)
 {
-	char sbuf[STRERR_BUFSIZE];
+	bool finished = cmd->finished;
+	int result = cmd->finish_result;
 
-	for (;;) {
+	while (!finished) {
 		int status, code;
-		pid_t waiting = waitpid(pid, &status, 0);
+		pid_t waiting = waitpid(cmd->pid, &status, block ? 0 : WNOHANG);
+
+		if (!block && waiting == 0)
+			break;
+
+		if (waiting < 0 && errno == EINTR)
+			continue;
 
+		finished = true;
 		if (waiting < 0) {
-			if (errno == EINTR)
-				continue;
+			char sbuf[STRERR_BUFSIZE];
+
 			fprintf(stderr, " Error: waitpid failed (%s)",
 				str_error_r(errno, sbuf, sizeof(sbuf)));
-			return -ERR_RUN_COMMAND_WAITPID;
-		}
-		if (waiting != pid)
-			return -ERR_RUN_COMMAND_WAITPID_WRONG_PID;
-		if (WIFSIGNALED(status))
-			return -ERR_RUN_COMMAND_WAITPID_SIGNAL;
-
-		if (!WIFEXITED(status))
-			return -ERR_RUN_COMMAND_WAITPID_NOEXIT;
-		code = WEXITSTATUS(status);
-		switch (code) {
-		case 127:
-			return -ERR_RUN_COMMAND_EXEC;
-		case 0:
-			return 0;
-		default:
-			return -code;
+			result = -ERR_RUN_COMMAND_WAITPID;
+		} else if (waiting != cmd->pid) {
+			result = -ERR_RUN_COMMAND_WAITPID_WRONG_PID;
+		} else if (WIFSIGNALED(status)) {
+			result = -ERR_RUN_COMMAND_WAITPID_SIGNAL;
+		} else if (!WIFEXITED(status)) {
+			result = -ERR_RUN_COMMAND_WAITPID_NOEXIT;
+		} else {
+			code = WEXITSTATUS(status);
+			switch (code) {
+			case 127:
+				result = -ERR_RUN_COMMAND_EXEC;
+				break;
+			case 0:
+				result = 0;
+				break;
+			default:
+				result = -code;
+				break;
+			}
 		}
 	}
+	if (finished) {
+		cmd->finished = 1;
+		cmd->finish_result = result;
+	}
+	return result;
+}
+
+int check_if_command_finished(struct child_process *cmd)
+{
+	wait_or_whine(cmd, /*block=*/false);
+	return cmd->finished;
 }
 
 int finish_command(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid);
+	return wait_or_whine(cmd, /*block=*/true);
 }
 
 int run_command(struct child_process *cmd)
diff --git a/tools/lib/subcmd/run-command.h b/tools/lib/subcmd/run-command.h
index d794138a797f..b2d39de6e690 100644
--- a/tools/lib/subcmd/run-command.h
+++ b/tools/lib/subcmd/run-command.h
@@ -41,17 +41,20 @@ struct child_process {
 	int err;
 	const char *dir;
 	const char *const *env;
+	int finish_result;
 	unsigned no_stdin:1;
 	unsigned no_stdout:1;
 	unsigned no_stderr:1;
 	unsigned exec_cmd:1; /* if this is to be external sub-command */
 	unsigned stdout_to_stderr:1;
+	unsigned finished:1;
 	void (*preexec_cb)(void);
 	 /* If set, call function in child rather than doing an exec. */
 	int (*no_exec_cmd)(struct child_process *process);
 };
 
 int start_command(struct child_process *);
+int check_if_command_finished(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
-- 
2.44.0.478.gd926399ef9-goog


