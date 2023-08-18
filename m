Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25B6780E52
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377819AbjHROwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377521AbjHROv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:51:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0613C20;
        Fri, 18 Aug 2023 07:51:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ICodLF029456;
        Fri, 18 Aug 2023 14:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=3cEdf1BA9mkJH1vSngadWzODUbmNb0BncU2g8daHDO4=;
 b=KiQIXldu01/G/cn2oKgO9LFffqI7LhD/DwkWy3M0wTW6bDcSfCfNCEzO//dfkMhtmqYf
 o79G3LjQi4a6VV4NwNR9UQhD3BwMnr3fg9mnUHqICNg04TDbhEJaDlDKgHp61cizZ5CJ
 waN1LxwPwLP+6RrQG1KiWwjFz9Qp6hRyPFdpFTRF+L2O031C2VyRBJOFPPYgvB92BgQ3
 Le27nO1be3G7Z7/F1ClIm778trfqCtFuai0926j64W1zVRedpU4YgB5KohemBXFdbua1
 rkqahylooBHwABZDLeVLJdBxFhEW1IW6m5W6OIFoLs3PY18eDZz3BOPBx2HPPpx+H81j 9w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sj6320j30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 14:51:08 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37IEp5ej000308;
        Fri, 18 Aug 2023 14:51:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3se35mqdxy-1;
        Fri, 18 Aug 2023 14:51:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IEp4Qq000300;
        Fri, 18 Aug 2023 14:51:05 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37IEp4UO032767;
        Fri, 18 Aug 2023 14:51:04 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 1F0C31200077; Fri, 18 Aug 2023 20:21:04 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_mdalam@quicinc.com, quic_srichara@quicinc.com
Subject: [PATCH 2/3] mtd: rawnand: qcom: Clear buf_count and buf_start in raw read
Date:   Fri, 18 Aug 2023 20:21:00 +0530
Message-Id: <20230818145101.23825-3-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818145101.23825-1-quic_mdalam@quicinc.com>
References: <20230818145101.23825-1-quic_mdalam@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XiZaebA4NENsixwCBFJIeIMP7-4RAVTQ
X-Proofpoint-ORIG-GUID: XiZaebA4NENsixwCBFJIeIMP7-4RAVTQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_18,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 mlxlogscore=882 classifier=spam adjust=0 reason=mlx scancount=1
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

Initialize buf_count and buf_start to 0 before starting the
raw read. If we will not initialize then read staus will get
updated with wrong value and we will see failure for even
successful raw read transaction.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 413e214c8e87..73dd1b4e4e31 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1471,6 +1471,9 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	int raw_cw = cw;
 
 	nand_read_page_op(chip, page, 0, NULL, 0);
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+	clear_read_regs(nandc);
 	host->use_ecc = false;
 
 	if (nandc->props->qpic_v2)
-- 
2.17.1

