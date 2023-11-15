Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2437A7EAE07
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjKNK1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKNK1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:27:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E2783;
        Tue, 14 Nov 2023 02:27:44 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE9lpqi005329;
        Tue, 14 Nov 2023 10:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=REeZzKF2rsqLjNC1YywmV+SEyFMzmlpW5huEYDn24Zs=;
 b=n4x1byOZCfKkhuyTmMWR1tQrysc5I3Q/wiomgYpEAakAE1snOpsXQqY0f/16rit7mqQw
 c8YeWsDRb9vjJuIABmXVgtDZWSURUdtSzZkHLL+gWyC1IsZME4tBi9Ftb5dYdCuzcQbc
 XxWKvTMSVn7aPfyy9EK5ePhQneo62hfPJefr+A6HDvCk+MjOh4xtjPHIM1iwJvmHvfYa
 8v6ETm2yBNeyj5FY/1Hjl0t6LpHDx6EGCeQEMy/iNjGVD7mZcd4dhoXNTUBRc5tLqWOS
 eBoez5QI1Viwj13N6rVVu/02ppJfhMePCH/SGPKMeMrMXgB7w9msnH0J2MoWPhj6TH6p 1A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubj732c27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 10:27:40 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AEARdem005801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 10:27:39 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 02:27:36 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] PM / devfreq: Synchronize queuing the same timer instance twice
Date:   Tue, 14 Nov 2023 15:57:28 +0530
Message-ID: <1699957648-31299-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Lmcwf-dUmthPVbaEM42TD129_IHlube4
X-Proofpoint-ORIG-GUID: Lmcwf-dUmthPVbaEM42TD129_IHlube4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a chance if a frequent switch of the governor
done in a loop result in timer list corruption where
timer_cancel being done from two place one from
cancel_delayed_work_sync() and followed by expire_timers()
can be seen from the traces[1], however, looks like
device_monitor_[start/stop] need to synchronized too.

Let's use polling flag to synchronize the queueing the
timer instance twice.

[1]
...
..
<idle>-0    [003]   9436.209662:  timer_cancel   timer=0xffffff80444f0428
<idle>-0    [003]   9436.209664:  timer_expire_entry   timer=0xffffff80444f0428  now=0x10022da1c  function=__typeid__ZTSFvP10timer_listE_global_addr  baseclk=0x10022da1c
<idle>-0    [003]   9436.209718:  timer_expire_exit   timer=0xffffff80444f0428
kworker/u16:6-14217    [003]   9436.209863:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da2b  now=0x10022da1c  flags=182452227
vendor.xxxyyy.ha-1593    [004]   9436.209888:  timer_cancel   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [004]   9436.216390:  timer_init   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [004]   9436.216392:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da2c  now=0x10022da1d  flags=186646532
vendor.xxxyyy.ha-1593    [005]   9436.220992:  timer_cancel   timer=0xffffff80444f0428
xxxyyyTraceManag-7795    [004]   9436.261641:  timer_cancel   timer=0xffffff80444f0428

[2]

 9436.261653][    C4] Unable to handle kernel paging request at virtual address dead00000000012a
[ 9436.261664][    C4] Mem abort info:
[ 9436.261666][    C4]   ESR = 0x96000044
[ 9436.261669][    C4]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 9436.261671][    C4]   SET = 0, FnV = 0
[ 9436.261673][    C4]   EA = 0, S1PTW = 0
[ 9436.261675][    C4] Data abort info:
[ 9436.261677][    C4]   ISV = 0, ISS = 0x00000044
[ 9436.261680][    C4]   CM = 0, WnR = 1
[ 9436.261682][    C4] [dead00000000012a] address between user and kernel address ranges
[ 9436.261685][    C4] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[ 9436.261701][    C4] Skip md ftrace buffer dump for: 0x3a982d0
...

[ 9436.262138][    C4] CPU: 4 PID: 7795 Comm: TraceManag Tainted: G S      W  O      5.10.149-android12-9-o-g17f915d29d0c #1
[ 9436.262141][    C4] Hardware name: Qualcomm Technologies, Inc.  (DT)
[ 9436.262144][    C4] pstate: 22400085 (nzCv daIf +PAN -UAO +TCO BTYPE=--)
[ 9436.262161][    C4] pc : expire_timers+0x9c/0x438
[ 9436.262164][    C4] lr : expire_timers+0x2a4/0x438
[ 9436.262168][    C4] sp : ffffffc010023dd0
[ 9436.262171][    C4] x29: ffffffc010023df0 x28: ffffffd0636fdc18
[ 9436.262178][    C4] x27: ffffffd063569dd0 x26: ffffffd063536008
[ 9436.262182][    C4] x25: 0000000000000001 x24: ffffff88f7c69280
[ 9436.262185][    C4] x23: 00000000000000e0 x22: dead000000000122
[ 9436.262188][    C4] x21: 000000010022da29 x20: ffffff8af72b4e80
[ 9436.262191][    C4] x19: ffffffc010023e50 x18: ffffffc010025038
[ 9436.262195][    C4] x17: 0000000000000240 x16: 0000000000000201
[ 9436.262199][    C4] x15: ffffffffffffffff x14: ffffff889f3c3100
[ 9436.262203][    C4] x13: ffffff889f3c3100 x12: 00000000049f56b8
[ 9436.262207][    C4] x11: 00000000049f56b8 x10: 00000000ffffffff
[ 9436.262212][    C4] x9 : ffffffc010023e50 x8 : dead000000000122
[ 9436.262216][    C4] x7 : ffffffffffffffff x6 : ffffffc0100239d8
[ 9436.262220][    C4] x5 : 0000000000000000 x4 : 0000000000000101
[ 9436.262223][    C4] x3 : 0000000000000080 x2 : ffffff889edc155c
[ 9436.262227][    C4] x1 : ffffff8001005200 x0 : ffffff80444f0428
[ 9436.262232][    C4] Call trace:
[ 9436.262236][    C4]  expire_timers+0x9c/0x438
[ 9436.262240][    C4]  __run_timers+0x1f0/0x330
[ 9436.262245][    C4]  run_timer_softirq+0x28/0x58
[ 9436.262255][    C4]  efi_header_end+0x168/0x5ec
[ 9436.262265][    C4]  __irq_exit_rcu+0x108/0x124
[ 9436.262274][    C4]  __handle_domain_irq+0x118/0x1e4
[ 9436.262282][    C4]  gic_handle_irq.30369+0x6c/0x2bc
[ 9436.262286][    C4]  el0_irq_naked+0x60/0x6c

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
This is further to the issue reported at 

https://lore.kernel.org/all/1699459797-21703-1-git-send-email-quic_mojha@quicinc.com/


 drivers/devfreq/devfreq.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 474d81831ad3..09b93104521b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -461,10 +461,14 @@ static void devfreq_monitor(struct work_struct *work)
 	if (err)
 		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
 
+	if (devfreq->stop_polling)
+		goto out;
+
 	queue_delayed_work(devfreq_wq, &devfreq->work,
 				msecs_to_jiffies(devfreq->profile->polling_ms));
-	mutex_unlock(&devfreq->lock);
 
+out:
+	mutex_unlock(&devfreq->lock);
 	trace_devfreq_monitor(devfreq);
 }
 
@@ -483,6 +487,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		return;
 
+	mutex_lock(&devfreq->lock);
 	switch (devfreq->profile->timer) {
 	case DEVFREQ_TIMER_DEFERRABLE:
 		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
@@ -491,12 +496,16 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
 		break;
 	default:
-		return;
+		goto out;
 	}
 
 	if (devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
+
+	devfreq->stop_polling = false;
+out:
+	mutex_unlock(&devfreq->lock);
 }
 EXPORT_SYMBOL(devfreq_monitor_start);
 
@@ -513,6 +522,14 @@ void devfreq_monitor_stop(struct devfreq *devfreq)
 	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		return;
 
+	mutex_lock(&devfreq->lock);
+	if (devfreq->stop_polling) {
+		mutex_unlock(&devfreq->lock);
+		return;
+	}
+
+	devfreq->stop_polling = true;
+	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 }
 EXPORT_SYMBOL(devfreq_monitor_stop);
-- 
2.7.4

