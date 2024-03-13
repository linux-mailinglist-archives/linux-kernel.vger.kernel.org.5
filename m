Return-Path: <linux-kernel+bounces-101013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F2687A0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64A21F217DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2B224E0;
	Wed, 13 Mar 2024 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GjeWV7nG"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9D210E9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293135; cv=none; b=uzlRQw+MIZg7yMB5Ppd4sD7BqeRDP2nRSH8gjHKxdyiX5orS0otE7NV+67cKmBGDf5hb3v2N62jyp4jh4qEriy3pVhpwPblKVcuOppxfxy9M8gDMjW1WFoq+uQutWLLuLKf7KYpSBJVWkIJV4RDDZ85g3CFpybNVAvTAPGAxy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293135; c=relaxed/simple;
	bh=bEbpzc3o6NPBPhxbWoEkjxbQuHObKOCYacbHoAyzbQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HwgygCLF9j4awAxjbj8GPu+ktaCWF7ZJ2Y3bn4xjM08NYbR/rTyoOWhc3bSHgUJKwIMAqngbDJJ/pVlIilzWNXr6gZIpoOkO5g1ChmyOp/V6jLa1pcnI1MkGNOFtIvftRIV5SA+fcOYlN4l67F9mWMNs7SWGlx9rDBPOQYBYB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=GjeWV7nG; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-690e2d194f6so11214396d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293132; x=1710897932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZYANLYuUMfpIZu9pt5liLGvM3ivTsaOwqTCSKV0HFk=;
        b=GjeWV7nG2315toKGqMB98wMglLGQEWI8bPXLZl8V2NpxHHquRPHYwj3Y3pKKyNHhYV
         zy1hoDGDrUHgOdKpxzBANwXhrLkWkY69wIkCARkjxzhGMSKqs3kjsYNv5O3Fblyjh0IR
         H+ggZOUhDNgeE7wRdyPrHR0vgwJFcRqWbyqXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293132; x=1710897932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZYANLYuUMfpIZu9pt5liLGvM3ivTsaOwqTCSKV0HFk=;
        b=WPqYNZVIH5psfbikhT8qR0RbSyeUUhoG5L16vZ8KWWkokZTpsKqqLqgUYOv5q0tahq
         mtn+fNpWRvV6+6MrzVnmzuUxgrsrX9yJTDzYmeeplTL7ojlvfTcfHXxUgX2Zu34ksKRu
         MXJ1y9Edz4e9Cg9UMo/Efk3do+U9njXuFLJfwUCz/P9iJJjEPl6kJVxgYr9l9z4FTmfr
         B23JP2pnu9XooDlsV2hgDry9/pXKKrIM4xU7zJLlec+efQV92wLZosCOr3EUDlFKbMdV
         CrHV2ekJBMoNkhiLwuWpQSbmuOuwPbjyblo6+pv+e25PvPV4BWKzaAd/YWv+WNPIasM3
         j9bg==
X-Gm-Message-State: AOJu0Yxsa9dAh+Njwo24j7JZ89D+PhYOH3sCKtFO4Fh81BGVxlSwMhRk
	JpWphFDiuUDQh81mkvLah+tqToHeMKeUjIXZudkZLRZ/I/J5riPd4iRw8FxucvBuYRtOXL+F3y3
	l
X-Google-Smtp-Source: AGHT+IENf7xbFa4g7w2qrwzP0tC65M2qKSQANmudIY7CUuScaysHdsqw8e6UzYS5NHM2OVnofApjVA==
X-Received: by 2002:a0c:eecb:0:b0:690:d6fc:f0e with SMTP id h11-20020a0ceecb000000b00690d6fc0f0emr5943620qvs.11.1710293131938;
        Tue, 12 Mar 2024 18:25:31 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:31 -0700 (PDT)
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
Subject: [PATCH v2 13/15] sched/deadline: Make start_dl_timer callers more robust
Date: Tue, 12 Mar 2024 21:24:49 -0400
Message-Id: <20240313012451.1693807-14-joel@joelfernandes.org>
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

For whatever reason, if start_dl_timer() returned 0 during replenish (it
did not start a new timer), then do not marked dl_defer_armed, because
we never really armed.

Further, we need to cancel any old timers,

This is similar to what dl_check_constrained_dl() does.

Add some guardrails for such situations.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/deadline.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index dbba95d364e2..e978e299381c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -918,7 +918,16 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 		if (!is_dl_boosted(dl_se)) {
 			dl_se->dl_defer_armed = 1;
 			dl_se->dl_throttled = 1;
-			start_dl_timer(dl_se);
+			if (!start_dl_timer(dl_se)) {
+				/*
+				 * If for whatever reason (delays), if a previous timer was
+				 * queued but not serviced, cancel it.
+				*/
+				hrtimer_try_to_cancel(&dl_se->dl_timer);
+				dl_se->dl_defer_armed = 0;
+				dl_se->dl_throttled = 0;
+				return;
+			}
 		}
 	}
 }
@@ -1465,7 +1474,14 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 		hrtimer_try_to_cancel(&dl_se->dl_timer);
 
 		replenish_dl_new_period(dl_se, dl_se->rq);
-		start_dl_timer(dl_se);
+
+		/*
+		 * Not being able to start the timer seems problematic. If it could not
+		 * be started for whatever reason, we need to "unthrottle" the DL server
+		 * and queue right away. Otherwise nothing might queue it. That's similar
+		 * to what enqueue_dl_entity() does on start_dl_timer==0. For now, just warn.
+		 */
+		WARN_ON_ONCE(!start_dl_timer(dl_se));
 
 		return;
 	}
-- 
2.34.1


