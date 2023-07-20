Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64BB75AB10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGTJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjGTJjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:39:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAED82D53;
        Thu, 20 Jul 2023 02:35:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K4Eate005080;
        Thu, 20 Jul 2023 09:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=rgB87VYg+qSX8naWX8H1W8jl5doCwBmeRMl7/YA3vig=;
 b=Gp6XBcf3XfzsAWPehRBsAZbjnvbjaZY+D7a9b0F48t3hh1i42G6JsdiDV6+E4n5itZ7Q
 MOA8DNp7kaPaN/8HKz17CxsmaW04aI4xy30MZkFVMQEILsjcmLMLkPrXK+KUD5Lm/wII
 /6Q/5FNQ4iE3PkcWpAKm1siX/Lgjdas6eBlnjnseJ1S7SzOkLxTetlUF9LR19FxYgp2I
 O91JMbNjuXS0q2bAAexwL8DX/KQ/FjXVrrJ78ehYJNSKqPjCNCpj4Mcul0H6J/LBQLJW
 RsnPZmmlw8GmJV8FszWW3T0ks2mWdb7g3eAc1+n93q7VQvCFCsAcV74RHDBZsNlIvzPH fQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxup4gru0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 09:34:54 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36K9YpEx029166;
        Thu, 20 Jul 2023 09:34:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm8sj6-1;
        Thu, 20 Jul 2023 09:34:51 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36K9YpiT029104;
        Thu, 20 Jul 2023 09:34:51 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36K9YpJh028935;
        Thu, 20 Jul 2023 09:34:51 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 6A47863F16C; Thu, 20 Jul 2023 15:04:50 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, quic_cang@quicinc.com, stanley.chu@mediatek.com,
        bvanassche@acm.org, quic_asutoshd@quicinc.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        konrad.dybcio@linaro.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org, jejb@linux.ibm.com,
        linux-arm-msm@vger.kernel.org, quic_ziqichen@quicinc.com,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V3] scsi: ufs: ufs-qcom: Change UFS devfreq timer to delayed
Date:   Thu, 20 Jul 2023 15:04:46 +0530
Message-Id: <20230720093446.30697-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6Yh8Leu9ip2O3oF0fERLemcjLrw0oAbt
X-Proofpoint-ORIG-GUID: 6Yh8Leu9ip2O3oF0fERLemcjLrw0oAbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_03,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200079
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devfreq uses the default DEVFREQ_TIMER_DEFERRABLE mode which uses
the deferred timer for scheduling the devfreq load monitor function.
This causes the load monitoring to be done only with non-idle CPUs
and not making use of the idle CPUs.

Hence, use the DEVFREQ_TIMER_DELAYED mode which uses the delayed
timer thereby making use of idle CPUs as well for load monitoring.

Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---

changes from v2:
- Modified commit message as per mani's suggestion
- removed threshold change

Changes from v1:
- Realigned the commit text

 drivers/ufs/host/ufs-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index df9161cb9825..07e5050dae77 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1619,6 +1619,7 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 					struct devfreq_simple_ondemand_data *d)
 {
 	p->polling_ms = 60;
+	p->timer = DEVFREQ_TIMER_DELAYED;
 	d->upthreshold = 70;
 	d->downdifferential = 5;
 }
--
2.17.1

