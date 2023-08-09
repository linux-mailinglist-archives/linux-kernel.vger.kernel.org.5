Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93995776067
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjHINRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHINRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:17:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B945128
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:17:10 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379CH6jf003576;
        Wed, 9 Aug 2023 13:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=wqiKosW8sF+2lO6oeFYvAFaiESETnfkgoeH2ctKPazA=;
 b=GVyMCY3DVRLmWcqV9THB8vNZWWTJEhfNJj+3cftvXKzR2toh4QioDIYJZ/TXCeVDWk39
 Z/Gb7ujyn+0HgHu75yLx0ArUlSzFRN7HNP8wqVG4fbwstNzGu1OY+p09GaDH+TYfKm8u
 rxvXELiPmbquBnWCdAUZ+o60R6Uhkk6U+8Y98wfreKqHZ2yWmpYEJVSrvRFKP8ICwxMY
 tX9B2LyVBEHd+uOExjzaz+ECGDr98CPKcZ1BtMhNsSzUpdeHOFDB9GDNtXlC45E8LMCa
 43g4j9nYrDD/31joLvvSIlIMC1n0wYFlV6zimp5mznPJbjirL2AVnYsiXmeBXyESPHEq hg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc0051epq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 13:17:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379DH0s5025420
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 13:17:00 GMT
Received: from hyd-lablnx450.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 06:16:58 -0700
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_charante@quicinc.com>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Subject: [PATCH v2] cma: introduce CMA_ALLOC_DEBUG config
Date:   Wed, 9 Aug 2023 18:46:40 +0530
Message-ID: <20230809131640.18791-1-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MgpH7odurn7fcTmOimzhzs8mDBhptik9
X-Proofpoint-GUID: MgpH7odurn7fcTmOimzhzs8mDBhptik9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1011
 mlxlogscore=975 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090117
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently enabling CONFIG_CMA_DEBUG enables DEBUG preprocessor macro.
If DEBUG is defined, it's equivalent to a printk with KERN_DEBUG loglevel
flooding the dmesg buffer with pr_debug prints from mm/cma driver and from
included files as well. This results in excessive amount of CMA logging and
also might distract the debug teams with unrelated KERN_DEBUG prints.One of
the ways engineers currently tackle this problem is by passing loglevel=N
though commandline to suppress KERN_DEBUG messages. This approach can
sometimes become tiresome due to its repetitive nature.
This patch proposes an alternative approach by introducing a simple new
config CONFIG_CMA_ALLOC_DEBUG which only shows the cma bit allocation
status in case of cma failure and do not enable DEBUG preprocessor macro
from CONFIG_CMA_DEBUG avoiding excessive CMA logging from pr_debug.
Engineers and tech teams seeking only for bitmap status in case of cma
failure can use this simple config instead of worrying about changing
the loglevel or trying other similar workarounds.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 mm/Kconfig | 11 +++++++++++
 mm/cma.c   |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 09130434e30d..ad2a20576a65 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -891,12 +891,23 @@ config CMA
 config CMA_DEBUG
 	bool "CMA debug messages (DEVELOPMENT)"
 	depends on DEBUG_KERNEL && CMA
+	select CMA_ALLOC_DEBUG
 	help
 	  Turns on debug messages in CMA.  This produces KERN_DEBUG
 	  messages for every CMA call as well as various messages while
 	  processing calls such as dma_alloc_from_contiguous().
 	  This option does not affect warning and error messages.

+config CMA_ALLOC_DEBUG
+	bool "CMA bitmap status upon failure"
+	depends on CMA
+	help
+	  Turns on bitmap dump in case of cma failures. This prints
+	  current status of CMA bit upon failures and will appear
+	  when cma_alloc() return no_warn argument as false and won't
+	  flood the dmesg buffer with unrelated KERN_DEBUG prints. No
+	  need to explicitly enable this if CMA_DEBUG is enabled.
+
 config CMA_DEBUGFS
 	bool "CMA debugfs interface"
 	depends on CMA && DEBUG_FS
diff --git a/mm/cma.c b/mm/cma.c
index a4cfe995e11e..0ead392769b3 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -383,7 +383,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	return ret;
 }

-#ifdef CONFIG_CMA_DEBUG
+#ifdef CONFIG_CMA_ALLOC_DEBUG
 static void cma_debug_show_areas(struct cma *cma)
 {
 	unsigned long next_zero_bit, next_set_bit, nr_zero;
--
2.17.1

