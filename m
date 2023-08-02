Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8876C457
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjHBE6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjHBE5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:57:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCBA19B0;
        Tue,  1 Aug 2023 21:57:53 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724LVX9004633;
        Wed, 2 Aug 2023 04:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Uw4pWzd4yqDlj0SnBrdTj0genxMDTxppvIzuJneDixY=;
 b=XFN+g4PjBkz8/gni9bJB0AMch+5TdYPiFmg3uVr74Mlg/dUrwhDChCEDi5BrrNROlOwp
 mCCGKibHAZk3YL0XCdPA52XAsYip3LogL4Ob0tBwOGB5+md66V7/2H+K43aeWyPJTMRF
 wFuLvmIj+V2NqTPHqTHa6gvnOKdX8VV0mprznE4qFC+6mT7gqq9UaKoz5DZtA/KaWDlZ
 Rh2BZ+ZRCzopAhpuV04kvwb4o4guHxtC0A2xQuEzCM37jnabGRy3qdolb5QG+2PVRSXJ
 B6DtdcyQ3cxMuBBmr+OOlkDJpBOSc5XroJTMOiMymaOlH8hy8VlQygnBMQwyAwKBFP5D qg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7bw9gek3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 04:57:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3724vkmP030985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 04:57:46 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 21:57:43 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
Subject: [PATCH v3] misc: fastrpc: Fix remote heap allocation request
Date:   Wed, 2 Aug 2023 10:27:38 +0530
Message-ID: <1690952258-31364-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zAsM2xHJ4ccq4ryr-mzZjHZhxLMYGvJ7
X-Proofpoint-GUID: zAsM2xHJ4ccq4ryr-mzZjHZhxLMYGvJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_02,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote heap is used by DSP audioPD on need basis. This memory is
allocated from reserved CMA memory region and is then shared with
audioPD to use it for it's functionality.

Current implementation of remote heap is not allocating the memory
from CMA region, instead it is allocating the memory from SMMU
context bank. The arguments passed to scm call for the reassignment
of ownership is also not correct. Added changes to allocate CMA
memory and have a proper ownership reassignment.

Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
Changes in v2:
  - Removed redundant code
Changes in v3:
  - Reuse channel context perms for source perms

 drivers/misc/fastrpc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 30d4d04..8e002a4 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1866,7 +1866,11 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	err = fastrpc_buf_alloc(fl, fl->sctx->dev, req.size, &buf);
+	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
+		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
+	else
+		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
+
 	if (err) {
 		dev_err(dev, "failed to allocate buffer\n");
 		return err;
@@ -1905,12 +1909,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	/* Add memory to static PD pool, protection thru hypervisor */
 	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
-		struct qcom_scm_vmperm perm;
-
-		perm.vmid = QCOM_SCM_VMID_HLOS;
-		perm.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(buf->phys, buf->size,
-			&fl->cctx->perms, &perm, 1);
+		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+			&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
 		if (err) {
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 					buf->phys, buf->size, err);
-- 
2.7.4

