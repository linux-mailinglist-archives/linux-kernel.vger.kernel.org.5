Return-Path: <linux-kernel+bounces-132878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA6A899B88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749B1B21299
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32316C6A7;
	Fri,  5 Apr 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q+YbpgwB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3216C442
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315046; cv=none; b=KNMAB4z31rPQaP3aDT6VJrudK2wu8mL0XhlFA+iewUvwdmeA/vIsxxb9EYZOaORNSw0B6PLQKoT1VlLf25J7+t7R76L8JZyeO1FbpNJaiSlOmcWRNfoJD1edOR/H5IyDzcE0XUhATiGViQ9+K9gFzdzg0Tg0E4/VmNCaYxFAqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315046; c=relaxed/simple;
	bh=itOTK8ClA+pTJ/B6S2TzJ7Aj4zf26Rg68UHzyKxe108=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Om+Uc7LikTglyvvTAjwX9wcqPk4W89CWBujm/4/NIo75AC9qG1OzKTbt6zmB3mWOAY7S20r1qfJ+M1d2tcxYi9kGiHEJj31KYYQb84TbwktMgmoyOsjxtCF0w3q1mTL2A5No6peX4k5T2afZGeNZFSuj2z3PVMRWsZ4e4nhgGNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q+YbpgwB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Y5Ccj0++8TjNxyCdrumDAmasoET46Cckf/W1eeLKY0g=; b=q+YbpgwB0Ma1uMhNzTymsNxd9j
	fot2skru4PqQsb0A+tgQoa5EMNmktXZV7GLTq5KDm8ol3V7u/0oTKcmAbaRUQCT1nvUXyNig4WmLT
	sU6Bb8dB05frgGLOXwoB2oYKcE/cmfcryUGBzMeBu844xf/S7QBSkYrEEQwctI4BTuERtstKFmysd
	KMVn4rg9V8LNTzm9I+FpWBMUfzKGyboKqXvlXQu605LE7gtGso0QOFOHBnQ1hp9k2CSXEzwPiJVUM
	HBhJL/fAVeszSGrOuyN+HssIzsAZy7eY0TAmtGjJrN/TBb/j6iDR81lq/tS7hSLI/mg5QqQtO6oSh
	vPX6Ep5A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMG-0000000AKMK-3lJ9;
	Fri, 05 Apr 2024 11:03:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8A62530243A; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405110010.129481249@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:27:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [RFC][PATCH 04/10] sched/fair: Cleanup pick_task_fair()s curr
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With 4c456c9ad334 ("sched/fair: Remove unused 'curr' argument from
pick_next_entity()") curr is no longer being used, so no point in
clearing it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8427,15 +8427,9 @@ static struct task_struct *pick_task_fai
 		return NULL;
 
 	do {
-		struct sched_entity *curr = cfs_rq->curr;
-
 		/* When we pick for a remote RQ, we'll not have done put_prev_entity() */
-		if (curr) {
-			if (curr->on_rq)
-				update_curr(cfs_rq);
-			else
-				curr = NULL;
-		}
+		if (cfs_rq->curr && cfs_rq->curr->on_rq)
+			update_curr(cfs_rq);
 
 		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
 			goto again;



