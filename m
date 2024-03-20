Return-Path: <linux-kernel+bounces-108874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BBD88113B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D9F1C2279E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC8340847;
	Wed, 20 Mar 2024 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lVMoeFU6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3EC3F9CF;
	Wed, 20 Mar 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935283; cv=none; b=L4QVX8jPSy+znI5P8+opqNqjGmU815gWv/O9JdvzGnPjUEsRbneN1KkpR4R9iIpH8pkgZ00jHBOhXm/kui7jgUwTbxL97usl93OmqONy5jk7Agxv9ksOgki/Xyiqv3c3bhb3ICbaHvjURZRQ7p3C5n8uP1VsMYInvzzeNzsxWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935283; c=relaxed/simple;
	bh=EOb9/l2e15nPHK123SEuQfZdbHocz8yvT6YntCAyhHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmT8qAEO0MTHNJU8JJEzQqVQEBaGJf/jwqaIeF1H6JJaEtfRjoU/oceIaz4dTEyLBbEQl3eL35mPbW+pQEyGvnrrtb1Kh4OlHFlkKOho2frMpvOes7c1oqgUq40u+0y1a6dh+dbzvYVde6oLoPn/WbfzXAQyYEZXVbOTUjVjCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lVMoeFU6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KAQ5tL012589;
	Wed, 20 Mar 2024 11:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2iJB6Ca3ZSpW6JZnmE+ktf3dHzeYY6fu73vQlCtlpBw=;
 b=lVMoeFU6wAZzXZJ84gWJf3jC6vGCuUGXAScw+Df8XE81H893tiyiF/uCgxZ719n49XKc
 xNJeRViSh4/p9l7jC73IDTHiaKigsa/R7K9aYmJagfFPKgbwjAYkedFw9vbIFhQzMfWx
 KmRfwSQ8TzBOU7ziwqCqlsvtAmef5tPcLvddQe8qmoagKDVlATo4bVzxOhTNtSFLUx6e
 UM3pXmZC8bPJ6LsowxRQGRgretJDB/uLYV4YSwdPcMeIdwfV9WSCl/PT9FkKQ9Q/t1L9
 C4lwSzlslqC5S8WNAsIIN6XqU59uyBZpxCPYI4OwZK7qNvQVXv1H87XfDee969OMkvQk VA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wywpt871e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KA96m0002778;
	Wed, 20 Mar 2024 11:47:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2nk3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBlpP212517978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4254658059;
	Wed, 20 Mar 2024 11:47:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 859D858058;
	Wed, 20 Mar 2024 11:47:50 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:50 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 08/13] crypto: ecc - Add NIST P521 curve parameters
Date: Wed, 20 Mar 2024 07:47:20 -0400
Message-ID: <20240320114725.1644921-9-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: X0iUM4eGodQuHSircKcgOUrG5L0lV9hf
X-Proofpoint-ORIG-GUID: X0iUM4eGodQuHSircKcgOUrG5L0lV9hf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200093

Add the parameters for the NIST P521 curve and define a new curve ID
for it. Make the curve available in ecc_get_curve.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
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


