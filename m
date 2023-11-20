Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A487F1A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjKTRhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjKTRhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:37:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD2131;
        Mon, 20 Nov 2023 09:36:54 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKHGVjB020976;
        Mon, 20 Nov 2023 17:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=JbCQVIXqkNI2H2MAYTXCqiy7vmoSbLN+sWhONQVWWSE=;
 b=La3sMofqd+WN1wbl9ix7XINzkPV7O+AZHLwTo3dsPuo9fs+Znz2jBl+D6qrQcsiDDhk3
 oU/ZhqUCJRtbpBI054rBUjCh6Feu+VuZgQYNklJzA4SV+1KCTC3D6p/d/GUNFT8iHs7i
 bkeZJawWCdjXnQtVoir2KpguZu1ynWLpv6TNKben2h4gmjpjL3bd3jol3iSBVqFri4eH
 c4zR5dB6qils+c9H/qiipzjlKW2VtDO+ZRgFmQvX4bfKCqpMao+rbeAQ8DH3igi3tf7p
 4FF0unywaB6esJllJPM70RGi9N1CaduTbVcn+AW7IAK0KBdKq4xbSzil647e50oIkCaU FQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug7ea8rjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 17:36:44 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKHahKQ011372
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 17:36:43 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 09:36:42 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
Date:   Mon, 20 Nov 2023 09:36:31 -0800
Subject: [PATCH 1/2] freezer,sched: do not restore saved_state of a thawed
 task
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231120-freezer-state-multiple-thaws-v1-1-f2e1dd7ce5a2@quicinc.com>
References: <20231120-freezer-state-multiple-thaws-v1-0-f2e1dd7ce5a2@quicinc.com>
In-Reply-To: <20231120-freezer-state-multiple-thaws-v1-0-f2e1dd7ce5a2@quicinc.com>
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
X-Proofpoint-GUID: 8W7odmxie3OejK1QtSb8I4tvck-TU7eD
X-Proofpoint-ORIG-GUID: 8W7odmxie3OejK1QtSb8I4tvck-TU7eD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_17,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 impostorscore=0 adultscore=0
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

It is possible for a task to be thawed multiple times when mixing the
*legacy* cgroup freezer and system-wide freezer. To do this, freeze the
cgroup, do system-wide freeze/thaw, then thaw the cgroup. When this
happens, then a stale saved_state can be written to the task's state
and cause task to hang indefinitely. Fix this by only trying to thaw
tasks that are actually frozen.

This change also has the marginal benefit avoiding unnecessary
wake_up_state(p, TASK_FROZEN) if we know the task is already thawed.
There is not possibility of time-of-compare/time-of-use race when we skip
the wake_up_state because entering/exiting TASK_FROZEN is guarded by
freezer_lock.

Fixes: 8f0eed4a78a8 ("freezer,sched: Use saved_state to reduce some spurious wakeups")
Reviewed-by: Abhijeet Dharmapurikar <quic_adharmap@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 kernel/freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index c450fa8b8b5e..759006a9a910 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -201,7 +201,7 @@ void __thaw_task(struct task_struct *p)
 	if (WARN_ON_ONCE(freezing(p)))
 		goto unlock;
 
-	if (task_call_func(p, __restore_freezer_state, NULL))
+	if (!frozen(p) || task_call_func(p, __restore_freezer_state, NULL))
 		goto unlock;
 
 	wake_up_state(p, TASK_FROZEN);

-- 
2.41.0

