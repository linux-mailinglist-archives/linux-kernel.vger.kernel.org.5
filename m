Return-Path: <linux-kernel+bounces-87830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BA086D99A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DD11F25C09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272473D0D0;
	Fri,  1 Mar 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eiNMumx/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A423A8D2;
	Fri,  1 Mar 2024 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259624; cv=none; b=HuF8SrnfJ29Cfp4YCX/MHPTZZ5TljbsnqSJbEKQgsEB45DwY03VCWGm6kBdfNZzGUavh5UP+ewkl1m+yHmilU363FNUWPQqnUOaE/bBDxAzgaKR7NmHQPcwYMGH/gBqFhmh81V1UPM3GtcU/IIIhFiUI8YR8yisPjgZb5AwrZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259624; c=relaxed/simple;
	bh=o1v/JX7sIpsoVFsmxKrT91VXsaiTzc9XeG2SC7KxnEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rssBo1RJ2L1U9K56egnZOfBpGSel4Xb8F1dvZFCgS/P6uNy3yQc6awtCSxbYFQJFqBL++3wzjCtCi4BtoEMirYAvfkSBl6RZwa4ozmQXDlfYZK5J1pwBoTyGQDT3LcnQUyXA8pPEf9iW300LE4s+v6jzaQOTnviuWlB/GRWnmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eiNMumx/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4212Hf09028224;
	Fri, 1 Mar 2024 02:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mKVkxb/T5qGHQvaRTLWjs+ciJiOyEWiLYIdnDAuupJk=;
 b=eiNMumx/wNhPmvmKrZAnaC0JtRauZlj4u+3ktAmRS5y/V+z9zdCIPEG0hSU76ZpNRrxE
 2UxE+4ibFzhFnoP2sYD7BgVWf4yXdsiXgCGGGIK+oyIL49Vhz3wQJfq4NMElWOJGDMb+
 OkhB/jiczm37gRikpGgs9VUHiXXILfvklg03RAf7Qi5UIlpXQRGaO39jeEMcudCtSOGl
 JigJzsctRreRlkp7fVTq3FltXZWkvmIodU5Q+tW5AVzJAsCi6MLASFh3n5R0gcB+SqH3
 6d5dHt2nK1Yf7Ym1+iG2RgFN1XnLVW4di79QImUfMQ1vnCl4V15fHTtGDrhcw9k22IdS aA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk63t81k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4210gfdu008808;
	Fri, 1 Mar 2024 02:20:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftsu1w6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4212KErj38535578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 02:20:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA11658071;
	Fri,  1 Mar 2024 02:20:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52FE958068;
	Fri,  1 Mar 2024 02:20:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 02:20:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 09/12] crypto: ecdsa - Rename keylen to bufsize where necessary
Date: Thu, 29 Feb 2024 21:20:04 -0500
Message-ID: <20240301022007.344948-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301022007.344948-1-stefanb@linux.ibm.com>
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z5FTQ5LHpF0DZt41-ToOm6gm3W3sJOnf
X-Proofpoint-ORIG-GUID: z5FTQ5LHpF0DZt41-ToOm6gm3W3sJOnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010018

In some cases the name keylen does not reflect the purpose of the variable
anymore once NIST P521 is used but it is the size of the buffer. There-
for, rename keylen to bufsize where appropriate.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 4daefb40c37a..4e847b59622a 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -35,8 +35,8 @@ struct ecdsa_signature_ctx {
 static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
 				  const void *value, size_t vlen, unsigned int ndigits)
 {
-	size_t keylen = ndigits * sizeof(u64);
-	ssize_t diff = vlen - keylen;
+	size_t bufsize = ndigits * sizeof(u64);
+	ssize_t diff = vlen - bufsize;
 	const char *d = value;
 	u8 rs[ECC_MAX_BYTES];
 
@@ -58,7 +58,7 @@ static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
 		if (diff)
 			return -EINVAL;
 	}
-	if (-diff >= keylen)
+	if (-diff >= bufsize)
 		return -EINVAL;
 
 	if (diff) {
@@ -138,7 +138,7 @@ static int ecdsa_verify(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
-	size_t keylen = ctx->curve->g.ndigits * sizeof(u64);
+	size_t bufsize = ctx->curve->g.ndigits * sizeof(u64);
 	struct ecdsa_signature_ctx sig_ctx = {
 		.curve = ctx->curve,
 	};
@@ -165,14 +165,14 @@ static int ecdsa_verify(struct akcipher_request *req)
 		goto error;
 
 	/* if the hash is shorter then we will add leading zeros to fit to ndigits */
-	diff = keylen - req->dst_len;
+	diff = bufsize - req->dst_len;
 	if (diff >= 0) {
 		if (diff)
 			memset(rawhash, 0, diff);
 		memcpy(&rawhash[diff], buffer + req->src_len, req->dst_len);
 	} else if (diff < 0) {
 		/* given hash is longer, we take the left-most bytes */
-		memcpy(&rawhash, buffer + req->src_len, keylen);
+		memcpy(&rawhash, buffer + req->src_len, bufsize);
 	}
 
 	ecc_swap_digits((u64 *)rawhash, hash, ctx->curve->g.ndigits);
-- 
2.43.0


