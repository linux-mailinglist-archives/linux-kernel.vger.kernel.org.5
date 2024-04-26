Return-Path: <linux-kernel+bounces-159792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DCF8B341B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788EC1F22AED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C224A13F420;
	Fri, 26 Apr 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U7YVXvUb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2F13EFEC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123982; cv=none; b=lasCEl5OLmOSPDwBTZXiUB95BItRQmOgwxkv1KIwUtciG28hwEHsZID0DVDILh6JcPygm4pzdVN38dlnju0ERrbY6w0uBtqNQ8PDMQyYO09s0VE+nclQkq/JoXGHAwGUu9qYFFzlemFSQHFhaZsFoyQcHg1QKX14x8Rjb1DJ6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123982; c=relaxed/simple;
	bh=QjYSxE3yZoLUejKiYWIVmEy5qj3B8Wwzl1R9gERcVew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBWzkEi9grkRaItNUVf+FhA/R5PV8uUh9XqzHcUlPpFoK1rV8OFMt9Jsw66DP5HoHzNPDs9LoJxknENmPNm1TMMopZ6SwE08nsrHqXVj2LXTq48zduxEA2vtnnOzw/WLonDRJEGuT/ev14zKxa+TnPdMpPR3xFkvNW5uWf6iZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U7YVXvUb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dECxewvaWaBcgZAbVDss5owSSvV/A1Shy2Brqu6LXFE=; b=U7YVXvUblL3XyhQNOwb2fa4nsV
	GuC59ZSwSFe8eC16/MmbcAN/VUjL/MX6Emn+/2TfQwNoO/XsGQP5orn05d8acMYfJkMKJbGXmv9UA
	5G/Vtt32mJGvpnQV1nZELjSEANS/UKeoucIpAeZiJPH2QOqtOiESV618ef8dxLPkjw5G7CyZCevIZ
	9jP8hTp1pvw/cHVNFKOFdE4QcO6x6T1bq3uWsOWWzqM/UeMgSZ2P2yjDN/xbLD2azDhRVlyjVCI6A
	rmAtWwtEVfDNfmhc8FScxoMAYOD8QilXjEWeDGWZprwZ5OkNpZuwZqyd9+3GLZZLjZXPvEEpJ6DdQ
	rpKyl2Fg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Hwf-0000000FGWw-3T5G;
	Fri, 26 Apr 2024 09:32:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7A7763003EA; Fri, 26 Apr 2024 11:32:41 +0200 (CEST)
Date: Fri, 26 Apr 2024 11:32:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	nd <nd@arm.com>, John Stultz <jstultz@google.com>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240426093241.GI12673@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425114949.GH12673@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 01:49:49PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 25, 2024 at 12:42:20PM +0200, Peter Zijlstra wrote:
> 
> > > I wonder if the delayed dequeue logic is having an unwanted effect on the calculation of
> > > utilization/load of the runqueue and, as a consequence, we're scheduling things to run on
> > > higher OPP's in the big cores, leading to poor decisions for energy efficiency.
> > 
> > Notably util_est_update() gets delayed. Given we don't actually do an
> > enqueue when a delayed task gets woken, it didn't seem to make sense to
> > update that sooner.
> 
> The PELT runnable values will be inflated because of delayed dequeue.
> cpu_util() uses those in the @boost case, and as such this can indeed
> affect things.
> 
> This can also slightly affect the cgroup case, but since the delay goes
> away as contention goes away, and the cgroup case must already assume
> worst case overlap, this seems limited.
> 
> /me goes ponder things moar.

First order approximation of a fix would be something like the totally
untested below I suppose...

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfd1fd188d29..f3f70b5adca0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5391,6 +5391,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 			if (cfs_rq->next == se)
 				cfs_rq->next = NULL;
 			se->sched_delayed = 1;
+			update_load_avg(cfs_rq, se, 0);
 			return false;
 		}
 	}
@@ -6817,6 +6818,7 @@ requeue_delayed_entity(struct sched_entity *se)
 	}
 
 	se->sched_delayed = 0;
+	update_load_avg(qcfs_rq, se, 0);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d07a3b98f1fb..d16529613123 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -810,6 +810,9 @@ static inline void se_update_runnable(struct sched_entity *se)
 
 static inline long se_runnable(struct sched_entity *se)
 {
+	if (se->sched_delayed)
+		return false;
+
 	if (entity_is_task(se))
 		return !!se->on_rq;
 	else
@@ -823,6 +826,9 @@ static inline void se_update_runnable(struct sched_entity *se) {}
 
 static inline long se_runnable(struct sched_entity *se)
 {
+	if (se->sched_delayed)
+		return false;
+
 	return !!se->on_rq;
 }
 #endif

