Return-Path: <linux-kernel+bounces-144430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B08A8A4655
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293A4B20A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D22C8E1;
	Mon, 15 Apr 2024 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gS6yvvv9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CE17F8;
	Mon, 15 Apr 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713141052; cv=none; b=nOwIdopvw6c7lF5BSpR/MBHrA+4aO5DqXk620LaL2P/449ibe8/q+5dvbTlukptIGBbUQ00x6YNd9WVilSaIUPpQYBWsCz8qGg3K0b/gCOvovp6v361g6Y4Y23ngGMdWs2p84jfSgaebxf3wNDbPSud/fJQNvpXwZsw1aJkalTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713141052; c=relaxed/simple;
	bh=6bKuQUe1H8PV9axvbYjuw9pGeG2200M/J9uOUasY5sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZ0ZSAe5CwtJJcZLVbE21vALsDwIwBoouICWg0d+0YihnfyyKS1ELjF6faf5b3pTHIBx8/l/z9oAQ70pNg/GqVxNQCpqd5E3RS2eowvt7WO8e4M2UTRE7pPIRRZPXNmXmmcFF1JhA4ofYLO9cHZOcBIhNnDt+cJKeotVfpE0x+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gS6yvvv9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43EMpA1B029099;
	Mon, 15 Apr 2024 00:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9iIaT+PEJcJjzd4/flj82lcuMlYUdN0r1NlTYNkZzsw=;
 b=gS6yvvv9FnRNG3X0+tcDRpP//cbuh+9j4wi7YwDNtfMz9wA06dMuY1Rf6jI5pB49TCUi
 dZlnXab90WU9UIqX2ts5kqU6FfSJy/hDlLA6iuGqYp4jUbsVv3kEjUrH3fO8z5a+xYV9
 3YMDL6e2GmhhRZA6AnQyeMMRYKZBGA0glrkFFbbSmzmbGCDiiY2ek1s760VEXoeCgrNF
 shpu/X8eOIB9xZPpxxpR+trGDxma8dW0efAm1GZqgNT+Z5wKq9DYAvrGs5F2yqpqZbLf
 yb+YIBJqGu6I2y7GUVQIQnvBKCjL2H25BX+AxMPjoNZFyZ60aDzhacU1MszLxcObBzAs FA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xffft2vdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 00:30:41 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43EKqe5u018152;
	Mon, 15 Apr 2024 00:30:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4csw5g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 00:30:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43F0Uefj38928668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 00:30:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B8CE5806C;
	Mon, 15 Apr 2024 00:30:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5482958079;
	Mon, 15 Apr 2024 00:30:39 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 00:30:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
        salvatore.benedetto@intel.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/2] crypto: ecdh - Pass private key in proper byte order to check valid key
Date: Sun, 14 Apr 2024 20:30:25 -0400
Message-ID: <20240415003026.2661270-2-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: ksjlax4eBGmK9uRAyt_qPbArM6uyGbtZ
X-Proofpoint-ORIG-GUID: ksjlax4eBGmK9uRAyt_qPbArM6uyGbtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150001

ecc_is_key_valid expects a key with the most significant digit in the last
entry of the digit array. Currently ecdh_set_secret passes a reversed key
to ecc_is_key_valid that then passes the rather simple test checking
whether the private key is in range [2, n-3]. For all current ecdh-
supported curves (NIST P192/256/384) the 'n' parameter is a rather large
number, therefore easily passing this test.

Throughout the ecdh and ecc codebase the variable 'priv' is used for a
private_key holding the bytes in proper byte order. Therefore, introduce
priv in ecdh_set_secret and copy the bytes from ctx->private_key into
priv in proper byte order by using ecc_swap_digits. Pass priv to
ecc_is_valid_key.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdh.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 3049f147e011..a73853bd44de 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -27,6 +27,7 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 			   unsigned int len)
 {
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
+	u64 priv[ECC_MAX_DIGITS];
 	struct ecdh params;
 
 	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
@@ -40,9 +41,10 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 				       ctx->private_key);
 
 	memcpy(ctx->private_key, params.key, params.key_size);
+	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
 
 	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
-			     ctx->private_key, params.key_size) < 0) {
+			     priv, params.key_size) < 0) {
 		memzero_explicit(ctx->private_key, params.key_size);
 		return -EINVAL;
 	}
-- 
2.43.0


