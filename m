Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3827C7F0AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjKTD3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjKTD3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:29:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A667194;
        Sun, 19 Nov 2023 19:29:43 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK3CHTS018348;
        Mon, 20 Nov 2023 03:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MXZb06dO0e5VghAyynbrHW/Ridb0Wla0tD7TN/K48VU=;
 b=Ixn1s+IHueCaAZ9vsiRKzv9XnqXnhCuJWVV320N00kpBi4AJvBK1V8GvyK3Atr9NxV2R
 e9XShkuHfcaVioiuLev4OSpBtluwhYsGOqDqxBKNbxi76KHuS6ZtPQVVwWQ7hWHZICsP
 SdfMlhE0+ZHvFiahOLFKU+kUhm+vZfTwcVB5dNBtrOREUdBXaeiMzQzrdm/N+5oV5vp+
 ZR66TNmacWXqbd1jsD+irMeN3tzEBCseu2lDe8mS0tQP4OudAaq16Y12zX8Amx9q3dD7
 wDehqtj5ZZvPCYHSpbvij88UcL9IuBX+65/4uzs9MVu38x/yeNQI2bMSPWe32537pGU+ Ow== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uemks2rng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 03:29:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK3TUpr032694
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 03:29:30 GMT
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 19 Nov 2023 19:29:24 -0800
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     Nathan Chancellor <nathan@kernel.org>, <linux@armlinux.org.uk>,
        <ardb@kernel.org>, <mhiramat@kernel.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_lijuang@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 1/1] ARM: kprobes: Explicitly reserve r7 for local variables
Date:   Mon, 20 Nov 2023 11:29:09 +0800
Message-ID: <20231120032909.19186-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nXIc84DIJG67fapBTqJd7EOTyenoPWSf
X-Proofpoint-ORIG-GUID: nXIc84DIJG67fapBTqJd7EOTyenoPWSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_21,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=561 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registers r7 is removed in clobber list, so compiler may choose r7 for
local variables usage, while r7 will be actually updated by the inline asm
code. This caused the runtime behavior wrong.
While those kind of reserved registers cannot be set to clobber list
because of error like "inline asm clobber list contains reserved
registers".
Explicitly reserve r7 by adding attribute no-omit-frame-pointer for this
file, then in T32 asm code r7 is used as a frame pointer and is not
available for use as a general-purpose register.
Note that "no-omit-frame-pointer" will make the code size a little bigger
to store the stack frame pointer.

Fixes: dd12e97f3c72 ("ARM: kprobes: treat R7 as the frame pointer register in Thumb2 builds")
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
Cc: stable@vger.kernel.org
---
 arch/arm/probes/kprobes/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/probes/kprobes/Makefile b/arch/arm/probes/kprobes/Makefile
index 6159010dac4a..b1f21e78950b 100644
--- a/arch/arm/probes/kprobes/Makefile
+++ b/arch/arm/probes/kprobes/Makefile
@@ -8,6 +8,7 @@ test-kprobes-objs		:= test-core.o
 
 ifdef CONFIG_THUMB2_KERNEL
 obj-$(CONFIG_KPROBES)		+= actions-thumb.o checkers-thumb.o
+CFLAGS_actions-thumb.o		+= -fno-omit-frame-pointer
 test-kprobes-objs		+= test-thumb.o
 else
 obj-$(CONFIG_KPROBES)		+= actions-arm.o checkers-arm.o

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.17.1

