Return-Path: <linux-kernel+bounces-166999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F168BA32D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459221C209F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F2168DA;
	Thu,  2 May 2024 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zco1UODU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811812E47
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689112; cv=none; b=cdm6ZQF7CJ1ieJCTsnaJ9f5JwoZy8VGKHSrGGI8F0slL966vtZKTXRn2cUaHTQcrRkN8OJu61e1W1Msbyrj4UTazLTavkAGzYJZrpBJxm8LjAL3EKo4ZlFQEBHwqobOwUki7lpSwWskCYlcl38mlNZSMCiZBmmuQcHO3RZATQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689112; c=relaxed/simple;
	bh=mVhefkMKYAgbzew8H9zwdvpcck6nt+d0ii0oo+fk8MY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=jin4TzqfgN1msZKzRMV4mxfiVi9+pvz16cOPkL6vSZ/pEgPi466HMSA7sNsG89zjqMyDw6kndzRd+BVpFoi4rtlRAQuFmGe/yWMsO/e2OMp/WfevhopcfAPBcV9xgVHrxWKBabFEfO1qKlLGwrY73OXKy6kJq/BFdKQoJQATLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zco1UODU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so174204247b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714689109; x=1715293909; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D9BlVLjpP7oToPEloTg+EP74LvtZdSlc3EOCbIFaf28=;
        b=Zco1UODUtmQjINKK1ayFk5w/Lz6/sySujiFOSzaSGo5O/GNlzjoFEshkRtoxrm8T9b
         fFq2M+6a3Iw2CVuGmcjrdil/RNq8XueAPc0wthWV949fDEDTfhin12XPejRiASPPXqL0
         VSgs7YyNun1/0SMYwzspfDhXEUnzECfW7b1KCWiPo+LMQH7T14yfXZNg2K94afGsvY/8
         Nd/w/vmadayaEbuk2GIKOJDTnZJJdb/HHVmbikq0Q357C7EKKVWLbCO8O9nn6Q4+5TEN
         CsxqKhrBVOvULerUJ/hAqIcmmWKCm6OVZTjJy98RtLFHqun9Dxw2EZnAHEZuemxazg8j
         1xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689109; x=1715293909;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9BlVLjpP7oToPEloTg+EP74LvtZdSlc3EOCbIFaf28=;
        b=pZ6iNQx9uAYfPVvQnMz2bx15X6lpgxIfqtbARttVgB9f/V/7cbGGMcnoed6al88th7
         K++AqaHLNuXCCU9hd4F70w6zr8WljTfwQ7k2iPXauI4jUZOsjVF/l5VAe/r92Yqlv7iK
         qMg1VBqWa7Ce+xoJfFU1OsktORPTB1eoh+u8J3yiT4wUWJid5qgv1INpGs/TFaHZ3JRJ
         EWESWeR10rsAcMXhmZ16CL2/SoXuSAYKymebbVS0O6dZbADLDszmMxp2yVVkUx9MbnLT
         bk2H6ZGgWxELOy8P2FYiUjS46/jQiGAmmeNulG2//3NJv+QD32HiBg72VSBuMYHMhWU/
         QqsA==
X-Forwarded-Encrypted: i=1; AJvYcCVfKunKtz60Fvyy4qQqry4Utg41Rd1za9KC3b2qq40ZuJZJWzNcQ2qMRhm6+kxOSJHPaVfmceBNS2kW4eFur5M07eaidmZ7ZrC+39nq
X-Gm-Message-State: AOJu0YzLRHvECca4omSe2gsI2EiQVQYgBqbZczHl2M605IoA33q2V/px
	cekiJCdl4x/DNMXkhCRpEFZUP52KCzGLHZTMMvNv8bJqQaXitdluqH/AevnF4PfdyfTjhvebz5l
	ObnIinQ==
X-Google-Smtp-Source: AGHT+IF4e2VbqkN2jjNWKDDm3Gcln7ovSliebeDlmk9dm6IpKVCKWNcrpc6+GmqKSfIrd1hZK2lR4tHdmIyq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a0d:d78b:0:b0:61b:e15c:2b84 with SMTP id
 z133-20020a0dd78b000000b0061be15c2b84mr187197ywd.6.1714689109242; Thu, 02 May
 2024 15:31:49 -0700 (PDT)
Date: Thu,  2 May 2024 15:31:15 -0700
Message-Id: <20240502223115.2357499-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v2] perf test: Be more tolerant of metricgroup failures
From: Ian Rogers <irogers@google.com>
To: Veronika Molnarova <vmolnaro@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously "set -e" meant any non-zero exit code from perf stat would
cause a test failure. As a non-zero exit happens when there aren't
sufficient permissions, check for this case and make the exit code
2/skip for it.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2. Add skip if event mode isn't valid in per-thread mode. Suggested
    by Veronika Molnarova <vmolnaro@redhat.com>.
---
 .../perf/tests/shell/stat_all_metricgroups.sh | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index 55ef9c9ded2d..c6d61a4ac3e7 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -1,9 +1,7 @@
-#!/bin/sh
+#!/bin/bash
 # perf all metricgroups test
 # SPDX-License-Identifier: GPL-2.0
 
-set -e
-
 ParanoidAndNotRoot()
 {
   [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
@@ -14,11 +12,37 @@ if ParanoidAndNotRoot 0
 then
   system_wide_flag=""
 fi
-
+err=0
 for m in $(perf list --raw-dump metricgroups)
 do
   echo "Testing $m"
-  perf stat -M "$m" $system_wide_flag sleep 0.01
+  result=$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
+  result_err=$?
+  if [[ $result_err -gt 0 ]]
+  then
+    if [[ "$result" =~ \
+          "Access to performance monitoring and observability operations is limited" ]]
+    then
+      echo "Permission failure"
+      echo $result
+      if [[ $err -eq 0 ]]
+      then
+        err=2 # Skip
+      fi
+    elif [[ "$result" =~ "in per-thread mode, enable system wide" ]]
+    then
+      echo "Permissions - need system wide mode"
+      echo $result
+      if [[ $err -eq 0 ]]
+      then
+        err=2 # Skip
+      fi
+    else
+      echo "Metric group $m failed"
+      echo $result
+      err=1 # Fail
+    fi
+  fi
 done
 
-exit 0
+exit $err
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


