Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA32E7FD001
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjK2Hht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjK2Hh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:37:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17AF19BC;
        Tue, 28 Nov 2023 23:37:20 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT7RZhg007125;
        Wed, 29 Nov 2023 07:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=34Yd6W3Cr+IwCKKx95of4zGmT83ghEUbaMMFO3ZwbFg=;
 b=UzwTqtUtAUZXPJc6pMXMc2JPlu+uSqqD+uRBioiHoijANrKxeQw+Z/qZ8AA3SIVsA/jW
 8Vyzu0+8E3jJRONSiE/WQExVSXZluCMj+jArWQASzWOems3J9suxsBQEwU+ajhCxvap2
 n+mlcyznjxxQ+5YAmUU6eJdK4w+Rflvz+PlKF6mEBL2UYr30aCqUHT0SJIbrOpKvYuGB
 QoO29LOj6O1dFFAGrgO7AP7sTwMSgTVLGIDIBMHprerGU8Fas/sVW/X0lPSvsDzrY9JU
 q2oFC/QkyEWEAIV82f7Kgq6IjsE2+d118m/RXDG9YCLT4rPtsp8+eT9rxc2lxThAGw2a 1A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up0x00a8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 07:37:01 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT5EEbG012193;
        Wed, 29 Nov 2023 07:36:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrknmwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 07:36:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AT7avqT25297412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 07:36:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 319AC2004B;
        Wed, 29 Nov 2023 07:36:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B49AE20043;
        Wed, 29 Nov 2023 07:36:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Nov 2023 07:36:56 +0000 (GMT)
Received: from nicholasmvm.. (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4DC9E6030B;
        Wed, 29 Nov 2023 18:36:54 +1100 (AEDT)
From:   Nicholas Miehlbradt <nicholas@linux.ibm.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Miehlbradt <nicholas@linux.ibm.com>
Subject: [PATCH] rtc: fix uninitialized read of rtc_wkalrm.time
Date:   Wed, 29 Nov 2023 07:36:47 +0000
Message-Id: <20231129073647.2624497-1-nicholas@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GbTP6RiJ4MUC-v08dHZkNh2o5eX09s23
X-Proofpoint-ORIG-GUID: GbTP6RiJ4MUC-v08dHZkNh2o5eX09s23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_05,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=777 spamscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If either of the first two branches of the if statement in
rtc_read_alarm_internal are taken the fields of alarm->time are not
initialized but are subsequently read by the call to rtc_tm_to_time64.

Refactor so that the time field is only read if the final branch of the
if statment which initializes the field is taken.

Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
---
 drivers/rtc/interface.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 1b63111cdda2..f40e76d2fe2b 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -179,6 +179,7 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc,
 				   struct rtc_wkalrm *alarm)
 {
 	int err;
+	time64_t trace_time = -1;
 
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
@@ -201,11 +202,12 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc,
 		alarm->time.tm_yday = -1;
 		alarm->time.tm_isdst = -1;
 		err = rtc->ops->read_alarm(rtc->dev.parent, alarm);
+		trace_time = rtc_tm_to_time64(&alarm->time);
 	}
 
 	mutex_unlock(&rtc->ops_lock);
 
-	trace_rtc_read_alarm(rtc_tm_to_time64(&alarm->time), err);
+	trace_rtc_read_alarm(trace_time, err);
 	return err;
 }
 
-- 
2.37.2

