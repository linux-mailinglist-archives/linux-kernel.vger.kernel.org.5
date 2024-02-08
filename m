Return-Path: <linux-kernel+bounces-58780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92984EBA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5781C24014
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C051535CB;
	Thu,  8 Feb 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EMfJ23rS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251214F8AB;
	Thu,  8 Feb 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430753; cv=none; b=XA05+gYvnmNt93BLVnKEPEgxqvHGlOfu0c8mxJ29sOtSLMYrO2CIYw8zG6rj1hiD+6ilj2a2vZeEVA+zN2rrzvt3+23+k5RqKx47euUGpFC+dSwkP8Vw8VyPp+9GhxmGP+fBjHmmP381k1U7RwgHpkwuT3Hby2UlhjRaeVSW4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430753; c=relaxed/simple;
	bh=iDLqYOvXqv0xVY5Kd4dar94Z4Qe+w4rHq4TTjrgyKf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/ODsg0WuJzUY7J5iFyTHmkFURHwhGOdLYKLfnRD8r8oLmdgC+Yeqt1NE03LawJhkRG5sumDc0GhMGFoe5bfr2mIfqLoN6+vuw1QfBOG+1Dw2uWK0EQETKIuDXoU+3Z1woujQ984QUzBWr7n7y9Fpy0YENGGskVt1OR7z179Ct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EMfJ23rS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418KgNiP029745;
	Thu, 8 Feb 2024 22:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=h0e7AaxL4FWmhcgwWJTFxrpBd4ZzW9N+CXKvJr6JwDU=;
 b=EMfJ23rS8gDNsLLO/T2L58tyQlK63L7SZN0tSlcgr/Ic7Wju9pJUy3e326SqZOyGxSYI
 TkqRpzpst3M4fvdKoO5CEDe+Juqo+D/txC+4NaaA1FNn+Af5Wi46iVdoXuXI8B+8OG5/
 Sc1MCJypobB69i8Ybtxd4Clsane38AHcpACynQlSucAJW63HkuYnKzbRrz224cvdOg3y
 DR2PB5ePjWnDE0gyeAh+ZLcoDM7ssOxmWyFqaAN+02tNRIctQpXCxbMfj92/E4Xj/Enx
 +IzgLfHz/qmCusDldKW8RCqIPLoMmQI+gqLtKMuvn1V9ggNUof5HI8Fqcl2U3wPSv2GI AQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w567j1vky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418LH5iD008623;
	Thu, 8 Feb 2024 22:19:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221kf5dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:04 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ33Y23921344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67C1C58060;
	Thu,  8 Feb 2024 22:19:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F37CC5805A;
	Thu,  8 Feb 2024 22:19:02 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:19:02 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 06/14] crypto: ecc - Add NIST P521 curve parameters
Date: Thu,  8 Feb 2024 17:18:32 -0500
Message-ID: <20240208221840.3665874-7-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: uc6HJwvpMD_kEWR45ndVA4x_8IgAdndw
X-Proofpoint-ORIG-GUID: uc6HJwvpMD_kEWR45ndVA4x_8IgAdndw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=873 mlxscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080124

Add the parameters for the NIST P521 curve and define a new curve ID
for it. Make the curve available in ecc_get_curve.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c            |  2 ++
 crypto/ecc_curve_defs.h | 44 +++++++++++++++++++++++++++++++++++++++++
 include/crypto/ecdh.h   |  1 +
 3 files changed, 47 insertions(+)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 0734cea284a4..73fbbfc8d69c 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -60,6 +60,8 @@ const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 		return &nist_p256;
 	case ECC_CURVE_NIST_P384:
 		return &nist_p384;
+	case ECC_CURVE_NIST_P521:
+		return &nist_p521;
 	default:
 		return NULL;
 	}
diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
index 9719934c9428..93a47a5d460a 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -86,6 +86,50 @@ static struct ecc_curve nist_p384 = {
 	.b = nist_p384_b
 };
 
+/* NIST P-521 */
+static u64 nist_p521_g_x[] = { 0xf97e7e31c2e5bd66ull, 0x3348b3c1856a429bull,
+				0xfe1dc127a2ffa8deull, 0xa14b5e77efe75928ull,
+				0xf828af606b4d3dbaull, 0x9c648139053fb521ull,
+				0x9e3ecb662395b442ull, 0x858e06b70404e9cdull,
+				0xc6ull };
+static u64 nist_p521_g_y[] = { 0x88be94769fd16650ull, 0x353c7086a272c240ull,
+				0xc550b9013fad0761ull, 0x97ee72995ef42640ull,
+				0x17afbd17273e662cull, 0x98f54449579b4468ull,
+				0x5c8a5fb42c7d1bd9ull, 0x39296a789a3bc004ull,
+				0x118ull };
+static u64 nist_p521_p[] = { 0xffffffffffffffffull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0x1ffull };
+static u64 nist_p521_n[] = { 0xbb6fb71e91386409ull, 0x3bb5c9b8899c47aeull,
+				0x7fcc0148f709a5d0ull, 0x51868783bf2f966bull,
+				0xfffffffffffffffaull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0x1ffull };
+static u64 nist_p521_a[] = { 0xfffffffffffffffcull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0xffffffffffffffffull, 0xffffffffffffffffull,
+				0x1ffull };
+static u64 nist_p521_b[] = { 0xef451fd46b503f00ull, 0x3573df883d2c34f1ull,
+				0x1652c0bd3bb1bf07ull, 0x56193951ec7e937bull,
+				0xb8b489918ef109e1ull, 0xa2da725b99b315f3ull,
+				0x929a21a0b68540eeull, 0x953eb9618e1c9a1full,
+				0x051ull };
+static struct ecc_curve nist_p521 = {
+	.name = "nist_521",
+	.g = {
+		.x = nist_p521_g_x,
+		.y = nist_p521_g_y,
+		.ndigits = 9,
+	},
+	.p = nist_p521_p,
+	.n = nist_p521_n,
+	.a = nist_p521_a,
+	.b = nist_p521_b
+};
+
 /* curve25519 */
 static u64 curve25519_g_x[] = { 0x0000000000000009, 0x0000000000000000,
 				0x0000000000000000, 0x0000000000000000 };
diff --git a/include/crypto/ecdh.h b/include/crypto/ecdh.h
index a9f98078d29c..9784ecdd2fb4 100644
--- a/include/crypto/ecdh.h
+++ b/include/crypto/ecdh.h
@@ -26,6 +26,7 @@
 #define ECC_CURVE_NIST_P192	0x0001
 #define ECC_CURVE_NIST_P256	0x0002
 #define ECC_CURVE_NIST_P384	0x0003
+#define ECC_CURVE_NIST_P521	0x0004
 
 /**
  * struct ecdh - define an ECDH private key
-- 
2.43.0


