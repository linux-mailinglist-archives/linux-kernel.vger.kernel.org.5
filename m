Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F859797372
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbjIGPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjIGPXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AB3CC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:22:49 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38780LF5017722;
        Thu, 7 Sep 2023 08:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=0b/Ncc9rDmXZwstAdB+GapOrVFd5IDTpsgog17FZjn8=;
 b=E7JjmbuQc6XUJDK0Nm8SVh6a+AnHMFAefyikW4CRhKUMGvswY04sWuCZ4q6rY4ceL/Wq
 w3ubTZqz1VHWAgThkQ1iD9wbQZU/2ikzv9y0EOOAcek+s+sKbJmXvBlpz1E0Misj+DD5
 bjjWmg8CXN0USgIXSXFaMvsrSsvJBCEL7pihgaY6GB0kA7rFbeiCuK8cozBiP0xAhL65
 W2MwcC+yTC9hUzJ0DfS4EuHlGzhpsod6TN+2dSTxuMATqxYynAa9efoumUae1a6oCyZ0
 K1lIWXrn39ic/Fn6wheeRS3KxHPPHLoIH/rDjTq49+7auiL57E/g0l/xJOu2H2+VPYLH ng== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxwes1fca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 08:04:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38784Drh028944
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 08:04:13 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 01:04:10 -0700
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     Zhenhua Huang <quic_zhenhuah@quicinc.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_tingweiz@quicinc.com>
Subject: [PATCH] Revert "dma-contiguous: check for memory region overlap"
Date:   Thu, 7 Sep 2023 16:03:56 +0800
Message-ID: <1694073836-5125-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m7cNjHTLLMLwmkPeAVp6f1rfxRIXNZw0
X-Proofpoint-GUID: m7cNjHTLLMLwmkPeAVp6f1rfxRIXNZw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=882
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3fa6456ebe13adab3ba1817c8e515a5b88f95dce.

The Commit broke the CMA region creation through DT on arm64,
as showed below logs with "memblock=debug":
[    0.000000] memblock_phys_alloc_range: 41943040 bytes align=0x200000
from=0x0000000000000000 max_addr=0x00000000ffffffff
early_init_dt_alloc_reserved_memory_arch+0x34/0xa0
[    0.000000] memblock_reserve: [0x00000000fd600000-0x00000000ffdfffff]
memblock_alloc_range_nid+0xc0/0x19c
[    0.000000] Reserved memory: overlap with other memblock reserved region

From call flow, region we defined in DT was always reserved before entering
into rmem_cma_setup. Also, rmem_cma_setup has one routine cma_init_reserved_mem
to ensure the region was reserved. Checking the region not reserved here seems
not correct.

early_init_fdt_scan_reserved_mem:
    fdt_scan_reserved_mem
        __reserved_mem_reserve_reg
		early_init_dt_reserve_memory
			memblock_reserve(using “reg” prop case)
        fdt_init_reserved_mem
		__reserved_mem_alloc_size
			*early_init_dt_alloc_reserved_memory_arch*
				memblock_reserve(dynamic alloc case)
        __reserved_mem_init_node
		rmem_cma_setup(region overlap check here should always fail)

Example DT can be used to reproduce issue:

    dump_mem: mem_dump_region {
            compatible = "shared-dma-pool";
            alloc-ranges = <0x0 0x00000000 0x0 0xffffffff>;
            reusable;
            size = <0 0x2800000>;
    };

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 kernel/dma/contiguous.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 88c595e..f005c66 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -473,11 +473,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
-	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
-		pr_info("Reserved memory: overlap with other memblock reserved region\n");
-		return -EBUSY;
-	}
-
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.7.4

