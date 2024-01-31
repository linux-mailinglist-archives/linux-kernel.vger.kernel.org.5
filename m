Return-Path: <linux-kernel+bounces-46532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62CF844101
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2ACD28F7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932F080BFA;
	Wed, 31 Jan 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPdCq7EN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2DD80BF1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708990; cv=none; b=fVSzxVSAPr5xPSuAywgT9e521wYXmjM74WZePgBFxDpI52c7DnQGog1Ggrew0XEwzczYPklsGsdFfrfwEPK2hVyRkIVbyHEMN/NlgJTEa6P8N99+/icIaORlm1NvC+6CFPeVNW1tDT9vfALbJv++IWpgbI1E3a063SLAdRNF/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708990; c=relaxed/simple;
	bh=u2dme1MUFaWQF1BSStVrUjjYLnHIqMsZ+Wjfwetyd+o=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ESjZZp5/+tUACIiAQEUjiqdDEUb5US82Z5l9U9k+BnBopxpmopXwN8BGsa33mEDPFPYo9gyr+zDWl8cmpAoZjumvYSVlfGWKhd3bXO9YiwJKmrXkjYO3jwONQbOt8F/oMYkna36QC+OUeCuhWaX5o/JrjkcTMfMk5Jluou2IIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPdCq7EN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6c47cf679so801533276.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706708988; x=1707313788; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TRAmZ7zfR7GIpS+aIsz6syaxM6Q4TrPavG5oF05xWJs=;
        b=XPdCq7ENDKCH03IYWpJWWzcDbG4raKx2XumxlXaJJevXX00oTKTWX3gHAWyUBXtzIU
         1Oy2YV4FOV+GXeGSYj4Kbng5P2avdJbN2eytRr4Ed1NK1DLu8DbJIngkCqDrl8KijmUz
         9PMilDUg/C0CvHP0K/dHPFk6+UxS88zyGm1CiYCpuPFOKYzeLvBxYUJQ1kJoFaLAg/Z1
         BpXMDur1nrdknuhK7eg7kc4OHg+CevQSNPA3glys5LDOMbnLXKAPg7kKV0NV7q/yazsP
         bhiAbj0mQO5Yp2QGCmPbHXzkX6/x4H0JU8FrPAXTwYnEfQyPbegJC//qxB6S4rgaiOMV
         Mffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708988; x=1707313788;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRAmZ7zfR7GIpS+aIsz6syaxM6Q4TrPavG5oF05xWJs=;
        b=m8wew3YKwhIS04doYFOtwdokot1HD1qbkq3QmBJSPcRKyoIzAlhQW9NjW9aaRsJKIO
         FkgRf26Ngyhpvpbz53P+6yanHNpdSWZGHjq9evVb8bY/e8zfdL2UQpsd2xfBIoMeY+S1
         3OFZvesSXVaiHNKalCzgLwHrrZe97X+8NVZ6noeA3BYPYL93DRRI1uPffkavG3+JTrDU
         5M8MEZpkIV//Eg4YTkI7Rw7ST190UeT5rsZ33+kegI7AYkiTsM2xabnTbs3subGO3Skx
         rpTrb3De0TE/HGwix4IwSPqebHyK2Y6Q9YpHzJQ2gGN4cxPdk//FjMOdYzKSfePD0Zi9
         sOCw==
X-Gm-Message-State: AOJu0YzO8X9011nmM3JnscCDm4H4hKj0KvUWxs/Gc5IdJIlWXqznZpA5
	MHc8aZFlcT7GhaqZpj1MOfuY4Z7rzdhUoXiYCQ2GXvJ5g088B+DiDiRLggqcCL9dMeyR4/sePLc
	TALlQyg==
X-Google-Smtp-Source: AGHT+IGgH9VGUNbP6lTtRKVCwmmsOcX/L3HvdfE06R8+BcjhYIuCAG2dqmf3z8P9FHQAPg2aDpRvX5PKpcMV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d0ab:43c6:7969:62ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:1793:b0:dc6:519b:5425 with SMTP
 id ca19-20020a056902179300b00dc6519b5425mr468454ybb.11.1706708988337; Wed, 31
 Jan 2024 05:49:48 -0800 (PST)
Date: Wed, 31 Jan 2024 05:49:38 -0800
Message-Id: <20240131134940.593788-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 1/3] perf tsc: Add missing newlines to debug statements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tchen168@asu.edu, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"

It is assumed that debug statements always print a newline, fix two
missing ones.

Signed-off-by: Ian Rogers <irogers@google.com>
---
This patch was inspired by bad debug output in:
https://lore.kernel.org/linux-perf-users/CAGjhMsg_bVKJ_zfsLUR32+oZwGDr3OiBHV_BJ3QtFjyKAs7Sgg@mail.gmail.com/
---
 tools/perf/arch/x86/util/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 9b99f48b923c..e2d6cfe21057 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -33,7 +33,7 @@ static double cpuinfo_tsc_freq(void)
 
 	cpuinfo = fopen("/proc/cpuinfo", "r");
 	if (!cpuinfo) {
-		pr_err("Failed to read /proc/cpuinfo for TSC frequency");
+		pr_err("Failed to read /proc/cpuinfo for TSC frequency\n");
 		return NAN;
 	}
 	while (getline(&line, &len, cpuinfo) > 0) {
@@ -48,7 +48,7 @@ static double cpuinfo_tsc_freq(void)
 	}
 out:
 	if (fpclassify(result) == FP_ZERO)
-		pr_err("Failed to find TSC frequency in /proc/cpuinfo");
+		pr_err("Failed to find TSC frequency in /proc/cpuinfo\n");
 
 	free(line);
 	fclose(cpuinfo);
-- 
2.43.0.429.g432eaa2c6b-goog


