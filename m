Return-Path: <linux-kernel+bounces-101015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4848787A0BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DE3281494
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8412556F;
	Wed, 13 Mar 2024 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yZn9k/Hm"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095FE225CD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293139; cv=none; b=WXpYQfw6qi5hMpUHhtq++Q9u5CqdP714gc57VYjihYkpTdlGVxPLE5lD6nRcO/puV+/7MKJWNz6WKYXISMTzKQSBMqgt/lgFC9UTdIvM7jt3O1LQcDpeD3muEcUmJsBsLEZtp57/lFmrpcOImEStT/AUuyj6fBok+i17hxXfjhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293139; c=relaxed/simple;
	bh=7fIBSHLdyRr253VoUz32d0lGxdCPuDKV5UA70PG7VVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bIAIAHJIvechjqxBaGbTNI5p8gzjv/5P5vb9gLZJcBIAillu17FJhs1l2d+9Ih5yihhOgj3JWtzbOqGEU5bKJlsgnETuL9vM8nx/AA9fV6wZPUidREOFWzyuXALnXaRpcTUCSUEpPbSgqzRfuKW15FCRzgWBhUeHns2PRZ8Y/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=yZn9k/Hm; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7dc3a92c4b8so7151241.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293136; x=1710897936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFP3nhe5u/vPdDQ2418/fxPClwHL82o3qm5dzpjWd74=;
        b=yZn9k/Hm4weqkCzGR8/8pL9kq4SMqZEEEH0yeI5hQ9mqV63MDGWsyzhXvFQnz/eaD8
         aLIhN2EsxklhTKIh0SJ1NCFzPLa7CH6mt8MaprvyrCwE+SYqCiURTotnGdwUY/rdhYg5
         yuYmavtUg2jJ6Ra043CwPDYJEdGcW0G4PgVQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293136; x=1710897936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFP3nhe5u/vPdDQ2418/fxPClwHL82o3qm5dzpjWd74=;
        b=h3GbJXRep4T4WuX/omifU8IcDHVslZB1N4zsikGdY8lTQarHuk2gFcANTsFMyhw7No
         EHN0q4RhvZzisCkzU7F+s/jfuTVT7mdyjEOu/8xtlX1eVqwiXKukFSPNeYe87tiDFBx3
         Mc4gtLdRar/fo3VoJnSDFBGtIB/ANzmwv+ModQc7W0P263NIjHqfCwTmJOrE1xaUFIMl
         p+4kTTA+o5iYRutDH2HKNbSTixdWq64FFmLLkmYRZejzTwZy83WzTWvWv058Wu/cjnna
         mEcEgU+ET2amyBVq1rto168EZlhWVIT4xwpHYAEwpO+CPk111e6d1JEOD+q/L5KoVYEA
         39fw==
X-Gm-Message-State: AOJu0YxT+SbqmJOYs7+srbUidtFA8NTsIuG8VzH5COBKcpYYGSsIWaGj
	w1gMJSB5+LnLL272UA+W6mhJUvB5JLw9bQaKVBL48xw0HKX0Wuxb3QC3vn1HB76NV2Yr7fjdyfE
	S
X-Google-Smtp-Source: AGHT+IHFyfYpc9INhRrW5wM3R5KSsVt91M/yg0XSiM2yIflnqcoaTMBRvEN1d1qEZiPy/gNCwjWcjA==
X-Received: by 2002:a05:6122:1dab:b0:4d3:3b1b:aa92 with SMTP id gg43-20020a0561221dab00b004d33b1baa92mr8166193vkb.11.1710293136009;
        Tue, 12 Mar 2024 18:25:36 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:35 -0700 (PDT)
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
Subject: [PATCH v2 15/15] sched/deadline: Always start a new period if CFS exceeded DL runtime
Date: Tue, 12 Mar 2024 21:24:51 -0400
Message-Id: <20240313012451.1693807-16-joel@joelfernandes.org>
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

We believe that this is the right thing to do. The unit test
(cs_dlserver_test) also agrees. If we let the CFS run without starting a
new period, while the server is regularly throttled, then the test fails
because CFS does not appear to get enough bandwidth.

Intuitively, this makes sense to do as well. If CFS used up all the CFS
bandwidth, while the DL server was in a throttled state, it got the
bandwidth it wanted and some. Now, we can start all over from scratch to
guarantee it a minimum bandwidth.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/deadline.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 179369d27f66..a0ea668ac1bf 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1454,23 +1454,6 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	 * starting a new period, pushing the activation to the zero-lax time.
 	 */
 	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
-		s64 runtime_diff = dl_se->runtime + dl_se->dl_runtime;
-
-		/*
-		 * If this is a regular throttling case, let it run negative until
-		 * the dl_runtime - runtime > 0. The reason being is that the next
-		 * replenishment will result in a positive runtime one period ahead.
-		 *
-		 * Otherwise, the deadline will be pushed more than one period, not
-		 * providing runtime/period anymore.
-		 *
-		 * If the dl_runtime - runtime < 0, then the server was able to get
-		 * the runtime/period before the replenishment. So it is safe
-		 * to start a new deffered period.
-		 */
-		if (!dl_se->dl_defer_armed && runtime_diff > 0)
-			return;
-
 		hrtimer_try_to_cancel(&dl_se->dl_timer);
 
 		replenish_dl_new_period(dl_se, dl_se->rq);
-- 
2.34.1


