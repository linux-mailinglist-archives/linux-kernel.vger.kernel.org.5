Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA0B7F1A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjKTRhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjKTRhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:37:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7B132;
        Mon, 20 Nov 2023 09:36:54 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKHQn2A002178;
        Mon, 20 Nov 2023 17:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=Y4hKSC8osUSLbhShv+siTVPHh9deWzSVjPWV2cjpYt4=;
 b=Elh8y6kWZWbUH8nxcojfCFGnaAltxyVKyptAfngX8J7vH/3cD7UFtAZPbvB1rKx+vZNy
 rNUWtpJkQKq3rU/TXREwySrbjFTT15fYLOMYadSSYYxaHYRi954oYMFd3/yWvMS5K89H
 zUWkSNvvmX0TII4zhbovyK2Z1PJJSRHrvquzcBd3zFdFhWTC6/q0ACDeQrj223l6mS2L
 Fz7/6AA+AWd2LmldoG6FLjzdWP4FIr8E2GVqEZ7xfnPWK2VZ19aNl0O0xQRco2O42vqt
 mhdsXPi5I6jhjNf2zLgmaBUZJJanrlAsMPybtx/PU3S/591/cv37sO7lRRYcy5qE4NuI jg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug7ea8rjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 17:36:44 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKHahZg026197
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 17:36:43 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 09:36:42 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH 0/2] freezer,sched: do not restore saved_state of a thawed
 task
Date:   Mon, 20 Nov 2023 09:36:30 -0800
Message-ID: <20231120-freezer-state-multiple-thaws-v1-0-f2e1dd7ce5a2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6ZW2UC/4XNuxKCMBCF4VdxUrtOlpBBrXwPhyIkG9kZBUwCX
 hjeXbw0Nlr+p/jOKCIFpii2i1EEGjhy28yBy4WwtWkOBOzmFpnMFKJcgw9EdwoQk0kEp/6YuDs
 SpNpcIhRGmbXbOOMqJWaiC+T5+uL35dw1x9SG2+ttwOf6gVH/hgcEBK8yVyB5qSu5O/dsubEr2
 56eT28mk38ZCSa3uVZeyyLXX0w5TdMD4/4tfhEBAAA=
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, "Ingo Molnar" <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Abhijeet Dharmapurikar <quic_adharmap@quicinc.com>
X-Mailer: b4 0.13-dev
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2xFWSMeQIEmKN960l1nM2d2mIlfA7_ql
X-Proofpoint-ORIG-GUID: 2xFWSMeQIEmKN960l1nM2d2mIlfA7_ql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_17,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=575 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series applies couple fixes to commit 8f0eed4a78a8 ("freezer,sched:
Use saved_state to reduce some spurious wakeups") which was found while
testing with legacy cgroup freezer. My original testing was only with
system-wide freezer. We found that thaw_task could be called on a task
which was already frozen. Prior to commit 8f0eed4a78a8 ("freezer,sched:
Use saved_state to reduce some spurious wakeups"), this wasn't an issue
as kernel would try to wake up TASK_FROZEN, which wouldn't match the
thawed task state, and no harm done to task. After commit 8f0eed4a78a8
("freezer,sched: Use saved_state to reduce some spurious wakeups"), it
was possible to overwrite the state of thawed task.

To: Rafael J. Wysocki <rafael@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc:  <linux-arm-msm@vger.kernel.org>
Cc: Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
Cc:  <linux-pm@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Originally sent to only linux-arm-msm, resending to correct authors.
- Link to v1: https://lore.kernel.org/r/20231120-freezer-state-multiple-thaws-v1-0-a4c453f50745@quicinc.com

---
Elliot Berman (2):
      freezer,sched: do not restore saved_state of a thawed task
      freezer,sched: clean saved_state when restoring it during thaw

 kernel/freezer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 6d7e4782bcf549221b4ccfffec2cf4d1a473f1a3
change-id: 20231108-freezer-state-multiple-thaws-7a3a8d9dadb3

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>

