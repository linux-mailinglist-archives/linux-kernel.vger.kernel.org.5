Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB607CF462
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbjJSJr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345170AbjJSJr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:47:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FEC12D;
        Thu, 19 Oct 2023 02:47:55 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J7utYK027608;
        Thu, 19 Oct 2023 09:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=a58jiXbH+2/LaFJXKU2YOMr8Zly5NjUTQPykbnM9zGk=;
 b=MQpupaCD2A2qhiRVz7/1SOdSGreSbAyzf6lEgn5MGgGAjfRXTpwwgqpKHTbIDZnMIAPf
 9IRpBDxNBGEfrnd9fK4Xcf73brrAPWZeghBvZ8u8wisvuaoeMenIqeT+WgDWSGHbkeJe
 5ILNgJGJP3r5gkbHfb/FGG5dcWAi37GfsfFx3OAAZ3jfGnjGCZu3pofyDzGsegCf5yoK
 EBEECAeZ94UAexwl3LZSodZCGl7F1rpuI/GbWYW3NjZYtTdv/yIRxOfQtFHuTgOUQvep
 3HNsXgeN0LD70LX5YUfLsJJA9HNGdzHry0OH1Ur2QrdOJ/i8mbR1LSw2GIC8kskZEh/v tw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttfeuaebu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 09:47:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J9lfNI012415
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 09:47:41 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 02:47:34 -0700
From:   Nikhil V <quic_nprakash@quicinc.com>
To:     Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
CC:     Nikhil V <quic_nprakash@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
Subject: [PATCH v2 3/4] PM: hibernate: Add support for LZ4 compression for hibernation
Date:   Thu, 19 Oct 2023 15:16:36 +0530
Message-ID: <a9adad63abd6c17bc7fedb51510402c8017462fb.1697707408.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1697707408.git.quic_nprakash@quicinc.com>
References: <cover.1697707408.git.quic_nprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TAD2EwRo_h7obZJr7dQVpXzWmrNub9Y-
X-Proofpoint-GUID: TAD2EwRo_h7obZJr7dQVpXzWmrNub9Y-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_06,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the support for LZ4 compression to be used with hibernation.
The main idea is that different compression algorithms
have different characteristics and hibernation may benefit when it uses
any of these algorithms: a default algorithm, having higher
compression rate but is slower(compression/decompression) and a
secondary algorithm, that is faster(compression/decompression) but has
lower compression rate.

LZ4 algorithm has better decompression speeds over LZO. This reduces
the hibernation image restore time.
As per test results:
                                    LZO             LZ4
Size before Compression(bytes)   682696704       682393600
Size after Compression(bytes)    146502402       155993547
Decompression Rate               335.02 MB/s     501.05 MB/s
Restore time                       4.4s             3.8s

LZO is the default compression algorithm used for hibernation. Enable
CONFIG_HIBERNATION_COMP_LZ4 to set the default compressor as LZ4.

Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
---
 kernel/power/Kconfig     |  5 +++++
 kernel/power/hibernate.c | 25 ++++++++++++++++++++++---
 kernel/power/power.h     | 14 ++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index d4167159bae8..afce8130d8b9 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -101,11 +101,16 @@ config HIBERNATION_COMP_LZO
 	bool "lzo"
 	depends on CRYPTO_LZO
 
+config HIBERNATION_COMP_LZ4
+	bool "lz4"
+	depends on CRYPTO_LZ4
+
 endchoice
 
 config HIBERNATION_DEF_COMP
 	string
 	default "lzo" if HIBERNATION_COMP_LZO
+	default "lz4" if HIBERNATION_COMP_LZ4
 	help
 	  Default compressor to be used for hibernation.
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index ed9901b75333..87be8cda9b9b 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -721,6 +721,9 @@ static int load_image_and_restore(bool snapshot_test)
 	return error;
 }
 
+#define COMPRESSION_ALGO_LZO "lzo"
+#define COMPRESSION_ALGO_LZ4 "lz4"
+
 /**
  * hibernate - Carry out system hibernation, including saving the image.
  */
@@ -780,11 +783,24 @@ int hibernate(void)
 
 		if (hibernation_mode == HIBERNATION_PLATFORM)
 			flags |= SF_PLATFORM_MODE;
-		if (nocompress)
+		if (nocompress) {
 			flags |= SF_NOCOMPRESS_MODE;
-		else
+		} else {
 		        flags |= SF_CRC32_MODE;
 
+			/*
+			 * By default, LZO compression is enabled. Use SF_COMPRESSION_ALG_LZ4
+			 * to override this behaviour and use LZ4.
+			 *
+			 * Refer kernel/power/power.h for more details
+			 */
+
+			if (!strcmp(hib_comp_algo, COMPRESSION_ALGO_LZ4))
+				flags |= SF_COMPRESSION_ALG_LZ4;
+			else
+				flags |= SF_COMPRESSION_ALG_LZO;
+		}
+
 		pm_pr_dbg("Writing hibernation image.\n");
 		error = swsusp_write(flags);
 		swsusp_free();
@@ -974,7 +990,10 @@ static int software_resume(void)
 	 * the algorithm support.
 	 */
 	if (!(swsusp_header_flags & SF_NOCOMPRESS_MODE)) {
-		strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
+		if (swsusp_header_flags & SF_COMPRESSION_ALG_LZ4)
+			strscpy(hib_comp_algo, COMPRESSION_ALGO_LZ4, sizeof(hib_comp_algo));
+		else
+			strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
 		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
 			pr_err("%s compression is not available\n", hib_comp_algo);
 			error = -EOPNOTSUPP;
diff --git a/kernel/power/power.h b/kernel/power/power.h
index d9bf10d92546..026d40e0972a 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -167,11 +167,25 @@ extern int swsusp_swap_in_use(void);
  * Flags that can be passed from the hibernatig hernel to the "boot" kernel in
  * the image header.
  */
+#define SF_COMPRESSION_ALG_LZO	0 /* dummy, details given  below */
 #define SF_PLATFORM_MODE	1
 #define SF_NOCOMPRESS_MODE	2
 #define SF_CRC32_MODE	        4
 #define SF_HW_SIG		8
 
+/*
+ * Bit to indicate the compression algorithm to be used(for LZ4). The same
+ * could be checked while saving/loading image to/from disk to use the
+ * corresponding algorithms.
+ *
+ * By default, LZO compression is enabled if SF_CRC32_MODE is set. Use
+ * SF_COMPRESSION_ALG_LZ4 to override this behaviour and use LZ4.
+ *
+ * SF_CRC32_MODE, SF_COMPRESSION_ALG_LZO(dummy) -> Compression, LZO
+ * SF_CRC32_MODE, SF_COMPRESSION_ALG_LZ4 -> Compression, LZ4
+ */
+#define SF_COMPRESSION_ALG_LZ4	16
+
 /* kernel/power/hibernate.c */
 int swsusp_check(bool exclusive);
 extern void swsusp_free(void);
-- 
2.17.1

