Return-Path: <linux-kernel+bounces-10859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C79281DD78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 02:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2CE1C21535
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 01:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433F67F6;
	Mon, 25 Dec 2023 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="oFBQLMks"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861067E8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP1spln032372;
	Sun, 24 Dec 2023 17:54:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=BC5nEToYFRQxAGVkchZjdAh38Xp+fvw5oJSslrhXXw4=; b=
	oFBQLMksC1r/w4albSQn9Th7dNqCp8qALwPbTdpr6Sd0WsVuakvk7vKdEHanvEen
	GHghui2fUIZ8H1AzkfyACAsVky7x8YF00neAqDM4qV34jpaSbjeyYHI2IK2PBQVB
	12d9aaBEv9c4zMzdvz+pRdHHZv5uyE2xf2VkyPQiT2gulFE0UKHb0Yf6tzs4ovTe
	XM/aCeBridbZbchMoauW4G/6kV0Znv2xQfKXZv/s4azI2ubh763/Nji13PUqTM/s
	psFT+jHjOepGHUN/7lvOQ3uhNVppWp60or0Heh0ajVBdY9xgordLbSXugT3ckUDe
	hEcGxwl/gEWvppcoeH8v+g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5uq4h2ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 24 Dec 2023 17:54:54 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Dec 2023 17:54:57 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 24 Dec 2023 17:54:56 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in __run_timers
Date: Mon, 25 Dec 2023 09:54:51 +0800
Message-ID: <20231225015451.2518934-1-lizhi.xu@windriver.com>
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
X-Proofpoint-GUID: pvSjyBBZDeBiqOgHsZpDkubC0nywlvwn
X-Proofpoint-ORIG-GUID: pvSjyBBZDeBiqOgHsZpDkubC0nywlvwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 mlxlogscore=720 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250013

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 88035e5694a8

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..9daa5d695dbd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -941,8 +941,11 @@ static void worker_enter_idle(struct worker *worker)
 	/* idle_list is LIFO */
 	list_add(&worker->entry, &pool->idle_list);
 
-	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
+	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer)) {
+		raw_spin_unlock_irq(&pool->lock);
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
+		raw_spin_lock_irq(&pool->lock);
+	}
 
 	/* Sanity check nr_running. */
 	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);

