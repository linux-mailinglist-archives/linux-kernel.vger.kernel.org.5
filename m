Return-Path: <linux-kernel+bounces-131597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853368989E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142CE1F2FB0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096D012D761;
	Thu,  4 Apr 2024 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CbnlL49T"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90112AACE;
	Thu,  4 Apr 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240394; cv=none; b=UTd+1y4reBag1b/5GmVlHcStF77opwcS6LmKZ5pI7/F2EMAntU1C53w+OQq7D0Z0Xvte4Di6oWAsje2lbFUFq28LqC9SsbAd2MfLfa8GVgAG7P1I3m4lTDdClRhK2X+JECPMTfTB8EzH5G7QQ66rzsKqjfjt8TJT43U1wtbhaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240394; c=relaxed/simple;
	bh=EWqoaU6lF9Qw5R8PV+uS1cFZUvMHkk1fsG58V9yNxb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcqG/VFbZAl/lJ3liWXD3kx6afyatpeQk07YY78Kpu3tmKeXINMe0EGu74zWC4EQ01oaeG+qt4xgEioh9SaHfkLMkzUKvu1CHTDpqIr5MNu3+dz85TOia0JsugIAByhZZP8/AakcunHisWyujcYjTDNbb3JmChDJrMmjpBLKhN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CbnlL49T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434EIlLg018375;
	Thu, 4 Apr 2024 14:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=od/CzriufuKwAI7nTnZU2H3suYb3Ur4hEZoLyK6/eUw=;
 b=CbnlL49TrB2a0idDIAVH9hlNNr6NOqX7oKLPjzIvBKNCEKo3cClrTfGjrdvmqDJeRmhq
 JieQAzYA+juicdqwcL/sC28WDQeZOKRWyAmhHY+cKAt67X9xyAFpfXfoM5/rIF0gPMaE
 gGFrcs8+fSa5M4p0iTlvOOa5iyXm4FFsncy+AnJwI0TcnKsHsonG1hfDjbasv/64SdEZ
 hNJEsSud1ov3eweQETcP86lkRlPgVKdB0WDMH4AXZ/32dIptTnj4ISNaCxRFsX8+FfBS
 8fN1bccsP+e5lNkPbXTXUWYSq3YjclG0CoiJ/+35uuUMubc5nlb2wOawPOCK8jqZk/q6 ZA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wuk802y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:35 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434DVRtq008686;
	Thu, 4 Apr 2024 14:19:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epw4k55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJX5923724750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:35 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E60895804E;
	Thu,  4 Apr 2024 14:19:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13BCF58055;
	Thu,  4 Apr 2024 14:19:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:31 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 02/13] crypto: ecdsa - Convert byte arrays with key coordinates to digits
Date: Thu,  4 Apr 2024 10:18:45 -0400
Message-ID: <20240404141856.2399142-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404141856.2399142-1-stefanb@linux.ibm.com>
References: <20240404141856.2399142-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oLQmtTBAPQQcdjEBT6aFtAL0NYfHn-DY
X-Proofpoint-GUID: oLQmtTBAPQQcdjEBT6aFtAL0NYfHn-DY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040098

For NIST P192/256/384 the public key's x and y parameters could be copied
directly from a given array since both parameters filled 'ndigits' of
digits (a 'digit' is a u64). For support of NIST P521 the key parameters
need to have leading zeros prepended to the most significant digit since
only 2 bytes of the most significant digit are provided.

Therefore, implement ecc_digits_from_bytes to convert a byte array into an
array of digits and use this function in ecdsa_set_pub_key where an input
byte array needs to be converted into digits.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c                | 14 +++++++++-----
 include/crypto/internal/ecc.h | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 3f9ec273a121..e819d0983bd3 100644
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
+	ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
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
index 4f6c1a68882f..ab722a8986b7 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -56,6 +56,27 @@ static inline void ecc_swap_digits(const void *in, u64 *out, unsigned int ndigit
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
+	unsigned int o = nbytes & 7;
+	__be64 msd = 0;
+
+	if (o) {
+		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
+		out[--ndigits] = be64_to_cpu(msd);
+		in += o;
+	}
+	ecc_swap_digits(in, out, ndigits);
+}
+
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
-- 
2.43.0


