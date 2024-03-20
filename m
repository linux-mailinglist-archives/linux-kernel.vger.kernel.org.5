Return-Path: <linux-kernel+bounces-108369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D4A8809BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5B32849D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD2C1946F;
	Wed, 20 Mar 2024 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="ebfEqXGg"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DBB107A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902548; cv=none; b=e/v7KO+hyB3Vj6ahbAgZs6xKr8HDfD8QMPcff1wXtx32CUNlTp83MCF/jTTqnkIb2FSFfeLq6ZYVF9fOhpPtOQTlamhzYUpx1GbbAdwQjiitV3FTUytLl+ooIFudTMRoSuXd3quWuhRP79yIEtiOAsNQCvoxPoFn0Jo0PDgKVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902548; c=relaxed/simple;
	bh=xfUq48QO6OVoxR0oxw0nGWYHlbBWHnOlmAnISATgV2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jlhTiKcGMtjh+5Ww5cOZuwTgYxZ6KPnP+ynvqxfu1A/Ms55ivBbWSdgRDEJKxSn3otq9TPwh6GFJhtRtxbYiba9X1es0YcTP+kX20Ebb3f78PO4mSrc/ate8BtsskhixuM685auYsTE79EpxpdXrXNktjZV2/rLvVGh2U+KbMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=ebfEqXGg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-430a25ed4e7so38551311cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1710902545; x=1711507345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WzVosZB8NV09/ZiVxYfUQEEiRP/cgORaiI2cKH0KzxM=;
        b=ebfEqXGg6zInbzB7p1gP3M53nHGWaA5XWy7Fae8D7C2svwmpxRiNO5UYt7NnqZAgyG
         D2x3EJwSi7B+FE7L8ugadDarYDrtoN99P12ISP5ubQzMJIc5YWTDaB9D5TcQoMdY0L+U
         GP2SD7/xnUJNUitgdQ3uzXdQmlKKiBkAxXH2SrB1erchbMkzqeSxhk6TDlEkk/1ixFtA
         ByzYJG13YznlEKkZqDPddbZynW6Nfc+zV84irNNHVwYfbIt4J2LWku85lnO2dzY4lrXF
         ryh++Pu6PtqrqI+2+hTmDp8GgOc8LrhnxySiUUiiMzU3mr0gubmht78e3zly0F9yfTHO
         NOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902545; x=1711507345;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzVosZB8NV09/ZiVxYfUQEEiRP/cgORaiI2cKH0KzxM=;
        b=M+anUt8jLvl7XmO1V364Eez9n5VtcHwM1skF+TPp9t0eh8lXQD8zE3rH4m5fs78jGB
         z2sAZTb6MM9OJW7ecjbB/8Kmdwfju6ZRrRbBZ+RcYV3TbmmqIygVSGVgTb5Y7OvYwTTZ
         gBloZeWiQGqdry7eZse2nVbkf9PRyzjEX2lm3fbZc4zML8RroYiTgSqqIbMJkOzIoAAA
         r7a3WUGth80mz2ERn8B31kcam9xGfrKNn3vMCf/mW/xYNmsNCUpf3DMHRxpzrbJwseuq
         9iATjcIzJK/Gz5DRsQS9EvzWu++WKn5EICjAviqpkk3VBPxPeQ+KjlNbU/Qsf63LIQNH
         IFvg==
X-Forwarded-Encrypted: i=1; AJvYcCUiO3DRPFtjp/CMK0h0ZLwGHWa74ZT+AE2Zr3cttUE1ujguTd1o2T1VJ3Xv02RskECkyRq5Hd+3fFX1houuYEqyB+4ZGAtJnO87HENH
X-Gm-Message-State: AOJu0YyVIoVEfpV91Pweqogyg65tFYeQ5+UWwvgtHMwg3sdnZK8Fi66Q
	6JHaxBLdITkZAyN3VWr7Dwmy/4VSDHtwJgDbotbCy2wiAIb1j63OzEDYFcNocA==
X-Google-Smtp-Source: AGHT+IGEfbBr6cutAmN+mlO7n/aShmIQU3GTmhE5CM9Lh4mCEbZf0tbj0IjwPIaD6NVNuXa3bBmlRg==
X-Received: by 2002:a05:622a:110a:b0:431:baa:ab0c with SMTP id e10-20020a05622a110a00b004310baaab0cmr135047qty.50.1710902544986;
        Tue, 19 Mar 2024 19:42:24 -0700 (PDT)
Received: from localhost (pool-74-98-221-57.pitbpa.fios.verizon.net. [74.98.221.57])
        by smtp.gmail.com with UTF8SMTPSA id fg14-20020a05622a580e00b00430bddc75a5sm4582852qtb.23.2024.03.19.19.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:42:24 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	dskarlat@cs.cmu.edu
Subject: [RFC PATCH 6/7] pass gfp mask of the allocation that waked kswapd to track number of pages scanned on behalf of each alloc type
Date: Wed, 20 Mar 2024 02:42:17 +0000
Message-Id: <20240320024218.203491-7-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
References: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
Reply-To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

In preparation for exporting the number of pages scanned for each alloc
type

Signed-off-by: Kaiyang Zhao <zh_kaiyang@hotmail.com>
---
 include/linux/mmzone.h |  1 +
 mm/vmscan.c            | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4889c9d4055..abc9f1623c82 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1288,6 +1288,7 @@ typedef struct pglist_data {
 	struct task_struct *kswapd;	/* Protected by kswapd_lock */
 	int kswapd_order;
 	enum zone_type kswapd_highest_zoneidx;
+	gfp_t kswapd_gfp;
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index aa21da983804..ed0f47e2e810 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7330,7 +7330,7 @@ clear_reclaim_active(pg_data_t *pgdat, int highest_zoneidx)
  * or lower is eligible for reclaim until at least one usable zone is
  * balanced.
  */
-static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
+static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx, gfp_t gfp_mask)
 {
 	int i;
 	unsigned long nr_soft_reclaimed;
@@ -7345,6 +7345,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		.order = order,
 		.may_unmap = 1,
 	};
+	if (is_migrate_movable(gfp_migratetype(gfp_mask)))
+		sc.gfp_mask |= __GFP_MOVABLE;
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
 	psi_memstall_enter(&pflags);
@@ -7659,6 +7661,7 @@ static int kswapd(void *p)
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
+	gfp_t gfp_mask;
 
 	if (!cpumask_empty(cpumask))
 		set_cpus_allowed_ptr(tsk, cpumask);
@@ -7680,6 +7683,7 @@ static int kswapd(void *p)
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
 	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
+	WRITE_ONCE(pgdat->kswapd_gfp, 0);
 	atomic_set(&pgdat->nr_writeback_throttled, 0);
 	for ( ; ; ) {
 		bool ret;
@@ -7687,6 +7691,7 @@ static int kswapd(void *p)
 		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
 		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
 							highest_zoneidx);
+		gfp_mask = READ_ONCE(pgdat->kswapd_gfp);
 
 kswapd_try_sleep:
 		kswapd_try_to_sleep(pgdat, alloc_order, reclaim_order,
@@ -7696,8 +7701,10 @@ static int kswapd(void *p)
 		alloc_order = READ_ONCE(pgdat->kswapd_order);
 		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
 							highest_zoneidx);
+		gfp_mask = READ_ONCE(pgdat->kswapd_gfp);
 		WRITE_ONCE(pgdat->kswapd_order, 0);
 		WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
+		WRITE_ONCE(pgdat->kswapd_gfp, 0);
 
 		ret = try_to_freeze();
 		if (kthread_should_stop())
@@ -7721,7 +7728,7 @@ static int kswapd(void *p)
 		trace_mm_vmscan_kswapd_wake(pgdat->node_id, highest_zoneidx,
 						alloc_order);
 		reclaim_order = balance_pgdat(pgdat, alloc_order,
-						highest_zoneidx);
+						highest_zoneidx, gfp_mask);
 		if (reclaim_order < alloc_order)
 			goto kswapd_try_sleep;
 	}
@@ -7759,6 +7766,8 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 	if (READ_ONCE(pgdat->kswapd_order) < order)
 		WRITE_ONCE(pgdat->kswapd_order, order);
 
+	WRITE_ONCE(pgdat->kswapd_gfp, gfp_flags);
+
 	if (!waitqueue_active(&pgdat->kswapd_wait))
 		return;
 
-- 
2.40.1


