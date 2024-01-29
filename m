Return-Path: <linux-kernel+bounces-42527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F4D8402B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CA91C21DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B861657333;
	Mon, 29 Jan 2024 10:19:36 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB856474
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523576; cv=none; b=b2A4vpFCIZnHSIM1W5tyJXmNbMCR79QxqBhqjQpVLGgkRo8m0DlUAg9xANwdz7NT4VM1iZTb1sTgI5WyER4ZqwadoDkmimOcaFOrDejB6Ek0ZvD+TXARtdyCgr13GlrRSLk29mfhOVY/AA6Co3CgOghw/J6dyhhKWW1otxzA5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523576; c=relaxed/simple;
	bh=0pbNMZwQGIU61mp3Riq86bwoqCEQr3qg2nODWQqlvcU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GfhP1Kb/yqjzdDJ7Xjht7CoRJD009MG+VdiDA52R8kkvf+nO1Fcru1WEbe0ZRTQfCDpijYYkroDTWe5rbEGwZ/xXwDjYSDpfq6wbUgtwdkcg9yl6aYRMzGf2fNSKKQzoeLpkUzZjG1ZyACGxrAR9UMuNRSZ2oamRVqIpjfqYV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4TNkmW1wQgzB0Y9C;
	Mon, 29 Jan 2024 18:19:07 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 29 Jan
 2024 18:19:30 +0800
Date: Mon, 29 Jan 2024 18:19:29 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] sched/core: Fix prio for fair in __task_prio
Message-ID: <202401291819+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: wuxshcsitd00600.xfusion.com (10.32.133.213) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

It is said "120" in the comment, but MAX_RT_PRIO + MAX_NICE equals 119.
DEFAULT_PRIO should be the right prio.
Fix it and imodify the corresponding prio in prio_less.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..13484ee71e5b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -168,7 +168,7 @@ static inline int __task_prio(const struct task_struct *p)
 	if (p->sched_class == &idle_sched_class)
 		return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
 
-	return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
+	return DEFAULT_PRIO; /* 120, squash fair */
 }
 
 /*
@@ -194,7 +194,7 @@ static inline bool prio_less(const struct task_struct *a,
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
+	if (pa == DEFAULT_PRIO)	/* fair */
 		return cfs_prio_less(a, b, in_fi);
 
 	return false;
-- 
2.40.0


