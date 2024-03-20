Return-Path: <linux-kernel+bounces-108873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD78881135
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7C21F22F34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0783FBBB;
	Wed, 20 Mar 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BGZZkzXr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB503F9CD;
	Wed, 20 Mar 2024 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935282; cv=none; b=ZbNiqGHwx1zxQ5MhtBhD4ItxSiatGlF68pIe6DDg+LXhs9fTzD1X6GKnXb8eYM+hzCDVNFFlncML01lycUuEkA2IbkzjM1T7sMqnL7BqOcidIuYj/nrdCuS2bVqwIdreyZoqdhYnjZSyeJH0LRATWmGmSUT2cgstXCoENtzKraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935282; c=relaxed/simple;
	bh=VuXnyWK+oTi5rXjJkYlrTmxyXTkffXXblFiz1RaEdiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTChS0Cm4H0vslMMftiOaeOy0Xjur6MRoOk5/ckSO6AmOR+LLCsznOkIctkKZNSD8KorOYdHSYtLneV5fbcu6QZ100w3gDOrKQqVNjeJZWE0MzfvVUvp+hv5Pb+qKBbic/mNFBRCPXQ726tbLQyVq/NzbD4Qag4QdzSq31XVs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BGZZkzXr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBB9Gs018085;
	Wed, 20 Mar 2024 11:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aiSTuVnuK5ak9LWl6r/aXDZHUbtvdgr4VlC6QlQ1LIo=;
 b=BGZZkzXrdv2pOCAPAeYze9XDh4WOaEg1tME2ioLlAfiZq70tuJtFYy8IS/JFdDUwNg/t
 2VN1MiFzNVLJ3xAFLCLC/vvkDjz7Xntqwqbml/b4SYA0m24qYS8f6fEBDqT/CV8hl4/T
 2euBTz1OxHCQsxQHW75QRnsPwtqLDu9nbuHQLKc1cEH8k6WOcdHFkCxPzNkJbE5/uyPH
 ia+IU4/EWA49mjBBpwWDcZaUrv0pw5TKeetdLV2+wBQd7phTKmRanTTwA42t7SbgcLk9
 EbGbRijm2Ti+w+lU2o12SQ61UCggAIZqy2Z4EKT6JeAF/dC5AmR0OPWKokpY0i7BF9+Q KQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyxbr83sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42K9Jprb011558;
	Wed, 20 Mar 2024 11:47:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8m5wet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBlmBY20644402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12AD458057;
	Wed, 20 Mar 2024 11:47:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7270D58061;
	Wed, 20 Mar 2024 11:47:47 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:47 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 04/13] crypto: ecdsa - Extend res.x mod n calculation for NIST P521
Date: Wed, 20 Mar 2024 07:47:16 -0400
Message-ID: <20240320114725.1644921-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320114725.1644921-1-stefanb@linux.ibm.com>
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G0TD6Hx1YKt59siXYUFRfZ0e7YJfptZQ
X-Proofpoint-GUID: G0TD6Hx1YKt59siXYUFRfZ0e7YJfptZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200093

res.x has been calculated by ecc_point_mult_shamir, which uses
'mod curve_prime' on res.x and therefore p > res.x with 'p' being the
curve_prime. Further, it is true that for the NIST curves p > n with 'n'
being the 'curve_order' and therefore the following may be true as well:
p > res.x >= n.

If res.x >= n then res.x mod n can be calculated by iteratively sub-
tracting n from res.x until res.x < n. For NIST P192/256/384 this can be
done in a single subtraction. This can also be done in a single
subtraction for NIST P521.

The mathematical reason why a single subtraction is sufficient is due to
the values of 'p' and 'n' of the NIST curves where the following holds
true:

   note: max(res.x) = p - 1

   max(res.x) - n < n
       p - 1  - n < n
       p - 1      < 2n  => holds true for the NIST curves

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 64e1e69d53ba..1814f009f971 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -122,7 +122,7 @@ static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash, const u64 *r, con
 
 	/* res.x = res.x mod n (if res.x > order) */
 	if (unlikely(vli_cmp(res.x, curve->n, ndigits) == 1))
-		/* faster alternative for NIST p384, p256 & p192 */
+		/* faster alternative for NIST p521, p384, p256 & p192 */
 		vli_sub(res.x, res.x, curve->n, ndigits);
 
 	if (!vli_cmp(res.x, r, ndigits))
-- 
2.43.0


