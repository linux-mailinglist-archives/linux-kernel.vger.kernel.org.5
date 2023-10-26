Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315497D7EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbjJZIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344752AbjJZIxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:53:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A86B129;
        Thu, 26 Oct 2023 01:53:37 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q6la89032722;
        Thu, 26 Oct 2023 08:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YnVXtye3YRvsdRNXR9+JZk2Alik2CJJezIeBwhlX6B0=;
 b=U1zA9ptgxEynn/uUGhlXEhq7JqJ3UVzY2qlp4kBmFWAlGPz+d/IMz+Y6xR5dS9Bf4keW
 /yEk7N8JAdgDq066rbdJjtBwM0SYZwSNzbKnlZdH1NO+2Vvvf5n6S9EQT1alcQ3fhhDj
 0zbJ57yRQhnM0LnA2YkEJNWmKnJmXaS1kkRWTbE3nlo4Sq5hQxzOul8uucK16pY+pQQI
 NDnC5aS0ElwVK0ovk64Pix8WVe4PW0r3EEpav1lr+jRNoLwlPaWRfKki3E7ZWKtQxXms
 TeeoLk4iczV/PcaXYwgwbw+RPPPIWZ4Ej8I0xaK0ov5UnS0FtxtK2/3CLYVkwf/t6NUl 4Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ty0tu2m5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:53:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39Q8rYD3022809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:53:34 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 01:53:32 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] misc: fastrpc: Add support for users to clean up DSP user PD
Date:   Thu, 26 Oct 2023 14:23:20 +0530
Message-ID: <1698310400-5601-5-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698310400-5601-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1698310400-5601-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WLBvg42gYmNtxkwsYXHJAWebIhpIkAsQ
X-Proofpoint-GUID: WLBvg42gYmNtxkwsYXHJAWebIhpIkAsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_06,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=802
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310260074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index e012ff25..7b1a41d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2254,6 +2254,11 @@ static int fastrpc_internal_control(struct fastrpc_user *fl,
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

