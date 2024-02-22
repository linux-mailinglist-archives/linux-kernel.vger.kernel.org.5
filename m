Return-Path: <linux-kernel+bounces-77337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044B58603F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE18028D134
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA271740;
	Thu, 22 Feb 2024 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4hnrQlT2"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C0107B4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634966; cv=none; b=D2qhoIuWRssca8uZ/7TrowuU4WYFElsCL8nhk3tpLNgekecDoqJMvsS0CRbaMBW+9tTaOWcjb0FyZ8PD0G08Y20QqD6L9t6A4/+SxYCNDwc7IL2VUGKgAt1u5HdyASLPyBsKGWzYJjEyWd0eiL+7OznJuKyMRvFSZTyv+6acHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634966; c=relaxed/simple;
	bh=t6lIHG5+4nq4OdH6rjR/34noTWcvT5l1VGyYFtSM6QE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ATKNCHR/F2OUj8q0RkUzKjMbqB4/08yF+GDvLFJaa9sk6ZpG7NyoK5G8xb43IGa/UryuQgIOsBAP2NkIX3OTCGcmEDfPEon/7XB6VJ0N/RMxuQYWp9MCHyMrOuoCZEbD8jklTQIRtTC/StUsPHlWia/gxNYdBKlnKjk2YwTBm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4hnrQlT2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29a5bae5b3fso152983a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708634963; x=1709239763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SRK9EHuaQ+JCWCMfavbkHoRAzX9PoIfHas8OXdMxkpQ=;
        b=4hnrQlT25VPjn6pjfdLMqVPQrgy3o6Ag8Qug1l3WsqX8/NSwoHp14937uhHjxKCPEv
         m35hgFl8uG8a35XKHoLcufELeTvuGKdLVaEgjT1G/RCGLJs1E7aUz7RW/GL4uBrRNlVQ
         j2WItNtDvobYjy7Lbu9I2n1Ve4qM8wh8xNBtuL5E49RDRa0JYfhx0YDZWyEQzW419QJS
         VRfj4cTwt38eEUoou+HacWr/xM7MdlcZA5GLZU+fuP2HieVzhV8x1J9DEN5PJzFNP692
         99TobyXAFOb01ueQVTOhT5EeduMQhY6pDbsOKGVpSRE1MKezjnAqMTfi1Q2r0UZKCc+t
         B7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708634963; x=1709239763;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRK9EHuaQ+JCWCMfavbkHoRAzX9PoIfHas8OXdMxkpQ=;
        b=uikfsUJdtH2i5NoSkNBv+9J21Ap+GEkYIVUjLt7YLcC4U94x1AJSf5Ea6sFZVHrZ6I
         xP3+TA4j7lM/fqN2qDJUC6T7f/c/Pjt0cmlmxOEx4A/SQjs6Yg0uJwIG//bVuQJKmQJS
         fFjptX/JHJ6dTlYsDOf9fG5HnPCX8RUxw++kUUAYCTEhCTCg6nrDKfR1lvvsZKQjg3lq
         XVNfH5kOJ+vMfpK/nFj5W0OAcHxVHtM9JEhbyAmauZFnICUkAmlyL59UwrSRAHIeIt7p
         WAk/lX4Ebgkwb8mhmmQyWQj7BRIkb+EYz/EaeHyu9JS66HxvFAxhJ8nWJ30/vBMihH0e
         eCDQ==
X-Gm-Message-State: AOJu0Ywz59HFqQdwfmsvgYxD9Yr4uY7qAX93uBEzyVABnjw0bGDZIQ+s
	vIXYONTc3IunTxSFVsykQ49ruaOmmoCx1KrqHLgygWzQtoYMXqslfQtAwCUZ0qKd8CA5to+myur
	EKd1DIiQgE59jlP4+zwxeB3QgkIuQ2aMX+AoQLMN8nBIomNI4ucL4yt1T0cR6TfatiQDv+NDQrl
	6POyj3xXB3UimEnJBzx+d0F8DYhpkYqbYxfNjMBL+grjec
X-Google-Smtp-Source: AGHT+IFZIu/dpLQatqQ76wt+ZwIKWWabdruAAQksE7eS0lDLNXhBRdw4mkS8madTKLUUBmxEESOqEWeliMC3
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90b:2e05:b0:299:998d:1251 with SMTP id
 sl5-20020a17090b2e0500b00299998d1251mr76807pjb.6.1708634962783; Thu, 22 Feb
 2024 12:49:22 -0800 (PST)
Date: Thu, 22 Feb 2024 12:49:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222204917.1719153-1-jstultz@google.com>
Subject: [PATCH] [RFC] sched: Add trace_sched_waking() tracepoint to sched_ttwu_pending()
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, kernel-team@android.com, 
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

So this patch adds a trace_sched_waking() call to
sched_ttwu_pending(), so we see the same state machine
transitions.

With this change, the number of unexpected state transitions
in perfetto was greatly reduced.

This has been in my drafts for awhile, so I wanted to send
this out for thoughts/feedback.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: kernel-team@android.com
Reported-by: Zimuzo Ezeozue <zezeozue@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
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
2.44.0.rc0.258.g7320e95886-goog


