Return-Path: <linux-kernel+bounces-88301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A74E86DFDB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD411F22893
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AFC6D52D;
	Fri,  1 Mar 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCZo2iIH"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E16CDAF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291404; cv=none; b=qalCEJzmiMF8vDu5nzttI4sid4QN7zIuuns11yhfllq2za03E6dXMGtaATSnRq0ySFCcrhUilE2JdRVkb0OCtPCKcDbjAGDQsDq7NPoiioGUInE1gK/XHK5ikU/8rZF8n0l33s98g0hOe2Z5G/VOwan2hLd0u83hCLKpX96QNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291404; c=relaxed/simple;
	bh=TW5vxueQOJxD0Gl+Zr9DXeL15E/AlN64VY2kWOen7vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFiC4Awe22bgsCNOKgUGI49ScXUMskQRyHahExUm3SkHvuu1tFa2hLhC6u77NfLr3IaLC5HbkBCIcNI6fkuf3o5vcAKnmcdeHUtH7tkOT6/ZG3rdKh4OH1yA9/xbpoG/ojBYsTYOUJQ/k9JboROXxsXHICeCPkgU90LrWzWoRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCZo2iIH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so1959620e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291400; x=1709896200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cD+TwI/HZoywmTZsork3oY9Fn4598AcRR6hubkpx5Is=;
        b=ZCZo2iIHD2E3VruiEiIKkdJTD+v54T6356yDyC84CeEt7YNjLQWzMxndxxFmBoFLHQ
         q1YTs8qDc7xoSHLI7ZgPsiSjpqNsDWTcfO25t4W2dbfBVdRX+Biy8/XPFbaivz/eQJPP
         z0TEsr5xVHgQett/NQQN++iGir4IFI9GaRY6WFqb/HlcirXNEbe5NloDHPSImXDjjhJt
         cMSQPEWqACRelWeT4S+mxmRxK4qNBupHrge66Y9+zVqPIObRDxX/Ps4+2Hfije6nicap
         h8ZrPn/2eJYz03nvYfg7XvvZPRRh2RkT/qpiuEPSzAZ3N7nmg9iZ0Dt05gziWEzM7xcn
         z1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291400; x=1709896200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cD+TwI/HZoywmTZsork3oY9Fn4598AcRR6hubkpx5Is=;
        b=om3C/oQaQ8bY0cY1JCIwM9+DqsWqwugvcL4wk/IiNpjT4Tf04bFE6okKZ6tVlFy1Lx
         KHFF8sNIme3qkE29T8wqMbKcvAhiffTig05gXhHQP31j+6TjpxLW+B6dX/7OnGPRfXNB
         Cjt/DgZgLSbe9YCwlAPgLIH6ymOtqHU++mWUcKX1BYzqSNHpNwFxqyCaGdX+IkJQ4cQd
         +5MoKlfb8NwAqdl9gWpWWjmhJDGghpDwKIvTDrF0m8WmgFZ8sfAOokWxGoxWpn4FBc7q
         z1CLfyK69Um5qJwc49go3NmbO18CGRbjX6Kv/m71LHysz0kN7UtZROJY5Zmk4WIubnHb
         wZuw==
X-Gm-Message-State: AOJu0Yyg7It3YgQExiBrVaSpN+Jjlz7x0GbasHyTi33pqcVFytkqV+AT
	WbnVCZ7z2j1cjyjwfov+UySdTVTa125/hfy5rweToQEFoYskdzAdr44haBe4z80=
X-Google-Smtp-Source: AGHT+IFZmXK36GHtWeo4/3f9acagQmXhkFu8EzEAUZIIqmlfI1V3pCIXrW9iS/6WMshtPQAAvuexPQ==
X-Received: by 2002:ac2:5634:0:b0:512:f628:32b9 with SMTP id b20-20020ac25634000000b00512f62832b9mr824309lff.27.1709291400460;
        Fri, 01 Mar 2024 03:10:00 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b00412cad66f8fsm490264wmq.44.2024.03.01.03.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:09:59 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 4/7] sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
Date: Fri,  1 Mar 2024 12:09:48 +0100
Message-Id: <20240301110951.3707367-5-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301110951.3707367-1-mingo@kernel.org>
References: <20240301110951.3707367-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two typos:

 - There's no such thing as 'nohz_balancing_kick', the
   flag is named 'BALANCE' and is capitalized:  NOHZ_BALANCE_KICK.

 - Likewise there's no such thing as a 'pending nohz_balance_kick'
   either, the NOHZ_BALANCE_KICK flag is all upper-case.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 934ace69eb30..31838b9dcf36 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12410,14 +12410,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 /*
  * run_rebalance_domains is triggered when needed from the scheduler tick.
- * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
+ * Also triggered for NOHZ idle balancing (with NOHZ_BALANCING_KICK set).
  */
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {
 	struct rq *this_rq = this_rq();
 	enum cpu_idle_type idle = this_rq->idle_balance;
 	/*
-	 * If this CPU has a pending nohz_balance_kick, then do the
+	 * If this CPU has a pending NOHZ_BALANCE_KICK, then do the
 	 * balancing on behalf of the other idle CPUs whose ticks are
 	 * stopped. Do nohz_idle_balance *before* rebalance_domains to
 	 * give the idle CPUs a chance to load balance. Else we may
-- 
2.40.1


