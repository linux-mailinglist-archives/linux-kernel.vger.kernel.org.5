Return-Path: <linux-kernel+bounces-69162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF49858542
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A951F21B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD3A135A46;
	Fri, 16 Feb 2024 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="affI+dTq"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BE1353E5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108306; cv=none; b=kU62QZ2j6tKTqrOha/28zw58wx3S72sMhrKstVkXj9ghHz4A6GlD6ZU2mSb0hYvL68eFDhDsmzHi0iLTcNK3ph1ZAFIkLpWhDm8ETLOmi+GUuNhqlirjdCZs3W7xn/GsT33rS4O6jBTizfV9E/mwPQmiQUE/UgBGfk1/WqRT42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108306; c=relaxed/simple;
	bh=BiiWEkX4I10hm0Y+ah7m6xE4dk8P54pifKn/ZYznW2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OiKIgvF8AxSI+vro7C02ozjVfpp4HVmklJLcM7hQDahj73lRON2rN15k5A6UmjNYD/E1sQspIeKx25xo7EPGdHZ0qyxD8AYDcQsef1vV0LBWyG5UEOieT/mjUbnApduVVlQnvwVac0akdjH4WYaYMTA42Exxh0r7BttH9KPKWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=affI+dTq; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6818a9fe380so13862416d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708108303; x=1708713103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS0mEpzEEFGetzR6NtkyoXN8TWiVnIyPmeWduyYdhXs=;
        b=affI+dTqhOv2xxiSZ+dyvFmb9JgvjzInrIzZuv5+cVOuNMWSXyYCPrRBeu5iS4mj4c
         e3ZZi19gmrTb9jmmBE86fqdT6OByBU8C9BGmkOSvKzc8oYoqF7jQvVD2cClauReYKhqn
         45LMMyZ5Og0zZl0zp7vEoRXaxykck4RXtdQdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108303; x=1708713103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS0mEpzEEFGetzR6NtkyoXN8TWiVnIyPmeWduyYdhXs=;
        b=diZ2AmVR7USHZIE+eyrDqc8V+zoHfghYKUqi8Ordkbri3mL0dIbEWf38Wi0bE8/E6R
         dRWlbaRoBF5MLq8xokYr3zEpI97SCMDsh0VQovECaYuaL2N5NxDnRdkcbKZex7kr7N8i
         biLLYirQmQOA0JdLPfxotrYSKJuJmcS3mZZx8WMnenvjkU9e7LoQqBMpzR60YdMxLFGk
         qGqccW7Np0X3pJ/5gubNYwkYsqU+9DPDUp4iwfiYeruL0E5uL1L5aeM1Pjx6reWi4yO6
         qVO56/jL764PIdgRXLHYVNsd5hHKROYI8TA0fAwtoLrvDI1cBAsNaaeuxBiQ0UQXpQn2
         SHmQ==
X-Gm-Message-State: AOJu0YxhI8TbtyzbPLpZfyeTC+75zt2cMTuS25M1Cn57fIaPZ/MU2oi0
	QFwFqhmBXdMTGcMS2w1o1MS5odrpBaABtUnxgg4rACyDIsP0RC5RZ6MMSSpjFy+17glFEynuufu
	L
X-Google-Smtp-Source: AGHT+IHBo8ZmZGNl4vr3CeJCFDtCUPLEwDFNgk+oyNvQak4sFIggeBOWvdQftkTYFaUjbF5QR3fWwQ==
X-Received: by 2002:a0c:e38e:0:b0:68f:3ecd:840b with SMTP id a14-20020a0ce38e000000b0068f3ecd840bmr1086525qvl.23.1708108302915;
        Fri, 16 Feb 2024 10:31:42 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0068cdadb5e7esm159722qvb.31.2024.02.16.10.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:31:42 -0800 (PST)
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
Subject: [PATCH 03/10] sched/core: Fix priority checking for DL server picks
Date: Fri, 16 Feb 2024 13:31:01 -0500
Message-Id: <20240216183108.1564958-4-joel@joelfernandes.org>
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

In core scheduling, a DL server pick (which is CFS task) should be given higher
priority than tasks in other classes.

Not doing so causes CFS starvation. A kselftest is added later to demonstrate
this.  A CFS task that is competing with RT tasks can be completely starved
without this and the DL server's boosting completely ignored.

Fix these problems.

Reviewed-by: Vineeth Pillai <vineeth@bitbyteword.org>
Reported-by: Suleiman Souhlal <suleiman@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 63f41453b79e..0a05caf9d3d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -162,6 +162,9 @@ static inline int __task_prio(const struct task_struct *p)
 	if (p->sched_class == &stop_sched_class) /* trumps deadline */
 		return -2;
 
+	if (p->dl_server)
+		return -1; /* deadline */
+
 	if (rt_prio(p->prio)) /* includes deadline */
 		return p->prio; /* [-1, 99] */
 
@@ -191,8 +194,24 @@ static inline bool prio_less(const struct task_struct *a,
 	if (-pb < -pa)
 		return false;
 
-	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
-		return !dl_time_before(a->dl.deadline, b->dl.deadline);
+	if (pa == -1) { /* dl_prio() doesn't work because of stop_class above */
+		const struct sched_dl_entity *a_dl, *b_dl;
+
+		a_dl = &a->dl;
+		/*
+		 * Since,'a' and 'b' can be CFS tasks served by DL server,
+		 * __task_prio() can return -1 (for DL) even for those. In that
+		 * case, get to the dl_server's DL entity.
+		 */
+		if (a->dl_server)
+			a_dl = a->dl_server;
+
+		b_dl = &b->dl;
+		if (b->dl_server)
+			b_dl = b->dl_server;
+
+		return !dl_time_before(a_dl->deadline, b_dl->deadline);
+	}
 
 	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
 		return cfs_prio_less(a, b, in_fi);
-- 
2.34.1


