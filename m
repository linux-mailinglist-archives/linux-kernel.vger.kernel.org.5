Return-Path: <linux-kernel+bounces-58774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC05584EB8C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB9A1C24092
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1DB50278;
	Thu,  8 Feb 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XdkyxC2W"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492794F61D;
	Thu,  8 Feb 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430751; cv=none; b=c9H/oH4dYmPtzkqQigmjP/ZObQ9sGy0wr7FTePr0WsDABYy8waZBwZQVZCx08F4Wx9y6jS/hjc0DoQ2a8e2ryHOgVDx66QD6R21//5UpTEVOO6LHjnONkOUc/oBUz9AJpmvRXt7h62ZR0ggHT5xGxvWVeVlB5Btcp7cF7BQJMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430751; c=relaxed/simple;
	bh=aYU1g3Z8rQ/iOUFt9MV6DrDCFLa7ygR/Kgj036V2Gmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Algb9y6B34Xkz5eR1nedjPluy4O24mfF5hSZGi65m5Ya3gHloWUaZKYqz4l1XVKUqvRXqCl5QPDsAfnHYjUXlP1fc0lxarOSBZqmFCid01YWOF2htNjwRCu0lD9KmUZpY33dQqAiq0NjIFd5xOZRvj0dHO/aNs0ITWWpVTOYY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XdkyxC2W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LSTDd018522;
	Thu, 8 Feb 2024 22:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xnGKcx0RffylGuqYrfYFBJvby+ml1t1I+2QRcmXL03Q=;
 b=XdkyxC2Wl7g28JCxoew2o4b8SEse9nO4ZdzpmK7c9OxMjRkK+NZXlrBS7/BQB0A/UwPI
 KAkOUsqDkS8Kk8W2Lp2axO/0KfNDwBi3nPhc5JdOzTDgJste9Sas/TazS/3TqK30YHoq
 oxcONACZPU9R/sqPtBaQ/c9Epw9CgvV3o/brx6HSNuXh8dyH+6Redu6mM6G06G0Zb7fj
 pOGKpn4NwHNGkD3NlNzJncc5D4Nwi7nLRp8LYqm52IFnSPks0Wqy/s0sUCp/fYmCRyTz
 Xi6/Pik9mBFVvyNsujLvYwfEYe0ylIt0hChAaz4Giv0/Gt5OeIrjFuwAcZoNnMCBQjxr Zw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w56w7s0sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:02 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418L0l5S005455;
	Thu, 8 Feb 2024 22:19:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akycmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ1UT17105508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:01 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BD6758056;
	Thu,  8 Feb 2024 22:19:01 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C76185805A;
	Thu,  8 Feb 2024 22:19:00 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:19:00 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 02/14] crypto: ecdsa - Adjust tests on length of key material
Date: Thu,  8 Feb 2024 17:18:28 -0500
Message-ID: <20240208221840.3665874-3-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: ehyKC9COd-02KpZo_agl3D2vthetikYB
X-Proofpoint-ORIG-GUID: ehyKC9COd-02KpZo_agl3D2vthetikYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080124

In preparation for support of NIST P521, adjust the basic tests on the
length of the provided key parameter to only ensure that the length of the
x plus y coordinates parameter array is not an odd number and that each
coordinate fits into an array of 'ndigits' digits. Mathematical tests on
the key's parameters are then done in ecc_is_pubkey_valid_full eliminating
invalid keys.

The change is necessary since NIST P521 keys do not have keys with
coordinates that each fully require 'full' digits (= u64), unlike
NIST P192/256/384 that all require multiple 'full' digits.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index c3748ddc9964..228f675ac2ed 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -230,7 +230,7 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 	if (ret < 0)
 		return ret;
 
-	if (keylen < 1 || (((keylen - 1) >> 1) % sizeof(u64)) != 0)
+	if (keylen < 1 || ((keylen - 1) & 1) != 0)
 		return -EINVAL;
 	/* we only accept uncompressed format indicated by '4' */
 	if (d[0] != 4)
@@ -239,7 +239,7 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 	keylen--;
 	digitlen = keylen >> 1;
 
-	ndigits = digitlen / sizeof(u64);
+	ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
 	if (ndigits != ctx->curve->g.ndigits)
 		return -EINVAL;
 
-- 
2.43.0


