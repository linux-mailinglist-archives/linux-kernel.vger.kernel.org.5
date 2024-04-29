Return-Path: <linux-kernel+bounces-162660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8A58B5EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4971F22F04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA2284A58;
	Mon, 29 Apr 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n4Kjlks1"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952D314A8D;
	Mon, 29 Apr 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407229; cv=none; b=XpNfKqjFLAlgCN78lBrDaQHSAQ/JzZ7RGi0snZo9jfZkIaRWicXDwhaYlxY9OuRHLsL4rZzFxGuOzcYi29mR2D2w0FN5qhVRyf/UH5ZK1+GcY0G0HcEddBQYInaSrnRVha/730SySu67tmAQIqInMWtKAn074u9ClhZ7DdCXWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407229; c=relaxed/simple;
	bh=N4AXQ9Sm3ZMZO5yFRp5NX2KC0ZilNb9dYL3CF2h/4eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTn+FkUY1QtwRN20C21zTX8z/MMs2YBlk/jMYH4eGGPU7Nx2CB0rD++oyMcMUMApLtWyBEI4DbjOi++5UgMG8Pm1jP3RyPfBX167/HUcE8X9u9XDA4wNArp1Gr3m5xCBat6aD1uC897ZMnmOhn4/zelwzlMQdL6GQ+1rUSc3DAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n4Kjlks1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TG1r71003472;
	Mon, 29 Apr 2024 16:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=h4+iE+KbJHd6Gc6j7wA2FWoZzMmC3ovRPKg0l7zryMI=;
 b=n4Kjlks1gytAdTnkrjLPVkDy7aCkfeqwDzojR6qUHF6iapAEjVLR3Qxu4vvKmv5+HeJ2
 jNEYmAbQLM0vopPE1ESJiVT5UotnaMeqjzvBoMN4Q2and1mYe1RNgZu0/yphmlZHPeGP
 Gaw6n2UKNwiwa9CRqbiWSq+PNzadowVreIjCFhL6xiiorievGCV4v5ZDKkbpdlouftiM
 tWy14BZ9zU9KxNm8reTwzij8Gr33T54u0Zr8EiyP5Wq3nLYnC1xnqXGqDCVkQ9OJilvY
 FWD59YDFNxAz7+80fXq8ncLU4BUo608mHFBg35qlhCItZ3pfH01ONxsqo3smy0Nwmhhe Eg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xteqar13n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:13:40 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43TF28OW003036;
	Mon, 29 Apr 2024 16:13:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscpp8714-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:13:38 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43TGDaiN15925780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 16:13:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 657D158062;
	Mon, 29 Apr 2024 16:13:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4CA35805A;
	Mon, 29 Apr 2024 16:13:35 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2024 16:13:35 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, lukas@wunner.de, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2] crypto: ecc - Prevent ecc_digits_from_bytes from reading too many bytes
Date: Mon, 29 Apr 2024 12:13:16 -0400
Message-ID: <20240429161316.3146626-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: arv7NAPhe9CPalAeYXLn5Ttmz0HUse4d
X-Proofpoint-ORIG-GUID: arv7NAPhe9CPalAeYXLn5Ttmz0HUse4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290104

Prevent ecc_digits_from_bytes from reading too many bytes from the input
byte array in case an insufficient number of bytes is provided to fill the
output digit array of ndigits. Therefore, initialize the most significant
digits with 0 to avoid trying to read too many bytes later on. Convert the
function into a regular function since it is getting too big for an inline
function.

If too many bytes are provided on the input byte array the extra bytes
are ignored since the input variable 'ndigits' limits the number of digits
that will be filled.

Fixes: d67c96fb97b5 ("crypto: ecdsa - Convert byte arrays with key coordinates to digits")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---

v2:
 - un-inline function
 - use memset
---
 crypto/ecc.c                  | 22 ++++++++++++++++++++++
 include/crypto/internal/ecc.h | 15 ++-------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index c1d2e884be1e..fe761256e335 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -68,6 +68,28 @@ const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 }
 EXPORT_SYMBOL(ecc_get_curve);
 
+void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
+			   u64 *out, unsigned int ndigits)
+{
+	int diff = ndigits - DIV_ROUND_UP(nbytes, sizeof(u64));
+	unsigned int o = nbytes & 7;
+	__be64 msd = 0;
+
+	/* diff > 0: not enough input bytes: set most significant digits to 0 */
+	if (diff > 0) {
+		ndigits -= diff;
+		memset(&out[ndigits - 1], 0, diff * sizeof(u64));
+	}
+
+	if (o) {
+		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
+		out[--ndigits] = be64_to_cpu(msd);
+		in += o;
+	}
+	ecc_swap_digits(in, out, ndigits);
+}
+EXPORT_SYMBOL(ecc_digits_from_bytes);
+
 static u64 *ecc_alloc_digits_space(unsigned int ndigits)
 {
 	size_t len = ndigits * sizeof(u64);
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 7ca1f463d1ec..f7e75e1e71f3 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -64,19 +64,8 @@ static inline void ecc_swap_digits(const void *in, u64 *out, unsigned int ndigit
  * @out       Output digits array
  * @ndigits:  Number of digits to create from byte array
  */
-static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
-					 u64 *out, unsigned int ndigits)
-{
-	unsigned int o = nbytes & 7;
-	__be64 msd = 0;
-
-	if (o) {
-		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
-		out[--ndigits] = be64_to_cpu(msd);
-		in += o;
-	}
-	ecc_swap_digits(in, out, ndigits);
-}
+void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
+			   u64 *out, unsigned int ndigits);
 
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
-- 
2.43.0


