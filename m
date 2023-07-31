Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E13769734
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjGaNJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjGaNJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:09:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461761BC3;
        Mon, 31 Jul 2023 06:08:39 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VCkFhF029018;
        Mon, 31 Jul 2023 13:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=HmBwFRAqoui3gzkguf7120kFVc4zporDkOR9nPzEu08=;
 b=Bje7rO5BcQCT6JyXe9kO7iEtsVwuc8iM8UJz37020cN4NUYWzM6mInRFonPMvACOh8Fv
 R5T8abxIBrsHy+JI9G+i63KH47T2Cxq6LTVxO7pLM0sGMGph01MJeCFD8g6biQoI+TBJ
 Py2en1Dx/fllFL9SkSZ3frMbhjiARGyqw//YlexgFBo/mz9lCRcNwq0FAsqbNLSNjS2z
 YFz/xtehzk7UwcKpooggRokBHT8rdH4GPG651aXI8S3eEd2tyvYe8gNfxl9U22DG+1Zl
 v67HPM8EWe3llcoDWbDXET5A+NIyMAr3Zbjyri0Wz7KkJp8HCS0hE7cMCvivwV0npuue dw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d8gr9t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 13:08:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VD88tc010356
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 13:08:08 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 06:08:05 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <clew@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
Subject: [PATCH] soc: qcom: qmi: Signal the txn completion after releasing the mutex
Date:   Mon, 31 Jul 2023 18:37:55 +0530
Message-ID: <20230731130755.2674029-1-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2MCfZqn-01gkgbnJFEm4Ycok3cmIs0C8
X-Proofpoint-GUID: 2MCfZqn-01gkgbnJFEm4Ycok3cmIs0C8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_06,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=897
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

txn is in #1 stack

Worker #1                                       Worker #2
********					*********

qmi_txn_wait(txn)                               qmi_handle_message
   |                                                  |
   |                                                  |
 wait_for_complete(txn->complete)                    ....
   |                                             mutex_lock(txn->lock)
   |                                                  |
 mutex_lock(txn->lock)                                |
   .....                                         complete(txn->lock)
   |                                             mutex_unlock(txn->lock)
   |
 mutex_unlock(txn->lock)

In this case above, while #2 is doing the mutex_unlock(txn->lock),
in between releasing lock and doing other lock related wakeup, #2 gets
scheduled out. As a result #1, acquires the lock, unlocks, also
frees the txn also (where the lock resides)

Now #2, gets scheduled again and tries to do the rest of the lock
related wakeup, but lock itself is invalid because txn itself is gone.

Fixing this, by doing the mutex_unlock(txn->lock) first and then
complete(txn->lock) in #2

Fixes: 3830d0771ef6 ("soc: qcom: Introduce QMI helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 drivers/soc/qcom/qmi_interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index 78d7361fdcf2..92e29db97359 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -505,12 +505,13 @@ static void qmi_handle_message(struct qmi_handle *qmi,
 				pr_err("failed to decode incoming message\n");
 
 			txn->result = ret;
-			complete(&txn->completion);
 		} else  {
 			qmi_invoke_handler(qmi, sq, txn, buf, len);
 		}
 
 		mutex_unlock(&txn->lock);
+		if (txn->dest && txn->ei)
+			complete(&txn->completion);
 	} else {
 		/* Create a txn based on the txn_id of the incoming message */
 		memset(&tmp_txn, 0, sizeof(tmp_txn));
-- 
2.34.1

