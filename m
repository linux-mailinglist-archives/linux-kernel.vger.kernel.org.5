Return-Path: <linux-kernel+bounces-36431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E885883A09E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A108A28679F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B1D168D7;
	Wed, 24 Jan 2024 04:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w9rYoI0V"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911AA16423
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070633; cv=none; b=KPz/BilwzaZObbKF3C5wwlAuA5IzJSvbBaYPQwttU5CPU/RyqYUnBTpAVwF9957CRf4DZ63WszJZKP7sXfC+tEO1qAL2/ceLbtwQQvWD4bCBkIzir9mlxy2PgjGewNzSGW+xndh8h/TneugKFJ9SivCjXXztEp7FrKJYNyz467I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070633; c=relaxed/simple;
	bh=ktGpNrNpovCGFIfJRaOQi+xr2H2KIZoGJ+VlEz/s/Vo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RQ1Jtu8PIgMuT8XuFQ2syOSYv8YzWOG+qhG65cmOmw3WnTxOyZDgHXa1HiMo89Qtp97VT5jr3Yk0nIcSu1ZY7PhQLyGA8GepWs53kRHvPI71UFON86crGGPnhE/wzmDVzFb+BYDajtTeszqz79p8LSBIU8L9/2VSAsQRZ7IpbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w9rYoI0V; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc237543b74so6293675276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706070630; x=1706675430; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SLazpc0GwSHvqXNx6aE49dIdTieh1SbCFqUC1qSvB0=;
        b=w9rYoI0VC/n0+N1BXqN0wR5GvES+itnZSlgYVYhf+hBkztuWcrR/lLol7E3iCVOxxt
         Jsds3SjJfmUw+buZDuSaU2VTyOynjwqZRQnKo2UqXXyc8M/J70H8aPhbIyfMudziRUc2
         6TyH3bwTESexsmpMfQIBQOW44bMKptUAfGH2xNTYUK9n/NVglx7gKzz2V4FChBXfTP0f
         rS1mnX114luPPooIVsC34tZFi7d52xGz4lECMt7clnyQb4Uz8uH/qGz/2X0iz+Q74viq
         3uS5Wx0eK29slo4CF0Y4NfxvhN0eTI5VqpWK5he5bgzuZDLmbhBR9ftxELzoZdcXFrON
         h7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706070630; x=1706675430;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SLazpc0GwSHvqXNx6aE49dIdTieh1SbCFqUC1qSvB0=;
        b=S7FICteoyopw5pXbT5NElQLDMBY7cvOaXz5KZaEgjxkbfmdr1B42PilIsttTG6x9f9
         i7CNJQySl1BqCJxBeEqhQMAFnmAX3cZEy9KzsStvMYPsaYNjiXX7OCQgoL0Q7JL7p/WD
         VzRbfezLlsgVFOO6NgN+ureg+MwnQvc99c6ZXWl9iqgyalslzvPJR1z8mcBu0jHvzb8k
         9QXSLhqOoFNGZh0NKusq9cdieq3A9tPOF6elCY2EFpUTnzFvP0LqPUQUd4H5SIEG6gv0
         KuX0DzJMleafpxNGRqRuBsVwnmiwf39BO8ATOJ0jxHYbIREWYhPLLwYC/chfTT3B/nxa
         HdqQ==
X-Gm-Message-State: AOJu0Yw6j0N5qf/CE3BYvoJ/vqkpnNhUajFI33UUhyoWmENDBYQucH1Q
	z0/GFzRExf8rxSEMThFdHlJUf3+fq5jETmgD8BAyJRmlnQKksNk7fpOiQ84fC5pI4QFP/u43V1e
	WMMg81w==
X-Google-Smtp-Source: AGHT+IFvv+H1HQdQNamSO9zJ1+/XkhkUKTtdpjUKBjuWQ6XbshZZhXlGf3PQ0ItJoIwBVuKWxYoYJtDMGVWA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b37:2438:2b2f:daae])
 (user=irogers job=sendgmr) by 2002:a25:d683:0:b0:dc2:57c9:b44d with SMTP id
 n125-20020a25d683000000b00dc257c9b44dmr14640ybg.8.1706070630536; Tue, 23 Jan
 2024 20:30:30 -0800 (PST)
Date: Tue, 23 Jan 2024 20:30:15 -0800
In-Reply-To: <20240124043015.1388867-1-irogers@google.com>
Message-Id: <20240124043015.1388867-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124043015.1388867-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 5/5] perf test: Make daemon signal test less racy
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The daemon signal test sends signals and then expects files to be
written. It was observed on an Intel Alderlake that the signals were
sent too quickly leading to the 3 expected files not appearing. To
avoid this send the next signal only after the expected previous file
has appeared. To avoid an infinite loop the number of retries is
limited.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/daemon.sh | 34 ++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index 4c598cfc5afa..e5fa8d6f9eb1 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -414,16 +414,30 @@ EOF
 	# start daemon
 	daemon_start ${config} test
 
-	# send 2 signals
-	perf daemon signal --config ${config} --session test
-	perf daemon signal --config ${config}
-
-	# stop daemon
-	daemon_exit ${config}
-
-	# count is 2 perf.data for signals and 1 for perf record finished
-	count=`ls ${base}/session-test/*perf.data* | wc -l`
-	if [ ${count} -ne 3 ]; then
+        # send 2 signals then exit. Do this in a loop watching the number of
+        # files to avoid races. If the loop retries more than 600 times then
+        # give up.
+	local retries=0
+	local signals=0
+	local success=0
+	while [ ${retries} -lt 600 ] && [ ${success} -eq 0 ]; do
+		local files
+		files=`ls ${base}/session-test/*perf.data* 2> /dev/null | wc -l`
+		if [ ${signals} -eq 0 ]; then
+			perf daemon signal --config ${config} --session test
+			signals=1
+		elif [ ${signals} -eq 1 ] && [ $files -ge 1 ]; then
+			perf daemon signal --config ${config}
+			signals=2
+		elif [ ${signals} -eq 2 ] && [ $files -ge 2 ]; then
+			daemon_exit ${config}
+			signals=3
+		elif [ ${signals} -eq 3 ] && [ $files -ge 3 ]; then
+			success=1
+		fi
+		retries=$((${retries} +1))
+	done
+	if [ ${success} -eq 0 ]; then
 		error=1
 		echo "FAILED: perf data no generated"
 	fi
-- 
2.43.0.429.g432eaa2c6b-goog


