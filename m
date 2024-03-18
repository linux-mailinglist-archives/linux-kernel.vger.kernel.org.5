Return-Path: <linux-kernel+bounces-106569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD2687F06C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9C11C214A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3456B5676D;
	Mon, 18 Mar 2024 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYROjDMQ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211056755
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790137; cv=none; b=EYh+HTnnv3ERPJ6yIQd8iTBFsTKxbViVYoseLaKfG8sTlMNz10sIBPxO//beQSczUYF1CJ10PveCpKrHaI9sGdzllHcmec4V0Iw3DcA190PhXdSYwzeR9A4ix0IWBzXKQdoRy6jnyGrs6T8dqNrkUo/PzbgG/A5jlS7yuZ+rLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790137; c=relaxed/simple;
	bh=qWcin4IBgnnJ7YmYWDXIxqcW/lPwClgTmuho/6O2BcM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jBaVmBL9bxu2SBSncbcbXVQzqv3hTBMO32PkDe7q+i8WFgxi2n58Idv0tYT4KPcGowC2MUi+FiEtGq1yNWkIFggQ/WY3Q8qgbNtbRJBkJMIFTNht2A/Gc/2uFBMve7XaPyC+/jnAEqnNg4t0RNJf4R7SggAtky9sndxPR7CGUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYROjDMQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610b9326be0so18848607b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710790135; x=1711394935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F16jgXrZscVwhw0pO80D+sTNG2mCObfU77ILYDXQUA8=;
        b=UYROjDMQAyXndWtbyCeME1l0nw4MFFl9sL4dAbScbwE6MMF5YcqHk5s4hE7Xa906/5
         dp7s57Bkzt66nhNQmVjnPoagRintNsbyQGDc6jka6Y9nMt9neAzfG5ABgyqwl/YCnC18
         jDVNHIgG+K1IC0SBVZuEXxBAmCGlYhwp1fG+etYqA1EqsM6PnmjM3VTn86VrQK/Exn3O
         l9DhnEgaJfELnIONf5sYitDGbBGavu/bDMsE5qPcuaYDEzjh8JoXO8m6+nraT//SQog9
         /TbfZmpd/Y785u1CS91Vw3e2GWcoh0ZgPEVmV3NKsIVyUysgaT7XsHwHVzNNGO4hLPNw
         FS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710790135; x=1711394935;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F16jgXrZscVwhw0pO80D+sTNG2mCObfU77ILYDXQUA8=;
        b=ZPaMpBzoQOghUcMT/Q2djlD5Dtc3ARyIJGXvp1Ma/3J0B6wiYZr70GQPN5PR98wm0E
         KPYZqo4bCwt6v4yUrf/ZDYVCjoLjz2P5/8c8Zspsg3ZRVb90JGAOjNg8PiAr2Ynplhj+
         KWGP/EfYBnztDDsKf9/74bGqJG1gnlvouUxaMs7bRKpU38IKsf0yAtSvMPkxr101VMQp
         EM26Gzr33K6A7479QMINMVviJChSsIaLiQo+2oSNMaaEDv7eg+s+iI37mhBrPmmL7q5r
         l6CcezOyTKsmVRdToCQVldcsyVp4Yi20+MSwlH+Lkng89WgrKfh6H1xxBlA4TX2v6Di9
         szHA==
X-Gm-Message-State: AOJu0YwtusglbbR6nFZk/7YGd+dhz2HZMHBHxUTOrXeSIMbyq3ToH1Gm
	xLJlZMYX5kCNCvE2oJVPUHsenfFXiEMsR2mX2jazk+LK25l89LfFi3zVCSgOwGC3F+Rdp5jkRZI
	DeHCPGcFe/XekICwRzly9JybwOTWTVDrsfOpq06ybn3xsWwe8VLdT9d6fgD3ie4kfjZUJ6vLy9L
	U8PWA1TGIrOPRQgw3zbLbwrK9TWqMgdonv4b3Pjmdy19MQ
X-Google-Smtp-Source: AGHT+IF4M6hQpCzc7sjvJsjq7d/XVFnrLJoM1jKJ4vpiQHvABmIu4Tx7HTLY9lt7Beoc6McHAyxWe4qwagfR
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:118f:b0:dcc:8927:7496 with SMTP
 id m15-20020a056902118f00b00dcc89277496mr742526ybu.5.1710790134765; Mon, 18
 Mar 2024 12:28:54 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:28:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240318192846.75299-1-jstultz@google.com>
Subject: [RESEND][PATCH v2] sched: Add trace_sched_waking() tracepoint to sched_ttwu_pending()
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
2.44.0.291.gc1ea87d7ee-goog


