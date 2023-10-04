Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F757B7C2B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbjJDJb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242039AbjJDJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:31:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5E511B;
        Wed,  4 Oct 2023 02:31:47 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3945WKvB013360;
        Wed, 4 Oct 2023 09:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=MUhzYguRNuFFCnbPijV6TT9fkbP4WSksbMRqsHfa5KE=;
 b=Z0U4G0+celwPaRj8LN05Z5/4gHdthZuXqXIdpyxXFPG83QRBkrLLkM0r30eVRz7KQc5/
 3umNF53hwWpj2olOVKy4yuIebnRvCY+HxCReLdZUCRT5+Pq1FRF3McEtGhc7QrDawaDM
 GO93Pg95f/qo+7ouA55efwRzXBk6ZiUzBz4XQ3yXrVLCR2SQR52BE7V2hi6L3W+MzNSN
 s6CO9WE2ERsZEXNF66wQCl+kgpLqXN2Xmo+IM6KDnPeJKcix0yAGXLG/ZkwweGI3LeZL
 mjoBboRZMNtX5Lt0gejP/sYbjUXZXYsk2pgn/MEzUQygB6SIsnx/TWEGSGqJcWXIzhvt tQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tghsjtgjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 09:31:33 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3949VWT3023298
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 09:31:33 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 02:31:25 -0700
From:   Nikhil V <quic_nprakash@quicinc.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
CC:     Nikhil V <quic_nprakash@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
Subject: [PATCH 4/4] PM: hibernate: Support to select compression algorithm
Date:   Wed, 4 Oct 2023 15:00:17 +0530
Message-ID: <d01f3c45daa5f91c1453a420e221858dd9a426a3.1696410298.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1696410298.git.quic_nprakash@quicinc.com>
References: <cover.1696410298.git.quic_nprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eEf-C7-HcELNFc3GGS28LbssY0OvEitw
X-Proofpoint-ORIG-GUID: eEf-C7-HcELNFc3GGS28LbssY0OvEitw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the default compression algorithm is selected based on
Kconfig. Introduce a kernel command line parameter "hib_compression" to
override this behaviour.

Different compression algorithms have different characteristics and
hibernation may benefit when it uses any of these algorithms, especially
when a secondary algorithm offers better decompression speeds over a
default algorithm, which in turn reduces hibernation image restore time.

Users can set "hib_compression" command line parameter to override the
default algorithm. Currently LZO and LZ4 are the supported algorithms.
Usage:
    LZO: hib_compression=lzo
    LZ4: hib_compression=lz4

LZO is the default compression algorithm used with hibernation.

Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 kernel/power/hibernate.c                      | 31 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..3f5f3e453db1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1734,6 +1734,12 @@
 				(that will set all pages holding image data
 				during restoration read-only).
 
+	hib_compression= [COMPRESSION ALGORITHM]
+		lzo		Select LZO compression algorithm to compress/decompress
+				hibernation images.
+		lz4		Select LZ4 compression algorithm to compress/decompress
+				hibernation images.
+
 	highmem=nn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
 			size of <nn>. This works even on boxes that have no
 			highmem otherwise. This also works to reduce highmem
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 87be8cda9b9b..ccc7a1aaed8d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -742,7 +742,8 @@ int hibernate(void)
 	 * Query for the compression algorithm support if compression is enabled.
 	 */
 	if (!nocompress) {
-		strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
+		if (!hib_comp_algo[0])
+			strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
 		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
 			pr_err("%s compression is not available\n", hib_comp_algo);
 			return -EOPNOTSUPP;
@@ -1416,6 +1417,33 @@ static int __init nohibernate_setup(char *str)
 	return 1;
 }
 
+static const char * const comp_alg_enabled[] = {
+#if IS_ENABLED(CONFIG_CRYPTO_LZO)
+	COMPRESSION_ALGO_LZO,
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_LZ4)
+	COMPRESSION_ALGO_LZ4,
+#endif
+};
+
+static int __init compression_setup(char *str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(comp_alg_enabled); i++) {
+		if (!strcmp(str, comp_alg_enabled[i])) {
+			strscpy(hib_comp_algo, str, sizeof(hib_comp_algo));
+			goto setup_done;
+		}
+	}
+	pr_info("Cannot set specified compressor. Falling back to %s\n",
+		default_compressor);
+	strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
+
+setup_done:
+	return 1;
+}
+
 __setup("noresume", noresume_setup);
 __setup("resume_offset=", resume_offset_setup);
 __setup("resume=", resume_setup);
@@ -1423,3 +1451,4 @@ __setup("hibernate=", hibernate_setup);
 __setup("resumewait", resumewait_setup);
 __setup("resumedelay=", resumedelay_setup);
 __setup("nohibernate", nohibernate_setup);
+__setup("hib_compression=", compression_setup);
-- 
2.17.1

