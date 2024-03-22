Return-Path: <linux-kernel+bounces-111595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA977886E55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586771F2347E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43544C624;
	Fri, 22 Mar 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IWlhzVx2"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6C4AEEA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117018; cv=none; b=lduubzwWX5ByWf5PmFIlYVNOwRUxFjqgh3KvtJiuD3/jD+lAAv2B8bCNK2WplmKKuYp0xhlR0GXq77eKd4jkKfNiBA1e0y3Se9b2Fr+3GVwlBeYuSTDhleFSE/KkIC/m+Z69C3zxl8u7MtVE4mciVcMEPqTzYfySNx4RsZ4v8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117018; c=relaxed/simple;
	bh=/WVw+2mF2M6x/LHxpWjjlX+149bMDjEg/8tEHATWr1M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=toZmsIBZENLnfRIukUmpaIKJnFVR2sLcExikgMX8vdkKDXZzbhUqm/Vf234nAhA97FNzvOhTjc/RDLXpKZb0nca51NhCpLt02U3/0epwRv3iH/SXhAAbm5aSvgviBl6L2cCQanOYoHCou7TjsFKXOmHc6BaL7DA6fG/Wh2EBPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IWlhzVx2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MCc5Bc010599;
	Fri, 22 Mar 2024 14:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=JuZDXIzrdXpCyKh+M56NpJp3APSOUuW4a0tBes8DwkQ=;
 b=IWlhzVx2e5tE7kh6dOEAITr+eiUx9zds6uiZb3jJfP3k/gzwjM3NNtzDO1ubzriYCF8r
 PSQitsoeIyrb+rv6DK6SWps0zxEREgy1L+qfD1Mu/QuZOJVsYdkdrATbWWApkjxs0zRU
 xFwCImZ6ZWLUNqxbgs5be9y3hsH1WamVHpRel7shV5WdrbgE2lSPF2gMXt0DEgI4hSt8
 T3K8wP0oLAIeiwbceB8KR4BD43hS2PASyHKt2p8QJ7OZuCm3KzyV2pu0UR+nZXSgaxUI
 2CF8UfnIUdwZczEdJofCN+ySbVK3EYuqs7U7BvfD51TIloywVBR57RK7K/hofcnL1lGm 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x1a5795ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 14:16:41 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MEGfwr009309;
	Fri, 22 Mar 2024 14:16:41 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x1a5795jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 14:16:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42MEFrut031976;
	Fri, 22 Mar 2024 14:16:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x0x16p3ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 14:16:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42MEGarg26608362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 14:16:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64CE52004D;
	Fri, 22 Mar 2024 14:16:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99DB020040;
	Fri, 22 Mar 2024 14:16:34 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.195.40.125])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Mar 2024 14:16:34 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, vschneid@redhat.com, qperret@google.com
Subject: [PATCH v2 0/2] sched: Minor changes for rd->overload access
Date: Fri, 22 Mar 2024 19:46:30 +0530
Message-Id: <20240322141632.28654-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Content-Type: text/plain; charset=yes
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cTVOgmSs2qqpJfjfk7hdJQaqxMdixITr
X-Proofpoint-GUID: 6ya8PDKIMJ7_EAqLiMo_PNmQKx56wQPT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=749 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220101

v1 -> v2:
- dropped Fixes tag.
- Added one of the perf probes in the changelog for reference.
- Added reviewed-by tags.

tl;dr
When running workloads in large systems, it was observed that access to
rd->overload was taking time. It would be better to check the value
before updating since value changes less often. Patch 1/2 does that.
With patch updates happen only if necessary. CPU Bus traffic reduced a
bit. No significant gains in workload performance.

Qais Suggested that it would be better to use the helper functions to
access the rd->overload instead. Patch 2/2 does that.

*These patches depend on below to be applied first*
https://lore.kernel.org/all/20240307085725.444486-1-sshegde@linux.ibm.com/


-----------------------------------------------------------------------
Detailed Perf annotation and probes stat
-----------------------------------------------------------------------
=======
6.8-rc5
=======
320 CPU system, SMT8
  NUMA node(s):          4
  NUMA node0 CPU(s):     0-79
  NUMA node1 CPU(s):     80-159
  NUMA node6 CPU(s):     160-239
  NUMA node7 CPU(s):     240-319

Perf annoate while running "schbench -t 320 -i 30 -r 30"
       │     if (!READ_ONCE(this_rq->rd->overload) ||
 18.05 │       ld       r9,2752(r31)
       │     sd = rcu_dereference_check_sched_domain(this_rq->sd);
  6.97 │       ld       r30,2760(r31)


Added some dummy codes so the probes can be put at required places.
perf probe -L update_sd_lb_stats
     46         if (env->sd->flags & SD_NUMA)
     47                 env->fbq_type = fbq_classify_group(&sds->busiest_stat);

     49         if (!env->sd->parent) {
                        /* update overload indicator if we are at root domain */
     51                 WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);

perf -probe -L newidle_balance
                rcu_read_lock();
     38         sd = rcu_dereference_check_sched_domain(this_rq->sd);

                if (!READ_ONCE(this_rq->rd->overload) ||
                    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {

perf probe -L add_nr_running
         #ifdef CONFIG_SMP
     11         if (prev_nr < 2 && rq->nr_running >= 2) {
     12                 if (!READ_ONCE(rq->rd->overload)) {
     13                         a = a +10;
                                WRITE_ONCE(rq->rd->overload, 1);
                        }

probe hits when running different workload.
idle
320 probe:add_nr_running_L12
260 probe:add_nr_running_L13
1K probe:newidle_balance_L38
596 probe:update_sd_lb_stats_L51

/hackbench 10 process 100000 loops
130K probe:add_nr_running_L12
93 probe:add_nr_running_L13
1M probe:newidle_balance_L38
109K probe:update_sd_lb_stats_L51

/schbench -t 320 -i 30 -r 30
3K probe:add_nr_running_L12
436 probe:add_nr_running_L13
125K probe:newidle_balance_L38
33K probe:update_sd_lb_stats_L51

Modified stress-ng --wait
3K probe:add_nr_running_L12
1K probe:add_nr_running_L13
6M probe:newidle_balance_L38
11K probe:update_sd_lb_stats_L51

stress-ng --cpu=400 -l 20
833 probe:add_nr_running_L12
280 probe:add_nr_running_L13
2K probe:newidle_balance_L38
1K probe:update_sd_lb_stats_L51

stress-ng --cpu=400 -l 100
730 probe:add_nr_running_L12
0 probe:add_nr_running_L13
0 probe:newidle_balance_L38
0 probe:update_sd_lb_stats_L51

stress-ng --cpu=800 -l 50
2K probe:add_nr_running_L12
0 probe:add_nr_running_L13
2K probe:newidle_balance_L38
946 probe:update_sd_lb_stats_L51

stress-ng --cpu=800 -l 100
361 probe:add_nr_running_L12
0 probe:add_nr_running_L13
0 probe:newidle_balance_L38
0 probe:update_sd_lb_stats_L51

L13 numbers are quite less compared to L12. This indicates that it might
not change often.

------------------------------------------------------------------------------
==========
With Patch:
==========
Perf annoate while running "schbench -t 320 -i 30 -r 30"
       │     if (!READ_ONCE(this_rq->rd->overload) ||
       │       ld       r9,2752(r31)
       │     sd = rcu_dereference_check_sched_domain(this_rq->sd);
       │       ld       r30,2760(r31)
       │     if (!READ_ONCE(this_rq->rd->overload) ||
       │       lwz      r9,536(r9)
       │       cmpwi    r9,0
       │     ↓ beq      2b4
       │100:   mflr     r0
       │       cmpdi    r30,0
  0.38 │       std      r0,240(r1)
  1.56 │     ↓ beq      120


perf probe -L update_sd_lb_stats
     49         if (!env->sd->parent) {
     50                 int a;
                        /* update overload indicator if we are at root domain */
                        if ( READ_ONCE(env->dst_rq->rd->overload) != sg_status & SG_OVERLOAD) {
     53                         a= a+10;
                                WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
                        }

perf probe -L newidle_balance
     38         sd = rcu_dereference_check_sched_domain(this_rq->sd);

                if (!READ_ONCE(this_rq->rd->overload) ||
                    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {

perf probe -L add_nr_running
		#ifdef CONFIG_SMP
     11         if (prev_nr < 2 && rq->nr_running >= 2) {
     12                 if (!READ_ONCE(rq->rd->overload)) {
     13                         a = a +10;
                                WRITE_ONCE(rq->rd->overload, 1);
                        }

perf probes when running different workloads. How many times actual
value changes in update_sd_lb_stats is indicated as L53/L50*100.
idle
818 probe:newidle_balance_L38
262 probe:update_sd_lb_stats_L53	<-- 86%
321 probe:add_nr_running_L12
261 probe:add_nr_running_L13
304 probe:update_sd_lb_stats_L50

/hackbench 10 process 100000 loops
1M probe:newidle_balance_L38
139 probe:update_sd_lb_stats_L53	<-- 0.25%
129K probe:add_nr_running_L12
74 probe:add_nr_running_L13
54K probe:update_sd_lb_stats_L50

/schbench -t 320 -i 30 -r 30
101K probe:newidle_balance_L38
2K probe:update_sd_lb_stats_L53		<-- 9.09%
5K probe:add_nr_running_L12
1K probe:add_nr_running_L13
22K probe:update_sd_lb_stats_L50

Modified stress-ng --wait
6M probe:newidle_balance_L38
2K probe:update_sd_lb_stats_L53		<-- 25%
4K probe:add_nr_running_L12
2K probe:add_nr_running_L13
8K probe:update_sd_lb_stats_L50

stress-ng --cpu=400 -l 20
2K probe:newidle_balance_L38
286 probe:update_sd_lb_stats_L53	<-- 36.11%
746 probe:add_nr_running_L12
256 probe:add_nr_running_L13
792 probe:update_sd_lb_stats_L50

stress-ng --cpu=400 -l 100
2 probe:newidle_balance_L38
0 probe:update_sd_lb_stats_L53		<-- NA
923 probe:add_nr_running_L12
0 probe:add_nr_running_L13
0 probe:update_sd_lb_stats_L50

stress-ng --cpu=800 -l 50
2K probe:newidle_balance_L38
0 probe:update_sd_lb_stats_L53		<-- 0%
2K probe:add_nr_running_L12
0 probe:add_nr_running_L13
429 probe:update_sd_lb_stats_L50

stress-ng --cpu=800 -l 100
0 probe:newidle_balance_L38
0 probe:update_sd_lb_stats_L53		<-- NA
424 probe:add_nr_running_L12
0 probe:add_nr_running_L13
1 probe:update_sd_lb_stats_L50

This indicates that likely that value changes less often. So adding a
read before update would help in generic workloads.
-------------------------------------------------------------------------------

Shrikanth Hegde (2):
  sched/fair: Check rd->overload value before update
  sched/fair: Use helper functions to access rd->overload

 kernel/sched/fair.c  |  6 ++++--
 kernel/sched/sched.h | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

--
2.39.3


