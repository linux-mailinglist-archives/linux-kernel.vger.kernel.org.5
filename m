Return-Path: <linux-kernel+bounces-47416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD98844DB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624712897D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F43E811;
	Thu,  1 Feb 2024 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHDLIFzG"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0323C0D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746530; cv=none; b=QHbxnbYHag4oKVD8iODTfnMYe1LVsbVd63ONfKkDdMpKaa9U6Id43REJBI8PAN+MpQqeHLQyemoPVk91uHeTCmuvgWArNdjeCQNDJNlTAc8Y8ONBLphpG8K6nQyshjxVnhQtfLWXT3o9AurpFtQVlQnsLxfDAOXZDZcr2vvnf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746530; c=relaxed/simple;
	bh=P0dE4SZC6JMGyd4Zz6ysHena7Iqo04wzT6xeGII9Szk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qkguyNvgGIYCets3FBXhHtP+MiP/akTBrYp7KrTvJ3DXJP1R/TpMp/WQIU1l/+JGCVPA9+DsnncG1ynF7tdufByuSlcjQ6AloKgsUluwoV1oJuH+IRpIidD8D0HPXBOh2aJzZoXJqui6M2dwMihYxrOHxe/pdZCjWwmVd98wKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHDLIFzG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6bea4c8b9so482980276.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706746528; x=1707351328; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iap9AX1ulrmbLUTYu3qyDksm4nz07RhuxN54fV9TeXc=;
        b=nHDLIFzGWBCxcdSTVZ5+aNUiwVraAfNfr8Tzc0DMpWYk/CHh0M56nzPxx/mpjEWNlq
         G6Z/F88sCNYlVaBYZogLUTfPmr5yw6YwHfTnN5FvQzCvETLXBo7xfbIZoIxnJxZk2ZWg
         lr6adnw+YgdcivQhahbZfh6x0Z+mVEcAc8bk+RYI8VAdlS3Ncd/5ifOogza28b2t1dNI
         GwUO7Cf909GyueoPI0zBN2I3TcV3wGlPy7E0E2RFoTFfUf1HfdjLc6BRtikmWry/d8Qg
         J1Do6xirVvyBSgsQV57EDxy23kKyzajKfWoHyQHSphrj48YclGHT8BMwdHNZcrpDCUca
         NeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746528; x=1707351328;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iap9AX1ulrmbLUTYu3qyDksm4nz07RhuxN54fV9TeXc=;
        b=KUo9Zt7hPzj2ktgwRXBUFcszggaSV+nAcYc2A7jDoxIdgTfNM02H7+mw4L486sersd
         /tHu1tSlLh28HXLhr3BtqNxW8YiLouRp8rh+sTVTu1ariTCSz2G4XPAlugfHKf1D66m/
         PSuMSZ9++z/iRMtrCy+k1mU8tFCuDnuXGPtJ0bvErL/QbX2+rnRfeE9bY8NIbP4tq0XF
         kUPrKVsQU6BhG2kHM++WHnVHlHx6oZaMsxNjrpdeEqxp4j0adA2sNvaI40ASwNzSkPSX
         T7RqMyoqYOQksVxma+RTEiJ+0Uu7F2BcalQRBd9LcWJP/XbzOBN+poMWCizbXofQrl0D
         DMbw==
X-Gm-Message-State: AOJu0Yz5YDjfMx8/sgbloN8CR5TFEQkJ+fp8+rV7CI5q1lwbYjVXFDL3
	PH9I890c0uttewmGS3ZCuuXlsfYtRkxyNRmPXkpSKIMVNYLKgJ+U3xmK1KDeka9Vm4rlrxCLG0N
	PaOJ+hA==
X-Google-Smtp-Source: AGHT+IHxRSD0hjkzmEn1KU/PefzyPoGeVucSTS9v+lxpdrWfgHxnXREFi5iodt++/FgSyJgjDSNWNxNG8mLR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a25:db82:0:b0:dc6:d890:1a97 with SMTP id
 g124-20020a25db82000000b00dc6d8901a97mr9830ybf.9.1706746528067; Wed, 31 Jan
 2024 16:15:28 -0800 (PST)
Date: Wed, 31 Jan 2024 16:14:58 -0800
In-Reply-To: <20240201001504.1348511-1-irogers@google.com>
Message-Id: <20240201001504.1348511-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 4/9] tools subcmd: Add a no exec function call option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
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
2.43.0.429.g432eaa2c6b-goog


