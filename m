Return-Path: <linux-kernel+bounces-76180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE80C85F3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3201C23BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5737152;
	Thu, 22 Feb 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YVIstuwt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70160182D2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592774; cv=none; b=HZoTN5i1VXGsgbsfOGc2ZJmj+ynzaf21gPIL07VsRG/rDjiVCW5IkkqOw3hdAzsW3R4DXvFLiiIaEiHh75LylznZ9qVJFD+6Bv9IN7JuQOhKCJ2LHtRFDwVfe2UVdDFhAaZB84DtxxkXVaVI/ov79IlzqytSNF5baLofQ3PgCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592774; c=relaxed/simple;
	bh=8c/Xh5sRpC4JqMGbwZlEN2x9qcwZFAlKpVkj5lFERAo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQsSt5LRvR7XUgee42XFpw6pQ0ms0h+uQS03MHPTfQ9Slv9gCbw/v2KzJIDSGRdiXqaYToFq/v8ptIjY6TSPgIOwouGWVg6DFDXQRUZxrc3eKVd8A0GOKJZnsMkf5HbjvgLgF89v5CBd5PuTwcfN2Pyu50R7I4z1Y7o2qM2h/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YVIstuwt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M6mhop019458;
	Thu, 22 Feb 2024 09:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=b7MKLBW
	4+oeVN4wDzAN30WAcbkMR7wXtDIhD/4exjd4=; b=YVIstuwtn/vitABEqDTJki2
	aRlRB8Otas4WX55YjnfBq/cyRdIrRl252rNd7gqOo9L0iI0Pq3rsrvM3qEp/+FBh
	brCLG7SXnMrn0AK6wXUBr9avlGs8zbwLBRMw0drvVlvAWNNurk+yuP2U6h4JXty4
	09+of8onv4gGZeor2WtMDGPa4bLIr7FSsyxNIt4ShmLgwvcapilcxtFUQHX3Asdu
	HPZNG0CDQvaQeVV87z4w57zom5X/qxcn0H9qqewIShK0ehYO9GspGyDF8j6YHavu
	+xrLB/Qr9wvWpvOWJuypn2Mvy8lb/yZUY7vZf60ItDz47Rle/YqpbnR1sm9lbEQ=
	=
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we1b0gf0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 09:05:57 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M95vR1027616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 09:05:57 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 01:05:55 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <pmladek@suse.com>, <rostedt@goodmis.org>, <john.ogness@linutronix.de>,
        <senozhatsky@chromium.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] printk: Add atomic context check inside console_unlock()
Date: Thu, 22 Feb 2024 14:35:38 +0530
Message-ID: <20240222090538.23017-1-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2cY2Txy475aLHp0j55uuqHQs-E4pPdlS
X-Proofpoint-GUID: 2cY2Txy475aLHp0j55uuqHQs-E4pPdlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220071

Situation of schedule while atomic context can happen in a
scenario if CPU-Y executing a async probe of ufs and while
printing a line it is started spinning for console lock
after preemption disable on CPU-Y and later it got the handover
of console lock from CPU-X and in console_unlock() it get
schedule with preempt disable as console_may_schedule was one
and due to which do_cond_resched was one.

         CPU-X                          CPU-Y

                                      worker_thread
                                       process_one_work
                                        async_run_entry_fn
                                         ufshcd_async_scan
                                          ufshcd_device_init
really_probe+0x1c8                         ufshcd_probe_hba
 platform_probe+0xc0                        ufshcd_config_mcq
  qcom_geni_serial_probe+0x374               _dev_info
   uart_add_one_port+0x10                     __dev_printk
    serial_ctrl_register_port+0x10             dev_printk_emit
     serial_core_register_port+0x5dc            dev_vprintk_emit
      register_console+0x284                      vprintk_emit
       console_init_seq()                          preempt_disable();
	                                           console_trylock_spinning()
        console_lock();
         console_flush_all()

Hand over of console lock happen from CPU-X to CPU-Y
                                                   console_unlock()
          console_lock+0x74                         console_flush_all
	   down[jt]+0x40                             __might_resched
	    __down+0x18
             __down_common+0x68
              ___down_common+0xdc
               schedule_timeout+0x4c
                schedule+0x78
                 __schedule+0x6c0

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..8b666feff65d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3028,7 +3028,7 @@ void console_unlock(void)
 	 * messages practically incapacitating the system. Therefore, create
 	 * a local to use for the printing loop.
 	 */
-	do_cond_resched = console_may_schedule;
+	do_cond_resched = in_atomic() || console_may_schedule;
 
 	do {
 		console_may_schedule = 0;
-- 
2.43.0.254.ga26002b62827


