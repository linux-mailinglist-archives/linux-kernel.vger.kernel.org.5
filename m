Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB8D7E0ADE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 22:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjKCVx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 17:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKCVxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 17:53:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D04DD54
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 14:53:49 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3LbPNc017492;
        Fri, 3 Nov 2023 21:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=L1gf4SE0cotgosJUEiy6yyXLDrfDlqrR65MXeq9+/EQ=;
 b=BPJBVjx0r268tH9SosMFM3Ie/nSCZcenCqpMwSEh6+ItoexCwe9G0eAuU1Di9dqntwcQ
 HsyBGOcCRA4pi7m8ifS5pkZvTt1hBKlIYo7mKnJs0nC9t/pIHU2Vat3USAR276lzwwc4
 F/KomMfgqvMUPPLAmaE3G4yRLhawMOIlehZgn0ORJZ2m7a1PnKnZi9yEDNJgPShRB3rL
 tAAJCByBc+9p90HwaIaoiYTPco+9Noo295QS/nlD3wwWShemuJt/rfVD+k2c0e7oNcYh
 0RQZao36u2ij8pJFiOxqfRMOoFakPRbtP1MMgiBazE6ACc+aKPhrDTCCN0gbRPc26AgQ TA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4cw9ukym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 21:53:26 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3LrPMh027221
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 21:53:25 GMT
Received: from hyd-lablnx450.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 14:53:20 -0700
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <konrad.dybcio@linaro.org>, <quic_saipraka@quicinc.com>,
        <quic_pkondeti@quicinc.com>, <quic_molvera@quicinc.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>,
        "Bibek Kumar Patro" <quic_bibekkum@quicinc.com>
Subject: [PATCH 0/3] iommu/arm-smmu: introduction of ACTLR implementation for Qualcomm SoCs
Date:   Sat, 4 Nov 2023 03:21:21 +0530
Message-ID: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B1flFjoFBxgkLDveYWnb16GOolpjwtXn
X-Proofpoint-ORIG-GUID: B1flFjoFBxgkLDveYWnb16GOolpjwtXn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_21,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=552 spamscore=0
 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series consists of three parts and covers the following:

1. Introducing intital set of driver changes to implement ACTLR register
for custom prefetcher settings in Qualcomm SoCs.

2. Adding ACTLR data and implementation operations for SM8550.

3. Re-enabling context caching for Qualcomm SoCs to retain prefetcher
settings during reset and runtime suspend.

Link to discussion on RFC posted on ACTLR implementation:
https://lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com/

Bibek Kumar Patro (3):
  iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
  iommu/arm-smmu: add ACTLR data and support for sm8550
  iommu/arm-smmu: re-enable context caching in smmu reset operation

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 143 ++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c      |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |   5 +
 4 files changed, 146 insertions(+), 9 deletions(-)

--
2.17.1

