Return-Path: <linux-kernel+bounces-33085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72053836443
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188012892D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA8D3D3B9;
	Mon, 22 Jan 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fZPEOq2E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4E3D57C;
	Mon, 22 Jan 2024 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929418; cv=none; b=mBwbMMZwaoIzc7A/FCtyIOgo42fPwbxcGVJWCWHSSn/1vKgF5VD0b7C6ZSGoTYLdfdZGr8UwhxkvvuWLzDJV9CeNH0uWBTR3LLysuxlAK96U+TGyYaTFX8QznzVSMeL16+ZMCshWeq4VxMkZdnWLqvuaKpp4piAvG14eRaZEaTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929418; c=relaxed/simple;
	bh=mzal3D5t8xPYi8YMehEc7GD2hfDFDozMDS7SkE/s4d8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWRz1bdHN5JNkrcFl4tDOljiHfUOiCxxYVexU1K42rHt9QOHb2k4wW811Q10lTQ+EyiYtt950XpqDSR9GhYEbSMgobadMY70cZY5gAhwk6pyqnLItXuF3MFbNPU4ZGtqFjELe/8oGucyYsSEVk+SrYOBaOtSC78hfYIICc5mvDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fZPEOq2E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M7N9sN000881;
	Mon, 22 Jan 2024 13:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=YabyEjupAc5T0MWsc3lv
	nf6oWqMIVj5UD+cMnkaDxrU=; b=fZPEOq2Ee3HsE1kRJ6b91PsKSeVGfHeOZgkn
	08ABwyAPXFuqGiWrMe/ewGX3tUqb2fqnrrvgXuUwcw/UihG9/g2Mha0vTFUmnViT
	ZbZsEaOS7c9O+IhgyiGC6C3hYuaI4R/5CDy8CFsrNeZew3Ujtvgz/lqRVJUSpDpD
	1Td3MhgF+6N1xTdzqRV8+oug7FOhjYVUHbh73rowzYgdrFQ/w8xd6agP9/jmixHz
	RH3p5oa4drUJprKBUxAWzMNXpNxX2MCP12RfvPWkm3Hrqd7r6ZDYbJ6v1FhZxiau
	RPjb7lVlYmAFqG7V0/DVuDkXZ8CC2+DEdipZTOSRy9if8CrObg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsknn0x38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 13:16:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MDGfU8023582
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 13:16:41 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 05:16:35 -0800
From: Nikhil V <quic_nprakash@quicinc.com>
To: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC: Nikhil V <quic_nprakash@quicinc.com>,
        "Paul E. McKenney"
	<paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Yan-Jie Wang
	<yanjiewtw@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kprasan@quicinc.com>,
        <quic_mpilaniy@quicinc.com>, <quic_shrekk@quicinc.com>,
        <mpleshivenkov@google.com>, <ericyin@google.com>
Subject: [PATCH v3 4/4] PM: hibernate: Support to select compression algorithm
Date: Mon, 22 Jan 2024 18:45:28 +0530
Message-ID: <b31fc68f82722246c888e136074bf24aeae1b3b2.1705927916.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1705927916.git.quic_nprakash@quicinc.com>
References: <cover.1705927916.git.quic_nprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -Xw-HTxAMUsrt9j1U_A5NhjK2UI2xK8z
X-Proofpoint-ORIG-GUID: -Xw-HTxAMUsrt9j1U_A5NhjK2UI2xK8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220093

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
index 31b3a25680d0..22255bd9a4e3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1748,6 +1748,12 @@
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
index 219191d6d0e8..75002fb3ad42 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -748,7 +748,8 @@ int hibernate(void)
 	 * Query for the compression algorithm support if compression is enabled.
 	 */
 	if (!nocompress) {
-		strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
+		if (!hib_comp_algo[0])
+			strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
 		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
 			pr_err("%s compression is not available\n", hib_comp_algo);
 			return -EOPNOTSUPP;
@@ -1422,6 +1423,33 @@ static int __init nohibernate_setup(char *str)
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
@@ -1429,3 +1457,4 @@ __setup("hibernate=", hibernate_setup);
 __setup("resumewait", resumewait_setup);
 __setup("resumedelay=", resumedelay_setup);
 __setup("nohibernate", nohibernate_setup);
+__setup("hib_compression=", compression_setup);
-- 
2.17.1


