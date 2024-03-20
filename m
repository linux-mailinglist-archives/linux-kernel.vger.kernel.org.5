Return-Path: <linux-kernel+bounces-108881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E7881150
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189D5B22190
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC0E4DA12;
	Wed, 20 Mar 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MhroF5ge"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F84315B;
	Wed, 20 Mar 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935287; cv=none; b=mUBSSFJZt0vU+uYOWSUsmUS51kTxRyB8bOLSBy5c7I38nmSs3pfcMAa29g0BuO2+SnHu1fJrodrx+p0jNCJzcMzFkYvpNRiRyCMDDR1b7KWnzJjQ/MZTy2B49kNYJ8fjw2yJKTVtgflHQ5R3Pa6KPSV9+qyKDoxcTiLOHVKj17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935287; c=relaxed/simple;
	bh=aTNcGKZRDkNdIFQJEmnm6v8mNSne4oF/WdznYzYFbxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjqDJSCSvwdJ1j1ETtodeXCNTUx4Ju59sHl8Lpv9o1adYw9pwtHTVUXtsCuVidrbmRPjqE4ADKAogt80NN71OlMLVZcsEHAOk9VoULX6tNLpWHEEXjSw37OYpsORC7I7DTejMxb8aetzICm4HKSQnaki2oEHfYSKEd3Bm1rOHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MhroF5ge; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBj7XA022720;
	Wed, 20 Mar 2024 11:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QIXjQp5VnrgnGPlYmtEBbC74Qvnoo9W+f4ufafZvkqw=;
 b=MhroF5geWTz+8FyN0qRTz1npyBAvFMi+u0uxxV9+8latZ/Pgz79DOyNEwZfH2pa3YyNk
 GklX9u5s6UTxeixT0suogmxBzSw2NVjHk6Bw4RRo56c2vsoptn9Pq6N0PAMMhqvBBAnY
 RLtfDWy2i1loSFgBKvPbCxg7aReoCpfoBGnfDEG5t3cQkhEVfbrb4EfmkbP2SKaaOm8E
 5JSaVtq7Te3++dPK0ti9Z63N7cGLXpR8gyuhQ2cuJK+qH16YtPy0iPMw4rQl/8ZZwwoP
 T7MF7hhtcqiMkTDrxscbzw+iCqxR5bisO7LYOeAvo5eLSqOeEbrIJZWGab64SiZHaaWv kg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyxxr014p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KA96lw002778;
	Wed, 20 Mar 2024 11:47:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2nk30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBllUX56230184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1F0E58065;
	Wed, 20 Mar 2024 11:47:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5124958057;
	Wed, 20 Mar 2024 11:47:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:45 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 01/13] crypto: ecc - Use ECC_CURVE_NIST_P192/256/384_DIGITS where possible
Date: Wed, 20 Mar 2024 07:47:13 -0400
Message-ID: <20240320114725.1644921-2-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: aR-lb3CmwDzAabCcEZDTwaKqbU8cEyAN
X-Proofpoint-ORIG-GUID: aR-lb3CmwDzAabCcEZDTwaKqbU8cEyAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200093

Replace hard-coded numbers with ECC_CURVE_NIST_P192/256/384_DIGITS where
possible.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/ecc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index f53fb4d6af99..415a2f4e7291 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -689,7 +689,7 @@ static void vli_mmod_barrett(u64 *result, u64 *product, const u64 *mod,
 static void vli_mmod_fast_192(u64 *result, const u64 *product,
 			      const u64 *curve_prime, u64 *tmp)
 {
-	const unsigned int ndigits = 3;
+	const unsigned int ndigits = ECC_CURVE_NIST_P192_DIGITS;
 	int carry;
 
 	vli_set(result, product, ndigits);
@@ -717,7 +717,7 @@ static void vli_mmod_fast_256(u64 *result, const u64 *product,
 			      const u64 *curve_prime, u64 *tmp)
 {
 	int carry;
-	const unsigned int ndigits = 4;
+	const unsigned int ndigits = ECC_CURVE_NIST_P256_DIGITS;
 
 	/* t */
 	vli_set(result, product, ndigits);
@@ -800,7 +800,7 @@ static void vli_mmod_fast_384(u64 *result, const u64 *product,
 				const u64 *curve_prime, u64 *tmp)
 {
 	int carry;
-	const unsigned int ndigits = 6;
+	const unsigned int ndigits = ECC_CURVE_NIST_P384_DIGITS;
 
 	/* t */
 	vli_set(result, product, ndigits);
@@ -932,13 +932,13 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
 	}
 
 	switch (ndigits) {
-	case 3:
+	case ECC_CURVE_NIST_P192_DIGITS:
 		vli_mmod_fast_192(result, product, curve_prime, tmp);
 		break;
-	case 4:
+	case ECC_CURVE_NIST_P256_DIGITS:
 		vli_mmod_fast_256(result, product, curve_prime, tmp);
 		break;
-	case 6:
+	case ECC_CURVE_NIST_P384_DIGITS:
 		vli_mmod_fast_384(result, product, curve_prime, tmp);
 		break;
 	default:
-- 
2.43.0


