Return-Path: <linux-kernel+bounces-116552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BB188A0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8C01C37875
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B540A15A489;
	Mon, 25 Mar 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G8/2feiV"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925721422DF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345538; cv=none; b=E1X3UZsx8U0GgGWNM/rsLrBBiKr/uc1mmH0i79ryOO4NwZO1flxh72OvDI6r70qBBV3YBjAOHrkGnbAqkQ+fDxn/DoGxZoml7vHd0iu4lXtBD21i00tb21bxNs9fXsBCMzVvNXSusqUYTxYD6rFBlH6l55PHAJHD8Or2YpdX+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345538; c=relaxed/simple;
	bh=Nf9/+absmF2p9Y3Nt6wAdkzbW99RzEk9jOUSMk1Hpj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mj17qUn19gwVLejzZhV3yd+PV9HzBDdUV9sQ1yZI95DMxeGA9VLGVcMrVor0mV+wIY0iM+p0fpDcgyDXO3MRZGjBZJfi5ads6Gn1/NMIeNNA1iQgGSTTMjLrV1HIjx7s6nsirvbyIRDzOdQa01hyibNSBf/eVij63MuVbdlbalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G8/2feiV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42P3AFfv011154;
	Mon, 25 Mar 2024 05:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/Cdxic8Oiq1h4/eSkqGMxCD/okNBm3CJhlovnrT+fWA=;
 b=G8/2feiVkyZOOkAJoKGJjHIM8FXLaZEknIdj5s0hdKM3W+uxW2KIxFhAqXVCVzrQyI+V
 1luRFrZtvUhsjbgQTnGTFXbRugkA1IjAV6qHeJSDIQoP9gXZ0wxQUV/1G2xZm0fxpooG
 1ZJqQ3EocbEh3jhjqeT0wx3hNQq/9dvvNfLW2h3mNfCF+Y//sybT5gICVlRcBvF6yOSh
 PLQ71Yew0p8ta8pzYZ8c+sYskKcPPKGzbL8csT2VP2OxAxRsmYu49HVptZnKC29jGmvH
 n9cps3wSSBmTPDVwee4aXC8KlRcxQnUvCs5TJ4CpAoQm6LoGJACDqgaTYo9a/RWIpb19 pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x28fhtejp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:45:24 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42P5jOxm000615;
	Mon, 25 Mar 2024 05:45:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x28fhtejm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:45:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42P5dG27025481;
	Mon, 25 Mar 2024 05:45:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2awmexch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:45:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42P5jINf36176230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 05:45:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0C912004D;
	Mon, 25 Mar 2024 05:45:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1262A2004B;
	Mon, 25 Mar 2024 05:45:17 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 05:45:16 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: [PATCH v3 2/2] sched/fair: Use helper functions to access rd->overload
Date: Mon, 25 Mar 2024 11:15:05 +0530
Message-Id: <20240325054505.201995-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240325054505.201995-1-sshegde@linux.ibm.com>
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lc3uyEvxYz45w_H31MU8eWGqDiRwmpWQ
X-Proofpoint-GUID: _vsCfY0cPeSjIzc2oxU0yB5_4HlhpATB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_03,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=771
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250030

rd->overload is accessed at multiple places. Instead it could use helper
get/set functions. This would make the code more readable and easy to
maintain.

No change in functionality intended.

Suggested-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  |  5 ++---
 kernel/sched/sched.h | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eeebadd7d9ae..f00cb66cc479 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10621,8 +10621,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd

 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
-			WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
+		set_rd_overload_status(env->dst_rq->rd, sg_status & SG_OVERLOAD);

 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		set_rd_overutilized_status(env->dst_rq->rd,
@@ -12344,7 +12343,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);

-	if (!READ_ONCE(this_rq->rd->overload) ||
+	if (!is_rd_overloaded(this_rq->rd) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {

 		if (sd)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 41024c1c49b4..bed5ad8a1827 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -918,6 +918,17 @@ extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
 extern void sched_get_rd(struct root_domain *rd);
 extern void sched_put_rd(struct root_domain *rd);

+static inline int is_rd_overloaded(struct root_domain *rd)
+{
+	return READ_ONCE(rd->overload);
+}
+
+static inline void set_rd_overload_status(struct root_domain *rd, int status)
+{
+	if (is_rd_overloaded(rd) != status)
+		WRITE_ONCE(rd->overload, status);
+}
+
 #ifdef HAVE_RT_PUSH_IPI
 extern void rto_push_irq_work_func(struct irq_work *work);
 #endif
@@ -2518,8 +2529,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)

 #ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2) {
-		if (!READ_ONCE(rq->rd->overload))
-			WRITE_ONCE(rq->rd->overload, 1);
+		set_rd_overload_status(rq->rd, SG_OVERLOAD);
 	}
 #endif

--
2.39.3


