Return-Path: <linux-kernel+bounces-10880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD781DDEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6BB9B20E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 03:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8285BA56;
	Mon, 25 Dec 2023 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Oq7B2HaF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3D812
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP3BR0l029746;
	Mon, 25 Dec 2023 03:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=QRg48hyh/zPlqk0RFZeKCRb0YrCWvCns/Zy6ikrYLzs=; b=
	Oq7B2HaF521WJ7cAzY+ufizj0Z1EEYkcSJh2xO68AljwoEvGL0WURTxcMokPKpQT
	+mFVIwBo9dzEZ1+DRn7EzAvjmwqz/y+ehyYNhrCffQoWnXVY3FFiwtp3QS2SIj9e
	BVLvmKZiRgLQ7ujjzFwSGxWQ50A8xzFmjBX/lBA4lJoj+iLdglMsRMKShMj9wsJQ
	6/mpzDnefRpr/4vgQirH+4p9UPnK7usMPqUdCpbOscrwanVSnu4RQZNTPTUOw5B6
	xd25wlc0yM7HLoz2gAiiWn7KXM1iNpB+X/Xg5jlJricIt0SwHqLG9DLWwmT1G9kM
	FVumPABkRJjikqZr6/cNYg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5mrxsaw1-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 25 Dec 2023 03:18:37 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Dec 2023 19:18:40 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 24 Dec 2023 19:18:39 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in __run_timers
Date: Mon, 25 Dec 2023 11:18:35 +0800
Message-ID: <20231225031835.3191503-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b26907060cb9f1f5@google.com>
References: <000000000000b26907060cb9f1f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OkRV-R29Ga_vrERrZkK8xIFqAWZNvT0g
X-Proofpoint-GUID: OkRV-R29Ga_vrERrZkK8xIFqAWZNvT0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=785
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250021

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 88035e5694a8

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..30427a1f961c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -941,8 +941,12 @@ static void worker_enter_idle(struct worker *worker)
 	/* idle_list is LIFO */
 	list_add(&worker->entry, &pool->idle_list);
 
-	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
+	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer)) {
+		unsigned long flags;
+		raw_spin_unlock_irqrestore(&pool->lock, flags);
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
+		raw_spin_lock_irqsave(&pool->lock, flags);
+	}
 
 	/* Sanity check nr_running. */
 	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
@@ -2164,6 +2168,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	struct worker *worker;
 	int id;
 	char id_buf[23];
+	unsigned long flags;
 
 	/* ID is needed to determine kthread name */
 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
@@ -2207,7 +2212,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	worker_attach_to_pool(worker, pool);
 
 	/* start the newly created worker */
-	raw_spin_lock_irq(&pool->lock);
+	raw_spin_lock_irqsave(&pool->lock, flags);
 
 	worker->pool->nr_workers++;
 	worker_enter_idle(worker);
@@ -2220,7 +2225,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	 */
 	wake_up_process(worker->task);
 
-	raw_spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irqrestore(&pool->lock, flags);
 
 	return worker;
 
@@ -2727,15 +2732,16 @@ static int worker_thread(void *__worker)
 {
 	struct worker *worker = __worker;
 	struct worker_pool *pool = worker->pool;
+	unsigned long flags;
 
 	/* tell the scheduler that this is a workqueue worker */
 	set_pf_worker(true);
 woke_up:
-	raw_spin_lock_irq(&pool->lock);
+	raw_spin_lock_irqsave(&pool->lock, flags);
 
 	/* am I supposed to die? */
 	if (unlikely(worker->flags & WORKER_DIE)) {
-		raw_spin_unlock_irq(&pool->lock);
+		raw_spin_unlock_irqsave(&pool->lock, flags);
 		set_pf_worker(false);
 
 		set_task_comm(worker->task, "kworker/dying");
@@ -2792,7 +2798,7 @@ static int worker_thread(void *__worker)
 	 */
 	worker_enter_idle(worker);
 	__set_current_state(TASK_IDLE);
-	raw_spin_unlock_irq(&pool->lock);
+	raw_spin_unlock_irqrestore(&pool->lock, flags);
 	schedule();
 	goto woke_up;
 }

