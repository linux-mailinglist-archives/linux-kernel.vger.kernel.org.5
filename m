Return-Path: <linux-kernel+bounces-102800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B087B76D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815741F2357D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1455DF59;
	Thu, 14 Mar 2024 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CO9py+S1"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98FCD267
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395482; cv=none; b=UBJu9u+JdwFZzmO+Es7G08B4fS8j3HZsbSP+kGJDIvgDLQYdtBPZjHBM0TNDzA9ujQAVqYyWm7jfaznBHpcG3dtyoN+GbbGFeQYYxW5ryQil8GdstG7B+EjqSxw1/vQ7RYrlmj4otSv5rAPtU1WPMTkGbJV8f5FOFWE2uuquoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395482; c=relaxed/simple;
	bh=pYwFBWamBieIdW9SZt9AVp6RucUVMKW9akUtx9h7loo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=q/mgZWpn2PqkBQgkjoShUJGLcJQGPFDTxIB/zrRIiaj+9qBhDW5VeMVogvhMaGVVhQEXOd/AbopVoV0+ziJaVGNmrF/zKealf6vYthtdFIVe/ICkoiNfZfshWawtJc0YlA7oqTM4WFxFTo6QfigGNv1YAliSVliLxK10DWeGeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CO9py+S1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so841172276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395480; x=1711000280; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Ycxt5yLzxCom5vbiObPBkTkTg6hjsPvowJcvLZ1CJY=;
        b=CO9py+S16TCITvJ+syklCg+mB0n32HiRA+0gFeySmLSIzl53wuaezzVvag8TAxi83o
         mC6TXaK7YEcAbKC9f4tNXmA+IOihaKqwAw1Y28+cWyFxDdxMtM7bVk+h/b5BLnK10Nju
         f4TPF60EZh9W18en+4GnW4tyiMap3XxIvZ1QSDsWZDnW8+qhp8hqt19wC4Z1+glZqdz5
         GP58P814iYmB9a0wFLW7WFF+xCXuC456XENaHkEwGZMf+jvbWUKkSBhTdAM/esRyXdZq
         n3EOYKt6kpyGdsOrPuLig1rJS+Sjq2GBdLOiCQIUx8bsYKJPwJOziOUXnqL1usQP6AfS
         1tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395480; x=1711000280;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ycxt5yLzxCom5vbiObPBkTkTg6hjsPvowJcvLZ1CJY=;
        b=D0UE4aF/s4kK52NWqo2JGyxkZcdw6zYwHRCIF1ptNyzIpVRKn+Ymo5lrhSW/ic6mGQ
         doHs6Lk3GDDH22KiTFRaMLnYdwbrWWGNvCvb8/2cc8KW13rl58q4GiEooFDRIgS+VwCk
         1nunZIf6oDbMLI02AliMYg6nOUvtAN+gFGXUsASq4ZSHwDnmwnMFRAuObJuLEEdq6hgb
         IQ4oy5bCKt2xoWFAUjoJFnb0KRncrS3bpjTxS1/xrsyRMC9kJYLIW5uZxzxcIj+rB4bk
         BYLfso41fZpQU0ImNSOEmJ4C4kWjLymcLaY6s9uRCdEeTefpPISB+3hZViZksbLHaApg
         W4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXv3orUL8gN6uqg9qRtursEMQH8WCOSJ9bZ28bXYMcFYk/HcFt4pJSR59GiMloZX+0kMgWwekQFAX3mbsFYKWBOyEyY+bnIneYa5auT
X-Gm-Message-State: AOJu0YwzAeM3EKtpm/57Hr6aRou8Z2B2g49pjHS8Ja/306vgc99cvjyU
	4pKz7z0Wya4dWnqhfEqkBLTjZZ0bBN6Qo8ekFitUg0+8jZCPf/t6Z1yHEysMzkPRT4iFDoLWlPX
	D/Qvm7Q==
X-Google-Smtp-Source: AGHT+IHe1agMqsMATLFIo2OsHql0jl2X0vTCAH83A2XiKg/x3LK3+VtXRJBuf2uvfomEwPmpZr6WfAQkwEAE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:e04:b0:dc7:68b5:4f3d with SMTP id
 df4-20020a0569020e0400b00dc768b54f3dmr250371ybb.11.1710395479705; Wed, 13 Mar
 2024 22:51:19 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:40 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 01/12] perf jevents: Allow multiple metricgroups.json files
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow multiple metricgroups.json files by handling any file ending
with metricgroups.json as a metricgroups file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index fc704a96ba0b..f68b0a60cdef 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -608,7 +608,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  if item.name == 'metricgroups.json':
+  if item.name.endswith('metricgroups.json'):
     metricgroup_descriptions = json.load(open(item.path))
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
@@ -658,7 +658,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
+  if not item.is_file() or not item.name.endswith('.json') or item.name.endswith('metricgroups.json'):
     return
 
   add_events_table_entries(item, get_topic(item.name))
-- 
2.44.0.278.ge034bb2e1d-goog


