Return-Path: <linux-kernel+bounces-101003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47CE87A0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0125283EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF4311185;
	Wed, 13 Mar 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Lmd5F7kS"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E5101E3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293113; cv=none; b=lwyDUkw0oUt8eNd+/AiliEWrRXkjcmo2rdC2EUpenxVpCvtoQZ1junum4RzUoQS6fo+D5OmEMchjR9Iol1/v69a91j8tR/ulnZGYvseehSbdbE2dMOGgf2dUt2uuJStzeMHoauaEAEu46ocyQP5gGCOD/9EUpJdZn1ubtnbsXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293113; c=relaxed/simple;
	bh=BiiWEkX4I10hm0Y+ah7m6xE4dk8P54pifKn/ZYznW2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOPo+Z2++NBilC5T1nvW/74R6drIKQz1dmy5t4ATVSnLjwY3jE7DB+7zIMdu896eyc9eHubmdET4ZiNx7b+p/UGjzhJboLbRznmbxb3WLfVJm1xpCcHjpCU5ZdZvgt5b2jNFwv6/upyqrjuY13EbTD+KU5EesdUWcBWETgEawWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Lmd5F7kS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68f41af71ebso4403916d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293109; x=1710897909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS0mEpzEEFGetzR6NtkyoXN8TWiVnIyPmeWduyYdhXs=;
        b=Lmd5F7kSHB3CLxMAkPjZn1u6p0d2e5Kaihz2g0kj7lwpdaK+TMQ5bO6PVVAk+zU+M5
         ubAZH5dFRB4kMEtp9njI6OSfLkaWFEqJutfFabBOaOdFpEv2bf/gs5N81GFVEoSPuZ3n
         rppy4tBzbDui+7jD14LgMUvop85SmcaE9dOII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293109; x=1710897909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS0mEpzEEFGetzR6NtkyoXN8TWiVnIyPmeWduyYdhXs=;
        b=wXYdQwA68/9I7CwwQ1vg2NvQb+t17yC/FXc1PfJV1S1MDcJqkeMesgQxGMB5cXEaaI
         456Vv6KfQcM7fP2vuwM0BPA4Xl1ed8qOGz/9OpT8+fX4K0YZVeqx9a6gsF/KfKVP6zLl
         zbhWe3Lvt+fYgLBZdKbtSME5eZGNyhM+9uHodm35CfDy3hneDQIjdBYgb1Ul2hYV8MNY
         n5jua4Cep3Ia1UkekY4iT5Lqk9mHDIhewk5EH4Zslf+rIh8k7c5B2+FfNjQeAyr6Xacj
         vVm9o5KxfmWBTjSCZeUqIiDvlz9TOhaaySuU2bX2Cnt6AW2WWVTC4Ph+gcHX/ufIjYiD
         pNrg==
X-Gm-Message-State: AOJu0YxQHlvZRQdm0J9Cb6kcs3F6c8WhgqGKzs2My4WhZfONCFtwntXh
	xAMjMef+LZdDbjMVJLPWXlgfDNKDdkGPS3txrzrh14mZDLnUQW42qL3H5L6sFNL1LBmRgq1p8YH
	5
X-Google-Smtp-Source: AGHT+IElQlhXgi/ZRZZUbYfXr5ht+BVJzWT9InU24HMdotNnyf9v8L7jWcfpx6nCWo49v7x7q+0ZuQ==
X-Received: by 2002:a05:6214:c4e:b0:690:de5f:2127 with SMTP id r14-20020a0562140c4e00b00690de5f2127mr2730090qvj.36.1710293109232;
        Tue, 12 Mar 2024 18:25:09 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:08 -0700 (PDT)
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
Subject: [PATCH v2 03/15] sched/core: Fix priority checking for DL server picks
Date: Tue, 12 Mar 2024 21:24:39 -0400
Message-Id: <20240313012451.1693807-4-joel@joelfernandes.org>
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


