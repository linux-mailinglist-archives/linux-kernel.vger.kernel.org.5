Return-Path: <linux-kernel+bounces-87932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B9A86DB2E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC2EB2566A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2F537E5;
	Fri,  1 Mar 2024 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ro/PVEIb"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD55336D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271420; cv=none; b=Ws8cgAR746/4M/3fQlNKk4OE49I3AeHcSa8hNeOHZJLT+3Z9y+I9Nsc+R/UeaV1OoveHyXX8BbxdELA0OzzA02SEYnzP5kiWhNvjkVYU5sRQfpKgqr/oWD+bW+zdGsXCiypoLaCgPbSgJ+rIfsillPTuXnyv07e+f7iQ4Q8+MtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271420; c=relaxed/simple;
	bh=BBmU04u6tU5hlUeOKBhv7F/E4iRu0Xd0+OelCnDu9d4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Q6CDZGPCobSCGPClnsWL3cfotBxifgp3HzszehT1GzLEcr3IWP9+MjWNzOknFx76O4iTVf74+TVaNNsGDL0H50g+sEjFCCJMaksIIZwcn758XF2rUig6SLD6ScneNtb6Nb0VUhqRXWnEG7W5nBcd7Nyf8L3wQwUZ4FowbUR/Oc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ro/PVEIb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so3571474276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271418; x=1709876218; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRPVI6egL+2XI2pKzd6EAQy7fDTiYP04TRmL/KfQbAc=;
        b=ro/PVEIbA41Q4SdR4B2QPlPKNtMHCyuFGJUvsvuk/AtEFRo+N5U4X9+p246GpEtZFS
         oTardnH8fIDYNTWFC/+L/HxZ/67Zgh4sNVLkl0w8PiPltPr2H/Ithsi411awv1BTsyjs
         9uCLZN6j0VOemEVMEGV3H8r9YD+tUCx0TdOgblvCNpX9eeMHtJSfHgIJwbll876fnKmZ
         a9JdMWVIby1jPAo0k7fuD5ID25qi1xp0E7vflnjVZV+wqUp7vfYF3VzCDJz32u720K3D
         wkW0uwob92PUw9+3uKARnAUpyqCGH9fsRICo/Xz9PVIMdNmsRC7DlQL2h+qld4EQh9Rv
         5GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271418; x=1709876218;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRPVI6egL+2XI2pKzd6EAQy7fDTiYP04TRmL/KfQbAc=;
        b=K68DOdOiasclhsjjHMQ8c5H9Af+RmGvuuSWMD7Nu0GpSFbueqVz+FCgbix+q1T4pW1
         u2QtHjNRk8skIx2aJ36D1/zZydB6CjVHrmRK9zkJ5QD33I7mex5yTnYc+KAzdDCziSIH
         jo5qSv7Cbmqpyan8lDi1IKL6xo4ir/niPkQuM9oNLzcJLifGNM4kg/kZ0R8sQ8DV+dia
         KgofFFPUzFiOVvcchMry9WP9h7pmzZo6MxB6/AMHtDGU9R9oMTSGvqrQNeN3DlY6Ot8D
         Hw4oKJGzBSyK+e1SCO5o0YfY82ayAkd47BY7o7G3y16TMfJ3KVL0jquQXyQ+/FNvgj4H
         eT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWygP7CYQBJnjp66QSyzQ/quCdWvpBA7QLkljoae5cazsADi8SygAii/txS/gxow0EJTzAi7UTMSU8qUIhGNMlob7OOF/bgmKSLQe4j
X-Gm-Message-State: AOJu0YyBfmE0uhJrEymJVL/BFMldIFCs2Ei8eAMU0E25mslq0i1cfrtn
	Swz6GkrL1mTq1pT6nkj3kDNgxIQJ+96CHEpeXKiuMlepV7AnM0BYSH2Ml+6UlQ64GyfTgLvchiX
	8BCm5cQ==
X-Google-Smtp-Source: AGHT+IGRLMrQFbbox60wk3jGuHwsiDSFz/GgzyTXEcf4rK5AC6vMv1Mi7Tmq1hBxxVIampmyF3fsHTa+P71N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:b292:0:b0:dc7:5925:92d2 with SMTP id
 k18-20020a25b292000000b00dc7592592d2mr757438ybj.1.1709271418281; Thu, 29 Feb
 2024 21:36:58 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:41 -0800
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
Message-Id: <20240301053646.1449657-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301053646.1449657-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 3/7] perf machine: Move fprintf to for_each loop and a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid exposing the threads data structure by switching to the callback
machine__for_each_thread approach. machine__fprintf is only used in
tests and verbose >3 output so don't turn to list and sort. Add
machine__threads_nr to be refactored later.

Note, all existing *_fprintf routines ignore fprintf errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7872ce92c9fc..e072b2115b64 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1113,29 +1113,40 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 	return printed;
 }
 
-size_t machine__fprintf(struct machine *machine, FILE *fp)
+struct machine_fprintf_cb_args {
+	FILE *fp;
+	size_t printed;
+};
+
+static int machine_fprintf_cb(struct thread *thread, void *data)
 {
-	struct rb_node *nd;
-	size_t ret;
-	int i;
+	struct machine_fprintf_cb_args *args = data;
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
+	/* TODO: handle fprintf errors. */
+	args->printed += thread__fprintf(thread, args->fp);
+	return 0;
+}
 
-		down_read(&threads->lock);
+static size_t machine__threads_nr(const struct machine *machine)
+{
+	size_t nr = 0;
 
-		ret = fprintf(fp, "Threads: %u\n", threads->nr);
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++)
+		nr += machine->threads[i].nr;
 
-		for (nd = rb_first_cached(&threads->entries); nd;
-		     nd = rb_next(nd)) {
-			struct thread *pos = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
+	return nr;
+}
 
-			ret += thread__fprintf(pos, fp);
-		}
+size_t machine__fprintf(struct machine *machine, FILE *fp)
+{
+	struct machine_fprintf_cb_args args = {
+		.fp = fp,
+		.printed = 0,
+	};
+	size_t ret = fprintf(fp, "Threads: %zu\n", machine__threads_nr(machine));
 
-		up_read(&threads->lock);
-	}
-	return ret;
+	machine__for_each_thread(machine, machine_fprintf_cb, &args);
+	return ret + args.printed;
 }
 
 static struct dso *machine__get_kernel(struct machine *machine)
-- 
2.44.0.278.ge034bb2e1d-goog


