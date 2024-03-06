Return-Path: <linux-kernel+bounces-93239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA7B872CAA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AA81C21DEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908E9101C4;
	Wed,  6 Mar 2024 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i+/4xbF4"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D411737
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691711; cv=none; b=Jyks4rtlATVw3SBCTbVEMQp/9nP0E7Ab7yHvCNZ91A1LlSOAOWVRbCTMGJN8tJunUXxP8SZWFd8KORBjfx5nwEmAur/NIxuVb7u+MClVVMoo/WUi4DtncCxmQlO4xrNp6OiNbN89vzmUS/T/8UnIFNTxQYLTQwlH4E08AtALX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691711; c=relaxed/simple;
	bh=4Qcvxbo4yVnHGI1XijOvuVxr8KAxzPC/FWF9Ngs7Ecg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhGX0/0xOs10KCdGeYVVWSllYwe/0E0jofFdF0ihZmZDFdZkjI1VVNm753P9gAvtzX/gjj5tBp7wQ5Sou5dmNBYaSyUwELt8XVwOsfFrR2/so/NhI/GP2IxdAbtTiTWYfJKqair0ZbK22ALJVTIiyl4MI4Zsy5YkyNrfCaMhUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i+/4xbF4; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709691701; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sHdpStoisiwB+BViHQryg1RajFi92J6Co77x3KsUFjI=;
	b=i+/4xbF4OMXW/8gkwZOga9RCoOYh/CHdfvaksFBIp8ABl4q7Fc+VedW086NJepxuL120y5ltj6zE1Uh2po1ePeSd0vtRbL3U9sI1mJ4GN68OPHUZ9PPFgoxtSM4JwM5KXlOPe96eUQ61kuhjNG7nEc1gO6BUdlvFURRsETsgEus=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W1vhPKb_1709691700;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W1vhPKb_1709691700)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 10:21:40 +0800
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
Subject: [PATCH v2 1/2] sched/eevdf: Always update V if se->on_rq when reweighting
Date: Wed,  6 Mar 2024 10:21:32 +0800
Message-Id: <20240306022133.81008-2-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
References: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reweight_eevdf() needs the latest V to do accurate calculation for new
ve and vd. So update V unconditionally when se is runnable.

Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
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


