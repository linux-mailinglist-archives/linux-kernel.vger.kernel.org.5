Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762637EB160
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjKNN5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjKNN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:57:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6535D53;
        Tue, 14 Nov 2023 05:57:33 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE9lONG004872;
        Tue, 14 Nov 2023 13:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=YyPNtowo/JzT1pSI0wSSYFY69fK6vWqtjP2754NoftQ=;
 b=C1sBOC8Bkwu9Fgc5EaMNRRWxxrwXGR7n+3C9F2Vm5rAGdROrZFAzvQzsxpZny17jgWUx
 M8SGKvt9aWfzQhoQ1iL1umnnk3Ep+VoUh8whGtX/TfeQce1+LgPD5XSwbFMfU6mf/Cax
 EEd7k38gM5d7m8e3odty1i4bDeuvaUt3SsM4ZomBrT9jlNMphrVoJfmLdrv08Qs+OHKL
 2aVPgmbivzSn1r4zUQUgNFLFyfuI7k7thMu+HYIrM64t6103DpBRR7sMoBYPfnJchgbs
 Vu8Hl7ymkaHVxejrazJpq80tcMda3AhMUXOvTDkS9HPhbgHoGosFnXkmMASMj+5eEMmn +Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubmtvava2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 13:57:15 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AEDvELm016720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 13:57:14 GMT
Received: from hyd-lablnx450.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 05:57:09 -0800
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <konrad.dybcio@linaro.org>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Subject: [PATCH v2 0/3] iommu/arm-smmu: introduction of ACTLR implementation for Qualcomm SoCs
Date:   Tue, 14 Nov 2023 19:26:51 +0530
Message-ID: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MuRpWg32HSPcaImZL-FbIaTNgIIbirJ0
X-Proofpoint-GUID: MuRpWg32HSPcaImZL-FbIaTNgIIbirJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011
 spamscore=0 mlxlogscore=790 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140107
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

Changes in v2 from v1:
 - Incorporated suggestions on v1 from Dmitry,Konrad,Pratyush.
 - Added defines for ACTLR values.
 - Linked sm8550 implementation structure to corresponding
   compatible string.
 - Repackaged actlr value set implementation to separate function.
 - Fixed indentation errors.
 - Link to v1: https://lore.kernel.org/all/20231103215124.1095-1-quic_bibekkum@quicinc.com/

Changes in v1 from RFC:
 - Incorporated suggestion form Robin on RFC.
 - Moved the actlr data table into driver, instead of maintaining
   it inside soc specific DT and piggybacking on exisiting iommus
   property (iommu = <SID, MASK, ACTLR>) to set this value during
   smmu probe.
 - Link to RFC: //lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com/

Bibek Kumar Patro (3):
  iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
  iommu/arm-smmu: add ACTLR data and support for SM8550
  iommu/arm-smmu: re-enable context caching in smmu reset operation

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 156 ++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c      |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |   5 +
 4 files changed, 159 insertions(+), 9 deletions(-)

--
2.17.1

