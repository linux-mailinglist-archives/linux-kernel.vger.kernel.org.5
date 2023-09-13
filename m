Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECD179E076
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjIMHHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbjIMHHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:07:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BFB1738;
        Wed, 13 Sep 2023 00:07:48 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D6LeuN032357;
        Wed, 13 Sep 2023 07:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=AtULoQJOI/orWb1R9vpylxnI/QhZ91XnJHJFIIByYuE=;
 b=fL5qOsInEerQdiU2GacN+7eTN0KXwNz4W65JK9GU9nEK/3tn/ilKxR8K4lYwKJzCzQuA
 SsDtsHvm2whcULY5wyPQYeArhuXl+FpgGMxWZpteJJkG6gRkP8FuWd+Rjuc82619q527
 0c2OuApoRfMB4cJrVcd79CLhXsm9/+3H+Ut1zEwW3HlTmLFmSkPfkZW470MP1qY4slbE
 SliJeGKokGbZyjOHSTyucCR5L5GpnwaPa+Tl/mVDT3HxT5VElcgONDEMwSSGiJB3awIN
 YrnsLnjiMniaDzbG1hiIId+lZE5fjA08VGDXVNIiREHgk9JH6Y0jgKrZnwTN+r+rsGJo KA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y8jrxa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 07:07:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38D77Ufj022743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 07:07:30 GMT
Received: from hyd-lablnx450.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 13 Sep 2023 00:07:23 -0700
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To:     <mani@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_charante@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_pkondeti@quicinc.com>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v5] mtd: rawnand: qcom: Unmap the right resource upon probe failure
Date:   Wed, 13 Sep 2023 12:37:02 +0530
Message-ID: <20230913070702.12707-1-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oiAv9tXSZ13X51HGY9mUgpjxhZ53p84x
X-Proofpoint-GUID: oiAv9tXSZ13X51HGY9mUgpjxhZ53p84x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309130059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently provide the physical address of the DMA region
rather than the output of dma_map_resource() which is obviously wrong.

Fixes: 7330fc505af4 ("mtd: rawnand: qcom: stop using phys_to_dma()")
Cc: stable@vger.kernel.org
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
v5: Incorporated suggestions from Miquel/Mani
    - Added tag to automatically include this patch in stable tree.

v4: Incorporated suggestion from Miquel
    - Modified title and commit description.
    https://lore.kernel.org/all/20230912115903.1007-1-quic_bibekkum@quicinc.com/

v3: Incorporated comments from Miquel
    - Modified the commit message and title as per suggestions.
    https://lore.kernel.org/all/20230912101814.7748-1-quic_bibekkum@quicinc.com/

v2: Incorporated comments from Pavan/Mani.
    https://lore.kernel.org/all/20230911133026.29868-1-quic_bibekkum@quicinc.com/

v1: https://lore.kernel.org/all/20230907092854.11408-1-quic_bibekkum@quicinc.com/

 drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 64499c1b3603..b079605c84d3 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -3444,7 +3444,7 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 err_aon_clk:
 	clk_disable_unprepare(nandc->core_clk);
 err_core_clk:
-	dma_unmap_resource(dev, res->start, resource_size(res),
+	dma_unmap_resource(dev, nandc->base_dma, resource_size(res),
 			   DMA_BIDIRECTIONAL, 0);
 	return ret;
 }
--
2.17.1

