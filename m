Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DDB7DCA32
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjJaJw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjJaJwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:52:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB91BE6;
        Tue, 31 Oct 2023 02:51:29 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V7wkMj028089;
        Tue, 31 Oct 2023 09:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=VZc/kJkcyNEc1ap5ZwAxTxqFo3J/twOnXlrlLnHZTkc=;
 b=SKGHRn8EqYOhHgq4xradG3SlJPZnFwiFYY/0e3C+KzKRsaf1H6aTVmNanJDOpd2NE1Ff
 FON3qK6dSpzexR8BfcVPnsTNMsu4IK2rzX8ZXIQUhFkNCc3clnQ4WOCLSG897Adto34z
 jtTxTjDoAUNx7MEZHx8a9D8K7RIIXzNTlLfUxTjupjCPYCR3JdzlLJFSIVsiuAmFF5ft
 5JQy7FM1F+mFVnFw//MgxQ/8MqZZo6LAi95gHysS62wILFpLgRWR6mLXQ9sRcmUFR0av
 FnZ5je0OkIB42oio0tfCw0VJYxH9pOJYpwX8uPJm8vWSI9ojMR6PXHv/pZWD61nwLa7/ Ow== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2mcyhak1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 09:51:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V9pHm1013616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 09:51:17 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 31 Oct 2023 02:51:14 -0700
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Tue, 31 Oct 2023 15:21:05 +0530
Subject: [PATCH v2] bus: mhi: host: Add alignment check for event ring read
 pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAnOQGUC/2WNQQ6CMBBFr0JmbQ1TrEZX3sMQ0wwDnSgttkg0h
 LtbiTuX7yX//RkSR+EEp2KGyJMkCT6D3hRAzvqOlTSZQZe6whIrZe/S+Z79eCXHdFOUZWvKY6N
 3FvJqiNzKay1e6sxO0hjiez2Y8Gt/Lf3fmlCh0mTNAfeNITTnx1NIPG0p9FAvy/IB7/PwarAAA
 AA=
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>, <stable@vger.kernel.org>,
        "Krishna chaitanya chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698745873; l=1707;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=CKEOMvvyozRoZJfJBJGMpin1Es4JoOpllSbaQzNdyaA=;
 b=I3YG/fvd5//ELBnF7NLqYsUMv3KKz6HRcUSdSXrcwrrLdVF1KPmpfaZJcbkY1wEadNSzjU5JH
 xi5tiqZMbpmAIHHHqGbPTM0RqWxpfxBQHYCbTfeMMQcBrlCkbyMyoRb
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0GT6pYVTT8ovCuTo1Dvgl4jC-MoTOvYY
X-Proofpoint-ORIG-GUID: 0GT6pYVTT8ovCuTo1Dvgl4jC-MoTOvYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though we do check the event ring read pointer by "is_valid_ring_ptr"
to make sure it is in the buffer range, but there is another risk the
pointer may be not aligned.  Since we are expecting event ring elements
are 128 bits(struct mhi_ring_element) aligned, an unaligned read pointer
could lead to multiple issues like DoS or ring buffer memory corruption.

So add a alignment check for event ring read pointer.

Fixes: ec32332df764 ("bus: mhi: core: Sanity check values from remote device before use")
cc: stable@vger.kernel.org
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes in v2:
- Change the modulus operation to bit-wise & operation as suggested by Jeff.
- Link to v1: https://lore.kernel.org/r/20231023-alignment_check-v1-1-2ca5716d5c15@quicinc.com
---
 drivers/bus/mhi/host/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 499590437e9b..e765c16a99d1 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -268,7 +268,8 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
 
 static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
 {
-	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
+	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len &&
+			!(addr & (sizeof(struct mhi_ring_element) - 1));
 }
 
 int mhi_destroy_device(struct device *dev, void *data)

---
base-commit: 71e68e182e382e951d6248bccc3c960dcec5a718
change-id: 20231013-alignment_check-c013f509d24a

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>

