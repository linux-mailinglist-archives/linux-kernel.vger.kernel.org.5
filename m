Return-Path: <linux-kernel+bounces-126465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AE389385F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4418B20FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F170E9455;
	Mon,  1 Apr 2024 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L2XoCqrs"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F18F58
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952893; cv=none; b=BTAK1kw+iWlpd5Y65fFQRfqJaJbeRYky0s8GLXipCrwh3954TESDghO8lY4bqfykrX/Dlmr11oG4qR8zxPv3kjGWg/MN4pHQpTy1oRmAb+FlqQSDeZCbhKxPtob6ZbJ7LkrSwYa0ADVmUN2PvFyCgg+EazRLxEQpsRx/cHi7Ko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952893; c=relaxed/simple;
	bh=PW9Ga3dVjqVka4C+ses3fsScJkII9AHQ7Dt9OdB+RoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRw0Mgnqp5AmXcs7n4IByvBYZWxYE0mZpAWrQ5wNYt4L9ytSD1Y7E+7q+G1NPK6vgfM7+7cWjLQq7K3j+4FPvFGOcI0itb454nU9L+Dc9KpbZdG9AsxfJ+GXQFRWmcbhvYVOeeklmO9j6sDKepc/MPCIszvbXPK3RfR+guhQ298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L2XoCqrs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso2443440b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 23:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711952891; x=1712557691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXoaKmE0CgaaZOerStXHwchE8/DtZMSE2DNCNaIY420=;
        b=L2XoCqrstpPcDFwxEL3jwkEAdiHdbg43bP/hyNH8akWIghvtQJ79wci36XQtFLMfug
         MqhvNe1lGUn86RRZCJdpitaJd4Q+WRyLib2joVzjD7hsbEQqFMyWrH/02GvN8zIJRLcY
         uGkRac4n0y6OP1Z/pnWcQs2D7Uao7Q14jwYLAzCSkehAj5GJf1mNE3IP8JCHq5Bpkqss
         tIdd/tzs57GTbKGgdRtsdBj1jxeHZOSw0iMuP0vPYHM1MMIJ/AaeorPvqUfypKn0QymO
         IljhHdzt8wIgBLoy1jRVDOxPfMSKoKFuGcOOb0nCwqJ7MLh/3S3Oeuw8TiMKr86VUgo4
         CW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711952891; x=1712557691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXoaKmE0CgaaZOerStXHwchE8/DtZMSE2DNCNaIY420=;
        b=JaQXsfl91AkuipS+iSC49dchRQQgDtJQsKfuD9XPyd+6E0Eia1E0jJUs2mw2ub2z+3
         3LLRTPNYTyQeWl24TpzeJ7GILBPkoRx+l7w7b0IvKCEqcYSytfuM5ujz3OS02YYvTjEJ
         s0LPwtc6b5Y7pLYB1dE/gFEBHsgt5+ZaF2zIsIxs65kDqdFJrRKupA8LbXZI/GH57Aqq
         hnn/3tcrIXyLT2cgpEUS6T1YBbQLo4mNUDDSa6Cx5uUN+S+XpdFEMEDBMpktt0u1uWIa
         pFiDl/AvxrpnUxRtd5sZB7of0CaG0C/mAeIaTiz84XteZ7UlwR3Bsp5hsXaq7xS9bsr0
         /Hcg==
X-Forwarded-Encrypted: i=1; AJvYcCX8T2nIZLvGq77zrDnLcwd3RjYZv2YK84ZEDh+wTKo9AsMy5Uf9FymMi10uqgPoqXj7F1Xq2E5o8zpmKFjuoKjBw1j4/iC6SHyeFwIB
X-Gm-Message-State: AOJu0Yy1asAfKf1ps4O+Lha7C6dEKRIwDenbY/8NIc/N3lEp88olFeoY
	y95kQ27KO+lPm1CiaSgR7/6I8jkLva2euzjBbfr2je5uo0dT8GAPLcecuzh7FcY=
X-Google-Smtp-Source: AGHT+IGyJO6W7a9vGA42zEISDyPq8pZfWTwyac2IL1hq0cjIwwyYuw6FlByJVnomVlsCtwxbGFTVjg==
X-Received: by 2002:a05:6a00:1484:b0:6e8:a703:d911 with SMTP id v4-20020a056a00148400b006e8a703d911mr18653599pfu.1.1711952891072;
        Sun, 31 Mar 2024 23:28:11 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a00038f00b006e6b2ba1577sm7102001pfs.138.2024.03.31.23.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 23:28:10 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 1/2] perf sched timehist: Fix -g/--call-graph option failure
Date: Mon,  1 Apr 2024 14:27:23 +0800
Message-Id: <20240401062724.1006010-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401062724.1006010-1-yangjihong@bytedance.com>
References: <20240401062724.1006010-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf-sched enables the call-graph recording, sample_type of dummy
event does not have PERF_SAMPLE_CALLCHAIN, timehist_check_attr() checks
that the evsel does not have a callchain, and set show_callchain to 0.

Currently perf sched timehist only saves callchain when processing
sched:sched_switch event, timehist_check_attr() only needs to determine
whether the event has PERF_SAMPLE_CALLCHAIN.

Before:
  # perf sched record -g true
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 4.153 MB perf.data (7536 samples) ]
  # perf sched timehist
  Samples do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
    147851.826019 [0000]  perf[285035]                        0.000      0.000      0.000
    147851.826029 [0000]  migration/0[15]                     0.000      0.003      0.009
    147851.826063 [0001]  perf[285035]                        0.000      0.000      0.000
    147851.826069 [0001]  migration/1[21]                     0.000      0.003      0.006
  <SNIP>

After:
  # perf sched record -g true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.572 MB perf.data (822 samples) ]
  # perf sched timehist
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
    144193.035164 [0000]  perf[277062]                        0.000      0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_for_common <- wait_for_completion
    144193.035174 [0000]  migration/0[15]                     0.000      0.003      0.009    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
    144193.035207 [0001]  perf[277062]                        0.000      0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_for_common <- wait_for_completion
    144193.035214 [0001]  migration/1[21]                     0.000      0.003      0.007    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
  <SNIP>

Fixes: 9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event() helper")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b248c433529a..1bfb22347371 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2963,8 +2963,11 @@ static int timehist_check_attr(struct perf_sched *sched,
 			return -1;
 		}
 
-		if (sched->show_callchain && !evsel__has_callchain(evsel)) {
-			pr_info("Samples do not have callchains.\n");
+		/* only need to save callchain related to sched_switch event */
+		if (sched->show_callchain &&
+		    evsel__name_is(evsel, "sched:sched_switch") &&
+		    !evsel__has_callchain(evsel)) {
+			pr_info("Samples of sched_switch event do not have callchains.\n");
 			sched->show_callchain = 0;
 			symbol_conf.use_callchain = 0;
 		}
-- 
2.25.1


