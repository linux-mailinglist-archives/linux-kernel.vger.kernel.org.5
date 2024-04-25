Return-Path: <linux-kernel+bounces-158376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D09D8B1EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B5C1C20FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A75D477;
	Thu, 25 Apr 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKZUmFgM"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED386AE2;
	Thu, 25 Apr 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040250; cv=none; b=e1hI3dK+KJmyxARZip1812oUG2/aLJ4YVBjT8Z3ct42+HjLIIDmBfGWUjEN3GZ9qx83gkOKuAKVuKrsoF+aKArO5OjylQraUBvyALpv3A8pn4KegCuzQIoCKP/gdkJFEyhe9eIYo79aM2vxapDgY/evONbsPVgwYo40XM+27OaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040250; c=relaxed/simple;
	bh=h6c/iz0/hGW+t/SoQR9KYo1rv6hXOZ73jgFdz1C30Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJAtJfRDo/yT383R0QTvkecuANDMRtI0vvQ4rnBfLHFIc1WpTmcwZ8zu6mT9ky5hkgHyinOsl31OgALqq6oZ9l0jDLSkx0e53TRTuX3/YeVEN3EQzLVztyP9S+Tu4Rq0IC1UU++sp6HtH3w1I7PHLfb67Jsz+sCTuglZ9AC/NRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKZUmFgM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571c2055cb1so129411a12.1;
        Thu, 25 Apr 2024 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714040247; x=1714645047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DyJz1NSu4FQMeQ6GqAUKmKYgFhAoaWe3Xjy6oxrQH3g=;
        b=gKZUmFgMGrGL9wJM5bBEjPl2mIkywCPoNzMCyks9T9G19yeUK+7/iAKnkVN8BFRTXx
         N8/rW0B0TUlSDc14jiWM3uoBK3qCSXAu2DW9O64MHNHyuT5TIDOc0DmW0XQxkEyYuTkW
         kbXYgjUKnT2eShpe556tZocit0ki2NdoQooyy6t4aqmYEEgQjKUtrFyd767ZGICZQeVU
         B55tMqkivnJlG0HB+4IsyVAhbdpHa6ZIAMIInSQ1NQFhZXK9Rme+I47gCfWWJdC6dYLN
         xvSgcHgFqpHL6sAw7VhLmnI6LFVsh6WoX4QqlIz1NnBxudXc0yitLmf9CxoxAL5MUOIz
         BDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714040247; x=1714645047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyJz1NSu4FQMeQ6GqAUKmKYgFhAoaWe3Xjy6oxrQH3g=;
        b=qvQdltl/2rjI4uEhR9YYgsSRLmYgkIfOx0ejHlsG/x2Pb56eocKaJ6xFiZg0l5lF5E
         Fv1R4TzwtHrPMLQkOfN8ZT7FyhTxF1IdY6FylydLgEn47Rg5ZrjKLaq9unwrt+WBMfS0
         ZyNQ7iMVuldX8zdiF276t57eUcFUle5dfs8J9yQjSOCD6lXdTc+zesUVsqNsF9P5wKeV
         flQJtO5R4lm9a4eysS6OGDUtkF97Q4TJl00n6KT6uabA/2aPy+2BPnvUJ52MS4kEeAP+
         6/IcC4TPBtnG0RT+ifqU33liwSFCyn2gaHSwWfejI4Tg0S0QQSCyWnFccGk0ELilxNmu
         XEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSsgCsHd1CkS3l8MBpQHw7kHFQ4FUTWMyiZQ1kuntp2G2xtKLq7rGaenKYU7+273ZN23UoLTV/cManiSmkzoiIqm5O3EgeQkvdxDyPaJXJwsgtZI3EnNiIJ8KFAf/SQSa0h6Jp8vzG6kjPsfNOkw==
X-Gm-Message-State: AOJu0YzYFa7zkF0t9RHdCzVvnmKvTrE4vIhb7fHkzllxqZX6+tQ+1PZ5
	BuyD4/u7U6aREEnBSwToAIJ5fK5kx8oIgl3e9XhXSxEz7SAblHeU
X-Google-Smtp-Source: AGHT+IHzh7byLYkIbZT7mCsZJfBxll0wUdqoiPtK+8RgpXjgOjRTYtS/oExSR5RMZXdmU0vLNUd5VQ==
X-Received: by 2002:a50:cd93:0:b0:56e:2e4d:884e with SMTP id p19-20020a50cd93000000b0056e2e4d884emr4478808edi.0.1714040247031;
        Thu, 25 Apr 2024 03:17:27 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c7c9000000b005721127eefbsm4004600eds.17.2024.04.25.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:17:26 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] perf/x86/amd: Use try_cmpxchg() in events/amd/{un,}core.c
Date: Thu, 25 Apr 2024 12:16:14 +0200
Message-ID: <20240425101708.5025-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace this pattern in events/amd/{un,}core.c:

    cmpxchg(*ptr, old, new) == old

.. with the simpler and faster:

    try_cmpxchg(*ptr, &old, new)

The x86 CMPXCHG instruction returns success in the ZF flag, so this change
saves a compare after the CMPXCHG.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/events/amd/core.c   | 3 ++-
 arch/x86/events/amd/uncore.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 1fc4ce44e743..c1b8aeff7bc0 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -433,7 +433,8 @@ static void __amd_put_nb_event_constraints(struct cpu_hw_events *cpuc,
 	 * when we come here
 	 */
 	for (i = 0; i < x86_pmu.num_counters; i++) {
-		if (cmpxchg(nb->owners + i, event, NULL) == event)
+		struct perf_event *tmp = event;
+		if (try_cmpxchg(nb->owners + i, &tmp, NULL))
 			break;
 	}
 }
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 4ccb8fa483e6..cac7c20d1aee 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -162,7 +162,8 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	/* if not, take the first available counter */
 	hwc->idx = -1;
 	for (i = 0; i < pmu->num_counters; i++) {
-		if (cmpxchg(&ctx->events[i], NULL, event) == NULL) {
+		struct perf_event *tmp = NULL;
+		if (try_cmpxchg(&ctx->events[i], &tmp, event)) {
 			hwc->idx = i;
 			break;
 		}
@@ -196,7 +197,8 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 	event->pmu->stop(event, PERF_EF_UPDATE);
 
 	for (i = 0; i < pmu->num_counters; i++) {
-		if (cmpxchg(&ctx->events[i], event, NULL) == event)
+		struct perf_event *tmp = event;
+		if (try_cmpxchg(&ctx->events[i], &tmp, NULL))
 			break;
 	}
 
-- 
2.44.0


