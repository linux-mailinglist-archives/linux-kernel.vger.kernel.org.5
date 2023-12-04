Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78752803DA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjLDS4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjLDS4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:56:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD1ACB;
        Mon,  4 Dec 2023 10:56:42 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4CrX4t030965;
        Mon, 4 Dec 2023 18:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=w2Yu1aSNbKM1bL03R+vVvqY0inOjKskU3INa/KEM2Nc=;
 b=fXDeGUG6ZWX+6isB8oklzt+YY7uk0/dH+DmcAiZTpDpkFbqwR3bllCl5uFZz7Va8oe3Y
 X3Ls24KqT4XcYdqD46+xRloFYzPdpbE+n/SiXvDP9ZFYl3FCNJnMj5KIofJmzBLan4qS
 iUeCVKwC+Okv6ZX27DhP5dVBqwnNYfWQ+5PBx+MPE1PHgJimJDLayKkZQeO5Nyewf0Kk
 FQ3C3R/4t0WvYujnkbzTNIiphXh9k3Mo8PGtQgGTtMLmuEh7sHfyDBqTMPI9EtOJjPb0
 3UOTT9HhIuNUjPncpNEkN1hdDxavOMxI7oTcB9WfjuXowq+c6Jj5KtnwBKZxTMdWjfAt eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqv6750ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 18:54:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4Iso3x026202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 18:54:50 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 10:54:46 -0800
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <dinguyen@kernel.org>,
        <chenhuacai@kernel.org>, <tsbogend@alpha.franken.de>,
        <jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
        <shorne@gmail.com>, <mpe@ellerman.id.au>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [RFC PATCH v2 6/6] of: reserved_mem: Make MAX_RESERVED_REGIONS a config option
Date:   Mon, 4 Dec 2023 10:54:09 -0800
Message-ID: <20231204185409.19615-7-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204185409.19615-1-quic_obabatun@quicinc.com>
References: <20231204185409.19615-1-quic_obabatun@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MYU01A4VatwslHHXknCHGnrM5dBroguV
X-Proofpoint-GUID: MYU01A4VatwslHHXknCHGnrM5dBroguV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=957 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312040146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the value of MAX_RESERVED_REGIONS a config option which can be
modified based on user requirements.
The reserved_mem_array is required during device bootup to store the
information of the dynamically-placed reserved memory regions.
After paging_init(), this information is transferred to another
array which is dynamically allocated and used to store all the reserved
memory regions.

There is currently no obvious way to free the memory for the static
array after its contents are copied over to the dynamically allocated
array, but since the size required for the reserved_mem_array can vary
from device to device depending on the number of dynamically-placed
reserved memory regions, make the size of the array configurable in an
attempt to save some memory.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/Kconfig      | 13 +++++++++++++
 drivers/of/of_private.h |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index da9826accb1b..409ce2527461 100644
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
+	   The reserved_mem_array is used to store information about the dynamically
+	   placed reserved memory regions before we are able to allocate the memory
+	   needed to store all the reserved memory regions defined in the DT.
+	   Because the amount of memory needed initially for this array could vary,
+	   make the size of the reserved_mem_array configurable in an attempt to
+	   save some memory when possible.
+	   if unsure, leave as default value.
+
 endif # OF
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index ef56b2ea185c..278038bce0c0 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -36,7 +36,7 @@ struct alias_prop {
 #endif
 
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
-#define MAX_RESERVED_REGIONS    64
+#define MAX_RESERVED_REGIONS    CONFIG_OF_MAX_RESERVED_REGIONS
 
 extern struct mutex of_mutex;
 extern raw_spinlock_t devtree_lock;
-- 
2.17.1

