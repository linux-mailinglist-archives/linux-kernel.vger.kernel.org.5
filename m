Return-Path: <linux-kernel+bounces-144431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682168A4657
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C25D1C21430
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7957D15E9B;
	Mon, 15 Apr 2024 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tQ85zB1w"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759161171C;
	Mon, 15 Apr 2024 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713141056; cv=none; b=O2cYIAOg9GvRuzewrmjY8Ks5fWSpBQuoFip3Sxb8gXM/1tL7PDd/SKjQGPKknFZQvEQO3YZUsNi0JlVplxK7DpBMtYc1rIAdZ24dv7Y7i+zGnwJAx53/zbgvaX82JdGP60Y5xaArz7j6y+GPfdgIQkCFCaldaK3C8p+NlTcHeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713141056; c=relaxed/simple;
	bh=nAfafUULCLaQKdMTY3yXs2AItknvlss+nizzaVhMF30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGnA+uhZjZlY5vCF3yjhRV64bk8AUhtjQ/6waoyxP+7pxj2Fh7Q6IMsH/KAc2jMgFzDBw3YBZuzjm3qsUsGgfxsuO3X5mSSUNOz5I8ebR6P8M/d9h5Xapnw/rmqxnpfq737VsKa9lyh0R0WfEaFfhS/iFg5qh5XQ6OStoGapKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tQ85zB1w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43ENjmxx004713;
	Mon, 15 Apr 2024 00:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GfmdnYzb6uHb+k2RmkxuEiizAUPssu3zlTJYCZA0YS8=;
 b=tQ85zB1wULuQWTAal04AirBumUSx0T/tecgo3dTiy3519GVLNeSdXp3qgA4FzrohS+SG
 y52j5Aw2sQclK+1FyvvPMrHFxZNWA1E8JOE1qDLNcqdvEWDFvzTT8/Vli6jDaIQ2vjIq
 oa6UD3uLQi+Uj+SWryhT6xhlNTpC/9WG0Xh4dN5V+ZsW3S0OHvnV+eJuFo64hL2HdVyx
 qK+Uco2O5aWtRZMTb6lnqjSQcfMS3K0lz+6g7LP24hCy1CX1j0zDc+1fEk1x7ENBq0XF
 iP2GNOtbsD7boG3uY+Qx+132N/rAHUZc3UEU20Jn7jZoqoDMKRcWkvZMEOjaCx2Y70rx /g== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xgjnb8h93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 00:30:44 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43ELpWle023582;
	Mon, 15 Apr 2024 00:30:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnmx00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 00:30:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43F0UfYu36307544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 00:30:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7D7358066;
	Mon, 15 Apr 2024 00:30:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DC7E58063;
	Mon, 15 Apr 2024 00:30:40 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 00:30:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
        salvatore.benedetto@intel.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/2] crypto: ecdh & ecc - Initialize ctx->private_key in proper byte order
Date: Sun, 14 Apr 2024 20:30:26 -0400
Message-ID: <20240415003026.2661270-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415003026.2661270-1-stefanb@linux.ibm.com>
References: <20240415003026.2661270-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GGDON2JQHZ8voxZ8iQ8EyTlf9qJ7PF37
X-Proofpoint-GUID: GGDON2JQHZ8voxZ8iQ8EyTlf9qJ7PF37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404150001

ctx->private_key is currently initialized in reverse byte order in
ecdh_set_secret and whenever it is needed in proper byte order the variable
priv is introduced and the bytes from ctx->private_key are copied into priv
while being byte-swapped (ecc_swap_digits). To get rid of the unnecessary
byte swapping initialize ctx->private_key in proper byte order and clean up
all functions that were previously using priv or were called with
ctx->private_key:

- ecc_gen_privkey: Directly initialize the passed ctx->private_key with
  random bytes and get rid of the priv variable. This function only has
  ecdh_set_secret as a caller.

- crypto_ecdh_shared_secret: Called only from ecdh_compute_value with
  ctx->private_key. Get rid of the priv variable and work with the passed
  private_key directly.

- ecc_make_pub_key: Called only from ecdh_compute_value with
  ctx->private_key. Get rid of the priv variable and work with the passed
  private_key directly.

Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c                  | 29 ++++++++++-------------------
 crypto/ecdh.c                 |  7 +++----
 include/crypto/internal/ecc.h |  3 ++-
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 2e05387b9499..c1d2e884be1e 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1497,10 +1497,10 @@ EXPORT_SYMBOL(ecc_is_key_valid);
  * This method generates a private key uniformly distributed in the range
  * [2, n-3].
  */
-int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
+int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits,
+		    u64 *private_key)
 {
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
-	u64 priv[ECC_MAX_DIGITS];
 	unsigned int nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 	unsigned int nbits = vli_num_bits(curve->n, ndigits);
 	int err;
@@ -1509,7 +1509,7 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
 	 * Step 1 & 2: check that N is included in Table 1 of FIPS 186-5,
 	 * section 6.1.1.
 	 */
-	if (nbits < 224 || ndigits > ARRAY_SIZE(priv))
+	if (nbits < 224)
 		return -EINVAL;
 
 	/*
@@ -1527,17 +1527,16 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
 		return -EFAULT;
 
 	/* Step 3: obtain N returned_bits from the DRBG. */
-	err = crypto_rng_get_bytes(crypto_default_rng, (u8 *)priv, nbytes);
+	err = crypto_rng_get_bytes(crypto_default_rng,
+				   (u8 *)private_key, nbytes);
 	crypto_put_default_rng();
 	if (err)
 		return err;
 
 	/* Step 4: make sure the private key is in the valid range. */
-	if (__ecc_is_key_valid(curve, priv, ndigits))
+	if (__ecc_is_key_valid(curve, private_key, ndigits))
 		return -EINVAL;
 
-	ecc_swap_digits(priv, privkey, ndigits);
-
 	return 0;
 }
 EXPORT_SYMBOL(ecc_gen_privkey);
@@ -1547,23 +1546,20 @@ int ecc_make_pub_key(unsigned int curve_id, unsigned int ndigits,
 {
 	int ret = 0;
 	struct ecc_point *pk;
-	u64 priv[ECC_MAX_DIGITS];
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 
-	if (!private_key || ndigits > ARRAY_SIZE(priv)) {
+	if (!private_key) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ecc_swap_digits(private_key, priv, ndigits);
-
 	pk = ecc_alloc_point(ndigits);
 	if (!pk) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	ecc_point_mult(pk, &curve->g, priv, NULL, curve, ndigits);
+	ecc_point_mult(pk, &curve->g, private_key, NULL, curve, ndigits);
 
 	/* SP800-56A rev 3 5.6.2.1.3 key check */
 	if (ecc_is_pubkey_valid_full(curve, pk)) {
@@ -1647,13 +1643,11 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 {
 	int ret = 0;
 	struct ecc_point *product, *pk;
-	u64 priv[ECC_MAX_DIGITS];
 	u64 rand_z[ECC_MAX_DIGITS];
 	unsigned int nbytes;
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 
-	if (!private_key || !public_key ||
-	    ndigits > ARRAY_SIZE(priv) || ndigits > ARRAY_SIZE(rand_z)) {
+	if (!private_key || !public_key || ndigits > ARRAY_SIZE(rand_z)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1674,15 +1668,13 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 	if (ret)
 		goto err_alloc_product;
 
-	ecc_swap_digits(private_key, priv, ndigits);
-
 	product = ecc_alloc_point(ndigits);
 	if (!product) {
 		ret = -ENOMEM;
 		goto err_alloc_product;
 	}
 
-	ecc_point_mult(product, pk, priv, rand_z, curve, ndigits);
+	ecc_point_mult(product, pk, private_key, rand_z, curve, ndigits);
 
 	if (ecc_point_is_zero(product)) {
 		ret = -EFAULT;
@@ -1692,7 +1684,6 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 	ecc_swap_digits(product->x, secret, ndigits);
 
 err_validity:
-	memzero_explicit(priv, sizeof(priv));
 	memzero_explicit(rand_z, sizeof(rand_z));
 	ecc_free_point(product);
 err_alloc_product:
diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index a73853bd44de..c217f2d2d218 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -27,7 +27,6 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 			   unsigned int len)
 {
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
-	u64 priv[ECC_MAX_DIGITS];
 	struct ecdh params;
 
 	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
@@ -40,11 +39,11 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 		return ecc_gen_privkey(ctx->curve_id, ctx->ndigits,
 				       ctx->private_key);
 
-	memcpy(ctx->private_key, params.key, params.key_size);
-	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
+	ecc_digits_from_bytes(params.key, params.key_size,
+			      ctx->private_key, ctx->ndigits);
 
 	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
-			     priv, params.key_size) < 0) {
+			     ctx->private_key, params.key_size) < 0) {
 		memzero_explicit(ctx->private_key, params.key_size);
 		return -EINVAL;
 	}
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 4e2f5f938e91..7ca1f463d1ec 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -103,7 +103,8 @@ int ecc_is_key_valid(unsigned int curve_id, unsigned int ndigits,
  * Returns 0 if the private key was generated successfully, a negative value
  * if an error occurred.
  */
-int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey);
+int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits,
+		    u64 *private_key);
 
 /**
  * ecc_make_pub_key() - Compute an ECC public key
-- 
2.43.0


