Return-Path: <linux-kernel+bounces-74012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1316E85CEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7681F225C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85FB3A8CE;
	Wed, 21 Feb 2024 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3bnIIED"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F438DCC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486934; cv=none; b=SyzAYYWGtdqww8T1QvZEH96pfbgoaNfYxKcGWzhQAj+Bx+5y8ouHdlYs8QtRqqApIvDXcbIfq4KmVpqLem4hCxuchAs6I4y+KibgUhYmpTXESuI5lE/kMOTxajt6SmfHFhP7XsuaZ4oHOYs4Ux7RGSjR48PP5mgd/4Ouz6ZPAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486934; c=relaxed/simple;
	bh=nIwADbFncYymlWUg/R60jRadSx8+xe1bkn0KEBii9rU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aU05VRF3cspvmfriS9PWeSYJTXvqcdQy5N4yVrZoVEDqB7+2/Ikr5M3utOAuYFEZj4M4+0d1te64tUim3uCASocKtReGx72PKL5AAjhT2oBigNmBObFZIFGbZOnxJXeNNw9e9k84GfrecVLWcHI3v8Zd+OjFj4GalTJ+ZvDNEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3bnIIED; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6081639fecfso41735927b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708486932; x=1709091732; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eF36kSIEMlGOGF+Ru4Ee+ArAeIU+1BDlU+YfXMm89FI=;
        b=h3bnIIEDWRDfKD/YMR00cbHb9S5+to8IdxcG+rp2/cD33J5Rqai7CqWB3pkNS+9ILI
         +1fMJ3foXETnFYJhMICrxS6uy3cYGIPqwvb92Mv1ZkXgN734XZP4igLGLSUANfrxcus4
         hOovDO3gRWuoMCNEdivgzGzsJM9FBUPaugc0fTcnSRtSItvvg7Dla6Qxm22LLl7MYa2N
         fegE7djwCJP418WFzc4M75C2H7QwTPg/Dk4E/MtBGY0prZUdeOndGof3+GtyTCXp6JXO
         ICmMHxT33+SOgDb933qi0nzWrW4UMK9W3Sai9royTTQ5ko7A6SxjyC6CJ+BqPoTNKuAr
         re4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486932; x=1709091732;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eF36kSIEMlGOGF+Ru4Ee+ArAeIU+1BDlU+YfXMm89FI=;
        b=FdOnP9PGLF+4sQg90fgnxhgLDxUbBVtBQxnIXW4sPHIltvGzrxKCibtDyFU2TUnJ3p
         BTTC6xaehr5Lz+odXcX1s8Dz9MpaDcg5XLHEKgjsi5J97ubn+OQB+BJljVfuw2eHBo4F
         YTnRZPNSnp7drKgcD13qEhzI4TvGH09MNTm8KKl0PDk5I0WPedTeYsio2UVy0sZSBNuN
         vnZr0mHq2EYOt5wH75Tocc4xKX77RmY8ghRl0LqKywXTdH9oyB1gFzsVq2Y75J71SQOi
         PyFHFrQAhNFu+XH66rSczt68txYv+XMjxoFB8M90bHsp1HSE5rxCg8VwDRRpuFkA2NGo
         uV3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEpGu1RdLgJYVqSQyQnNlMLjlbJPebtgDHJgQMbuAo4TUAriQz/SDfrXfBDoHj/C/yNWzu/iLC9GIHDIzlWXUiJz85xL4Rn//yNWHf
X-Gm-Message-State: AOJu0YwHwJ6v7h0mD/bu3MfB/vWwa4BGvqvmZQScvE2ShJjo4UzFcOOC
	UIsWi3qN8pwnentRxQb057k4ssgUcu1eMxk95E5nY6awYvlsxpHT0BQYXYaFPLXDnLGTNJcGAeh
	5lIl8xQ==
X-Google-Smtp-Source: AGHT+IE/on57IS2xafUtNQKU7p+VrGTBQkCYynjxRso5yRXY1KPrBnnB3HTy5IyNKzr/8fPp2V2mhgp0xx+K
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:704:b0:dc7:6f13:61d9 with SMTP id
 k4-20020a056902070400b00dc76f1361d9mr660785ybt.4.1708486932038; Tue, 20 Feb
 2024 19:42:12 -0800 (PST)
Date: Tue, 20 Feb 2024 19:41:51 -0800
In-Reply-To: <20240221034155.1500118-1-irogers@google.com>
Message-Id: <20240221034155.1500118-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221034155.1500118-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v6 4/8] tools subcmd: Add a no exec function call option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Tools like perf fork tests in case they crash, but they don't want to
exec a full binary. Add an option to call a function rather than do an
exec. The child process exits with the result of the function call and
is passed the struct of the run_command, things like container_of can
then allow the child process function to determine additional
arguments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 2 ++
 tools/lib/subcmd/run-command.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 5cdac2162532..d435eb42354b 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -122,6 +122,8 @@ int start_command(struct child_process *cmd)
 		}
 		if (cmd->preexec_cb)
 			cmd->preexec_cb();
+		if (cmd->no_exec_cmd)
+			exit(cmd->no_exec_cmd(cmd));
 		if (cmd->exec_cmd) {
 			execv_cmd(cmd->argv);
 		} else {
diff --git a/tools/lib/subcmd/run-command.h b/tools/lib/subcmd/run-command.h
index 17d969c6add3..d794138a797f 100644
--- a/tools/lib/subcmd/run-command.h
+++ b/tools/lib/subcmd/run-command.h
@@ -47,6 +47,8 @@ struct child_process {
 	unsigned exec_cmd:1; /* if this is to be external sub-command */
 	unsigned stdout_to_stderr:1;
 	void (*preexec_cb)(void);
+	 /* If set, call function in child rather than doing an exec. */
+	int (*no_exec_cmd)(struct child_process *process);
 };
 
 int start_command(struct child_process *);
-- 
2.44.0.rc0.258.g7320e95886-goog


