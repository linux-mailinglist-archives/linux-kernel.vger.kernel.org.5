Return-Path: <linux-kernel+bounces-2900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5E88163F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834EC1F21C04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888F1FD1;
	Mon, 18 Dec 2023 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="YPYEAz83"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A661FA3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI1DUqS030923;
	Mon, 18 Dec 2023 01:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=ZEvhQt6KyC3YmTShSBehYJCn/AfTUtDQHzjvN0mfk6Y=; b=
	YPYEAz832yWU+uWeIIF6TNB9BHeZ5RuyWYsk91n+UcGsrdCMpIQaL7sZpowqbgxP
	xo/+QdOq4AKSRyEtQBAzub0WHBPEaqTkK5ESHbJKC6hBnqpEGABept7SAGBIAuWB
	heAAwHBCOMB5/fZytkuCSYh249++59jhSJEv8YwuHSdA5m7jFKGzpj2RRXPXnfRB
	/Nq/SrFp/bDsKxfMizl41J2q8sCvT7bR+IeG19YCMzJOKsHQzzeqbbT/WrnxzzIV
	Jg4K+Xe2Lsm42JumSmpPDThZm14LOeUKwKN2eRugQFxP6bUS+t0NoVUHagLR1YPu
	tyE71rTpFrh+bFk9nxLZbg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v12v5sekq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Dec 2023 01:13:46 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 17:13:51 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 17 Dec 2023 17:13:50 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in __run_timers
Date: Mon, 18 Dec 2023 09:13:43 +0800
Message-ID: <20231218011343.1782210-1-lizhi.xu@windriver.com>
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
X-Proofpoint-ORIG-GUID: H3gm6Qy4tsoHxOA-J3WJB66M7_897YZs
X-Proofpoint-GUID: H3gm6Qy4tsoHxOA-J3WJB66M7_897YZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=720
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312180006

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 88035e5694a8

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..33478bfee814 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -941,8 +941,10 @@ static void worker_enter_idle(struct worker *worker)
 	/* idle_list is LIFO */
 	list_add(&worker->entry, &pool->idle_list);
 
+	raw_spin_unlock_irq(&pool->lock);
 	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
+	raw_spin_lock_irq(&pool->lock);
 
 	/* Sanity check nr_running. */
 	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);

