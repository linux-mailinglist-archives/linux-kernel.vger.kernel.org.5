Return-Path: <linux-kernel+bounces-132879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B10899B89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA2D1F239B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE916C6AC;
	Fri,  5 Apr 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2wcoWqZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7D16C443
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315046; cv=none; b=mHoRrwhP19SoDLmUrjftE+xh+VgcRhq1reP49mU+RXwseGQSaLnAqI8H+HKSP4z76NEHfbiN2pcQFHFdnks5z5CP7N3U82ez5u3Kaxw21t/MXr8weyIvjjBysv1oQprQ8G/5HLHWoja2Gc4chCXd3I0qWCsmYtbPl4Au/Bx0biQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315046; c=relaxed/simple;
	bh=M4HBcgcD845WAC9I/6dj1Sl5pOIoU8bcnQl3McXkdWg=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=k9qmwzq1/5QE04QU/Fb7Wxt9EkGWt3qiCVrnImKtPnSn9YC6Fw8SQ/OlEPPwQ5og0eIANaU/Zdv6fl2XaJHeLVmZmPQbkIe5qSNJN6Vh+xRgeIWG9qYPNfv9dJaRb3zC6vHStwnsTvBQtI0VXZ6pshnNkqFO1EwjUMY8FTxWLgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S2wcoWqZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=j7sT52IkVneMcHlqpAGkJ+n2iSkCj1GRvOnWWUFsuJE=; b=S2wcoWqZ/ITrLPuJM7Suw6d7JG
	BJd+p8HkN9xeSnX4H2N4I++a6AQH9MEflxMndRhGi6ZuzU9R8RUVhbAOaCnAYxUlni5gGqJt0emDA
	7KSAUdG4pWejrmC8dcXv25OB9XMpr3n70jKgshzWRJxpMGM2jwAuVA9RGa8MjC4Y+ca6+EOsh9iiS
	NUCE0voerF684NTFWnKyeHM+XXWQ0W2A9C79l4M9Y7DuXN4q+eSHb83+j1mjJr59F5d1R5BMyhUMO
	VIlOk6LXa4qylEBUUCUZQkUxpSY46d2F6AU5I6H9UdVIG9vBYo/hlLXcHn71It1jQmlyAY1q0n4Fr
	Gp6QdExw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMG-0000000AKMJ-3hmb;
	Fri, 05 Apr 2024 11:03:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8662B301D7D; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405110010.024746026@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:27:57 +0200
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
Subject: [RFC][PATCH 03/10] sched/fair: Cleanup pick_task_fair() vs throttle
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Per 54d27365cae8 ("sched/fair: Prevent throttling in early
pick_next_task_fair()") the reason check_cfs_rq_runtime() is under the
'if (curr)' check is to ensure the (downward) traversal does not
result in an empty cfs_rq.

But then the pick_task_fair() 'copy' of all this made it restart the
traversal anyway, so that seems to solve the issue too.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8435,11 +8435,11 @@ static struct task_struct *pick_task_fai
 				update_curr(cfs_rq);
 			else
 				curr = NULL;
-
-			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
-				goto again;
 		}
 
+		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
+			goto again;
+
 		se = pick_next_entity(cfs_rq);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);



