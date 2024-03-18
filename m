Return-Path: <linux-kernel+bounces-106050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B187E859
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DEB1C213B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC6364B1;
	Mon, 18 Mar 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9JCD/S6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423D3611E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760692; cv=none; b=iHH0PoIBB2fLXWw33yvlOAqHpaQ96r1OIKYAmWhFb1OyucKMs8MjrGV6zF3s+HLTmsl637qKEST2Z2WCn+6CxTJxpxBgBOxTg9cVRkBFNNO1RImZqhP30uS+dcH2vhW3sZRJxcUFmwiWKM5qq+a5xC5r1VskbmIa/RibdVBOg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760692; c=relaxed/simple;
	bh=O8orsh4fpL1MSr02xvuqLOzLtF3YhhKLmLgVXGjAEP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jtSM7nOIWloUW08sSmQ/R+7KrLimB/782PNYam7D8gPQZCnuwldCHabHuvB5b0ys32CHVu86HNEZGrjeGQ71TGAHEe2fLl0VA8H5W2v/T9dzPP2t7C/xUIio/3vt/2lLFOofwVg1eSlrbgANmJqkp1BTVzBbaxQXGTK90c93ek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9JCD/S6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710760689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Xrq8vJ1NagCe+cTWlPAdrkNTdkW7Dtp8mrb26EB1sQ=;
	b=Y9JCD/S6pUU2VNUvtaEoumt2fdzWniUYhyDnuHMRFzxwyRpSiZTh6ZhSqlO9n3RmV3K05v
	lHAYNxYPXcQVeOELJFKTRBQA9N//QPtBKfzA138IobnMMYbsRvDWc/hOnNg4ZnuZEyu56L
	zZa+g2/uwmxSIzvtXgc9VJfXQKTxKf4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-AXyhhxoHONWn_NAucC7XSQ-1; Mon, 18 Mar 2024 07:18:04 -0400
X-MC-Unique: AXyhhxoHONWn_NAucC7XSQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFBA1101A5B3;
	Mon, 18 Mar 2024 11:18:03 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.225.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C333492BD0;
	Mon, 18 Mar 2024 11:18:00 +0000 (UTC)
From: Daniel Vacek <neelx@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Daniel Vacek <neelx@redhat.com>,
	stable@vger.kernel.org,
	Bill Peters <wpeters@atpco.net>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: fix affine_move_task failure case
Date: Mon, 18 Mar 2024 12:17:48 +0100
Message-ID: <20240318111750.3097906-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Bill Peters reported CPU hangs while offlining/onlining CPUs on s390.

Analyzing the vmcore data shows `stop_one_cpu_nowait()` in `affine_move_task()`
can fail when racing with off-/on-lining resulting in a deadlock waiting for
the pending migration stop work completion which is never done.

Fix this by correctly handling such a condition.

Fixes: 9e81889c7648 ("sched: Fix affine_move_task() self-concurrency")
Cc: stable@vger.kernel.org
Reported-by: Bill Peters <wpeters@atpco.net>
Tested-by: Bill Peters <wpeters@atpco.net>
Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 kernel/sched/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc903467..d0ff5c611a1c8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3069,8 +3069,17 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		preempt_disable();
 		task_rq_unlock(rq, p, rf);
 		if (!stop_pending) {
-			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-					    &pending->arg, &pending->stop_work);
+			stop_pending =
+				stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+						    &pending->arg, &pending->stop_work);
+
+			if (!stop_pending) {
+				rq = task_rq_lock(p, rf);
+				pending->stop_pending = false;
+				p->migration_pending = NULL;
+				task_rq_unlock(rq, p, rf);
+				complete_all(&pending->done);
+			}
 		}
 		preempt_enable();
 
-- 
2.43.0


