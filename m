Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA24761780
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjGYLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjGYLs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:48:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C05F10E3;
        Tue, 25 Jul 2023 04:48:25 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PBl73p019214;
        Tue, 25 Jul 2023 11:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=sod3msRdmmhbk+9MCJa7CBZD8q/hqXsIwy8V3MMLdzw=;
 b=N5VoduOydDWrgFNK7hgjfTYyBhlcuM0Q2TWFWsQtLjexPqE79vimJsOwtg9kySALBC3q
 Vi5Zlb+PdX0NK2iwgozXfVnefhhG9cAUU1cMyfsasta9CqwSFXIJBVJ3VtIsMDRd8+TP
 wLZhPF13Epb636I+n/dO5iUm7KvRKhpa5fSdEFyRJq43K3ALWf30jD37+k7LcujO5Qej
 heIXrLXrgrLa5AtdcAXipk3AU58Etor4zUrGLOkATLFgHDu1mZvcecNg6Es33SQ7gUc4
 jm0j6aGqjP/r3fIQWkjkbZp+TJT6BY+z2v4LUu7Aae6vOqoPkd5Sp6guJIx6JRRiej8X Mg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2dqag0bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 11:48:22 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36PBmJ5F008462;
        Tue, 25 Jul 2023 11:48:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s086kv0ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Jul 2023 11:48:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36PBmGgW008439;
        Tue, 25 Jul 2023 11:48:18 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36PBmIwi008452;
        Tue, 25 Jul 2023 11:48:18 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id A4A0A3434; Tue, 25 Jul 2023 17:18:17 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        dan.carpenter@linaro.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 2/4] spi: spi-qcom-qspi: Use GFP_ATOMIC flag while allocating for descriptor
Date:   Tue, 25 Jul 2023 17:18:07 +0530
Message-Id: <1690285689-30233-3-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pG_7Nw6ndLAkMfrzn6JktmmFzHT9TSgt
X-Proofpoint-ORIG-GUID: pG_7Nw6ndLAkMfrzn6JktmmFzHT9TSgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_06,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=692
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250103
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While allocating for DMA descriptor, GFP_KERNEL flag is being used and
this allocation happens within critical section with spinlock acquired.
This generates a static checker warning.

Use GFP_ATOMIC to prevent sleeping; and since this increases chances of
allocation failure, add handling accordingly.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/abc223e8-44af-40bb-a0bd-9865b393f435@moroto.mountain/
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/spi/spi-qcom-qspi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index b995542..b938908 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -308,9 +308,11 @@ static int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, dma_addr_t dma_ptr,
 	dma_addr_t dma_cmd_desc;
 
 	/* allocate for dma cmd descriptor */
-	virt_cmd_desc = dma_pool_alloc(ctrl->dma_cmd_pool, GFP_KERNEL | __GFP_ZERO, &dma_cmd_desc);
-	if (!virt_cmd_desc)
-		return -ENOMEM;
+	virt_cmd_desc = dma_pool_alloc(ctrl->dma_cmd_pool, GFP_ATOMIC | __GFP_ZERO, &dma_cmd_desc);
+	if (!virt_cmd_desc) {
+		dev_warn_once(ctrl->dev, "Couldn't find memory for descriptor\n");
+		return -EAGAIN;
+	}
 
 	ctrl->virt_cmd_desc[ctrl->n_cmd_desc] = virt_cmd_desc;
 	ctrl->dma_cmd_desc[ctrl->n_cmd_desc] = dma_cmd_desc;
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

