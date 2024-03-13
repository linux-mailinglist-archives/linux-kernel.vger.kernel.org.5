Return-Path: <linux-kernel+bounces-101001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AC187A0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342611C22A70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D39BE5D;
	Wed, 13 Mar 2024 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AXh1/gNI"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F78A93C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293108; cv=none; b=j0K3QF0ndi9/y3RoGxLmpdmOGFC/xNSefyvY7cs/1lr2l2gNwD7a7T0ti4tnUsSQPlscdBMzCg3EG7ejibcahgjDdi0BtXFN10nR5wAnBlhLtYkZpkuYun23rIJjvmPOOdt2ftnGXOaSK3gKcVRk3KKsDvYgumY3g+nvO+QfFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293108; c=relaxed/simple;
	bh=/tum2WF4xPzP3d2/oUJvAp904N/cyC9DIis13Mprwms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hoZ1lN09s2KSufeChy9XOKZPs9YqU+lM0dqKYivsb47mL06yLasQxgWgG+/grcrkju9wZrkjIz+MdyuFuGZjILzQNoe70pi+8rWNzjdZw0U2co3EPQ7eD1Knism/w7nhqW7iCrRmzlI76tp6MgG22rorKVR2zO8f+98tY6E2Y+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=AXh1/gNI; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-473ac7bbe64so386267137.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293105; x=1710897905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVFjYg00n2ZAFDWX2JpqdHNuxugRyfOJfGbuxjDxV/Q=;
        b=AXh1/gNIRiIYRyHi/5afgdmUDcJxiLlFhc4sqZ7s3rfWa/RqRyuQNDIjOHlL5s04Du
         k+wmmxCUx3oz89sr7U9l5PRyv4oSxIXqkr2fVh5Dt/8ChgGx3nKqLDg4DZ7mBYNfCi3N
         x9cTAq7RWzgzFYvexyDR5a+Tk7XZWdEI5i9CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293105; x=1710897905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVFjYg00n2ZAFDWX2JpqdHNuxugRyfOJfGbuxjDxV/Q=;
        b=NqziyTuASk6p7HYvQ1Hb2R28vE3C+MbCcuSuwyOoUzRZV/RPef35+s0lI0rKx1u9gZ
         JVKI/DQWl/XeiTZI3gTmlKi5Qq6UV+Di4OmVI2sVytatbQF6u/7t0SgudslszXVp2P4w
         GhIK6fPu0zzrXzJ1aA23rf0CaRUdUf9o0IVT7QLBypbTDDgZBKQuFClzgCieEIHDg9cn
         jSk0bhrupxULsHofTArAKO7vFTFFhx4ZmSkOR8C2QlIklMQTUfPEPKgWfGVWF57VsLX6
         wnv8tssIg8IjPD946dFyIhmD0s01MOzdgV5R4kpZCp/SUyXQBAUKQKr8l0peKJTbU8XV
         nO6g==
X-Gm-Message-State: AOJu0YxLnsina4ulKf8Y9534gNsotk4zBic1COGAupD0VYMa+AsB97oO
	Rmho6sFUkP6AyvEXJA2zuPiVlndg3aXny9OTuugOSZOaZrwJcQISqGECNiIqlrC0+QVsvvvxjbZ
	D
X-Google-Smtp-Source: AGHT+IEXEUJofH0D0+hQCIBelr5x7iiFfSw5Npn4vbtW58PtqlERPNfEzwBLL4rsFAlZJvZQqR6xyw==
X-Received: by 2002:a67:e290:0:b0:472:53e0:6549 with SMTP id g16-20020a67e290000000b0047253e06549mr2130218vsf.14.1710293104735;
        Tue, 12 Mar 2024 18:25:04 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:03 -0700 (PDT)
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
Subject: [PATCH v2 01/15] sched/core: Add clearing of ->dl_server in put_prev_task_balance()
Date: Tue, 12 Mar 2024 21:24:37 -0400
Message-Id: <20240313012451.1693807-2-joel@joelfernandes.org>
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

Paths using put_prev_task_balance() need to do a pick shortly after. Make sure
they also clear the ->dl_server on prev as a part of that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 973fd610d089..7f3a2596c1ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5998,6 +5998,14 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 #endif
 
 	put_prev_task(rq, prev);
+
+	/*
+	 * We've updated @prev and no longer need the server link, clear it.
+	 * Must be done before ->pick_next_task() because that can (re)set
+	 * ->dl_server.
+	 */
+	if (prev->dl_server)
+		prev->dl_server = NULL;
 }
 
 /*
@@ -6041,14 +6049,6 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
-	/*
-	 * We've updated @prev and no longer need the server link, clear it.
-	 * Must be done before ->pick_next_task() because that can (re)set
-	 * ->dl_server.
-	 */
-	if (prev->dl_server)
-		prev->dl_server = NULL;
-
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
-- 
2.34.1


