Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9FE7D0210
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbjJSStg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjJSStd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:49:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95B712A;
        Thu, 19 Oct 2023 11:49:31 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JHLgmO009932;
        Thu, 19 Oct 2023 18:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SVRe8/19wuG8oL4B6r8uT37Q9MdZfQVs0NdeZstSINM=;
 b=ERrh52VT+P5NC8QwmvzXZLv3tvU2NH7tZur+IrGIHnZ14uzI3jHKX58xGMkqOusmdKKM
 n4dnHBSDCaodXR8BrerEsOxnFGrxt+AcPUnGBBEQEZDLqSXS9cvprIaRj+2ethkUyoIe
 NJs94CrWMbefqWj0IUArM0xHWcwJKXpH2frtvJvOCwRBsuoTwNsN+UsIw0F8YpN8GyjO
 m3iTDjWqTU2kDiI7eFsCXaimSe5NK8OofyAMhJAcBPLYUKzbybWNuW5meFuHC6T9uUuc
 CZEsz2EaTayv6we2GqrMttmusu/uoRc5S1B8y6ofq21qFGaUnoKcO85i28/AKh41guom xQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tu67jrnng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 18:49:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39JInNXW004105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 18:49:23 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 11:49:20 -0700
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [RFC PATCH 3/3] of: reserved_mem: Make MAX_RESERVED_REGIONS a config option
Date:   Thu, 19 Oct 2023 11:48:25 -0700
Message-ID: <20231019184825.9712-4-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231019184825.9712-1-quic_obabatun@quicinc.com>
References: <20231019184825.9712-1-quic_obabatun@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 73rSnwFUhcqArvYxVm75W5hE4LFPPWHw
X-Proofpoint-ORIG-GUID: 73rSnwFUhcqArvYxVm75W5hE4LFPPWHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=748 impostorscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to make the size of reserved_mem_array a config option which
can be modified based on user requirements.
The reserved_mem_array is required during device bootup to store the
information of the reserved memory regions that need to be dynamically
allocated. After some time, this information is transferred to another
array which is used to store all reserved memory regions, after which
the reserved_mem_array will no longer be needed.

Since the size required for the reserved_mem_array can vary and there
is currently no way to free the memory afterwards, make the size of the
array configurable in an attempt to save some memory.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/Kconfig           | 13 +++++++++++++
 drivers/of/of_reserved_mem.c |  9 ++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index da9826accb1b..3cb2ec4993b5 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -102,4 +102,17 @@ config OF_OVERLAY
 config OF_NUMA
 	bool
 
+config OF_MAX_RESERVED_REGIONS
+	int "OF resvered_mem array size"
+	default "64"
+	range 1 64
+	help
+	  The reserved_mem_array is used to store information about the dynamically
+	  placed reserved memory regions before we are able to allocate the memory
+	  needed to store all the reserved memory regions defined in the DT.
+	  Because the amount of memory needed initially for this array could vary,
+	  make the size of the reserved_mem_array configurable in an attempt to
+	  save some memory when possible.
+	  if unsure, leave as default value.
+
 endif # OF
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 203828ca118e..f408dce762e1 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -26,11 +26,10 @@
 
 #include "of_private.h"
 
-#define MAX_RESERVED_REGIONS	64
-static struct reserved_mem reserved_mem_array[MAX_RESERVED_REGIONS];
-static struct reserved_mem *reserved_mem __refdata = reserved_mem_array;
+static struct reserved_mem reserved_mem_array[CONFIG_OF_MAX_RESERVED_REGIONS];
+static struct reserved_mem *reserved_mem = reserved_mem_array;
 
-static int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
+static int total_reserved_mem_cnt = CONFIG_OF_MAX_RESERVED_REGIONS;
 static int reserved_mem_count;
 
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
@@ -93,7 +92,7 @@ static int alloc_reserved_mem_array(void)
 
 overlow_err:
 	memblock_free(new_array, alloc_size);
-	total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
+	total_reserved_mem_cnt = CONFIG_OF_MAX_RESERVED_REGIONS;
 	return -1;
 }
 
-- 
2.17.1

