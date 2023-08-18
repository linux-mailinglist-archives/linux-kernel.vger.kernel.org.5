Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7773780E55
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377895AbjHROwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjHROvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:51:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B0213D;
        Fri, 18 Aug 2023 07:51:24 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IDRFrh021959;
        Fri, 18 Aug 2023 14:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=mW9F2IuP1OKTCHFXPAqTq/Htp2mnM59CS/9+/TV+MIs=;
 b=WpSN0OSW6nv4a8bzvKN535ElcuHHEtBA32aw/Q/20lyXQ0Kw5wt2aHOKjw66l7SK10xb
 i/kPqpYZyBM/z8nJ4p9OBWPf5eeK9wQF3vxvQZLA081RbZwDrHdzC/WSftZ/TlR5+3aW
 1JvsJ6aTOYnoYU6HjmJgT2NM0QPUU7bELrsxgeXdIAIs5H7EvA59+AxxSOmahkTm59wC
 aA+dC/1INU45uIVTvLon7k9WYHQ6DpR9jy5CV6K/iez0Lg9coqJXTyyil9KwIQpH63qZ
 6Rm6WQd43EhW9L6NkQcETbA8Heczs1LGXm5n43KW3vtEQNL/C3fc6Hiumqphdq5qPos+ DA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sj6320j2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 14:51:06 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37IEp3TV032741;
        Fri, 18 Aug 2023 14:51:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3se35mqdxg-1;
        Fri, 18 Aug 2023 14:51:03 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IEp3xK032735;
        Fri, 18 Aug 2023 14:51:03 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37IEp3EQ032734;
        Fri, 18 Aug 2023 14:51:03 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 705471200077; Fri, 18 Aug 2023 20:21:02 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_mdalam@quicinc.com, quic_srichara@quicinc.com
Subject: [PATCH 0/3]mtd: rawnand: qcom: Fixes for exec_op
Date:   Fri, 18 Aug 2023 20:20:58 +0530
Message-Id: <20230818145101.23825-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UT0IIMWnJj61I9dgTJfSmFdNwBDflp64
X-Proofpoint-ORIG-GUID: UT0IIMWnJj61I9dgTJfSmFdNwBDflp64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_18,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 mlxlogscore=604 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180135
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the following.

1. fixes parameter page read len for 4K nand
   in exec_op.

2. fixes raw_nand_read issue.

3. fixes READ path issue in exec_op.

Applied on top of [1]

This series tested on IPQ8074 2K and 4K nand with
mtd_test*.ko (mtd_nandbiterrs.ko, mtd_pagetest.ko, mtd_readtest.ko
mtd_subpagetest.ko, mtd_torturetest.ko, mtd_stresstest.ko). 

[1] https://lore.kernel.org/lkml/20230805174146.57006-1-manivannan.sadhasivam@linaro.org/

Md Sadre Alam (2):
  mtd: rawnand: qcom: Update read_loc size to 512
  mtd: rawnand: qcom: Clear buf_count and buf_start in raw read

Sricharan Ramabadhran (1):
  mtd: rawnand: qcom: Add read/read_start ops in exec_op path

 drivers/mtd/nand/raw/qcom_nandc.c | 99 +++++++++++++------------------
 1 file changed, 41 insertions(+), 58 deletions(-)

-- 
2.17.1

