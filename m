Return-Path: <linux-kernel+bounces-58779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F2184EBA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE92628F31B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84D535C9;
	Thu,  8 Feb 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E2K/eCpJ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF44F895;
	Thu,  8 Feb 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430752; cv=none; b=dWD9hcAutkwodWlaH66vE2PM1JrSluW9VGRoFhPG2rzVQzhqCvS+7lI4HpW1Ee1lgSOOj6K3Y80LXoOpKXWOxE5hWTIWfhygVPNurSAx0GmsLhy2Dh5exMqS9oDFbZKT+ok4EKZvxYH5YrXTVYMHfx2JAu+3lMYsXbBcjJgzoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430752; c=relaxed/simple;
	bh=rbnTL2TCwXDFbk4YkuT0DJc9SEhwxCrmE6bqJiUHnAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lg+lggNVGlfclXSrFOoVQ9oUZiBsMZlGMBQeq8/bnK3WHgA9KMlq9t3rYW2x9MavQWNvpjVzp9XhYbCLcBY/wVV0ICd4I+jTFIRR3BMqaI7LkJv6G7uOHOQZwKM6Jt/Uf7jywUtRt1zOXf6sTKOJvLyoiDBj1xgE10lMFInEURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E2K/eCpJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LCdpm032015;
	Thu, 8 Feb 2024 22:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AH7So/3OYDhj6QzqleroVgxFObiNfKnr2PvOokHcixY=;
 b=E2K/eCpJN/ieWWmZSYa3yu2AGVfRmaVdrvjoDK//RBKqQWOdZqayRnLVR3ck+Rfx3qaP
 9l6V9UfcepRsn0eRavl504wtlCudEpT6IXx2uPnTHC2CtQj3AyEFnElSpkukSDvMI2AJ
 JvoH066v7fJINyTUZjGfE7uE5lNg2qeaSPI1psAGv4oYgeTmWJpO8IzXc/6VS9qsDpN0
 pGcmmNrpdKBInlhNvHd6pho1gERP6/UFIrJcbXMPHNAHVRONQOsbXWT/f4gRp66HTcQI
 2U5y51236rOhBWzOB/8D8rlWugfU5hmWcxj0DaVTBzjz1CQGcHY/rp2t6MNdAWRj4VTZ rA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w56nqsknn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418LKNPb008478;
	Thu, 8 Feb 2024 22:19:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221kf5dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ51i28639864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E8E358064;
	Thu,  8 Feb 2024 22:19:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9345858056;
	Thu,  8 Feb 2024 22:19:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:19:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 09/14] crypto: ecdh - Use properly formatted digits to check for valid key
Date: Thu,  8 Feb 2024 17:18:35 -0500
Message-ID: <20240208221840.3665874-10-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: crvSgIulxmQxUnVHQpgrRC1nmJnVZycc
X-Proofpoint-GUID: crvSgIulxmQxUnVHQpgrRC1nmJnVZycc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402080124

ecc_is_key_valid expects a key with the most significant digit in the last
entry of the digit array. Currently a reverse key is passed to
ecc_is_key_valid that then passes that rather simple test checking whether
the private key is in range [2, n-3]. For all current ecdh-supported
curves (NIST P192/256/384) n is a rather large number, therefore easily
passing this test. However, this will not work for NIST P521 anymore but
the properly prepared array of digits will need to be passed. Therefore,
use ecc_digits_from_array to create the digits array from the byte array
and pass the result to this test function. Use a swapped key in
ctx->private_key.

Note: The ctx->private_key is currently (unnecessarily) swapped and will
be swapped into proper order in ecc_make_pub_key and
crypto_ecdh_shared_secret before usage. Also the key generated in
ecc_gen_privkey, that is assigned to ctx->private_key, is currently
swapped. The above mention 'swap' and the ones mention here could likely
all be removed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdh.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 80afee3234fb..83029233c03e 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -27,6 +27,8 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 			   unsigned int len)
 {
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
+	u64 priv[ECC_MAX_DIGITS];
+	unsigned int nbytes;
 	struct ecdh params;
 
 	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
@@ -37,10 +39,13 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 		return ecc_gen_privkey(ctx->curve_id, ctx->ndigits,
 				       ctx->private_key);
 
-	memcpy(ctx->private_key, params.key, params.key_size);
+	nbytes = ctx->ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+
+	ecc_digits_from_array(params.key, nbytes, priv, ctx->ndigits);
+	ecc_swap_digits(priv, ctx->private_key, ctx->ndigits);
 
 	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
-			     ctx->private_key, params.key_size) < 0) {
+			     priv, params.key_size) < 0) {
 		memzero_explicit(ctx->private_key, params.key_size);
 		return -EINVAL;
 	}
-- 
2.43.0


