Return-Path: <linux-kernel+bounces-67807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C4857153
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC14D2810B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10A14830D;
	Thu, 15 Feb 2024 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kJCS3n4D"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410D1474A4;
	Thu, 15 Feb 2024 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038878; cv=none; b=Mlx/ego0ZV4SKJfUUHL53VO/0gP3KSLVT9ajUZnkMQXSWCwYIbVrYGNdxiKP8tH/dd3svQwPgyrPO/74RPQn6U3D/9cMKhInFUK90Q30P1cfxp9epOssyLPKhJuh2bStVncw138AcvODIoBoxOvwPmr/pEqYe8SJ6jVE1FXlkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038878; c=relaxed/simple;
	bh=6qLIPqSabW6RW0OWsYRTTEWkOu71GbSE4Aw7FmVAmlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoKz6NSRPlK43T7iet7ITFdMLBy8Yrw0vJsEqsRvWzJLkXNq4IVL94Bya6laYddxyEgxTcbzboQKQktIOMLVaYGMPqwBudre/0ybBeyu5Ip6ayDTvDushlxjkJMF90kxmH71irykLvEWNdwND6lNskMMQbLJulFjqMbed7eg/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kJCS3n4D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FMkmQI018163;
	Thu, 15 Feb 2024 23:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gXqWIgZmXlBKbikHv5ne67VayakspN2QeljIzb45JEc=;
 b=kJCS3n4DMUtvYkKSf3Nfc0RPaE/oiv/K6CNuCsnMqQQqyeHiA9Bg1FQY3JVHleg0K3my
 k9TiOl4PGPUdxCI7y/Utg5Zi2Da8dQTnXgOEXFORq1eAWujBqrvmE+HrLm+e4xP1Wyge
 kLZFCH8sNQXKLYpXrAVYeb/G7STL36uPb2muF/elXu4jDYVuYYckiOaVxTJoAbseRvhv
 eaXrzPD8Rz+KIh3bkH7rqFacXw3e1fAjTdqI3Nqp3vYIJwJBcz6Vn0IkXtFABY3iicXr
 N/D4bhzLAoQOaZ7abzsjLat+EXBqsZxq960JL0Exwhrcw3uUEkySw0Djxm3ebWrp2Kfn Nw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9ugch28a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLHWEQ009935;
	Thu, 15 Feb 2024 23:14:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p637dv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:30 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FNER0V14877348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:14:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE3E458045;
	Thu, 15 Feb 2024 23:14:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A14358050;
	Thu, 15 Feb 2024 23:14:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 23:14:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 09/14] crypto: ecdh - Use properly formatted digits to check for valid key
Date: Thu, 15 Feb 2024 18:14:08 -0500
Message-ID: <20240215231414.3857320-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215231414.3857320-1-stefanb@linux.ibm.com>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: COvWtIQGoIFyGOrtHwxszZih0RV0XK8_
X-Proofpoint-GUID: COvWtIQGoIFyGOrtHwxszZih0RV0XK8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150181

ecc_is_key_valid expects a key with the most significant digit in the last
entry of the digit array. Currently a reverse key is passed to
ecc_is_key_valid that then passes the rather simple test checking whether
the private key is in range [2, n-3]. For all current ecdh-supported
curves (NIST P192/256/384) the 'n' parameter is a rather large number,
therefore easily passing this test. Fix the format of the digit by using
ecc_digits_from_bytes to create a temporary private key and pass it to
the test function. Keep the swapped key in ctx->private_key.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdh.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 80afee3234fb..f187365db7b6 100644
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
+	memcpy(ctx->private_key, params.key, nbytes);
+	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
 
 	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
-			     ctx->private_key, params.key_size) < 0) {
+			     priv, params.key_size) < 0) {
 		memzero_explicit(ctx->private_key, params.key_size);
 		return -EINVAL;
 	}
-- 
2.43.0


