Return-Path: <linux-kernel+bounces-58783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB284EBAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A649C1F2B4E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB20853805;
	Thu,  8 Feb 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kmjE6dae"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB550259;
	Thu,  8 Feb 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430753; cv=none; b=Qk0CcvuiNSHxIj+mOUhWq7+I8iLWfRGOGNHVtXRFR/4MIkFqiDXhJ2w75bVm4sdKpTVR4slUHA2qKrxCa3QbI0ZWICcjs7eksDxxkLIzkNQWxhC8XTqHd6GTxUjwyXShjt0Ly/Jjcboo8Z82d0/IG0RwXJUxedAigMNZjult0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430753; c=relaxed/simple;
	bh=NNGcT0jsn2rmgum+BGtkYzWpmcnnckals9j/80o2/Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2ltd5UFID3tR1MKd9glXIbh/ysKBq3o12aMMQ1njjzUxJ5oAvxE5OY0ykv1qPCNNJstjZRWYgOgmbaVzE5CpJqtoOt6rVQxrLZqHwYows7lXX8y2TV2uvQxUeiEwIpk71LF7DJ9o9MsdbOOuLeTVsk7teGtNwPMWUG9cJkfTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kmjE6dae; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LRnqL020722;
	Thu, 8 Feb 2024 22:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CEa3ylXchT1oPyUT4t3DQt18ll2WAWvkKE4DHQ6Kzi4=;
 b=kmjE6daekSJi7RYA8zAPZxOtfXdxaXcITDaUIfNlbAOBeG343+Mw3hYI2NkSuvLmxe9a
 gJRzWQgQkIzp0AIhjfOrTdd0mjJgSaPhkfv8GkdLjPcWjCxkDNe2xYL049VhyttjUgf6
 AT7FhGmbRRIaoSO7uSRo4gBxr1FqTnGfHI5fxSt6SoEWBSYeM/VlBejp7v3rbsgt3Int
 PtMcF3iaqAfr5pTqSWtstEgY02x6yYAu0uY3T0xxdMR59OYADCTuK2mqFsYSSr5VZlqq
 qKJGXbPqV7dGHXBmy9q89X4+l5FtwIpsPZd9d5/py0X7vdMZ8tSEHA/9F8azLwZB7Zzg dg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w56vsryax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418LH5iG008623;
	Thu, 8 Feb 2024 22:19:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221kf5dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ7kr21168834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2263B5805A;
	Thu,  8 Feb 2024 22:19:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC6B05803F;
	Thu,  8 Feb 2024 22:19:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:19:06 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 13/14] crypto: ecdh - Use functions to copy digits from and to array
Date: Thu,  8 Feb 2024 17:18:39 -0500
Message-ID: <20240208221840.3665874-14-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GrMZKgV7dX9CEFz-oDLXMIBxfktbm_Q3
X-Proofpoint-GUID: GrMZKgV7dX9CEFz-oDLXMIBxfktbm_Q3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080124

All curves supported so far provide digit arrays with ndigits to convert
coordinates from and to. For NIST P521 only 8 digits and 2 bytes will be
given per coordinate so that conversion from ndigits (= 9) does not work
since some bytes are missing. Therefore, regard the input (and output)
arrays as byte arrays that need to be converted to digits (from digits).
Use ecc_digits_from array to convert a byte array to digits and
ecc_digits_to_array to convert digits to a byte array.

crypt_ecdh_shared_secret creates nbytes into a byte array from which
to create rand_z from. The most significant digit of rand_z needs to be
adjusted to mask out unnecessary bits beyond the 521 bits of the NIST P521
curve. Therefore, apply a mask to the most significant digit.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c                  | 27 +++++++++++++++------------
 crypto/ecdh.c                 | 24 ++++++++++++++----------
 include/crypto/internal/ecc.h | 10 +++++++---
 3 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index f643719450b8..e80ab4f3b5e1 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1542,7 +1542,8 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
 EXPORT_SYMBOL(ecc_gen_privkey);
 
 int ecc_make_pub_key(unsigned int curve_id, unsigned int ndigits,
-		     const u64 *private_key, u64 *public_key)
+		     const u64 *private_key, u8 *public_key,
+		     unsigned int nbytes)
 {
 	int ret = 0;
 	struct ecc_point *pk;
@@ -1570,8 +1571,8 @@ int ecc_make_pub_key(unsigned int curve_id, unsigned int ndigits,
 		goto err_free_point;
 	}
 
-	ecc_swap_digits(pk->x, public_key, ndigits);
-	ecc_swap_digits(pk->y, &public_key[ndigits], ndigits);
+	ecc_digits_to_array(pk->x, ndigits, public_key, nbytes);
+	ecc_digits_to_array(pk->y, ndigits, &public_key[nbytes], nbytes);
 
 err_free_point:
 	ecc_free_point(pk);
@@ -1641,14 +1642,14 @@ int ecc_is_pubkey_valid_full(const struct ecc_curve *curve,
 EXPORT_SYMBOL(ecc_is_pubkey_valid_full);
 
 int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
-			      const u64 *private_key, const u64 *public_key,
-			      u64 *secret)
+			      const u64 *private_key, const u8 *public_key,
+			      unsigned int nbytes, u8 *secret, u64 msd_mask)
 {
 	int ret = 0;
 	struct ecc_point *product, *pk;
 	u64 priv[ECC_MAX_DIGITS];
 	u64 rand_z[ECC_MAX_DIGITS];
-	unsigned int nbytes;
+	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 
 	if (!private_key || !public_key || !curve ||
@@ -1657,9 +1658,10 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto out;
 	}
 
-	nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
-
-	get_random_bytes(rand_z, nbytes);
+	get_random_bytes(tmp, nbytes);
+	ecc_digits_from_array(tmp, nbytes, rand_z, ndigits);
+	if (msd_mask)
+		rand_z[ndigits - 1] &= msd_mask;
 
 	pk = ecc_alloc_point(ndigits);
 	if (!pk) {
@@ -1667,8 +1669,9 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto out;
 	}
 
-	ecc_swap_digits(public_key, pk->x, ndigits);
-	ecc_swap_digits(&public_key[ndigits], pk->y, ndigits);
+	ecc_digits_from_array(public_key, nbytes, pk->x, ndigits);
+	ecc_digits_from_array(&public_key[nbytes], nbytes, pk->y, ndigits);
+
 	ret = ecc_is_pubkey_valid_partial(curve, pk);
 	if (ret)
 		goto err_alloc_product;
@@ -1688,7 +1691,7 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto err_validity;
 	}
 
-	ecc_swap_digits(product->x, secret, ndigits);
+	ecc_digits_to_array(product->x, ndigits, secret, nbytes);
 
 err_validity:
 	memzero_explicit(priv, sizeof(priv));
diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 83029233c03e..9f16dbef94d5 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -15,6 +15,8 @@
 struct ecdh_ctx {
 	unsigned int curve_id;
 	unsigned int ndigits;
+	unsigned int nbytes;
+	u64 msd_mask;
 	u64 private_key[ECC_MAX_DIGITS];
 };
 
@@ -28,7 +30,6 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 {
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
 	u64 priv[ECC_MAX_DIGITS];
-	unsigned int nbytes;
 	struct ecdh params;
 
 	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
@@ -39,9 +40,7 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 		return ecc_gen_privkey(ctx->curve_id, ctx->ndigits,
 				       ctx->private_key);
 
-	nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
-
-	ecc_digits_from_array(params.key, nbytes, priv, ctx->ndigits);
+	ecc_digits_from_array(params.key, ctx->nbytes, priv, ctx->ndigits);
 	ecc_swap_digits(priv, ctx->private_key, ctx->ndigits);
 
 	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
@@ -56,13 +55,13 @@ static int ecdh_compute_value(struct kpp_request *req)
 {
 	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
-	u64 *public_key;
-	u64 *shared_secret = NULL;
+	unsigned int nbytes = ctx->nbytes;
+	u8 *public_key;
+	u8 *shared_secret = NULL;
 	void *buf;
-	size_t copied, nbytes, public_key_sz;
+	size_t copied, public_key_sz;
 	int ret = -ENOMEM;
 
-	nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 	/* Public part is a point thus it has both coordinates */
 	public_key_sz = 2 * nbytes;
 
@@ -91,12 +90,14 @@ static int ecdh_compute_value(struct kpp_request *req)
 
 		ret = crypto_ecdh_shared_secret(ctx->curve_id, ctx->ndigits,
 						ctx->private_key, public_key,
-						shared_secret);
+						nbytes, shared_secret,
+						ctx->msd_mask);
 
 		buf = shared_secret;
 	} else {
 		ret = ecc_make_pub_key(ctx->curve_id, ctx->ndigits,
-				       ctx->private_key, public_key);
+				       ctx->private_key, public_key,
+				       nbytes);
 		buf = public_key;
 		nbytes = public_key_sz;
 	}
@@ -134,6 +135,7 @@ static int ecdh_nist_p192_init_tfm(struct crypto_kpp *tfm)
 
 	ctx->curve_id = ECC_CURVE_NIST_P192;
 	ctx->ndigits = ECC_CURVE_NIST_P192_DIGITS;
+	ctx->nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 
 	return 0;
 }
@@ -159,6 +161,7 @@ static int ecdh_nist_p256_init_tfm(struct crypto_kpp *tfm)
 
 	ctx->curve_id = ECC_CURVE_NIST_P256;
 	ctx->ndigits = ECC_CURVE_NIST_P256_DIGITS;
+	ctx->nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 
 	return 0;
 }
@@ -184,6 +187,7 @@ static int ecdh_nist_p384_init_tfm(struct crypto_kpp *tfm)
 
 	ctx->curve_id = ECC_CURVE_NIST_P384;
 	ctx->ndigits = ECC_CURVE_NIST_P384_DIGITS;
+	ctx->nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 
 	return 0;
 }
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index ba9ca0dcb971..29e899fcde8d 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -138,12 +138,14 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey);
  * @ndigits:		curve's number of digits
  * @private_key:	pregenerated private key for the given curve
  * @public_key:		buffer for storing the generated public key
+ * @nbytes:		number of bytes per coordinate of public key
  *
  * Returns 0 if the public key was generated successfully, a negative value
  * if an error occurred.
  */
 int ecc_make_pub_key(const unsigned int curve_id, unsigned int ndigits,
-		     const u64 *private_key, u64 *public_key);
+		     const u64 *private_key, u8 *public_key,
+		     unsigned int nbytes);
 
 /**
  * crypto_ecdh_shared_secret() - Compute a shared secret
@@ -152,7 +154,9 @@ int ecc_make_pub_key(const unsigned int curve_id, unsigned int ndigits,
  * @ndigits:		curve's number of digits
  * @private_key:	private key of part A
  * @public_key:		public key of counterpart B
+ * @nbytes:		number of bytes per coordinate of public key
  * @secret:		buffer for storing the calculated shared secret
+ * @msd_mask:		optional mask to apply to the most significant digit
  *
  * Note: It is recommended that you hash the result of crypto_ecdh_shared_secret
  * before using it for symmetric encryption or HMAC.
@@ -161,8 +165,8 @@ int ecc_make_pub_key(const unsigned int curve_id, unsigned int ndigits,
  * if an error occurred.
  */
 int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
-			      const u64 *private_key, const u64 *public_key,
-			      u64 *secret);
+			      const u64 *private_key, const u8 *public_key,
+			      unsigned int nbytes, u8 *secret, u64 msd_mask);
 
 /**
  * ecc_is_pubkey_valid_partial() - Partial public key validation
-- 
2.43.0


