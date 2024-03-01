Return-Path: <linux-kernel+bounces-87856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ACC86DA01
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7AA1F2382F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9D540C15;
	Fri,  1 Mar 2024 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaEUhDPx"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410B2F2C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709263604; cv=none; b=ep57rBl8h7825K/EOqowo+YUPzOCGYrDBJbi+Bz22TJfiSK/fUGhISAbQejFSI46cUo9jiR4BrtSyOPIADk/6WcLFfJ+I50UHfZyd/p2i/7njYzBBojLYnzsh1FLZq6FJFEG4uGNxwZ6iByePtDiAIOg6h8WoSVG5Zym1Xw5C0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709263604; c=relaxed/simple;
	bh=rbPCodznqhHhUtDUQSimWS+lG3PT01VsV2ENo/lepjk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NzI32uYY62FUMa/GhRb20LW0nds/pIjpFNEj2gG/l7CpAD4j0WYUCxYNnAIyDpDLSOJCng+tqvwOxOim3IuXskdmo5OukxwM3jYIWo7o4oYBvJhQY+soVQrE+8G1/qYaogQ0cOs6CRT32gHbLwMDah+yps0PszBzqEIY0lbIkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TaEUhDPx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so1339704a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709263602; x=1709868402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FKZzJvKcTnDdeF2Ft5+qWzW9X1Dsw98upGCNkUTIMRw=;
        b=TaEUhDPxzE7v4gKfnNAHFw2IGBl8DYY3s4C6uxdsk3jpJWZ6t5ZiOIsuYIlJClpOCO
         tZOEOaQ05LEsli2b24yT3/MRcaChqy+yS4CvlA06cIxTdQ+APQT79bqeaGjAYCeA1TKz
         kW5PpT3w+yx/QCEyPFBj7Cro/N990Q1cAF5jiLBI6OMg4t4KOxOulyUyK+UmsWcmSILj
         XU2ZOMIUc/5GvEDazmQxvZvsUgyBDfo1+6lKm6pPX/OVYasvuko1wqiL+X2y2AHv+YB4
         Bn2tbgqksomb2gisqPuu6htW6LGxUvXyR06wTA5kFoUCRdZlmwRgLmj0fAqEksSisHFy
         lNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709263602; x=1709868402;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKZzJvKcTnDdeF2Ft5+qWzW9X1Dsw98upGCNkUTIMRw=;
        b=aOWgexTueK1gNh/mCx804Aji35TejbdTEm1TXwEGMBsoTGmB5YjTEBplcfYJj5f5RF
         X23ut1uwLddmo2EtBxMd/p03IqffKtwSYhp57zAM2TyS1B9yustTs/X831FQvIxFcu+z
         1HWINyzB/3rM6JKxDo3baYBhCO/Pc8A9cyP7wQ7ITtCSyN6/73qXp8kAeb7bF9sqWq7E
         IwZw5l1A0PiPC32ioR99K46vEhAnt0i4rYxYhIW9eBC1olii02m5fidIVQ7Z9UaV2X90
         n/0fSVgDxcFFxnpF+kHVedBESXw19Eh1qTkdlBCIsIrVwNVBiQ7hY8tnOXBVfD0ZflbZ
         hQdQ==
X-Gm-Message-State: AOJu0YxnR4F1PrKxMBzmUdetBbt7MyaDkP6m+PX9vNwul+FqTj/VsSZF
	WMRGuEIGHWlNDJoVcpeXzpyR5VN6DzluN/kesUn8ng0jXEooZI+Ya8/RMnHFaU11rhMyw/ewCWR
	4WVGxF2mlucJTc+NtY4VLr+UxDopMrIcMqscRC4rZufgIY87SC/Nur/4NWnz0lisK10YHM5sZoK
	BTzOzNPNkTQFA7bszlF40OmvRpulFr2iLQvWBM7peSOlrd
X-Google-Smtp-Source: AGHT+IGgWjVeKE7oS2l7K/2ilyqMIe91UkaG9LRFOrrsMfaMlbH+TeeDE55pSqgueUvcZwNUuiWVZX5ukkfa
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:6fc4:0:b0:5cf:c149:8dc with SMTP id
 k187-20020a636fc4000000b005cfc14908dcmr684pgc.11.1709263600707; Thu, 29 Feb
 2024 19:26:40 -0800 (PST)
Date: Thu, 29 Feb 2024 19:26:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240301032637.2117250-1-jstultz@google.com>
Subject: [PATCH v2] sched: Add trace_sched_waking() tracepoint to sched_ttwu_pending()
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Phil Auld <pauld@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, kernel-team@android.com, 
	Zimuzo Ezeozue <zezeozue@google.com>
Content-Type: text/plain; charset="UTF-8"

Zimuzo reported seeing occasional cases in perfetto traces where
tasks went from sleeping directly to trace_sched_wakeup()
without always seeing a trace_sched_waking().

Looking at the code, trace_sched_wakeup() is only called in
ttwu_do_wakeup()

The call paths that get you to ttwu_do_wakeup() are:
try_to_wake_up() -> ttwu_do_wakeup()
try_to_wake_up() -> ttwu_runnable() -> ttwu_do_wakeup()
try_to_wake_up() -> ttwu_queue() -> ttwu_do_activate() -> ttwu_do_wakeup()
sched_ttwu_pending() -> ttwu_do_activate() -> ttwu_do_wakeup()

where trace_sched_waking() is currently called only in
try_to_wake_up().

So add a trace_sched_waking() call to sched_ttwu_pending(), so
we see the same state machine transitions.

With this change, the number of unexpected state transitions in
perfetto was greatly reduced.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: kernel-team@android.com
Reviewed-by: Phil Auld <pauld@redhat.com>
Reported-by: Zimuzo Ezeozue <zezeozue@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Minor commit message fix suggested by Phil Auld
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..233f06360d6a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3894,6 +3894,7 @@ void sched_ttwu_pending(void *arg)
 		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
 			set_task_cpu(p, cpu_of(rq));
 
+		trace_sched_waking(p);
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
 	}
 
-- 
2.44.0.rc1.240.g4c46232300-goog


