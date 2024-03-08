Return-Path: <linux-kernel+bounces-96920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9D876313
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C881C209F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CC755E73;
	Fri,  8 Mar 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrZeEiCv"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCAB5D746
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896728; cv=none; b=eqIJQlVcsSz1hygE5CRC7vpieuRw0zUzGCJ+7fR08UY47Ti3WWihDIzzVf+bB3H4oK0xxVOaogoAjVolH1sabKf7bhPr9kyEispiS8QaKB1W6BV8T8EtHeu3C9S+Hy7nzrnSnfSo55s0mp3AH35+UiZxR7JFqaBt5e66VBZMAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896728; c=relaxed/simple;
	bh=1Qy8fQjqx8ZxvIi4pjJjdOJElW1kL76efZnQGOLJkt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Irqsnj1ogFo7CsE2CjPJvKFzSINn4HBUqqlxzoVa5+sdmf9/a8zzdacMTKLHrWvconfCpbcYgwia5Lu4jpUFUoxxfClzh1Grvp5OZ90iTzvEGfG8/imoyT2B0WPu7EGTTRSElN/gTWEEHIGquTcUY6fn/HwztR+g0HC9LKgH+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrZeEiCv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412f1961101so17124715e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896725; x=1710501525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTzCczXvQjKBJxCPwBhryBD4dLKi2fHh1v5KBqSA4qo=;
        b=JrZeEiCvDLNJ2ArHvTSQpiLw7GFojKuFQwzu/d+0f//NWPSznjeXzfUSQrVvQ7QUnt
         +7HUIKAqnUZDYI1WPhsmpu1A7HJaITH33ADkGxODb+MfExfGyA9i8d17L949NvILMFL1
         mi7lfQrH1HFmMpitPqlsIAa3MoR3JhQHlPbaQb1BSK8D20PsC+dgbO8uOf9UZvldkRNO
         osO/3hgzJjbRfnhILOoeUQl2492T+x2zs95ZTIO1qTaI4xahRf4jh23hVBoCiJThlRrj
         g/sks/J4HmrHhejt2gM0O5isBFT7273p6w7azwqaPRVJFgKueV3sm31A6ovGWgfxYYIa
         4kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896725; x=1710501525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JTzCczXvQjKBJxCPwBhryBD4dLKi2fHh1v5KBqSA4qo=;
        b=NK/5I5iYu77BDmv+m6W54M6n+RJPhjrHddQEMZDIYmVs4bozPDz6cqGRYS8Xc769Iy
         hYyskDZvsGOy0UhOxaPjtcX+/Ow7BubQ7ZfvVPNmEzOGtxOoo9XUL2TmtFv/GmCxpVuH
         1opIeVU5dnYWWLLtJh83liANMSccTyelpfS2TNlyYiQQlIUm/4fgpy7cTB9OPg5c9lt/
         3yvYlznTqbWE9Qw6xRbT/n4uB3r73pr8Vf7GAc1S9ZcUqyLmqE1H9Ge67m0QI+HZjuJL
         bPyp4Bs0fUMlHcbahuJ8bz/ryO+zx6ndrFduLo6oSgdfU1P7aW8ujujmADeuveZ0ft3m
         ucbw==
X-Gm-Message-State: AOJu0YwDAPTxoYMTXR3KIDuk+m9KSLnfiA05ckCSyR1BOpMvTRihtxTX
	jCc7LPNqKcEddTvEzjO6Djjdjn4gu5xbVCI+bGbdSMWcQc1zPFLSvlOqPWwhPGw=
X-Google-Smtp-Source: AGHT+IEaFgMXxbldQDMji3qVITQatIqqKRMpyNd7fjQqkchlZvSIOz7R1DocoUTFVJPshNa4Ac0PnA==
X-Received: by 2002:a5d:4287:0:b0:33d:e74b:e3e with SMTP id k7-20020a5d4287000000b0033de74b0e3emr13636669wrq.41.1709896724638;
        Fri, 08 Mar 2024 03:18:44 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:44 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 12/13] sched/balancing: Rename find_idlest_group() => sched_balance_find_dst_group()
Date: Fri,  8 Mar 2024 12:18:18 +0100
Message-Id: <20240308111819.1101550-13-mingo@kernel.org>
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

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Also use 'dst' instead of 'idlest', because it's not really
true that we return the 'idlest' group or CPU, we sort by
idle-exit latency and only return the idlest CPUs from the
lowest-latency set of CPUs.

The true 'idlest' CPUs often remain idle for a long time
and are never returned as long as the system is under-loaded.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02ff0272b2e4..d0c3a091d7d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7098,7 +7098,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 }
 
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
+sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
 
 /*
  * sched_balance_find_dst_group_cpu - find the idlest CPU among the CPUs in the group.
@@ -7185,7 +7185,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		group = find_idlest_group(sd, p, cpu);
+		group = sched_balance_find_dst_group(sd, p, cpu);
 		if (!group) {
 			sd = sd->child;
 			continue;
@@ -10296,13 +10296,13 @@ static bool update_pick_idlest(struct sched_group *idlest,
 }
 
 /*
- * find_idlest_group() finds and returns the least busy CPU group within the
+ * sched_balance_find_dst_group() finds and returns the least busy CPU group within the
  * domain.
  *
  * Assumes p is allowed on at least one CPU in sd.
  */
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
+sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 {
 	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
 	struct sg_lb_stats local_sgs, tmp_sgs;
-- 
2.40.1


