Return-Path: <linux-kernel+bounces-132884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8671899B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F690285809
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241BC16C854;
	Fri,  5 Apr 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WDIwli+M"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429616C450
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315047; cv=none; b=k4KMpu4PwvnWZssYz+r705Yz5SVxkZ84ExFc38dhp8OAkfj0nddXulq4cn6TIWFgHM8GKjsXYsLRBqlBxcOytWLQNkdVm/82/K7O/oS3Cct6KaVdfqhKetPdG2tFXktz5+9cGzu8nS4Z+1++/HFJ3a1vea0IbpMx0OPfkMvCpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315047; c=relaxed/simple;
	bh=G3zEEifFIUowvgzC2xGXgVFPNUF8BqJLwrxadDtjzUw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RA+IFXERbj9nd61kspc0bxGuSYBeUj7cKWnVeRzjwUPV4nxKibwAdqFIC+MfCphE1LrRfzcXjn6PyhLu1wTdxR+rna233LxA2rDWfDGQi3nVhiIBUoL/fMpKeVPVExX1g3Vk4IyOppEoQ/uKb5Hqp3uCniIu14NCOvvpG2gS9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WDIwli+M; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=DIvonqwOyRldWsif2Gmc3wP/mbcmRypN9iUJW5nW9KM=; b=WDIwli+Mz5UO/Qi4PhqExB6sSU
	gK0IniEVu0JeivlxHmlgurCD5nMlU1T11ef6RcMBDThe41Y2p+dpICBvrBLccLDqqP31C8rAsHocQ
	aTuXnO0pNYUoG/sqjvEGjcIrUch9aUnqVHW1lGKYwF8h4E+U13/vhW6wDgiNXkARLyTlu3DsRkuYk
	nH8EqlGdrgP0SzstiFaTNIYXKvQrUaYCoooBmyZ95MGz9/1k5prqAW4Y+t83RlHvfeKk/azHrdcJz
	yNgg55IX4fSErK2uZoEdNJ/V6pIdbyszOq+p1VjfMVxKM1O0sG8hmeDP0+qr59cqbePtVB3/9sziZ
	QUBdV9HQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMH-00000005Z8k-44Nz;
	Fri, 05 Apr 2024 11:03:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A1859302DC7; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405110010.788110341@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:28:03 +0200
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
 efault@gmx.de,
 Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [RFC][PATCH 09/10] sched/eevdf: Allow shorter slices to wakeup-preempt
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Part of the reason to have shorter slices is to improve
responsiveness. Allow shorter slices to preempt longer slices on
wakeup.

    Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |

  100ms massive_intr 500us cyclictest NO_PREEMPT_SHORT

  1 massive_intr:(5)      | 846018.956 ms |   779188 | avg:   0.273 ms | max:  58.337 ms | sum:212545.245 ms |
  2 massive_intr:(5)      | 853450.693 ms |   792269 | avg:   0.275 ms | max:  71.193 ms | sum:218263.588 ms |
  3 massive_intr:(5)      | 843888.920 ms |   771456 | avg:   0.277 ms | max:  92.405 ms | sum:213353.221 ms |
  1 chromium-browse:(8)   |  53015.889 ms |   131766 | avg:   0.463 ms | max:  36.341 ms | sum:60959.230  ms |
  2 chromium-browse:(8)   |  53864.088 ms |   136962 | avg:   0.480 ms | max:  27.091 ms | sum:65687.681  ms |
  3 chromium-browse:(9)   |  53637.904 ms |   132637 | avg:   0.481 ms | max:  24.756 ms | sum:63781.673  ms |
  1 cyclictest:(5)        |  12615.604 ms |   639689 | avg:   0.471 ms | max:  32.272 ms | sum:301351.094 ms |
  2 cyclictest:(5)        |  12511.583 ms |   642578 | avg:   0.448 ms | max:  44.243 ms | sum:287632.830 ms |
  3 cyclictest:(5)        |  12545.867 ms |   635953 | avg:   0.475 ms | max:  25.530 ms | sum:302374.658 ms |

  100ms massive_intr 500us cyclictest PREEMPT_SHORT

  1 massive_intr:(5)      | 839843.919 ms |   837384 | avg:   0.264 ms | max:  74.366 ms | sum:221476.885 ms |
  2 massive_intr:(5)      | 852449.913 ms |   845086 | avg:   0.252 ms | max:  68.162 ms | sum:212595.968 ms |
  3 massive_intr:(5)      | 839180.725 ms |   836883 | avg:   0.266 ms | max:  69.742 ms | sum:222812.038 ms |
  1 chromium-browse:(11)  |  54591.481 ms |   138388 | avg:   0.458 ms | max:  35.427 ms | sum:63401.508  ms |
  2 chromium-browse:(8)   |  52034.541 ms |   132276 | avg:   0.436 ms | max:  31.826 ms | sum:57732.958  ms |
  3 chromium-browse:(8)   |  55231.771 ms |   141892 | avg:   0.469 ms | max:  27.607 ms | sum:66538.697  ms |
  1 cyclictest:(5)        |  13156.391 ms |   667412 | avg:   0.373 ms | max:  38.247 ms | sum:249174.502 ms |
  2 cyclictest:(5)        |  12688.939 ms |   665144 | avg:   0.374 ms | max:  33.548 ms | sum:248509.392 ms |
  3 cyclictest:(5)        |  13475.623 ms |   669110 | avg:   0.370 ms | max:  37.819 ms | sum:247673.390 ms |

As per the numbers the, this makes cyclictest (short slice) it's
max-delay more consistent and consistency drops the sum-delay. The
trade-off is that the massive_intr (long slice) gets more context
switches and a slight increase in sum-delay.

[mike: numbers]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/sched/fair.c     |   11 ++++++++---
 kernel/sched/features.h |    4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8538,9 +8538,14 @@ static void check_preempt_wakeup_fair(st
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 
-	/*
-	 * XXX pick_eevdf(cfs_rq) != se ?
-	 */
+	if (sched_feat(PREEMPT_SHORT) && pse->slice < se->slice &&
+	    entity_eligible(cfs_rq, pse) &&
+	    (s64)(pse->deadline - se->deadline) < 0 &&
+	    se->vlag == se->deadline) {
+		/* negate RUN_TO_PARITY */
+		se->vlag = se->deadline - 1;
+	}
+
 	if (pick_eevdf(cfs_rq) == pse)
 		goto preempt;
 
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -14,6 +14,10 @@ SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
  * 0-lag point or until is has exhausted it's slice.
  */
 SCHED_FEAT(RUN_TO_PARITY, true)
+/*
+ * Allow tasks with a shorter slice to disregard RUN_TO_PARITY
+ */
+SCHED_FEAT(PREEMPT_SHORT, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed



