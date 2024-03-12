Return-Path: <linux-kernel+bounces-100674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A24879BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434F12882B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD1114404A;
	Tue, 12 Mar 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GM4wKJyp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523FA1420DF;
	Tue, 12 Mar 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268677; cv=none; b=Y29MnCW1zvKrXylVxz0CPORKijqOIORXa4P7LShLIK5YGSKLpwe0WNFu5ts/DUq9H5yucsiciVdKcW66/KUC3WImnn0HIvC+Bphfjop6oE3fMWPKVVyyWxHxtQNKjvrtuZystA6+SjUHxr3ukne0vvHDFtx6RnaWsh7iWElAnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268677; c=relaxed/simple;
	bh=XOb7BR/hTAGHOU9J4ob29uAauismROveua5qDFaTihE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGuZHDpU1EWECpw3TAU6mMAty5TSsUMxiiBZE3aHM63k97OFLZ7NBdMoVI9SBM+uKDM/i6qzq+tAYjoLqY3sqz2+y3rnlUJMqmHT2WHu+yQLRXq3gi83vehQYxqBnSGKSlw0RW1lZ5rcEofLg/m6ZsFGdSob9JhVqtoS2GYOgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GM4wKJyp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CI2kvu007010;
	Tue, 12 Mar 2024 18:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tF7ZIM+bYalFMFtJm3H+CWjTZYpJ0AwQuISxV0Z1c7s=;
 b=GM4wKJypJpyO8ijCOmh5x0aJjebXl5nkxbKyTW9K+3Ng4pN2REmrRu/b7+vystA/ajCH
 cQyG+MAhRqDLIF4Jl+fI3CEzS1FxEh0mKJNzRbKRN/MbEaEUBMLLMOZAELBBEodhpV0S
 umSD1bJfS1V3e9UigE6XxRQo48KRvfCaPcf/rLipCzSUpGow8f4ejNxAs9d5ZRSdBTTw
 vNZn6ca8Dii/ConUsAgeSWqbwx1WcQF3ZeKQ1VWmD20v3jPA58R40k86lMDso9sPVDOi
 PurbTM2d4kNBLVNAOUwlkr8DN66cnoYQPOQW6yRyt9f5i5nvaIAvFwzvWeKj7bPjTgiB OQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtuyw0hdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:34 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CHEcq5018189;
	Tue, 12 Mar 2024 18:36:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23t94ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:33 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CIaVmi44171582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 18:36:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76B5858056;
	Tue, 12 Mar 2024 18:36:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8709858055;
	Tue, 12 Mar 2024 18:36:28 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 18:36:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 08/13] crypto: ecc - Add NIST P521 curve parameters
Date: Tue, 12 Mar 2024 14:36:13 -0400
Message-ID: <20240312183618.1211745-9-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -U7Drbih3zmLhDQOuvenM0m4sRqrNz29
X-Proofpoint-ORIG-GUID: -U7Drbih3zmLhDQOuvenM0m4sRqrNz29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_11,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120139

From: Stefan Berger <stefanb@linux.ibm.com>

Add the parameters for the NIST P521 curve and define a new curve ID
for it. Make the curve available in ecc_get_curve.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecc.c            |  2 ++
 crypto/ecc_curve_defs.h | 45 +++++++++++++++++++++++++++++++++++++++++
 include/crypto/ecdh.h   |  1 +
 3 files changed, 48 insertions(+)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index ead40b5ebb46..4f6fa8617308 100644
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
index ab1ef3d94be5..0ecade7d02f5 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -89,6 +89,51 @@ static struct ecc_curve nist_p384 = {
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
+	.nbits = 521,
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


