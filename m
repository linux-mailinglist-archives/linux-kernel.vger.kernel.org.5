Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D3D7A90F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjIUCiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIUCh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:37:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C1EE4;
        Wed, 20 Sep 2023 19:37:51 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38L2ETRR004317;
        Thu, 21 Sep 2023 02:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=xNyb8ZIupF+SY+3e23HEdJol+sE1HfzbPJHdC+LOLQc=;
 b=c0977gJCtvleggYx+qvcdtSAGVtyHyTQSr+MSsbf1PiITHpUh0VZb0YlltFKv50OCIut
 Qifmqn5MDrzjh5nhKVmfcySAjgq/or84mcaBeqpLJMTYAR9MjqPVuIm13Cm13+ZA1WSE
 fdwOki7rf9kSwtQlDpbXQ3UdF7hUpK9WbgDOU1VmcxHz1ERFn8wl8KiytWKIwDG9bJ5Z
 wY6e7ylHiNYn75CJVkXxJmKDWN8JC2yZ7DN6IaPxK6j6zzVHbqR8YAOC12zLQmtYeLsg
 F5GXGdtxSrGDg6xp+WIGrwt7lzXoFbL/nsKYy1C6F+qWol4nzp0BrqbVZW7y8Qg12fJi 0w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t87510k7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 02:37:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38L2biLB024347
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 02:37:44 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 20 Sep 2023 19:37:44 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Wed, 20 Sep 2023 19:37:31 -0700
Subject: [PATCH v3 2/3] soc: qcom: rmtfs: Support discarding guard pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230920-rmtfs-mem-guard-pages-v3-2-305b37219b78@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695263863; l=1416;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=QJw72O7i7ZmFiiHvUXcqqtPd/U+RD0Qw3QJSkoRMKPE=;
 b=FLlS4/QOwYvniUnTEcOE0fU/3G4BWKz6JFzFl+XjuxpIDc1VWL1XxL0X8ZKscc4kuBPi8IznpKwD
 cEkMzMjWBzlD00+KSi2O+Onh2IoD0RnuNPDKSVoxnBRrkQMKTRPM
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T7fwUtA8joYQe3ViHH0tIqzSM7z1ZP9M
X-Proofpoint-ORIG-GUID: T7fwUtA8joYQe3ViHH0tIqzSM7z1ZP9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_14,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 phishscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

In some configurations, the exact placement of the rmtfs shared memory
region isn't so strict. The DeviceTree author can then choose to use the
"size" property and rely on the OS for placement (in combination with
"alloc-ranges", if desired).

But on some platforms the rmtfs memory region may not be allocated
adjacent to regions allocated by other clients. Add support for
discarding the first and last 4k block in the region, if
qcom,use-guard-pages is specified in DeviceTree.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/rmtfs_mem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index f83811f51175..83bba9321e72 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -200,6 +200,15 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 	rmtfs_mem->client_id = client_id;
 	rmtfs_mem->size = rmem->size;
 
+	/*
+	 * If requested, discard the first and last 4k block in order to ensure
+	 * that the rmtfs region isn't adjacent to other protected regions.
+	 */
+	if (of_property_present(node, "qcom,use-guard-pages")) {
+		rmtfs_mem->addr += SZ_4K;
+		rmtfs_mem->size -= 2 * SZ_4K;
+	}
+
 	device_initialize(&rmtfs_mem->dev);
 	rmtfs_mem->dev.parent = &pdev->dev;
 	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;

-- 
2.25.1

