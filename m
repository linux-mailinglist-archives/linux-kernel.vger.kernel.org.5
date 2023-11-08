Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72CA7E5AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjKHQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:10:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9601BDD;
        Wed,  8 Nov 2023 08:10:30 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8Ft3X6018216;
        Wed, 8 Nov 2023 16:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Dz7cpevgCJbFuR3Su3kXmaA6HSyOlQ1v3fN+jtkdijM=;
 b=j3Gajic06GqJ557N2u1Nm4t+pEaJrIIHjso4aMwxS+6UFcTyRU27JSWaXANZbX8F/f8w
 dCig90+9IaoLl2nD8Q0xk0GP+fb9q+QMF2JP/BwXbLmOVbAH8DU2CZk1zNC+4a08oFQC
 NQlsPqzNRjKRmypc6e1K34gw6/abJYxjkCxraViXp5IbtJRFwDzvadFx2UdkBsTEELN8
 0XRzJpSkoF/Dla5qUN/m8ufWPi2YzNCWeleOID/9grMxQJt095fE2HnWK9Khl8KOLZrQ
 duCllICNFVWnZscMwYoY4Ip0dbQq/XcN9Yj7+81Vc+1cpi5c9F8m4D1Pk5DK3BBVzC9G +g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7w3ga3y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 16:10:12 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A8GABrb018201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 16:10:11 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 08:10:07 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>, <jstultz@google.com>,
        <tglx@linutronix.de>, <sboyd@kernel.org>, <tj@kernel.org>,
        <jiangshanlai@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: timer list corruption in devfreq
Date:   Wed, 8 Nov 2023 21:39:57 +0530
Message-ID: <1699459797-21703-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QTW4rBPPmdp3q75A4ABeYIk4M8CRzmkw
X-Proofpoint-GUID: QTW4rBPPmdp3q75A4ABeYIk4M8CRzmkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_04,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=544 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are facing an issue on 6.1 kernel while using devfreq framework
and looks like the devfreq_monitor_stop()/devfreq_monitor_start is
vulnerable if frequent governor change is being done from user space
in a loop.

echo simple_ondemand > /sys/class/devfreq/1d84000.ufshc/governor
echo performance > /sys/class/devfreq/1d84000.ufshc/governor

Here, we are using ufs device, but could be any device.

Issue is because same instance of timer is being queued from two
places one from devfreq_monitor() and one from devfreq_monitor_start() as
cancel_delayed_work_sync() from devfreq_monitor_stop() was not
able to delete the delayed work time completely due to which
devfreq_monitor() work rearmed the same timer.

But there looks to be issue in the timer framework where
it was initially discussed in [1] and later fixed in [2]
but not sure being whether is it issue in cancel_delayed_work_sync()
where del_timer() inside try_to_grab_pending() need to be replaced
with timer_delete[_sync]() or devfreq_monitor_stop() need to use
this api's and then delete the work.

[1]
https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

[2]
https://lore.kernel.org/all/20221123201306.823305113@linutronix.de/

In the below ftraces, last two are back to back two timer cancel
operations one from devfreq_monitor_stop() and other from expire_timer().

devfreq_monitor_stop
 cancel_delayed_work_sync
  __cancel_work_timer
    try_to_grab_pending
      del_timer()

00|__hlist_del(inline) == list corruption
-000|detach_timer(inline)
-000|expire_timers(inline) ==>
-000|__run_timers(base = 0xFFFFFF8A70F31240)
-001|run_timer_softirq()
-002|__do_softirq()
-003|____do_softirq()
-004|call_on_irq_stack(asm)
-005|do_softirq_own_stack()
-006|invoke_softirq(inline)

kworker/u16:2-5133    [002]   9436.089773:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da0d  now=0x10022d9fe  flags=56623106
<idle>-0    [002]   9436.149664:  timer_cancel   timer=0xffffff80444f0428
<idle>-0    [002]   9436.149666:  timer_expire_entry   timer=0xffffff80444f0428  now=0x10022da0d  function=__typeid__ZTSFvP10timer_listE_global_addr  baseclk=0x10022da0d
<idle>-0    [002]   9436.149705:  timer_expire_exit   timer=0xffffff80444f0428
kworker/u16:6-14217    [003]   9436.149776:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da1c  now=0x10022da0d  flags=119537667
vendor.xxxyyy.ha-1593    [006]   9436.182730:  timer_init   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [006]   9436.182731:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da24  now=0x10022da15  flags=153092102
vendor.xxxyyy.ha-1593    [004]   9436.188128:  timer_cancel   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [004]   9436.193456:  timer_init   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [004]   9436.193458:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da26  now=0x10022da17  flags=161480708
vendor.xxxyyy.ha-1593    [005]   9436.199602:  timer_cancel   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [004]   9436.205410:  timer_init   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [004]   9436.205412:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da29  now=0x10022da1a  flags=174063620
<idle>-0    [003]   9436.209662:  timer_cancel   timer=0xffffff80444f0428
<idle>-0    [003]   9436.209664:  timer_expire_entry   timer=0xffffff80444f0428  now=0x10022da1c  function=__typeid__ZTSFvP10timer_listE_global_addr  baseclk=0x10022da1c
<idle>-0    [003]   9436.209718:  timer_expire_exit   timer=0xffffff80444f0428
kworker/u16:6-14217    [003]   9436.209863:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da2b  now=0x10022da1c  flags=182452227
vendor.xxxyyy.ha-1593    [004]   9436.209888:  timer_cancel   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [004]   9436.216390:  timer_init   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [004]   9436.216392:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da2c  now=0x10022da1d  flags=186646532
vendor.xxxyyy.ha-1593    [005]   9436.220992:  timer_cancel   timer=0xffffff80444f0428
xxxyyyTraceManag-7795    [004]   9436.261641:  timer_cancel   timer=0xffffff80444f0428

<1>[10278.515522] [cpu:   0] Unable to handle kernel paging request at virtual address dead00000000012a

-000|__hlist_del(inline)
-000|detach_timer(inline)
-000|expire_timers(inline)
-000|__run_timers(base = 0xFFFFFF8A70F31240)
-001|run_timer_softirq()
-002|__do_softirq()
-003|____do_softirq()
-004|call_on_irq_stack(asm)
-005|do_softirq_own_stack()
-006|invoke_softirq(inline)
-006|__irq_exit_rcu()
-007|irq_exit_rcu()
-008|__el1_irq(inline)
-008|el1_interrupt(regs = 0xFFFFFFC0410FB680, handler = 0xFFFFFFE5222100F8)
-009|el1h_64_irq_handler(regs = ?)
-010|el1h_64_irq(asm)
 -->|exception
-011|arch_local_irq_enable(inline)
-011|raw_spin_rq_unlock_irq(inline)
-011|finish_lock_switch(inline)
-011|finish_task_switch(prev = 0xFFFFFF88D30D8000)
-012|context_switch(inline)
-012|__schedule(:sched_mode = 1091549328)
-013|schedule()
-014|schedule_hrtimeout_range_clock(expires = ?, delta = ?, mode = ?, clock_id = ?)
-015|schedule_hrtimeout_range(expires = 0x0, delta = 0, mode = 1091549520)
-016|poll_schedule_timeout(inline)
-016|do_poll(inline)
-016|do_sys_poll(:ufds = 0x00000072B4397BD8, :nfds = 2, :end_time = 0x0)
-017|__do_sys_ppoll(inline)
-017|__se_sys_ppoll(inline)
-017|__arm64_sys_ppoll(:regs = 0xFFFFFFC0410FBEB0)
-018|__invoke_syscall(inline)
-018|invoke_syscall(:regs = 0xFFFFFFC0410FBEB0, scno = ?, sc_nr = ?, :syscall_table = 0xFFFFFFE5231E0D20)
-019|el0_svc_common(regs = 0xFFFFFFC0410FBEB0, scno = ?, sc_nr = ?, syscall_table = 0xFFFFFFE5231E0D20)
-020|do_el0_svc(regs = 0xFFFFFFC0410FBEB0)
-021|el0_svc(regs = 0xFFFFFFC0410FBEB0)
-022|el0t_64_sync_handler(regs = ?)
-023|el0t_64_sync(asm)
 -->|exception
-024|NUX:0x736F8F15FC(asm)
 ---|end of frame
expire_timers(inline)
expires = 4297461926,
  function = 0xFFFFFFE262CD6E18,
 base = 0xFFFFFF8975713240
 baseclk = 4297461926
 fn = 0x0
 timer = 0xFFFFFF8044AA5430 ->
( entry = (next = 0xDEAD000000000122, pprev = 0xFFFFFFC008003EA0 -> 0xDEAD000000000122 ->
next = 0x0,pprev = 0x0)),
  expires = 4297461926,
  function = 0xFFFFFFE262CD6E18, //delayed_work_timer_fn


