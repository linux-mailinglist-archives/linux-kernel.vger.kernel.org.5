Return-Path: <linux-kernel+bounces-122444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3632488F792
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3797EB227D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3A4D9F5;
	Thu, 28 Mar 2024 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hdMF4pvv"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B22B9B4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605551; cv=none; b=c60HLTCH7YnApwvAnzC0ZiJsEcY4vaPSEA4xh421m8CghdUyJks1Kv5OWcoSkrLGwTa8+HqdZEkhs3HnV+SwLwfcrxJXMFlNHAszObecdWK/iqPhDjb3Oz1yx2CkCRctu0CWFmqrQUm+3181FxmEDmD8jUv68nk0cC46EHZUsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605551; c=relaxed/simple;
	bh=/321d+Qvt+lK15o4LdlFgN8rHDY1h6wWZiC7KtOA+6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=liJDuu+cFjBILWIcy8zZMVyAaAnVUS4C8DTu2GMouNpt6tBq2Lwc3U8ed6dgkhKXLM76PFj6TiqI2XM/uf0W3VSp1NmoSZoU6FWw/w3pvqIxDUdaYa8j1VNVuRBOXYTXqrh2eiVOXD78Hne+UqJd+wG9tePaBKt4iRFNx2NLP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hdMF4pvv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0f2798cd8so5602715ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711605549; x=1712210349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wulzPJ7dB/+aPvEvhFky4v54wMywLeN6EVfTjVAdQU=;
        b=hdMF4pvvUDzz8T6IgwGAAVy9/xaV8PEhYZ+VKLq21xDHV+D9FWu+cBk6Ln2NFhL6gY
         0J3djbf9oev700vA5SxVrjwYSgZSLLvugCwAxUeKtQrWnB4wwLSwGqlB+OkPgLEnBqT2
         RzEameaBil07zxPQZghtBqPhNKFnaHjiqktIqJBee20Zm92yCJP3/oedDdUAe+tp0mgC
         VnDPqtRMg0PFO1/ARW8bKuZXDUShItymykzKZh7T/58KeztO/VOlNeiQwIdP/iZXY+La
         jWZHOC0cdci/7PqY1FPqD72IH4PCIPNATk+7Of6KTTdj0YlKOiBfXsRYcSJ7ClYQEQEr
         uz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711605549; x=1712210349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wulzPJ7dB/+aPvEvhFky4v54wMywLeN6EVfTjVAdQU=;
        b=VS9GqbXnfT8TQzAsQe0nXvPPwp1yNli8/t/DGbinZiUSsHR08IoZB3oz9MwWmtl0lg
         hYCZCMKLxoR4aJ1OvNSoWIG4tgviKzvQwRh9XytQkmaRYnEUkKJ4woCJ4uZK+nImVxrR
         pTxJSHeLfju4+RxyiNvR1ZT2mEX+Px+CXn40ufkNNAsWntbOFuQFwfOQQbvTuUKTpacv
         lRuNjcqHYfKWwlXhLmz1GsXrH+iItl7F01bGCaZ+ZPh2J7bzY4uEN4hKuqcwl/TOsJqL
         ckzw02UOa+ceJ0u/0roLCWc1bR8fKyrVrnE1pa7dH9QZq7OPmHIgrewPOi2jTkGdAw4L
         moHw==
X-Forwarded-Encrypted: i=1; AJvYcCX8LeYFfQIYVddOveD0ZABdYMU2L5UUrHUCb6dqjmgL801XDY9r/o1MnUVSQy2ktPfAaP4Jp8Yw+iW7GlPGTMSdW/k2ta19jRntfPOr
X-Gm-Message-State: AOJu0YxM7gwxhvAGiFdptD4ZeAgWW2KK44ah63wN0QkNExRxa4lY4/jU
	dZoMjCjFkYPu6gkCabPvkr5oWlaBmG1jd/u6Hzws6nrqSTzjEY177IK1n7Dqg+k=
X-Google-Smtp-Source: AGHT+IGQs4yvoRNBq+7eeWYdLEpmrgliSr5BMY8vh6gqVLURZyVICtvGm8MBrUA4YaIyCit73IHg/w==
X-Received: by 2002:a17:903:2a8e:b0:1df:df4:73e0 with SMTP id lv14-20020a1709032a8e00b001df0df473e0mr2022452plb.4.1711605548965;
        Wed, 27 Mar 2024 22:59:08 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902d34900b001e0b461d104sm595984plk.67.2024.03.27.22.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 22:59:08 -0700 (PDT)
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
Subject: [PATCH 1/2] perf sched timehist: Fix -g/--call-graph option failure
Date: Thu, 28 Mar 2024 13:58:56 +0800
Message-Id: <20240328055857.383180-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
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


