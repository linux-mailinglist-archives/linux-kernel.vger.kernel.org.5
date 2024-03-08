Return-Path: <linux-kernel+bounces-96914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6008387630C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAFF1F21AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C475576D;
	Fri,  8 Mar 2024 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAuu3gKT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2E57865
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896721; cv=none; b=ShaZu5vBL9pMisHp9/SD1v8zjjn9Vg3XSm0QoaxsycgWsOCGvyV4xNKXNE8yled3u1V8FycmsaOojEOJ7rJlxL+HmIbAPtgQUly9qBLqBIrZhEtgXYC0jdPHOa3XRMGhLKHAjddfd/SJyjx97HkgLRUqgc9bj8U74Pu1ztDK3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896721; c=relaxed/simple;
	bh=AESe7ke6Yrm588PLCrye9y338EkZkbZJPxKaorzKjI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/YYtDucBRtMuvJgG+T/gkEl89TB0zoLeKQKEGCwxIdT5JWIOUrviAGck0qq01fb6y0V8VgRPo153+e6KkKx6EyC6xv0iUuij6q+Y35W63BdEPkdhMnY/2JHr306iTX2Cj6RELvCwJLOfNqGaw8XV9SD94WzwG+05Vq1RI2V2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAuu3gKT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e162b1b71so1781112f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896718; x=1710501518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNmM6RIenOn/m5YEPt0cx45ySsFNjYzl8lKQCamjeno=;
        b=TAuu3gKTdY5auzwqLtXbMRl5+QB6F8eA/A9T8np//UWNEVYAqdCuNIXE4CCvWJqajo
         3OyQzjpUVwwVRL5btNbrWVDs60LE9XkBgyvqWrSaxo1mgYdrQlX8HkU4wjNpkRB4wqfI
         eoX2PCjml1XtbS88VNKKboqJiuNRhiLK0qjUJDn1K8XROWlJneZMC022jcX5WxsTUEBF
         ae0xfc6UauHag/pmAgrfhO82ojFU3KoVaRywehNtm98HQSUcaknYpLaHqWxt+CIDB7N3
         3vqMZkKf3brL0DqFH+V2Bn1s9W+3iELsdMcxhl3hfkrwJIiLVm/3+H7TF1hwL4NDLE26
         rPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896718; x=1710501518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pNmM6RIenOn/m5YEPt0cx45ySsFNjYzl8lKQCamjeno=;
        b=mEJTuEUFO0lAihSS3AnoGnLTcNInimGd4nNJgf/S7bfMDci+ZeKuyXSn/v2gsrA6gL
         lYPYiJ1lMD0ce+mFtNtv95REHtPpZ1R7Nb0w0JwynO09lHGCicxo65Pwp2T9InxSJsCB
         t3fOA8x3wUaV0nSUwSMx7dZ4u4K7deSzaQi2OPi/BO6Ypw64QkIxIwpnVzzRJbMxBHPC
         2ISHCeRMC1snp/uVB0WxXWLEM5BgoWJv6kV8MowDvgCmJU5bI9/kGyGFMIby400sYl00
         hkiJStoARvThPj86ewbjJJH3iMC79NhB3LbXYVsRPD7nDnZzNHoCsmNuApC/mfVTrQYw
         IytA==
X-Gm-Message-State: AOJu0YyP1z+YbaynCbFWrGgNBbr89WoRppuV7FbHEOAi93hnGMZzT07Q
	gcqXMZiHt1oAvBJfR8DK/o4e/669zwMtwWsuPFspj7fNsk0xLJQl9hFkg4F7GsQ=
X-Google-Smtp-Source: AGHT+IGwLQ2ttyzIU6BRrqrLkPlr9/1NOZYNLni4hMseXlcw3MQ0yLcmRzBgb5YXR+QdJHBG54qLFA==
X-Received: by 2002:adf:b649:0:b0:33e:1f2b:a468 with SMTP id i9-20020adfb649000000b0033e1f2ba468mr15210958wre.24.1709896718127;
        Fri, 08 Mar 2024 03:18:38 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:37 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 06/13] sched/balancing: Rename find_busiest_queue() => find_src_rq()
Date: Fri,  8 Mar 2024 12:18:12 +0100
Message-Id: <20240308111819.1101550-7-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308111819.1101550-1-mingo@kernel.org>
References: <20240308111819.1101550-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The find_busiest_queue() naming has two small quirks:

 - Scheduler functions that deal with runqueues usually have a rq_ prefix
   or _rq postfix, but this function has neither.

 - Plus the 'busiest' qualifier to this function was historically
   correct, but has become somewhat of a misnomer: in quite a few
   cases we will not pick the busiest runqueue - but the best
   (possible) runqueue we can balance tasks from. So name it a
   bit more neutrally, similar to the 'src/dst' nomenclature
   we are already using when moving tasks between runqueues.

To fix both quirks, rename it to find_src_rq().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0d2753c50be9..e600cac7806d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10959,9 +10959,9 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue among the CPUs in the group.
+ * find_src_rq - find the busiest runqueue among the CPUs in the group.
  */
-static struct rq *find_busiest_queue(struct lb_env *env,
+static struct rq *find_src_rq(struct lb_env *env,
 				     struct sched_group *group)
 {
 	struct rq *busiest = NULL, *rq;
@@ -11280,7 +11280,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(&env, group);
+	busiest = find_src_rq(&env, group);
 	if (!busiest) {
 		schedstat_inc(sd->lb_nobusyq[idle]);
 		goto out_balanced;
-- 
2.40.1


