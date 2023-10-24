Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C67D44A9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjJXBKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJXBKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:10:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B597EDE;
        Mon, 23 Oct 2023 18:10:32 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O0rJMl025073;
        Tue, 24 Oct 2023 01:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Rm3I2nHRtdWaizFG/T8bQDHEIxz6rfk7S5/hRGdCpa8=;
 b=BGSx0EplG4nGFN/8TTT7xOOapLnkMeo6ilAc80uvvU1aUFnp5C6UYaAEQfyG4ve6SRBq
 rpa/GRg+PfcGoFZIIfbC/NdHtzXI4dcKul6oMeFMVTQFtyYwNeuI9Ro+5b2De8ukUfR8
 jiXQyTYv0XRvo0FAF7E9fEal8Fcc3xP1kMzsUZmFP49RjMWbtcwfh4wLPlEaownxm8XU
 jAlppa8pCOPJ46FLSq04xAMbEEo0OjKWlL401Xn5VhhIs6agS/p0zNFKCjGjPTkODl+R
 5NV/9UplEJjldmQg4glkp9x5N/Wu4BoQmmFWm+rhfnM54NmfbdwpfBc+fbWFt2U3+aAY iQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv5ky64n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 01:10:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39O1ADaQ021290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 01:10:13 GMT
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 18:10:08 -0700
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>
CC:     Maria Yu <quic_aiquny@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <ardb@kernel.org>
Subject: [PATCH v2] arm64: module: PLT allowed even !RANDOM_BASE
Date:   Tue, 24 Oct 2023 09:09:54 +0800
Message-ID: <20231024010954.6768-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BQdT7oyjF0HUPTWRE5XC7ujirxcb2trZ
X-Proofpoint-GUID: BQdT7oyjF0HUPTWRE5XC7ujirxcb2trZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_01,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=382 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240009
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module PLT feature can be enabled even when RANDOM_BASE is disabled.
Break BLT entry counts of relocation types will make module plt entry
allocation fail and finally exec format error for even correct and plt
allocation available modules.

Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
---
 arch/arm64/kernel/module-plts.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index bd69a4e7cd60..79200f21e123 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -167,9 +167,6 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
 		switch (ELF64_R_TYPE(rela[i].r_info)) {
 		case R_AARCH64_JUMP26:
 		case R_AARCH64_CALL26:
-			if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
-				break;
-
 			/*
 			 * We only have to consider branch targets that resolve
 			 * to symbols that are defined in a different section.
@@ -269,9 +266,6 @@ static int partition_branch_plt_relas(Elf64_Sym *syms, Elf64_Rela *rela,
 {
 	int i = 0, j = numrels - 1;
 
-	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
-		return 0;
-
 	while (i < j) {
 		if (branch_rela_needs_plt(syms, &rela[i], dstidx))
 			i++;

base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
-- 
2.17.1

