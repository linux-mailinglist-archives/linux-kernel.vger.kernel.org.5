Return-Path: <linux-kernel+bounces-79116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7454861DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7CF2889B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322AA149393;
	Fri, 23 Feb 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CwTrYNnT"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB1143C7C;
	Fri, 23 Feb 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720934; cv=none; b=XLQ5Hifi4XoG4ur6T2rTunn7t0SbNItLrJD+hu3riPUGDa8PiF9YDy09AOLcuVIme6e8Em8is2ifOzKWLk0UORDFYWCRBZ6d/tVWepKufyMn7L+GikbdJuC79U1B6J+bMGVMcTEcN1mWeFaQH0tWt2cA7bnd49W+y+fEzVZK/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720934; c=relaxed/simple;
	bh=FBnzCjcZIbwyWZ5sPWAYV2N+5U9ntGSsKofEExDldOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/I2HDknKLsqeePupvuJ5tmb3+OmhO13eJDkwWefTlPVxiGvxKJG8UIN0wqIUjN3rI95V0UgsQJBLL89R0iVxMaP3D/h+wSSxz1BIaKqKdUV5eh/h1asbSaWdDRlTOYaaKvu8H4RMdjDudzVuVR1y0Jpd+aozgExZ7pRn3S6Ubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CwTrYNnT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NKKGPM020796;
	Fri, 23 Feb 2024 20:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lkJWvWemqT3GohDbcDvoFQIa/ot2xv4+0jDQwX7U5pE=;
 b=CwTrYNnT8meLSZmoyd4NK/0pTJK4VheCGvn4hALCT++ev91uZE7c0IMb7q4O1QteuwQA
 NyUPuYfIjBXh2gkBx3vKDbqf1jDWsOme5sb7EMLQDMiqR+s55/dBgc0nb/yRYTIXUO5d
 wo1+qNTmIQev72Ascaa0qyGNPi4M8aL5kxpTx+hppVgnF4y/hfQrepNArwrAthdLj6aE
 5PpRDTxBKC7J/+mFrJ0gHI/LtxVO/HriQjOWGz+ptYeiM1QtdJwaN8Z1bTAdHvBsLWhB
 8Rg7YM+V6c0y83lbAsNy75NfEvtoEPyCWgFmbMtuZZnabRjnEavAid0RhI+d4g60OT2d cg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf21t0uq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:06 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NIAbYt014390;
	Fri, 23 Feb 2024 20:42:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u37g9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NKg3F149152378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 20:42:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25E745805E;
	Fri, 23 Feb 2024 20:42:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C7585805B;
	Fri, 23 Feb 2024 20:42:02 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 20:42:02 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key coordinates to digits
Date: Fri, 23 Feb 2024 15:41:40 -0500
Message-ID: <20240223204149.4055630-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223204149.4055630-1-stefanb@linux.ibm.com>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eum-a4B7AV4UnSlWAyRdRKZrqCFzGhsr
X-Proofpoint-ORIG-GUID: eum-a4B7AV4UnSlWAyRdRKZrqCFzGhsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230152

For NIST P192/256/384 the public key's x and y parameters could be copied
directly from a given array since both parameters filled 'ndigits' of
digits (a 'digit' is a u64). For support of NIST P521 the key parameters
first have to be copied into a temporary byte array with leading zeros
and can then be copied into the final digit array using ecc_swap_digits.

Implement ecc_digits_from_bytes to convert a byte array into an array of
digits and use this function in ecdsa_set_pub_key where an input byte array
needs to be converted into digits.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c                | 14 +++++++++-----
 include/crypto/internal/ecc.h | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index fbd76498aba8..ba8fb76fd165 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -222,9 +222,8 @@ static int ecdsa_ecc_ctx_reset(struct ecc_ctx *ctx)
 static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsigned int keylen)
 {
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	unsigned int digitlen, ndigits;
 	const unsigned char *d = key;
-	const u64 *digits = (const u64 *)&d[1];
-	unsigned int ndigits;
 	int ret;
 
 	ret = ecdsa_ecc_ctx_reset(ctx);
@@ -238,12 +237,17 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 		return -EINVAL;
 
 	keylen--;
-	ndigits = (keylen >> 1) / sizeof(u64);
+	digitlen = keylen >> 1;
+
+	ndigits = digitlen / sizeof(u64);
 	if (ndigits != ctx->curve->g.ndigits)
 		return -EINVAL;
 
-	ecc_swap_digits(digits, ctx->pub_key.x, ndigits);
-	ecc_swap_digits(&digits[ndigits], ctx->pub_key.y, ndigits);
+	d++;
+
+	ecc_digits_from_bytes(d, digitlen, ctx->pub_key.x, ndigits);
+	ecc_digits_from_bytes(&d[digitlen], digitlen, ctx->pub_key.y, ndigits);
+
 	ret = ecc_is_pubkey_valid_full(ctx->curve, &ctx->pub_key);
 
 	ctx->pub_key_set = ret == 0;
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 4f6c1a68882f..bee3329af7de 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -56,6 +56,25 @@ static inline void ecc_swap_digits(const void *in, u64 *out, unsigned int ndigit
 		out[i] = get_unaligned_be64(&src[ndigits - 1 - i]);
 }
 
+/**
+ * ecc_digits_from_bytes() - Create ndigits-sized digits array from byte array
+ * @in:       Input byte array
+ * @nbytes    Size of input byte array
+ * @out       Output digits array
+ * @ndigits:  Number of digits to create from byte array
+ */
+static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
+					 u64 *out, unsigned int ndigits)
+{
+	unsigned int sz = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
+	unsigned int o = sz - nbytes;
+
+	memset(tmp, 0, o);
+	memcpy(&tmp[o], in, nbytes);
+	ecc_swap_digits(tmp, out, ndigits);
+}
+
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
-- 
2.43.0


