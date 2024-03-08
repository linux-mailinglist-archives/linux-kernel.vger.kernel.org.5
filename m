Return-Path: <linux-kernel+bounces-96888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E5287629D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4C91F24CE3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D831D5A7B5;
	Fri,  8 Mar 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDECUJm+"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9405787D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895565; cv=none; b=P+9MMIGtsJ/maLTFU3xoxlFRWwiOJ54iDrBDrPFylmX1+zCoimO3234bTxWrYL2svv9aSGcMkwpLY6oW/EtQvmYcX0e0kie2vvlcGlpVHKlseo+ibL/MESZnuabE5XDxU/nPU+RnagfvddCHG+vnWrSpK0h12vqxOS8iC5EbwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895565; c=relaxed/simple;
	bh=jvd/ckWSFQuQAPs4OsDhzwHrIEHK4Z0I1Gi8xjnR7v4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXSUMiUyvJjmlRomB0+CGIZS40CUgU82BpEKUFSpmXD91jI2UzWKydU/6J1He9bkkFpON+10KEzOGs3M46MG/7IfkqLCxTKPMvMN81z4dJa6EKfnTCjWQH0uiYEwoq3nIKARb6kA0wezvegoiZ5h2/eAg/2osb8bvz9SlWGZdzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDECUJm+; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51323dfce59so772944e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895562; x=1710500362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ybDTCqxmEUr08eKUXzT0FhVWhzTIcU216Z59OdLni4=;
        b=UDECUJm+WhVPaps47T2Qmd1zZWPed3hee4bAl/zbORWzE4Budnvw8hQVrO8AoYMpqd
         5b7y95cB4AGRjbArcC+jvQIL3HJ6BXgN7AcPDlMwYEjgafQbk6NfViwBwXHSGOYpAQOQ
         gEgyrOU4k4Mmq9Mn3KaKKPMGoJPQMFmHUjiGIpMvrT3QZ6xg0GXpPoht9LWrQxWlcOS+
         HBfsbbzxuCUg0vA2/pqGQsgRJ/W4oIcJtTnxTvIqKqvYyTgTy8glFbOuPmKGX6H9jAF1
         u7SV5tWKYQ3QE0WLYQgFs60hMcPK1bIMW0LOBkBlO9j32VNtpLQ1MA6mDNAf34LUEXyW
         l1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895562; x=1710500362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ybDTCqxmEUr08eKUXzT0FhVWhzTIcU216Z59OdLni4=;
        b=Dq6OY3ar9/+924TcamwTmpeVE/O6OOs8WJMc9A5c59fEEFrrskhuq+wSyR82hhTUqi
         AZS0+CNYcHMZiB5XUe+lKPDWmMOQA34q95N/qddKo221jehiWj7M7QQgwmVdU3N0G5Lp
         H9hmWP3D86DwyFzRPGJRoL6fTLnC7uD5Tbj/AJ0DKfaziE1zA/5fsyh4SDqBn4lhuhKf
         DkMV+VxILedvvhw4ND+TotwQ0Q2ERUzp5x+CuR7B0hVNZsFmvgD4UiVv4CsVWYnPTS+H
         sVPKmhU86eMbv7rWzf6EPSc9WmDLFIG7Rbz6kcXHRWE62Uxy8QLrnKEPhvk3E/YhZyZa
         6Bhw==
X-Gm-Message-State: AOJu0YxBcJL0XS+uvdHvCosNVdl7woVjC5Baql9UQyrcv3gNBJkZ6cBD
	G5FfPADGSTeIhaKtiimgJsdIlKowdoEd8+QRyPobcG4n9MbrSLtBtnAkUtHid04=
X-Google-Smtp-Source: AGHT+IEOFx6N2ufye3+7jlFwX6zodqhgreM3OywFAbalMjW1nOjb080PzmkJ3kC2H50ZMf8BeLrxvQ==
X-Received: by 2002:ac2:47f2:0:b0:513:814d:c05f with SMTP id b18-20020ac247f2000000b00513814dc05fmr2473757lfp.66.1709895561541;
        Fri, 08 Mar 2024 02:59:21 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:21 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 07/10] sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
Date: Fri,  8 Mar 2024 11:58:58 +0100
Message-Id: <20240308105901.1096078-8-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308105901.1096078-1-mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
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
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 84d4791cf628..f3c03c6db3c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12409,15 +12409,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 }
 
 /*
- * run_rebalance_domains is triggered when needed from the scheduler tick.
- * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
+ * This softirq may be triggered from the scheduler tick, or by
+ * any of the flags in NOHZ_KICK_MASK: NOHZ_BALANCE_KICK,
+ * NOHZ_STATS_KICK or NOHZ_NEXT_KICK.
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


