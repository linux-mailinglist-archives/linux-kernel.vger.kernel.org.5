Return-Path: <linux-kernel+bounces-101011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6DE87A0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974E41F22B73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F01D6B6;
	Wed, 13 Mar 2024 01:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YnbbJR/y"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CA1B971
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293131; cv=none; b=F+0FikpRQaMkc3ZGMXM90cVSmj3UZSVn8k2sXb/nS/henNC/tLEuS8/Plnu5jg+XAkHcnQPSSMf64W66u8YNJO4PAYAoyXyxTnejesZx4/937vN/FwStqRYFA3UPHEAzmK4wHu7saLe5kFbwJXQl91wfqP8UsK384yJ7j2FwP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293131; c=relaxed/simple;
	bh=jY7DsCgc8BB+eH2jvyxI0sUw6W9MrUx/z0pU0qLpZHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8Y4+r6TzOZsguFe+Z03eY0Km55JqZCFyVqKpgrNHZ5PU9bo9o4UfBS9ml08Kw8gtdDfvAus02z3W0Dd1jNhrEUSxiFMdB5tglxVxLAGlKO/ahJlRMEdOvt2FxN+B3pdMDDAP9EzlgKk81QeV7v5c6CwhynMXyBDzah+4uQK9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=YnbbJR/y; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-690ddcd97dbso13295126d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293127; x=1710897927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FazbUMp2++JK4V9me5cdA/Vo7sBxJTMKGEWaWEVy5s=;
        b=YnbbJR/ypd+L/vsTzyQCw6ygrYRH+IQyvyTCDb6z+XMZHUddwixix3YLDCh5nT/oFo
         QpOYbe5XPwMtYSIFctVrOwP8oCt23YWDs54tQX1e/0bMwsM8kBG5eVxqirP+e1QTPBgz
         ifL+tkvRfS/beR1J9uexS0h1lWLjbHpO8Xoxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293127; x=1710897927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FazbUMp2++JK4V9me5cdA/Vo7sBxJTMKGEWaWEVy5s=;
        b=R3AQylqaJt+X9Ad6gu7KkX+o2N6/pshpeuDhv1Ya14zQ77unZ0xWm3pHFd0WoKCMFk
         dMjyuiT8uNZORORhfkZeM7XJVSLxF+UamF5BWVaGy6jC3k6qZrX/zkHnPpbS5fRG5HD/
         Zq5zChxA+wGzDjfbi8isyBoHpWoG+xXDyrpwTCU4txnqOXOWgal2ccCBKsN0RZHVaWEC
         TUi1521Ksas2fdeYfn1OeYlG+7xWjP4gpMoUFUZVZIbSeT3y4tRZZc/uVPSDk/732ukO
         O9SOH93k7Ncw05cCzekYIbCPhpUlolqrjAA4XTrSuG8G1PwMvhlOYzeOb0r4u0TX/A1K
         oNIw==
X-Gm-Message-State: AOJu0YxaTAfN/zVuFYjvo1wMEiwo9d/h8RoT30vG6gemCkaieGyq7KvZ
	ldkAsqfsI0N/u0VLN8YaEglVIzXJSnQwQwZGx7Q9TwpWYi9Pu5L+Hk09Tgwn92Y0aRsGuxqJUqd
	y
X-Google-Smtp-Source: AGHT+IG2mA+z/pc+onmOaLaX36WFzaDUZj+ekyCHGljdpYYb/qNsdpJ9t7ZHX0Q+Xtb722TDGKdK7A==
X-Received: by 2002:ad4:4e06:0:b0:690:c733:f027 with SMTP id dl6-20020ad44e06000000b00690c733f027mr2130618qvb.53.1710293127086;
        Tue, 12 Mar 2024 18:25:27 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:26 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	David Vernet <void@manifault.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	joseph.salisbury@canonical.com,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 11/15] sched/deadline: Mark DL server as unthrottled before enqueue
Date: Tue, 12 Mar 2024 21:24:47 -0400
Message-Id: <20240313012451.1693807-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313012451.1693807-1-joel@joelfernandes.org>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DL server may not have had its timer started if start_dl_timer()
returns 0 (say the zero-laxity time has already passed). In such cases,
mark the DL task which is about to be enqueued as not throttled and
cancel any previous timers, then do the enqueue.

This fixes the following crash:

[    9.263331] kernel BUG at kernel/sched/deadline.c:1765!
[    9.282382] Call Trace:
[    9.282767]  <TASK>
[    9.283086]  ? __die_body+0x62/0xb0
[    9.283602]  ? die+0x9b/0xc0
[    9.284036]  ? do_trap+0xa3/0x170
[    9.284528]  ? enqueue_dl_entity+0x45e/0x460
[    9.285158]  ? enqueue_dl_entity+0x45e/0x460
[    9.285791]  ? handle_invalid_op+0x65/0x80
[    9.286392]  ? enqueue_dl_entity+0x45e/0x460
[    9.287021]  ? exc_invalid_op+0x2f/0x40
[    9.287585]  ? asm_exc_invalid_op+0x16/0x20
[    9.288200]  ? find_later_rq+0x120/0x120
[    9.288775]  ? fair_server_init+0x40/0x40
[    9.289364]  ? enqueue_dl_entity+0x45e/0x460
[    9.289989]  ? find_later_rq+0x120/0x120
[    9.290564]  dl_task_timer+0x1d7/0x2f0
[    9.291120]  ? find_later_rq+0x120/0x120
[    9.291695]  __run_hrtimer+0x73/0x1b0
[    9.292238]  hrtimer_interrupt+0x216/0x2c0
[    9.292841]  __sysvec_apic_timer_interrupt+0x53/0x140
[    9.293581]  sysvec_apic_timer_interrupt+0x2d/0x80
[    9.294285]  asm_sysvec_apic_timer_interrupt+0x16/0x20

The crash can easily be reproduced by adding a 100ms delay as follows:

+int delay_inject_count;
+
 static void
 enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
@@ -1827,6 +1830,12 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
                setup_new_dl_entity(dl_se);
        }

+       // 100ms delay every 20 enqueues.
+       if (delay_inject_count++ > 20) {
+               mdelay(100);
+               delay_inject_count = 0;
+       }
+
        /*
         * If we are still throttled, eg. we got replenished but are a
         * zero-laxity task and still got to wait, don't enqueue.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/deadline.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5adfc15803c3..1d54231fbaa6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1949,6 +1949,18 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	if (dl_se->dl_throttled && start_dl_timer(dl_se))
 		return;
 
+	/*
+	 * We're about to enqueue, make sure we're not ->dl_throttled!
+	 * In case the timer was not started, say because the 0-lax time
+	 * has passed, mark as not throttled and mark unarmed.
+	 * Also cancel earlier timers, since letting those run is pointless.
+	 */
+	if (dl_se->dl_throttled) {
+		hrtimer_try_to_cancel(&dl_se->dl_timer);
+		dl_se->dl_defer_armed = 0;
+		dl_se->dl_throttled = 0;
+	}
+
 	__enqueue_dl_entity(dl_se);
 }
 
-- 
2.34.1


