Return-Path: <linux-kernel+bounces-136135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B5A89D060
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E1E28314A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539554F92;
	Tue,  9 Apr 2024 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xz+/+zvo"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C97548F6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629944; cv=none; b=n40AWzJivyAsy8UhTNXTJfroHu/8AzztfdH4t/DjAvelQ0wVbYtCKBgEj0FrHm/BGqZVr1/leUrisGU3oWnbz1vQG4vGMsSSUSqJ4SIEhraQwKk1sgjAIH7ZUXT4kvchxyg0wqS10DaFGcUmxlgNDiGeU+LSriVipUtr+kWqvNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629944; c=relaxed/simple;
	bh=zHgb1DbnyWnwYo9RlywRWcr9fcdSFqF5Ep8ycDoGlCM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=g+g7uc7gQQkoPIF81/8auJz580KjIjJl6edDmqXRLK8sftc4nn36dh3C4vBnf4UwvCzwB+pDpd5KtjuJptTIz5Oq3KkY3EcIO4R/2ZDfVaiAd8RnmV6WLhtgQprbzJhayA0M9J6dRtAXedL3+N+K0MRgG3q6mhGROODpD2wAbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xz+/+zvo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd1395fd1bfso8705018276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712629942; x=1713234742; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEEizuBA0YDf+F6hxxsK9XiEMrVCNDKuwIuop/k9nwY=;
        b=xz+/+zvomO1c/SFI2o2akmfEGMN9KaDo80e9pvyjP++ljBpVNk78bRLjeiiWhwATW5
         cJTr1tRccLQGOX3yvmcCOXoRZEs17coeJTfm4fybldzWz30L38ZHVxHq4ubE3/X1zxYe
         1gAO+xH02wqZIX3MxDCDqX/pOrQlbEKFPqEB5I5G6QjYriAqtxpCuzStROaMfygLfGzS
         yQHstCV7tFD941UGdS2qJQL7hWPOeG1tWtUYDsN2o0+18FsN2axMECrCDUABBTCEjc//
         ZSmE7qOtjhJJTMF6qofIqoyuN7hYiTyGjUANbhQeQTlEbN7nMJ6YRPwzcQk+XV8Mvwuv
         5FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712629942; x=1713234742;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEEizuBA0YDf+F6hxxsK9XiEMrVCNDKuwIuop/k9nwY=;
        b=VBgJqObfFxiiO2wwA2j/SO9SQqmNjFLtDDFFUNh/rzpyIgAKBJ6Yhn3KIXZ3ytuBoL
         vV/lNCIFMg9jPLLXh7SelAN3w5c/sDAIuX2O5u6OwdT27S/zI/pXMHNZNpVii1Ljiiae
         WiuqlL4oFNgG+A9ef5jBlflAR+dLe2TNgG30mPQSj0aYkl4ZDw0bW86R+N+i5z5tqNYD
         u66aDQpVK9PKAA3Tqm0CCQRA56rsBrHeiKiUOFL4bTtTm1GW3J4phlMiHmQ2442lW65/
         B4l3f4vGjm5eKLZoZxb1bXKo6EP1T8RGkTxpCMz8ojVyOosshBd6eavsQ+GDcrPCtnSP
         Nkrg==
X-Forwarded-Encrypted: i=1; AJvYcCV7maalaC4WOjT37bNHsytpWeV03FZWrLBe3YUkwBMZCj4HDEDPK0tCWuge3/+U716dDjpYZpiBC5bFTV8/kfkWBzU1nlCvCxgjzupC
X-Gm-Message-State: AOJu0YyNfUeEGOfMQVJxjm2EM7G2gjGLtJA8RSMNaIrktz8BS9f4yA4z
	+YhLvvGEtXzwaiErsZ2LWiDhxwFe28UZBt+19dkiFE1ABJ70J5zaqPyl8klltJrKwhMLJH8U/eF
	aj8qZUA==
X-Google-Smtp-Source: AGHT+IE/lTIb1w6m3oLvSH6LqosiDNwlIHfQKtduMtwdgVR0hA+1SlxrCW+9N5nSCHi+rxVOlZa0RIKPVMJJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5520:7788:6b7d:7115])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dda:ce5f:b4c3 with SMTP
 id w10-20020a056902100a00b00ddace5fb4c3mr3531327ybt.1.1712629942342; Mon, 08
 Apr 2024 19:32:22 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:32:13 -0700
In-Reply-To: <20240409023216.2342032-1-irogers@google.com>
Message-Id: <20240409023216.2342032-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409023216.2342032-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 1/4] perf build: Add shellcheck to tools/perf scripts
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Address shell check errors/warnings in perf-archive.sh and
perf-completion.sh.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build              | 14 ++++++++++++++
 tools/perf/perf-archive.sh    |  2 +-
 tools/perf/perf-completion.sh | 23 ++++++++++++++++-------
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index aa7623622834..b0cb7ad8e6ac 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -59,3 +59,17 @@ perf-y += ui/
 perf-y += scripts/
 
 gtk-y += ui/gtk/
+
+ifdef SHELLCHECK
+  SHELL_TESTS := $(wildcard *.sh)
+  TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
+else
+  SHELL_TESTS :=
+  TEST_LOGS :=
+endif
+
+$(OUTPUT)%.shellcheck_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(TEST_LOGS)
diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
index f94795794b36..6ed7e52ab881 100755
--- a/tools/perf/perf-archive.sh
+++ b/tools/perf/perf-archive.sh
@@ -34,7 +34,7 @@ if [ $UNPACK -eq 1 ]; then
 		TARGET=`find . -regex "\./perf.*\.tar\.bz2"`
 		TARGET_NUM=`echo -n "$TARGET" | grep -c '^'`
 
-		if [ -z "$TARGET" -o $TARGET_NUM -gt 1 ]; then
+		if [ -z "$TARGET" ] || [ $TARGET_NUM -gt 1 ]; then
 			echo -e "Error: $TARGET_NUM files found for unpacking:\n$TARGET"
 			echo "Provide the requested file as an argument"
 			exit 1
diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index f224d79b89e6..69cba3c170d5 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -108,6 +108,8 @@ __perf__ltrim_colon_completions()
 
 __perfcomp ()
 {
+	# Expansion of spaces to array is deliberate.
+	# shellcheck disable=SC2207
 	COMPREPLY=( $( compgen -W "$1" -- "$2" ) )
 }
 
@@ -127,13 +129,13 @@ __perf_prev_skip_opts ()
 
 	let i=cword-1
 	cmds_=$($cmd $1 --list-cmds)
-	prev_skip_opts=()
+	prev_skip_opts=""
 	while [ $i -ge 0 ]; do
-		if [[ ${words[i]} == $1 ]]; then
+		if [[ ${words[i]} == "$1" ]]; then
 			return
 		fi
 		for cmd_ in $cmds_; do
-			if [[ ${words[i]} == $cmd_ ]]; then
+			if [[ ${words[i]} == "$cmd_" ]]; then
 				prev_skip_opts=${words[i]}
 				return
 			fi
@@ -164,9 +166,10 @@ __perf_main ()
 		$prev_skip_opts == @(record|stat|top) ]]; then
 
 		local cur1=${COMP_WORDS[COMP_CWORD]}
-		local raw_evts=$($cmd list --raw-dump hw sw cache tracepoint pmu sdt)
+		local raw_evts
 		local arr s tmp result cpu_evts
 
+		raw_evts=$($cmd list --raw-dump hw sw cache tracepoint pmu sdt)
 		# aarch64 doesn't have /sys/bus/event_source/devices/cpu/events
 		if [[ `uname -m` != aarch64 ]]; then
 			cpu_evts=$(ls /sys/bus/event_source/devices/cpu/events)
@@ -175,10 +178,12 @@ __perf_main ()
 		if [[ "$cur1" == */* && ${cur1#*/} =~ ^[A-Z] ]]; then
 			OLD_IFS="$IFS"
 			IFS=" "
+			# Expansion of spaces to array is deliberate.
+			# shellcheck disable=SC2206
 			arr=($raw_evts)
 			IFS="$OLD_IFS"
 
-			for s in ${arr[@]}
+			for s in "${arr[@]}"
 			do
 				if [[ "$s" == *cpu/* ]]; then
 					tmp=${s#*cpu/}
@@ -200,11 +205,13 @@ __perf_main ()
 		fi
 	elif [[ $prev == @("--pfm-events") &&
 		$prev_skip_opts == @(record|stat|top) ]]; then
-	        local evts=$($cmd list --raw-dump pfm)
+		local evts
+		evts=$($cmd list --raw-dump pfm)
 		__perfcomp "$evts" "$cur"
 	elif [[ $prev == @("-M"|"--metrics") &&
 		$prev_skip_opts == @(stat) ]]; then
-	        local metrics=$($cmd list --raw-dump metric metricgroup)
+		local metrics
+		metrics=$($cmd list --raw-dump metric metricgroup)
 		__perfcomp "$metrics" "$cur"
 	else
 		# List subcommands for perf commands
@@ -278,6 +285,8 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 		let cword=CURRENT-1
 		emulate ksh -c __perf_main
 		let _ret && _default && _ret=0
+		# _ret is only assigned 0 or 1, disable inaccurate analysis.
+		# shellcheck disable=SC2152
 		return _ret
 	}
 
-- 
2.44.0.478.gd926399ef9-goog


