Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDD77A90F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjIUCiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIUCh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:37:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AA8E5;
        Wed, 20 Sep 2023 19:37:51 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38L1iEiM027364;
        Thu, 21 Sep 2023 02:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=DQqgahBrunVeJ2T5ssMsMl2PItK5lsgtV+m/zCZvEWc=;
 b=Yf0s5Xl4rb+JkXVCurM4lZo7q2+DzSezMICBiHZDBOxPq+eTtVAlWDBRkEZJRg3N+wNZ
 7W5OUNR5j2fvSfu6cNg5auX5K3+doxFDRMKGkZoudCPiJl//zv/JqnTz5e5fnkpDugle
 HjZvMDOk8WOZyR5MoUCLv+17p+86RNWmKeP5Z16MaKdhzWvvbsd5xUm4m9mWrGmjEfGn
 KnAS1SakKDcqJ7iR9ddKKSyBN8LiMwKLfV4hza8o4H2dSByoIlXeAuh+sVQG0A7Y0oi1
 bqkuJNKGApv8q49ywfC2VajNC/9U1NhzvJaYLaUkwvQchIVRAsMbsyD8DbGM+a0ENJot XQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7sh3tm1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 02:37:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38L2bjoO032304
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 02:37:45 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 20 Sep 2023 19:37:44 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Wed, 20 Sep 2023 19:37:32 -0700
Subject: [PATCH v3 3/3] soc: qcom: rtmfs: Handle reserved-memory allocation
 issues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230920-rmtfs-mem-guard-pages-v3-3-305b37219b78@quicinc.com>
References: <20230920-rmtfs-mem-guard-pages-v3-0-305b37219b78@quicinc.com>
In-Reply-To: <20230920-rmtfs-mem-guard-pages-v3-0-305b37219b78@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695263863; l=904;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=7jXz3rP8GNqMZsIHoKFFl+IwJpRuFh8oza0b3my6eAs=;
 b=HKuicCpF2ZYWAOR1HrVl0YJXuad3HGWt7ibs2VpT9C5bBFQEyFdqqVtLO8Syh8KZAFV74UbMKEsR
 XyGqjYLPCu8RK2914hN+iMYZGeH7+mcvoAy4fs/i3axKoxxZAyF9
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -XxDpDD5KCEqZ4iGvMDNfxJd37mWn0Jj
X-Proofpoint-GUID: -XxDpDD5KCEqZ4iGvMDNfxJd37mWn0Jj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_14,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=737
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the even that Linux failed to allocate the reserved memory range
specified in the DeviceTree, the size of the reserved_mem will be 0,
which results in a oops when memory remapping is attempted.

Detect this and report that the memory region was not found instead.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/rmtfs_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 83bba9321e72..13823abd85c2 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -180,7 +180,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 	int ret, i;
 
 	rmem = of_reserved_mem_lookup(node);
-	if (!rmem) {
+	if (!rmem || !rmem->size) {
 		dev_err(&pdev->dev, "failed to acquire memory region\n");
 		return -EINVAL;
 	}

-- 
2.25.1

