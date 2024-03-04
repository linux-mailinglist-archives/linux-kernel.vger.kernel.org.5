Return-Path: <linux-kernel+bounces-89996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB1186F8C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B7C2813B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A46FAD;
	Mon,  4 Mar 2024 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ReLNKGfZ"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F04A15
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709521261; cv=none; b=aN3hmu+2DqZ8NG70i1u1ZyCx1NEWQTnGe7DpdDRVA+5qjwFRXjzXqX5YDO+VDSimrXmoRWoXaEVxs3xOQigoRh0e0jkAqu6OuUNedW0WQHUuk0JAKzqWt1Qo1n3N1pLhpR0GfdgCbLOfBoyEd+qDNpq2QhOQhtcEHmhmZ4GNpjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709521261; c=relaxed/simple;
	bh=/na5pr5dBEKR/drn7nkYD2RUThEAWD8UrRCZ+1HtChw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mD6S8EWfmfQNncZ/sBn0cmphuRPxpPr7OzAsMAit+HZslgjcdAOnMUqcK2UJjPBkjuDxHbnIZu6q9s/Xy9SKDRClABZpEVsRhKaUNyKbzupLI/YupNza7f2FTV5uuYbguyTAatWz7TtiqO4XHdFCvgmN6XQyE5aCUKHRISrx0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ReLNKGfZ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709521250; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4u7FtZOI33xmYIt3T0Rn34srhvB3CoeuSZKAdi4JZLQ=;
	b=ReLNKGfZyE68O0Ahlr5OC2PFykZxYgv8s3P7C2jqqkpaO/z5Hi2F010IhPkFyia6Y47VvKhszNYhof9TEdoLF0pJQgYEHd3k0FGwwcWZG+UY8KcGXI+WgbAXwGHQAv1ZaENwA2gH1sXpMFQ+uodgasF0wete2vEtbW6rnlZpU7Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W1i0XYV_1709521249;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W1i0XYV_1709521249)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 11:00:49 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH 1/2] sched/eevdf: Always update V if se->on_rq when reweighting
Date: Mon,  4 Mar 2024 11:00:41 +0800
Message-Id: <20240304030042.2690-2-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240304030042.2690-1-dtcccc@linux.alibaba.com>
References: <20240304030042.2690-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reweight_eevdf() needs the latest V to do accurate calculation for new
ve and vd. So update V unconditionally when se is runnable.

Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..5551ce2af73e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3790,9 +3790,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	if (se->on_rq) {
 		/* commit outstanding execution time */
-		if (curr)
-			update_curr(cfs_rq);
-		else
+		update_curr(cfs_rq);
+		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
-- 
2.39.3


