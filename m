Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5392E7D2EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjJWJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjJWJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:43:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F272A4;
        Mon, 23 Oct 2023 02:43:40 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7Sl96004979;
        Mon, 23 Oct 2023 09:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=qX2IpiVetfNrVJqIeQTFFJqLBVuxvBnZSADd9eG8WYE=;
 b=W7GrQYWrK7kdGTOeprjlOLQGwZHbnIPvtpTYkXMJ5fr1y1n7oGSyki+YupEIqK4GyOj4
 4O4ATlUyPjLdSHoevXecwF8eEcj+zlmvf3tPEVuqxWmnR8DL6U2bidKsTmlT2wEcmdni
 Gf26eFuHxF0jdPIqB91i7KwEUXhhltuLzOv/FahUBmnYzi+/SM/R1R3356RmFwyEmJ05
 U4h+GpAWJoC4ad1DBuR9fh3YhZuWnStzeG8XqLnC+5tmFb5tLR6hBn2232uujm5eAh7b
 CYpqIlcxwGTrgmilABchXogqbvdoA2svpDgzAEKjF7TIpZo6WDIBvV2SVavxf0lIGFB1 iA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv5ndupap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:43:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N9hRh6013417
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:43:27 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 02:43:24 -0700
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Mon, 23 Oct 2023 15:13:06 +0530
Subject: [PATCH] bus: mhi: host: Add alignment check for event ring read
 pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231023-alignment_check-v1-1-2ca5716d5c15@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACtANmUC/x2MWwqAIBAAryL7neCjPuoqESHbWktloRGBdPekz
 xmYyZAoMiXoRIZINyc+QgFdCcDFhZkkT4XBKGO10la6jeewU7hGXAhXiUX6RrWTqR2U6ozk+fm
 P/fC+HwxYO+FhAAAA
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698054204; l=1344;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=07vhrQIHUHsNMbpycpffRwOJ06Rlyx3FlRgHXf2kqMM=;
 b=VVkOs1tRmVi0Mknh7IuNBSLQsMLHWqRd0EnFDT3RqhNgi0YspG+Rd+FKnCeuhUjMmUkchFJG6
 MJHfvo5ZEdTBhweh8x9izTlJNCwwFRuzAUduJM5ORFhSS+eKEapJiPT
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EawWRLqZJI-lZF3c_1622c3Ev9i5ErU7
X-Proofpoint-ORIG-GUID: EawWRLqZJI-lZF3c_1622c3Ev9i5ErU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=847 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though we do check the event ring read pointer by "is_valid_ring_ptr"
to make sure it is in the buffer range, but there is another risk the
pointer may be not aligned.  Since we are expecting event ring elements
are 128 bits(struct mhi_tre) aligned, an unaligned read pointer could lead
to multiple issues like DoS or ring buffer memory corruption.

So add a alignment check for event ring read pointer.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/bus/mhi/host/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 499590437e9b..c907bbb67fb2 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -268,7 +268,7 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
 
 static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
 {
-	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
+	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len && addr % 16 == 0;
 }
 
 int mhi_destroy_device(struct device *dev, void *data)

---
base-commit: 71e68e182e382e951d6248bccc3c960dcec5a718
change-id: 20231013-alignment_check-c013f509d24a

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>

