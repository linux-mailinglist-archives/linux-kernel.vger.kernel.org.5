Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7E57B1170
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjI1EQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjI1EQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:16:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A883114;
        Wed, 27 Sep 2023 21:16:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S3MqXC030058;
        Thu, 28 Sep 2023 04:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6CCI68ah3xAwytDjix9FVL7747Qa3cO2Y4a+ve6LKqU=;
 b=bxFSBGfXly2sog6YXCOpnnwDd26AHN5G3T0OYBo9MNI0NFSWvT7N7Ex8Z+7iOyl/gsRH
 Ga59q8t9fY/Hw/7zx0rF9fUbPCrrruFEL6m1IULKm89fuf33SPbXXw2f/kOc2R9xgjB/
 2S1HqexMM8mbMJJnamsRx5WxTW5b9je4+z1LYlCNDSQrjfOAywt/geSATCNLtfqUpiVl
 vU6MsC3wcktirJjFDfz1nHTXzet8GR+qG6024nShIBhgzfBQovwPKg4u3vsbL6edUg5Y
 +Xkl8pbZpfueE2WtuwIPqwN5A8MUTGRni/pBt+3XYEwK7U0J6QiDPZu+QktMoZ11kasv eA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcmqe9u1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 04:16:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S4GHo2020993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 04:16:17 GMT
Received: from hu-jiangenj-sha.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 27 Sep 2023 21:16:13 -0700
From:   Joey Jiao <quic_jiangenj@quicinc.com>
To:     <kasan-dev@googlegroups.com>
CC:     <quic_jiangenj@quicinc.com>, <quic_likaid@quicinc.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Subject: [PATCH] kasan: Add CONFIG_KASAN_WHITELIST_ONLY mode
Date:   Thu, 28 Sep 2023 09:45:59 +0530
Message-ID: <20230928041600.15982-1-quic_jiangenj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GpCpWJnb2Fhr6tVP9PFPXQ5MhDfiNxpf
X-Proofpoint-GUID: GpCpWJnb2Fhr6tVP9PFPXQ5MhDfiNxpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=849 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fow low memory device, full enabled kasan just not work.
Set KASAN_SANITIZE to n when CONFIG_KASAN_WHITELIST_ONLY=y.
So we can enable kasan for single file or module.

Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
---
 lib/Kconfig.kasan    | 8 ++++++++
 scripts/Makefile.lib | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index fdca89c05745..1cec4e204831 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -153,6 +153,14 @@ config KASAN_INLINE
 
 endchoice
 
+config KASAN_WHITELIST_ONLY
+	bool "Whitelist only KASAN"
+	depends on KASAN && !KASAN_HW_TAGS
+	default n
+	help
+	  Say Y here to only enable KASAN for module or files which has explicitly
+	  set KASAN_SANITIZE:=y which is helpful especially for memory limited devices.
+
 config KASAN_STACK
 	bool "Stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..e8d608ea369c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -158,6 +158,9 @@ endif
 #
 ifeq ($(CONFIG_KASAN),y)
 ifneq ($(CONFIG_KASAN_HW_TAGS),y)
+ifeq ($(CONFIG_KASAN_WHITELIST_ONLY),y)
+KASAN_SANITIZE ?= n
+endif
 _c_flags += $(if $(patsubst n%,, \
 		$(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
 		$(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
-- 
2.38.1

