Return-Path: <linux-kernel+bounces-69166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC5858546
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8900928282E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD7013340A;
	Fri, 16 Feb 2024 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="glu0DniM"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557F11369A7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108312; cv=none; b=lB1tCzJHCRIdnRfbuugMuw0ogXOmQZgZA3eDAdOmw9ApUgoMWp+ENyYuvPGrZ1blpz3HptOFt8vppNataLoZNCTq0QS87rXWupFRHj5RUINha0sVULNoopctIZJSEFcNOo8kXlvvZ1FqCYhHKIVRjMNpJH6UyBikFCXI5/Izkkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108312; c=relaxed/simple;
	bh=G1fDd4qTQBCk+lDij0THy4jcCMe3hYb5TF5caIUyaxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCw0lztQUgbD1qbjH9R4TYO6sAaNryf7dDjLN1A/RPBiyt3BO+e+bu6ZBB90Q0TFFjSSPQR2+dvZtUr3egvPFAmTi5BDg5YXOOogK5QupyApptMV5lGhUJt2FI2TcDWxYdnaJeFi7eZm6K7KOl5E36Y6M/rQ/Fh/lMcjh0aclrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=glu0DniM; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68f3fdcb59aso1160786d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708108309; x=1708713109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIgRVY95Czz2uvDMLBT/P8lHA/YSLsxu7WXMaEzsDZ8=;
        b=glu0DniM+b37P/XLwgGTJaGXenX6CGg6rvtGC/nmjfmDD3KmB/ymPgiB3AujHkbPN2
         iWchfmbPBdW+m2Jq4fMtIckhxoiqE74kSFdzJap7CsyZzH3WtvTLoTRl45Grmalfr0Ue
         71S50n1jDEc4dNzLFN6xTY6Uwpb5iJYVBef4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108309; x=1708713109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIgRVY95Czz2uvDMLBT/P8lHA/YSLsxu7WXMaEzsDZ8=;
        b=BJweHer2GKKudEKUDO7gyKeeUy6NnkIAj5lAvoYIzGChma85J9qdofHJXA38bDM+qU
         XPM5JsuPkGNnKrV6rFyR4ft5YvUhvZPZTGsSqKcLEG7FU02fSPDyYD6cu19Gy5PmQs2u
         4uuJ0BqfKdndPXw1dIkaJaHulZFl/pTc3AnIbht1LIXLinpksw+P0AW0a0JDljUeQyGX
         FTNZRUWCgTOu755uS4U4ccBqqBdB4K2joUMRNfJ+qPsGfE3Ijk60Nv6fdF0TqI/caw5P
         aDvrgBPOz5d6T29zJ7K6tkcLUndlHDkkK/BvM+4HUWgIaq2F84tJ3QIfU8hM0SirNJ3b
         YZWw==
X-Gm-Message-State: AOJu0Yzf3Y6mh5/sAGvRZrd6+2Y8A0mAbM8RtEq2+6C5YpNe6CytUCR3
	GQycpH44J3aOQFTwJ5e1jQgKacrGz3YxtFOGmOZtyjibxolJ9bjDdpQmwTqXfaWU5CSRtHAdhbq
	h
X-Google-Smtp-Source: AGHT+IGX8etptNM0tQd8HIVEAt7iS6dgP4kiS0uoQjpaIC3GY5i5pMiXKz5HRYZ7XJ+N8MEtyN98LQ==
X-Received: by 2002:a0c:f38d:0:b0:68f:1e7c:5f46 with SMTP id i13-20020a0cf38d000000b0068f1e7c5f46mr4945535qvk.45.1708108309141;
        Fri, 16 Feb 2024 10:31:49 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0068cdadb5e7esm159722qvb.31.2024.02.16.10.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:31:48 -0800 (PST)
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
	Phil Auld <pauld@redhat.com>
Subject: [PATCH 06/10] sched: server: Don't start hrtick for DL server tasks
Date: Fri, 16 Feb 2024 13:31:04 -0500
Message-Id: <20240216183108.1564958-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216183108.1564958-1-joel@joelfernandes.org>
References: <20240216183108.1564958-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suleiman Souhlal <suleiman@google.com>

Otherwise, we might start it even for tasks in a sched class that should
have it off.

Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
 kernel/sched/deadline.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8fafe3f8b59c..5adfc15803c3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2325,11 +2325,12 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	if (!p)
 		return p;
 
-	if (!p->dl_server)
+	if (!p->dl_server) {
 		set_next_task_dl(rq, p, true);
 
-	if (hrtick_enabled(rq))
-		start_hrtick_dl(rq, &p->dl);
+		if (hrtick_enabled(rq))
+			start_hrtick_dl(rq, &p->dl);
+	}
 
 	return p;
 }
-- 
2.34.1


