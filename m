Return-Path: <linux-kernel+bounces-150387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1BE8A9E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50669282E57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B594816D313;
	Thu, 18 Apr 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SZKSe9Ia"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B9316C6AF;
	Thu, 18 Apr 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453915; cv=none; b=mhYmwdVh/WugPigl9D7BYzA1B7iGZarbXc2yWu//FmdB2u6rCnvvDM4ekJFFz2UsvyKx8W1KNg6RoY2Mp+VxA3nbVQBkZIKlXlZhnLuC1/rZjber5lmg/H06+8VXKq+G9epjsxnxo3eenGWxNXUWzMGFjv+BAU6Ur6nBf9fyPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453915; c=relaxed/simple;
	bh=HlE4fPZK4QqVclWCai0r5iX113bkFo62eJU6ajqRMzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICA/LaJtEucHeOM+CVxZqzH+GWdZYJ0wzIZAz0Ecy+orWHBMjV1F4LeLxlb1zBAHk4NGffkC2otsZVKWT2Qxzyjy8zDFlNeuah80FPMbasbrFvMtPIGYaTBk5sVPEaQ0CztmnQyS/KtH0wQzq1azVk+E7ZP//JiTjmtcGzjac90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SZKSe9Ia; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43IF7NDG014728;
	Thu, 18 Apr 2024 15:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ui5X5RbZavMSqm/WSSHdsY7HGQVQlYK9cKnf+pMYams=;
 b=SZKSe9IaljpBMGZfcBUrWlMsv8jQwsJo3Scbb/IhKzsQpbNJOicRsdlQZjoCM0v74skY
 dP4LOdPgZ/P0Ls2oF/NhvyrNH9io3gDvPyWFqBy1ZxSUU07YXSyDLHTPILv7Jh0/OzVK
 NDhKoV1W+TAoeqZGfGZsXKs72d0kvN4C1uQ4jgbKSzYgh6DDXFiYYtSuNq19fA1Lwqan
 641O2vIChJIxTLvGZjryREUb3N1kk9yHzBX9B9JudY0IVAez/8qh3BwaJVzpserAYnNZ
 GdtT7J+aW9tyBi9zD4HjXqEThEF5sNJPj8K9aJH7rAa5pMwqDxSVJR/B+7xGQKYworTs Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xk5vhg1ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:24:58 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43IFOw6T015166;
	Thu, 18 Apr 2024 15:24:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xk5vhg1e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:24:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43IC7mZx023650;
	Thu, 18 Apr 2024 15:24:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cpbbgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:24:56 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43IFOs6G13173398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 15:24:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CE635807A;
	Thu, 18 Apr 2024 15:24:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BB5A5806A;
	Thu, 18 Apr 2024 15:24:53 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Apr 2024 15:24:53 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
        git@jvdsn.com, hkario@redhat.com, simo@redhat.com,
        Stefan Berger <stefanb@linux.ibm.com>,
        Salvatore Benedetto <salvatore.benedetto@intel.com>
Subject: [PATCH v3 1/2] crypto: ecdh - Pass private key in proper byte order to check valid key
Date: Thu, 18 Apr 2024 11:24:44 -0400
Message-ID: <20240418152445.2773042-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418152445.2773042-1-stefanb@linux.ibm.com>
References: <20240418152445.2773042-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nDWcfHAwDmb-6t_M4_EVPKeepNgFtdXL
X-Proofpoint-ORIG-GUID: O41QmvQtGrktv_G-LBPag4FoxLSQl-ti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_13,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180109

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
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/ecdh.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 3049f147e011..c02c9a2b9682 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -27,7 +27,9 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 			   unsigned int len)
 {
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
+	u64 priv[ECC_MAX_DIGITS];
 	struct ecdh params;
+	int ret = 0;
 
 	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
 	    params.key_size > sizeof(u64) * ctx->ndigits)
@@ -40,13 +42,16 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 				       ctx->private_key);
 
 	memcpy(ctx->private_key, params.key, params.key_size);
+	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
 
 	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
-			     ctx->private_key, params.key_size) < 0) {
+			     priv, params.key_size) < 0) {
 		memzero_explicit(ctx->private_key, params.key_size);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-	return 0;
+	memzero_explicit(priv, sizeof(priv));
+
+	return ret;
 }
 
 static int ecdh_compute_value(struct kpp_request *req)
-- 
2.43.0


