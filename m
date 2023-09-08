Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A431799275
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjIHWvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243165AbjIHWu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:50:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075C71FED;
        Fri,  8 Sep 2023 15:50:55 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388K0e4L016695;
        Fri, 8 Sep 2023 22:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=F3k7KeTvDFRHY2FyLaq52d7ups1kR425uouE6mppmeU=;
 b=jjUfAeVkAtSZlNvvbQuGfrFOksmvF/p6eWwRdR1hh7bFoLMtbggRYSlU8ZrxeF6UoEdN
 Iq7t4p+WZ7/VgMOXv5LUSvXwq2vbfbacPRvZuj6FzSqQ0ts/scaONQeCog1YTwzGtJJj
 0504JCrDSGclIuJaQdKAtWWLNGq9at972EFEYTpAoDhFWluy0Z+dY4yQZNhXDR4pQur0
 yFQ7XzxkW9GGaxRK7LQY9s7xV11AMZOsRTf6QRCuihAJdjWVLHSHsXSEEcvfi+OI/2ho
 8bKqtUUfFMMsZCtp84GVIJmQ6xXAemvORCsAowIbjfB17G3DiwE/dtJ2jozStuHgUPuP 4Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syu012ek5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 22:50:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388MofIT010603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 22:50:42 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 8 Sep 2023 15:50:38 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v4 0/2] Avoid spurious freezer wakeups
Date:   Fri, 8 Sep 2023 15:49:14 -0700
Message-ID: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqk+2QC/4XOy07EIBgF4FeZsBbDpRbqyvcws+DyY/84QoUBL
 5O+u3RiosZFl+csvnMupEBGKOT+cCEZGhZMsYfh5kDcbOITUPQ9E8GEZJoralpCT8tSM6ZaaMg
 An5Dpm3mGuhQ6BT3yadTMSkM6Yk0BarOJbu5MrKdTL5cMAd+vq4/Hnmcs55Q/rica39rvPaH39
 hqnnGoL2gU18kGJh9eKDqO7demFbHgTv0DJdkGxgVopMdw5b737D8ofcGL7D2UH/TBpwYM3bPB
 /wXVdvwDIFuUyhQEAAA==
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
CC:     Thomas Gleixner <tglx@linutronix.de>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Prakash Viswalingam" <quic_prakashv@quicinc.com>
X-Mailer: b4 0.13-dev
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kV7UEk9X3XJ8DieBq9vYArLkT9TCIxrM
X-Proofpoint-GUID: kV7UEk9X3XJ8DieBq9vYArLkT9TCIxrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=1 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=1
 phishscore=0 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 mlxlogscore=912 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
tasks that transition directly from TASK_FREEZABLE to TASK_FROZEN  are
always woken up on the thaw path. Prior to that commit, tasks could ask
freezer to consider them "frozen enough" via freezer_do_not_count(). The
commit replaced freezer_do_not_count() with a TASK_FREEZABLE state which
allows freezer to immediately mark the task as TASK_FROZEN without
waking up the task.  This is efficient for the suspend path, but on the
thaw path, the task is always woken up even if the task didn't need to
wake up and goes back to its TASK_(UN)INTERRUPTIBLE state. Although
these tasks are capable of handling of the wakeup, we can observe a
power/perf impact from the extra wakeup.

We observed on Android many tasks wait in the TASK_FREEZABLE state
(particularly due to many of them being binder clients). We observed
nearly 4x the number of tasks and a corresponding linear increase in
latency and power consumption when thawing the system. The latency
increased from ~15ms to ~50ms.

Avoid the spurious wakeups by saving the state of TASK_FREEZABLE tasks.
If the task was running before entering TASK_FROZEN state
(__refrigerator()) or if the task received a wake up for the saved
state, then the task is woken on thaw. saved_state from PREEMPT_RT locks
can be re-used because freezer would not stomp on the rtlock wait flow:
TASK_RTLOCK_WAIT isn't considered freezable.

For testing purposes, I use these commands can help see how many tasks were
woken during thawing:

1. Setup:
   mkdir /sys/kernel/tracing/instances/freezer
   cd /sys/kernel/tracing/instances/freezer 
   echo 0 > tracing_on ; echo > trace
   echo power:suspend_resume > set_event
   echo 'enable_event:sched:sched_wakeup if action == "thaw_processes" && start == 1' > events/power/suspend_resume/trigger
   echo 'traceoff if action == "thaw_processes" && start == 0' > events/power/suspend_resume/trigger
   echo 1 > tracing_on

2. Let kernel go to suspend

3. After kernel's back up:
   cat /sys/kernel/tracing/instances/freezer/trace | grep sched_wakeup | grep -o "pid=[0-9]*" | sort -u | wc -l

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
Changes in v4:
- Split into 2 commits
- Link to v3: https://lore.kernel.org/r/20230908-avoid-spurious-freezer-wakeups-v3-1-d49821fda04d@quicinc.com

Changes in v3:
- Remove #ifdeferry for saved_state in kernel/sched/core.c
- Link to v2: https://lore.kernel.org/r/20230830-avoid-spurious-freezer-wakeups-v2-1-8877245cdbdc@quicinc.com

Changes in v2:
- Rebase to v6.5 which includes commit 1c06918788e8 ("sched: Consider task_struct::saved_state in wait_task_inactive()")
  This allows us to remove the special jobctl handling on thaw.
- Link to v1: https://lore.kernel.org/r/20230828-avoid-spurious-freezer-wakeups-v1-1-8be8cf761472@quicinc.com

---
Elliot Berman (2):
      sched/core: Remove ifdeffery for saved_state
      freezer,sched: Use saved_state to reduce some spurious wakeups

 include/linux/sched.h |  2 --
 kernel/freezer.c      | 41 +++++++++++++++++++----------------------
 kernel/sched/core.c   | 40 +++++++++++++++++-----------------------
 3 files changed, 36 insertions(+), 47 deletions(-)
---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230817-avoid-spurious-freezer-wakeups-9f8619680b3a

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>

