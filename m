Return-Path: <linux-kernel+bounces-64737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83392854221
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C341C2673E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1873010A01;
	Wed, 14 Feb 2024 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xUNo3MuT"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8900C154
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886476; cv=none; b=qay91gEqLcet8LBdX0RznmUP0bLKoGOIppzCH1WOVAyh4qT7rHFCHvbT2dw8FiTqaOkPHvLJpRULZgRKX1PK7SdIItJOsR2GyItm5KNao7tGO5Te+m3XIMO99dDtJjrUTNGD7uOR7Mczv0vGSPXu9t32tzkJUtJsCglc9jkX6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886476; c=relaxed/simple;
	bh=9GvaQ8U/ciyGf0POxeefEusSW20t+DHMSsugj/N6ETY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KXd0EB6GbFEiBbX/ZcW3RVpfO8sBARiA/4vB7pD0PqmW32R2ecgqqn2XK5HXQz5sUkZ/1Ct2pK4ypd6YtSMuqsuFGn2SQ5Xpvgwzo4qT6vypE6uLEhaOEpvSKp2PvP6vAL3pY0M9bccWlsLlvaZ7grMjodTa3EH/cG5C5e7tYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xUNo3MuT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74645bfa8so2588395276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707886474; x=1708491274; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6UUwQ6uU0gh1AgBT5LAdlyWuLVQW/eRWP9wNVATd0w=;
        b=xUNo3MuTCHNPNBQSi0iOeCYRhkZNpLcWuhCz+RXhzVfhzxK+TFj5UCTqB1yjMiEgf4
         Y2IG/TsNqIuLvuXhVgwCfrFqkulqkxzpGVoKkvlnkvgmtXb2fvm49DMi+Cx4GsUWHQrZ
         sWYmkj0jSbpPEK9d36KD+H81PqEqLB+Dy2jKJeYw3fZYvAS1ASJvzI4cLcAKXNtG/yUE
         TWjImoL4OLfJtmjCA1uNDwXgoX/RJOZzGnIhuSWn0e/QVWX2zxnobM7lxur5JaxWHXVI
         Q5X5Zf41wd99vLJfhXQ4rztXfxNuf+epH4qJaFXBRbgLreCLKQGyL2o/vWpZP1VeA/E9
         3aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707886474; x=1708491274;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6UUwQ6uU0gh1AgBT5LAdlyWuLVQW/eRWP9wNVATd0w=;
        b=EVrpg7TZ7ydQjUykt3RJKokphZVTT/hi+i318IJJc+H5AhxtqXvCxWXVX0Pp2SsuaD
         GPIYRT62ID5n8BXhq9vYoRuzPLMSHPJPVstNQ/Hs1KvfVu2UHP7ewsRI0gYMXsU03s2v
         Dsjst4rClrj2WMSwfI5fi83f3UsuPj1Gh+Crkjisscmb/WyN8NtmLT92WXYcc3KKN68C
         JD/vzGltgKcWepqSmhHQU63/VylN/xwqH5rgxB4ewPL26tGHUe0pU4/wfDpwksvKwkEv
         Fka+txiiKAW2i4I2dXAI2aPAh80tZB+ENUib9uYJHCkmKze8bJP9qRjcVGbZeH2rX0Ct
         UGVA==
X-Forwarded-Encrypted: i=1; AJvYcCXd5/Pp6ZXramDNMiZw1c3sLrdrnjnm1TTeILrSe6Q9NBrnHPiXLovtC6hRoz8CMgJzkicz9nI3mRpFJj2ZHwjhwe/S3rKXrvzZnf74
X-Gm-Message-State: AOJu0Yw7EmPzVEiZ/B6jdZciohlbrWXBUax8v89gsepi8YnY4bb2+VQr
	ePHlPdrpMWfVbbBIM5M6MSo4R5BlJkLY1EoYSOATNQljaMwiu0Znmf1/oU+759ZlZAzSVnxFiRl
	kWPzVBw==
X-Google-Smtp-Source: AGHT+IEYhgWjbXFx0sxYnQQnVr7GNh7ZLD+INkja+l1mji2uo3Azkx4WVasjvNd44POf3VLkrK39N5w37xYF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a25:d3c6:0:b0:dc7:6cfa:dc59 with SMTP id
 e189-20020a25d3c6000000b00dc76cfadc59mr50124ybf.4.1707886473857; Tue, 13 Feb
 2024 20:54:33 -0800 (PST)
Date: Tue, 13 Feb 2024 20:53:49 -0800
In-Reply-To: <20240214045356.748330-1-irogers@google.com>
Message-Id: <20240214045356.748330-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214045356.748330-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v4 1/8] perf thread_map: Skip exited threads when scanning /proc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Scanning /proc is inherently racy. Scanning /proc/pid/task within that
is also racy as the pid can terminate. Rather than failing in
__thread_map__new_all_cpus, skip pids for such failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread_map.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index ea3b431b9783..b5f12390c355 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -109,9 +109,10 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 
 		snprintf(path, sizeof(path), "/proc/%d/task", pid);
 		items = scandir(path, &namelist, filter, NULL);
-		if (items <= 0)
-			goto out_free_closedir;
-
+		if (items <= 0) {
+			pr_debug("scandir for %d returned empty, skipping\n", pid);
+			continue;
+		}
 		while (threads->nr + items >= max_threads) {
 			max_threads *= 2;
 			grow = true;
@@ -152,8 +153,6 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 	for (i = 0; i < items; i++)
 		zfree(&namelist[i]);
 	free(namelist);
-
-out_free_closedir:
 	zfree(&threads);
 	goto out_closedir;
 }
-- 
2.43.0.687.g38aa6559b0-goog


