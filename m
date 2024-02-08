Return-Path: <linux-kernel+bounces-58777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F7384EB99
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710491C2405A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5045C51C23;
	Thu,  8 Feb 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R9bu96Z+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4904F888;
	Thu,  8 Feb 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430752; cv=none; b=LiZpdDKfQOU0KmrEM4wWW6NFkeQwJM5bKUsjwUKxhI6db9gJTXNQHuaeteRRm4aIHY9P7olGVsduU0aN0tUPVX/K13UCpW9ikHqcvRT21Gpm1i11vXAUgSjpSwzUlVW1A5wx/MTclLJWUkY3Dmz/EPRD0DdcezZyOrVlSwhq92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430752; c=relaxed/simple;
	bh=GGxYwqEr4nZvj1FkGgc3kDB/zoEFsqjC4bu6NegmesQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nuie8z1yQzzFyyc407MS97RMWuvGbrCgCMtyrcXYokRcN545YU38SACA9UCsCfHwYpGulxZcaReOt6wwNXzY+m91mWzkgM97PgoHyKRQsNavflIWIx62cFUbiHAGJd/RI0QMISMkQ/pjJz9NmhblR+gfL6+q3KoC6kSd0wdOmb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R9bu96Z+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418KwcIr013617;
	Thu, 8 Feb 2024 22:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DRGA0p86ciek27WTDGmQmhw7gPBSFeUUALtteKUO0l8=;
 b=R9bu96Z+WNB9ZCI8B/0FqMn9/g9bbAEPqtHh9Nc3AMtZVp9uCgjIuS68E0y4BiyIu0Tb
 TZ0OT/sqJ85W6Um//sSM1wxVawBh1cBUoBf/okWNIlfJRNBOFL92I2QTv/T5xuGjK2o2
 5+iE+n3Jwqr/Azd5Pb2Dvxn02aIMAMXZGNYXiRkpsN451Afgtvi3i4KtVsjqZLwrhdCa
 KpGSKXssncYph7Tb8F3uCZyXWlyrJwLmIKtw593SvA9pJDMromwULoz7CtbrTeAUADIA
 ifL6KsOUfMyGZTOmUWiqx29zp6JFRZkYfxeBLC3tQUUCpaOXK06U0mX8ZoGZ+yERAmwa mg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w56fa9pbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418Kowiq014739;
	Thu, 8 Feb 2024 22:19:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tp7haj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:02 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ1um17367716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3D4B5803F;
	Thu,  8 Feb 2024 22:19:01 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51DB95805A;
	Thu,  8 Feb 2024 22:19:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:19:01 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 03/14] crypto: ecdsa - Adjust res.x mod n for NIST P521
Date: Thu,  8 Feb 2024 17:18:29 -0500
Message-ID: <20240208221840.3665874-4-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: MYjUlFWUa1TtWxFJjhpXbc_2SYhywFZk
X-Proofpoint-ORIG-GUID: MYjUlFWUa1TtWxFJjhpXbc_2SYhywFZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080124

When res.x >= n then res.x mod n can be calculated by iteratively sub-
tracting n from res.x until n > res.x. For NIST P192/256/384 this is done
in a single subtraction since these curves' 'n' use all the 64bit digits.
This is also significantly faster than a modulo operation. For NIST P521
the same could take multiple subtractions. However, during testing with
varying NIST P521 keys it was never necessary to do any subtraction at all.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 228f675ac2ed..c9b867a9cbb9 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -121,8 +121,8 @@ static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash, const u64 *r, con
 	ecc_point_mult_shamir(&res, u1, &curve->g, u2, &ctx->pub_key, curve);
 
 	/* res.x = res.x mod n (if res.x > order) */
-	if (unlikely(vli_cmp(res.x, curve->n, ndigits) == 1))
-		/* faster alternative for NIST p384, p256 & p192 */
+	while (unlikely(vli_cmp(res.x, curve->n, ndigits) == 1))
+		/* faster alternative for NIST p521, p384, p256 & p192 */
 		vli_sub(res.x, res.x, curve->n, ndigits);
 
 	if (!vli_cmp(res.x, r, ndigits))
-- 
2.43.0


