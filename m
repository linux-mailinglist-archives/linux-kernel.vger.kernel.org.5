Return-Path: <linux-kernel+bounces-144545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C068A479B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0836B2206B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8D5258;
	Mon, 15 Apr 2024 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bpnBeCti"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9A441F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713159389; cv=none; b=briCP0uPo8bf02ojF3rZOfacHNZj+1HqRBocJ6tkXEhe8h5uO+p+DpjsC6KDri0OX3PXsaAmu7qj7L3loEEVRlKrrolgnyFj37X5ufBzEGWH/ucdDl6ba403H7Xh2tLvHDk+bcy7UZQK82sfqY9zFx8sftKdHVNGGPJtwEsA8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713159389; c=relaxed/simple;
	bh=kckeSP+6es+YxIZAdYhuQTAuNLR8/EiXJYPOKE5g9qw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EEsB35L1zOwXQIbv//eovablbAQw0xffe/UqjIzemKUkO+mmyGNrxO7ykj05am979iR6mOvMVeJz7MHAETtdgbKIJSQgpTS86czW53jqMHNwiRJdcA1TKkW5SMim1onW+8rdNurlOLZI9V4M/5IhcE1wfO2A2WsZyZHcpQ4g/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bpnBeCti; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43F4tXQZ027145;
	Mon, 15 Apr 2024 05:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=578oJD3vKVzQ97raOb0GVbeyqxwSn2B9DKLfHwCLPUo=;
 b=bpnBeCtiTi3wM9OIfV3Zp3VvzTGT4iIkt3ca0p+mJDlRVwONthmzxuo2sng7ILprB6RX
 HLDd9T2oEmUIXPGNpP7Dpxv22m4WjCerFQiG3zBaTP26pmtxvbIZknW4EO6BjKln+Hu8
 HqItLYdj/ypARruMZ6EoOOzK1UQL9eyNzWKGndmKpHpcbOz+1fpk9rNJWaL8Drqz6iPT
 Rji0L9/K7uWFYC/Ijvbv030P/6JWKQZN+WbA+X2iORVTlDJgKjhROiA8qD7RAVBlLk1Y
 dr1LwVJXG8r71Fy9WBYlIP6bBqNG1vUsWD9O08v6VXD7TxzRxyN6MFXm59UGg26NcttB 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfhu9b2b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 05:36:23 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43F5aM4t024435;
	Mon, 15 Apr 2024 05:36:22 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfhu9b2ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 05:36:22 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43F45wNl011161;
	Mon, 15 Apr 2024 05:35:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg7325m9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 05:35:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43F5Zr0P32834296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 05:35:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58A652004E;
	Mon, 15 Apr 2024 05:35:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48EFB20040;
	Mon, 15 Apr 2024 05:35:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Apr 2024 05:35:53 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 0FDFBE0323; Mon, 15 Apr 2024 07:35:53 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: fix selection of wake_cpu in kick_pool()
Date: Mon, 15 Apr 2024 07:35:49 +0200
Message-Id: <20240415053550.538722-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pdVJ57X7jUbi2tFZvbnNdcnR8nUMvIEL
X-Proofpoint-GUID: TAy7NcnC2xKBiGhouI8l9TmWqHuq8mZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150035

With cpu_possible_mask=0-63 and cpu_online_mask=0-7 the following
kernel oops was observed:

smp: Bringing up secondary CPUs ...
smp: Brought up 1 node, 8 CPUs
Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 0000000000000000 TEID: 0000000000000803
[..]
 Call Trace:
arch_vcpu_is_preempted+0x12/0x80
select_idle_sibling+0x42/0x560
select_task_rq_fair+0x29a/0x3b0
try_to_wake_up+0x38e/0x6e0
kick_pool+0xa4/0x198
__queue_work.part.0+0x2bc/0x3a8
call_timer_fn+0x36/0x160
__run_timers+0x1e2/0x328
__run_timer_base+0x5a/0x88
run_timer_softirq+0x40/0x78
__do_softirq+0x118/0x388
irq_exit_rcu+0xc0/0xd8
do_ext_irq+0xae/0x168
ext_int_handler+0xbe/0xf0
psw_idle_exit+0x0/0xc
default_idle_call+0x3c/0x110
do_idle+0xd4/0x158
cpu_startup_entry+0x40/0x48
rest_init+0xc6/0xc8
start_kernel+0x3c4/0x5e0
startup_continue+0x3c/0x50

The crash is caused by calling arch_vcpu_is_preempted() for an offline
CPU. To avoid this, select the cpu with cpumask_any_and_distribute()
to mask __pod_cpumask with cpu_online_mask.

Fixes: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope for unbound workqueues")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0066c8f6c154..d02b0c02c9e2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1277,7 +1277,8 @@ static bool kick_pool(struct worker_pool *pool)
 	    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
 		struct work_struct *work = list_first_entry(&pool->worklist,
 						struct work_struct, entry);
-		p->wake_cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
+		p->wake_cpu = cpumask_any_and_distribute(pool->attrs->__pod_cpumask,
+							 cpu_online_mask);
 		get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
 	}
 #endif
-- 
2.40.1


