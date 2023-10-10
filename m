Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9DD7C00B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjJJPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjJJPuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:50:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75582AC;
        Tue, 10 Oct 2023 08:50:13 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AEKSm1009846;
        Tue, 10 Oct 2023 15:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=uDzM6PKK+KnpqEZrVwvTN0RCuoyw6wDOip0JbtQYE0Q=;
 b=mOCVW13Ec97dZGrmOL1P1UZwVUT1LU/C82uwT88NSUR1K0vd+tmwEhuSNatPOCtMWwHN
 yP96aXMkt9ckyOBAf2JLjo445mqZRw6kMvqUDS0jAk8RDmJNDcAPVCUo+DMGTvKt1soJ
 YVmJneqeFbyhtPnpcWkGC+dg4XE4Rf6kt0FhqN9JgUdCmJohasp95Nb9UuHI8YqB9VDP
 OHUquDycOUd9LyV3LPodC49X4M91BPOCbFDjbTgd9NerBDwnIebvg6dz5ooc3hJfKlxE
 Hkg5FaKMNuLafdyTZxwbVWNbCT4mMorO6i5PdN6ZwyDjyKWnrfORi4vJI+tjX11yLRpq Nw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tn3s18txq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 15:49:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39AFnn2V025400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 15:49:52 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 10 Oct 2023 08:49:44 -0700
From:   Maramaina Naresh <quic_mnaresh@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>
Subject: [PATCH V1 0/4] Add per-cpu PM QoS support for QCOM UFS
Date:   Tue, 10 Oct 2023 21:19:03 +0530
Message-ID: <1696952947-18062-1-git-send-email-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ez6zKbQ3c6LUNUBZfgEZI2BaXGocufw7
X-Proofpoint-GUID: ez6zKbQ3c6LUNUBZfgEZI2BaXGocufw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_11,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=831 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add per-cpu PM QoS support for ufs. This improves random io performance
by 20% for ufs.

tiotest benchmark tool io performance results on sm8550 platform:

1. Without PM QoS support
	Type (Speed in)    | Average of 6 iterations
	Random Write(IPOS) | 32201
	Random Read(IPOS)  | 32201

2. With PM QoS support
	Type (Speed in)    | Average of 6 iterations
	Random Write(IPOS) | 40833.5
	Random Read(IPOS)  | 40833.5
(Improvement % with PM QoS = ~20%).

Maramaina Naresh (4):
  dt-bindings: ufs: qcom: Add qos property
  ufs: ufs-qcom: Add per-cpu PM QoS support for ufs
  ufs: ufs-qcom: Add per-cpu PM QoS vote support for ufs
  arm64: dts: qcom: sm8550: Add per-cpu PM QoS support for ufs

 .../devicetree/bindings/ufs/qcom,ufs.yaml          |  16 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |   9 +
 drivers/ufs/host/ufs-qcom.c                        | 340 ++++++++++++++++++++-
 drivers/ufs/host/ufs-qcom.h                        |  37 +++
 4 files changed, 401 insertions(+), 1 deletion(-)

-- 
2.7.4

