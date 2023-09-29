Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0537B2CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjI2HBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjI2HBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:01:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC41BF;
        Fri, 29 Sep 2023 00:01:02 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T6dSvf002216;
        Fri, 29 Sep 2023 07:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=z6OvOJkU2QmX7U+VT65MGN7ENiR2GR4q+lji8If0JzI=;
 b=nuOKLSXP6UeILLhfp6RzmzEtDaQF9a86vuZBRJF46YROPDKvaJSI+dFnxbwt7HXccVrD
 s9FQwQycaARapSNZiyDIUs6Z0HHaWq9txQF4cYxDai+lhbcvll/Y1ApJObOw2cIQH7Il
 K9Z0BpBijqWUZjEadWKLtE+m9IaQoY3h8dXpd1Lp4j5pl609e/Z0KBcPZ3BkLLfa5Ucp
 MKo9LUkH/ap/GuNk/TdaBezZwxRn+PZPkFlOxwcm4/fVUEvaUdG+WqxwUUwn8RIesZ6R
 VFKf7LCCHaifm4/S9jOqVWU1jZyCUDKk9ZnEF19aDlYMKnSYk5D9sOgi/rugPhzkRyhA GA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td24uaqvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:01:00 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T70x6m027435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:00:59 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 29 Sep 2023 00:00:56 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 4/4] misc: fastrpc: Add support for users to clean up DSP user PD
Date:   Fri, 29 Sep 2023 12:30:30 +0530
Message-ID: <1695970830-12331-5-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695970830-12331-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1695970830-12331-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XGEnaBTaYHrmh1UH1OkcBJ2_4-fl6eAl
X-Proofpoint-ORIG-GUID: XGEnaBTaYHrmh1UH1OkcBJ2_4-fl6eAl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_04,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=791 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a control mechanism for users to clean up DSP user PD. This
method can be used by users for handling any unexpected hang
scenarios on DSP PD. User can clean up DSP PD and restart the
user PD again.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 40cb867..55f5286 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2253,6 +2253,11 @@ static int fastrpc_internal_control(struct fastrpc_user *fl,
 	case FASTRPC_CONTROL_RPC_POLL:
 		err = fastrpc_manage_poll_mode(fl, cp->lp.enable, cp->lp.latency);
 		break;
+	case FASTRPC_CONTROL_DSPPROCESS_CLEAN:
+		err = fastrpc_release_current_dsp_process(fl);
+		if (!err)
+			fastrpc_queue_pd_status(fl, fl->cctx->domain_id, FASTRPC_USERPD_FORCE_KILL);
+		break;
 	default:
 		err = -EBADRQC;
 		break;
-- 
2.7.4

