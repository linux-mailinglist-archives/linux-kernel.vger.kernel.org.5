Return-Path: <linux-kernel+bounces-58778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55084EB9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D5F1F22235
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521B351C30;
	Thu,  8 Feb 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NwMFCaGl"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF564F894;
	Thu,  8 Feb 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430752; cv=none; b=icicp2q1Hp7QxVJEazB7hRJ9OZFVHJ5yWHZ+pbdy+4ZTm793EdjdMUqD2+LyJ6w7hjDQejE58K1GL9Dm9pVKq1Zba29SUIeRjJc5NWHfOCkaq94j27pVmVV2TV5/gj6SgMXwq3sUrzsZvKEbTiGew67AWXi073CKZwsGdzvxlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430752; c=relaxed/simple;
	bh=4gmnt0N+ElRQcbrv32rTMnC0LI2f7oMrwo91K3z9nhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHTwuNdf3iWz1gsLKqCkTiqRa27KWYI2Gvx/rdse5W3iVWdRVHd4mCxJKtj2ByC5t/Ci4cc1AmXw48UGVHJdu7IW+5RKCD7SUnjq0ODeyfUwPsjoYEYDuCjcjNnLF28ZtaFrspZuVCZZiLNM5uJ58VVeTgRIlazmsIJ/LivdTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NwMFCaGl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418KgZih030158;
	Thu, 8 Feb 2024 22:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MinIzDKfCKQy6B0slQpidM9BwLl++KcE0MImdVgZ1ZI=;
 b=NwMFCaGllOmPeQqa0zkxYpQ8TJpi91DB75hg5+vw3FFIr1qqlYsovlhIrS92lWU9Uafy
 4yi+MrA6DDTEL/VbLwpyQ+i1vklfqCryuCwDLV21SIFoC2/vqhV1P7ZIWbzCnt212jvF
 Hhp8MCG7Mc5mVYJ4yTuX1ZZgLA5oChjDzSnPYxFGwxdGDz+1Y6In+NsBG69M6GeHFYht
 AJQntPycIGOmGmD+fY8E8OCXaxj6fGgLpwvHC+flyeK9egrllpcU1SZJrawAHr5th995
 ibcAcQ4Nd58cC/5Mcyk4zjtd0dZt3nGm0hskoXI1MUwxwIaBmCIKAip0+Sf0xf7KEhml QA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w567j1vn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418LQojD016148;
	Thu, 8 Feb 2024 22:19:06 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h2f2mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ68k49938712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 179B45805A;
	Thu,  8 Feb 2024 22:19:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44815803F;
	Thu,  8 Feb 2024 22:19:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:19:05 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 11/14] crypto: Add nbits field to ecc_curve structure
Date: Thu,  8 Feb 2024 17:18:37 -0500
Message-ID: <20240208221840.3665874-12-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: TFepVx9K1KIaRqgTmhEkdMAAtvfYg9rl
X-Proofpoint-ORIG-GUID: TFepVx9K1KIaRqgTmhEkdMAAtvfYg9rl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=861 mlxscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080124

Add the number of bits a curve has to the ecc_curve definition. This field
only needs to be set for curves that don't fill up all bytes in their
digits, such as NIST P521 which has only 9 bits in the most significant
digit. This field will be used to determine the number of bytes a curve
requires for its key coordinates for example.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc_curve_defs.h    | 1 +
 include/crypto/ecc_curve.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
index 93a47a5d460a..09a221657c31 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -119,6 +119,7 @@ static u64 nist_p521_b[] = { 0xef451fd46b503f00ull, 0x3573df883d2c34f1ull,
 				0x051ull };
 static struct ecc_curve nist_p521 = {
 	.name = "nist_521",
+	.nbits = 521,
 	.g = {
 		.x = nist_p521_g_x,
 		.y = nist_p521_g_y,
diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
index 70964781eb68..337a44956926 100644
--- a/include/crypto/ecc_curve.h
+++ b/include/crypto/ecc_curve.h
@@ -23,6 +23,8 @@ struct ecc_point {
  * struct ecc_curve - definition of elliptic curve
  *
  * @name:	Short name of the curve.
+ * @nbits:      Curves that do not use all bits in their ndigits must specify
+ *              their number of bits here, otherwise can leave at 0.
  * @g:		Generator point of the curve.
  * @p:		Prime number, if Barrett's reduction is used for this curve
  *		pre-calculated value 'mu' is appended to the @p after ndigits.
@@ -34,6 +36,7 @@ struct ecc_point {
  */
 struct ecc_curve {
 	char *name;
+	unsigned int nbits;
 	struct ecc_point g;
 	u64 *p;
 	u64 *n;
-- 
2.43.0


