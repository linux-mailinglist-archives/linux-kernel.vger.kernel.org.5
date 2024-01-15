Return-Path: <linux-kernel+bounces-26264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062E082DDB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3610B21835
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10117BC1;
	Mon, 15 Jan 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RDvJyARC"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2226C17C62;
	Mon, 15 Jan 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FG8vvV015508;
	Mon, 15 Jan 2024 16:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=y5b7VDC1MpzD+mbQeLFZyvUOTMfYONCDmzQW1BLfcrI=;
 b=RDvJyARCFo/fknPN1hVN6+7+iAokklfadUXrYuHmMvdbf7e9i9wgDnc9a+2mPmF06wxT
 2Zwmm+IO9YguFAIo/8KKeczcwm9XuRHCVdTCI5ZmU+5fOiZN36Yzls0llp7C8D+uqUW7
 c5Sx84ZfirAs08lbsGvhISiz/h7jyNfS+fOWmi+nKYDcKcj+EFl+b2upzBvRl5tG5I+f
 SIwytnXG8OJaKYmu7gYNsm6jaJfG2v4/mvA3Je74ul1+jG32MTWa/GOyYsk7MRSraBFj
 AvILXJ2lKuLFwHPxlH3wBel9+k8N+6ty69Bly1ENMa8kcVbsaZWQ0ygaiJmgX0HlE9IB 0w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vmtse2get-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 16:35:59 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40FEQkEv008786;
	Mon, 15 Jan 2024 16:35:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm57y9g14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 16:35:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40FGZtxH59900316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 16:35:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FBC120049;
	Mon, 15 Jan 2024 16:35:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7496520040;
	Mon, 15 Jan 2024 16:35:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jan 2024 16:35:55 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH] tick-sched: fix idle and iowait sleeptime accounting vs CPU hotplug
Date: Mon, 15 Jan 2024 17:35:55 +0100
Message-Id: <20240115163555.1004144-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TT_Hpje2XlpQ_t7KYwgCSDPqmj3eccdr
X-Proofpoint-GUID: TT_Hpje2XlpQ_t7KYwgCSDPqmj3eccdr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_11,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401150121

When offlining and onlining CPUs the overall reported idle and iowait
times as reported by /proc/stat jump backward and forward:

> cat /proc/stat
cpu  132 0 176 225249 47 6 6 21 0 0
cpu0 80 0 115 112575 33 3 4 18 0 0
cpu1 52 0 60 112673 13 3 1 2 0 0

> chcpu -d 1
> cat /proc/stat
cpu  133 0 177 226681 47 6 6 21 0 0
cpu0 80 0 116 113387 33 3 4 18 0 0

> chcpu -e 1
> cat /proc/stat
cpu  133 0 178 114431 33 6 6 21 0 0 <---- jump backward
cpu0 80 0 116 114247 33 3 4 18 0 0
cpu1 52 0 61 183 0 3 1 2 0 0        <---- idle + iowait start with 0

> chcpu -d 1
> cat /proc/stat
cpu  133 0 178 228956 47 6 6 21 0 0 <---- jump forward
cpu0 81 0 117 114929 33 3 4 18 0 0

Reason for this is that get_idle_time() in fs/proc/stat.c has different
sources for both values depending on if a CPU is online or offline:

- if a CPU is online the values may be taken from its per cpu
  tick_cpu_sched structure

- if a CPU is offline the values are taken from its per cpu cpustat
  structure

The problem is that the per cpu tick_cpu_sched structure is set to zero on
CPU offline. See tick_cancel_sched_timer() in kernel/time/tick-sched.c.

Therefore when a CPU is brought offline and online afterwards both its idle
and iowait sleeptime will be zero, causing a jump backward in total system
idle and iowait sleeptime. In a similar way if a CPU is then brought
offline again the total idle and iowait sleeptimes will jump forward.

It looks like this behavior was introduced with commit 4b0c0f294f60
("tick: Cleanup NOHZ per cpu data on cpu down").

This was only noticed now on s390, since we switched to generic idle time
reporting with commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time()
and corresponding code").

Fix this by preserving the values of idle_sleeptime and iowait_sleeptime
members of the per-cpu tick_sched structure on CPU hotplug.

Fixes: 4b0c0f294f60 ("tick: Cleanup NOHZ per cpu data on cpu down")
Reported-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 kernel/time/tick-sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a17d26002831..d2501673028d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1576,13 +1576,18 @@ void tick_setup_sched_timer(void)
 void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	ktime_t idle_sleeptime, iowait_sleeptime;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
 		hrtimer_cancel(&ts->sched_timer);
 # endif
 
+	idle_sleeptime = ts->idle_sleeptime;
+	iowait_sleeptime = ts->iowait_sleeptime;
 	memset(ts, 0, sizeof(*ts));
+	ts->idle_sleeptime = idle_sleeptime;
+	ts->iowait_sleeptime = iowait_sleeptime;
 }
 #endif
 
-- 
2.40.1


