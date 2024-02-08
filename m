Return-Path: <linux-kernel+bounces-58776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF884EB96
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06E51C23A10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292E51033;
	Thu,  8 Feb 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E9+2YeR+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2594F88E;
	Thu,  8 Feb 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430752; cv=none; b=pvLqLwK5Q7Fxm1ruAx4ProxpV61MrX3Pmt1Q9MxdUQloGE+CgFFqbclCWg++9LVnKvNg53cxD8evnTxf2IpEFMP4Uj5AuYUcMvaTSB7PbmANdI1+SUq4z2D5XFHCEktEXAW92BFgl9e3EagqfQPmLDBuf83UTcW/a78ojD4nf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430752; c=relaxed/simple;
	bh=i2K5wwzKKH4qHyTahYdw1v/FpkocLObCm0CQdu9BDw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlI4ZZEINpVfL1L/nJSBaTB47v9H/7RWyIM12NCdjTcoLg8U+hz5VPRduARbYK0IV5+tAbDP6/ftZd8bkYQJzAtfqL5wl5Y4uTY1jKa4p3f2W2hfqwiIGxcG2z6Snu+FRu8GZhUPrLIawGRBO/lUAqGlXySPzsfENZWdiBryCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E9+2YeR+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418Lvt6i001480;
	Thu, 8 Feb 2024 22:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=i9Qno64bQr19ZMf6I9lEq1sW3bxyUMTPOe7FuaTuFQc=;
 b=E9+2YeR+zuyL7JmoW7V9/Y2VJNURn3cbIqhXVjHyeOs+iOrK52eJJ2b87K4izwtxwIew
 eb+gyRakLZiIJckoB82hNNwscUU7TNUXjrviBXhVvrqg5fqg2J3PD/GJVHk4PTkHXknY
 vSEEK8p9VUiuXNmIDvcJ+/KwDDTwm1nxpVB3n1WqbGm0t0VC54M/X/0mXMp8R93xkvSD
 UwH/4s0zqO3u8J5h6KOD6mFmQXKlSKjOgby21HZ7r5fgf85j8f9DfYEl5ynO58IcvoOZ
 Nw++6NPyUzbRjsfeFcNhRce29QjcHZEXzqJEQmTCqgffjVxg7jSR5z8LSBrR9aXfzRv0 UA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w52xqpvsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418Kowir014739;
	Thu, 8 Feb 2024 22:19:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tp7ham-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:03 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ2TR18874632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55BCF58056;
	Thu,  8 Feb 2024 22:19:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D98F85805A;
	Thu,  8 Feb 2024 22:19:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:19:01 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 04/14] crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
Date: Thu,  8 Feb 2024 17:18:30 -0500
Message-ID: <20240208221840.3665874-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208221840.3665874-1-stefanb@linux.ibm.com>
References: <20240208221840.3665874-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mtLPa16PrSk45-7PmPNrKcDlz9u7uMaP
X-Proofpoint-GUID: mtLPa16PrSk45-7PmPNrKcDlz9u7uMaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=668 impostorscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080124

Implement vli_mmod_fast_521 following the description for how to calculate
the modulus for NIST P521 in the NIST publication "Recommendations for
Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
section G.1.4.

NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
arrays fit the larger numbers.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c                  | 31 +++++++++++++++++++++++++++++++
 include/crypto/internal/ecc.h |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index f53fb4d6af99..ea7b28b5e00e 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -902,6 +902,31 @@ static void vli_mmod_fast_384(u64 *result, const u64 *product,
 #undef AND64H
 #undef AND64L
 
+/* Computes result = product % curve_prime
+ * from "Recommendations for Discrete Logarithm-Based Cryptography:
+ *       Elliptic Curve Domain Parameters" G.1.4
+ */
+static void vli_mmod_fast_521(u64 *result, const u64 *product,
+				const u64 *curve_prime, u64 *tmp)
+{
+	const unsigned int ndigits = 9;
+	size_t i;
+
+	for (i = 0; i < ndigits; i++)
+		tmp[i] = product[i];
+	tmp[8] &= 0x1ff;
+
+	vli_set(result, tmp, ndigits);
+
+
+	for (i = 0; i < ndigits; i++)
+		tmp[i] = (product[8 + i] >> 9) | (product[9 + i] << 55);
+	tmp[8] &= 0x1ff;
+
+	vli_mod_add(result, result, tmp, curve_prime, ndigits);
+}
+
+
 /* Computes result = product % curve_prime for different curve_primes.
  *
  * Note that curve_primes are distinguished just by heuristic check and
@@ -941,6 +966,12 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
 	case 6:
 		vli_mmod_fast_384(result, product, curve_prime, tmp);
 		break;
+	case 9:
+		if (!strcmp(curve->name, "nist_521")) {
+			vli_mmod_fast_521(result, product, curve_prime, tmp);
+			break;
+		}
+		fallthrough;
 	default:
 		pr_err_ratelimited("ecc: unsupported digits size!\n");
 		return false;
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index ee6886547fd1..22931f0c7295 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -33,7 +33,7 @@
 #define ECC_CURVE_NIST_P192_DIGITS  3
 #define ECC_CURVE_NIST_P256_DIGITS  4
 #define ECC_CURVE_NIST_P384_DIGITS  6
-#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
+#define ECC_MAX_DIGITS              (576 / 64) /* due to NIST P521 */
 
 #define ECC_DIGITS_TO_BYTES_SHIFT 3
 
-- 
2.43.0


