Return-Path: <linux-kernel+bounces-45836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78168436D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94682281CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9254F214;
	Wed, 31 Jan 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lEY1N22a"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380594CB4B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682664; cv=none; b=Cjcq2SmCNS/XA95gfPyhSHYM8FP8I7mNqTRCF8q2WfYEaUiFAip4TyGzwp58VT7dlAHByFE6ihESPOMa3X9YIBtkxgPQQeHBppvbP/D+D/1ouMJmdgx1yASpH7wOO46yOrWhH2F8ne5Db1Ek7hEkRy80hv9daho4+/4PlfDYZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682664; c=relaxed/simple;
	bh=u2dme1MUFaWQF1BSStVrUjjYLnHIqMsZ+Wjfwetyd+o=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ASjI7oXFDIw1Yxw2hCTH7OWtfatYRopSrPcXnWVa3I21dK6xrT49yCEFc/VHmRoVqs9PFDstu5SWhXGRWzLWf5Md2lSapRp64DGVgrqJLY7POh+4eRvivDS/YY+BKwoaF501DIlvJYf2JCSBiJue/AnilghXrPDCcnC1+y9bePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lEY1N22a; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6040ffa60ddso2077417b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706682661; x=1707287461; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TRAmZ7zfR7GIpS+aIsz6syaxM6Q4TrPavG5oF05xWJs=;
        b=lEY1N22aJJjhJRhsVvGAVQPEvDbXmvRSX97spBk7Kb2HByaW1DeNHA3PKNI49OeAvV
         nuF3qFqv+xfoQmEsMnaJLSr0I51Xk3m6lUtvepUFZdeL5YWiJFgj6idkZSau7c2dJ3wv
         tQhUiIvoiy7ST5arM0rukkJQpspxEo/vjviYkqFTXAl8QFHMSKidDA2bv1utAWEs/b02
         oUl7FaKzrA5I7PTQcZZK6Qf7cDzqPW5yYOLgfA8klQ+AG/xmEPQeagIf+4fbmx9iaLL6
         dWj6pqNIc3iloB8cvSU4Ua85fYXDoVtEAq+QDmuAeZywfmnOLvRD4p2U9eh9R1XWWKPX
         YeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706682661; x=1707287461;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRAmZ7zfR7GIpS+aIsz6syaxM6Q4TrPavG5oF05xWJs=;
        b=XIcSHmPhaxzNFWYMSYayznhuOh7htaicjk4vjrxwl0BWPYSm/iJ79RoX9r9a2Zw8QM
         n5gSrRI8mrzTKNVrLZ3QClNoj808AOFESiTiOAYaZco/E41bu37VxsVBYVtid0pjIUG4
         bybm/FqTVd0dNgGoJ37CK33uGhLgAhajnKwUUBgzORt4GxiVLvN+mCynO627W8U3xFfT
         xFgi81GXpJfsQ/5adsc4vSBkI2SqmfN1WZjdsywSBRvyuj73VtFfBtALisyr3JMwQhtO
         tWMWlJXORQcDIS3uBK7DKy4dGe9E1MMMSPqoPFno2/LRPUSzLuficwUH4OgAbKkU7BaT
         Wq5A==
X-Gm-Message-State: AOJu0YwUgHAME35e12iwp0zLVQD/FS/7puAenw42j/wre8OrT49GCmvm
	5TtVBsA3zgVxBkKvPU+1KM5qfdJTwfS7sPaWpm8IfR8GHZIOIfDtGKl0Rs2XV8ZYx23o5S7BS1P
	Sudl61g==
X-Google-Smtp-Source: AGHT+IFsiiN7iGKJd/InFXViWO69CjjVsRDCvAxsD8KKE2kphIKbHGhlve9tfNNSeYZg/JPhRlGwiUilpQ+z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d0ab:43c6:7969:62ab])
 (user=irogers job=sendgmr) by 2002:a81:9946:0:b0:604:45a:6740 with SMTP id
 q67-20020a819946000000b00604045a6740mr134886ywg.2.1706682661259; Tue, 30 Jan
 2024 22:31:01 -0800 (PST)
Date: Tue, 30 Jan 2024 22:30:46 -0800
Message-Id: <20240131063048.492010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1 1/2] perf tsc: Add missing newlines to debug statements
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


