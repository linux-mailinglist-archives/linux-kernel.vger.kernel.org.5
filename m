Return-Path: <linux-kernel+bounces-108884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D4E881159
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918591C22A31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869B05472A;
	Wed, 20 Mar 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KxA0T3os"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57404481DF;
	Wed, 20 Mar 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935289; cv=none; b=ETwJEkdcRwCKTRcrHCq8nRb6Cto/mHOGSex/xEivL8U/gXzhushtgAsAASyJfzBEGzxmBIbz/Fig31QRD9JKR1kiQuQ6ew3eT1HFWnNNyRlssyozUrGDjWcinZRsMcW5f2OZau8asfFAQ5KLl8shdJ8CJYaZbr8E3/PXAbcc5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935289; c=relaxed/simple;
	bh=EkGOOuHrH8vkTzw7ddNB7SaUz6qEXO5ZKJjLFRitTMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q91kYHnYCviBrBaqPBHvJ61HNP89Uk7+YAXyorI2PVz9BoIDitCkG3Xf/c4bHWztAUaB0zZYZ6LvhphmDNajINKY+V2urGuwNsRX0F7fv4tjBJn9aJjRPJrc2I0SX29CT5j5dw+e8F+jnfBT76d1FqVMjj8OyfEDkA9yOK8CrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KxA0T3os; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBj7XB022720;
	Wed, 20 Mar 2024 11:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pWY4rMdJA7kx/endSm+rSM2I1de/mMBe3gf2E9g0OA4=;
 b=KxA0T3osYaVe1Qud2KzqBu2OtW2MOSkIJqFFy+KYlUTn4qynK/Ampp6YYuHl+VmgtWQE
 8VIZwnBaMZlTtoSHHPDN/t1pr5Eh8HYtAPa0pPWhfqXe4XS9/1QDDKC9/DaWKGpXASn7
 utqk/FI50c4++gHxE7Lpflka7RUimXD9NsaWH7CC4bJ7zEx3Q3r4qPPKPvSVzb0xmuZ4
 ePThX/3D+uH3mBKf89j4KGJLMkn5wr2lQjvpJIu8T2QNC9z/cbOOQY06gEqCRf1u8G6P
 2UlLbuvcIKdok7GufsDIjPGTAcho0rrAff5JJvnYuXdx2LibT0BGsSwHZPuL6806kLTC 2Q== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyxxr014r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:52 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42K9xkbx010073;
	Wed, 20 Mar 2024 11:47:51 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvav314m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBlmIq14746336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCB3E58064;
	Wed, 20 Mar 2024 11:47:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B5EA58059;
	Wed, 20 Mar 2024 11:47:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:48 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 05/13] crypto: ecc - Add nbits field to ecc_curve structure
Date: Wed, 20 Mar 2024 07:47:17 -0400
Message-ID: <20240320114725.1644921-6-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: Exrkfw9JtR95Ccm_if9BZPXqUSQXKZTY
X-Proofpoint-ORIG-GUID: Exrkfw9JtR95Ccm_if9BZPXqUSQXKZTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200093

Add the number of bits a curve has to the ecc_curve definition to be able
to derive the number of bytes a curve requires for its coordinates from it.
It also allows one to identify a curve by its particular size. Set the
number of bits on all curve definitions.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecc_curve_defs.h    | 4 ++++
 crypto/ecrdsa_defs.h       | 5 +++++
 include/crypto/ecc_curve.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
index 9719934c9428..ab1ef3d94be5 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -17,6 +17,7 @@ static u64 nist_p192_b[] = { 0xFEB8DEECC146B9B1ull, 0x0FA7E9AB72243049ull,
 				0x64210519E59C80E7ull };
 static struct ecc_curve nist_p192 = {
 	.name = "nist_192",
+	.nbits = 192,
 	.g = {
 		.x = nist_p192_g_x,
 		.y = nist_p192_g_y,
@@ -43,6 +44,7 @@ static u64 nist_p256_b[] = { 0x3BCE3C3E27D2604Bull, 0x651D06B0CC53B0F6ull,
 				0xB3EBBD55769886BCull, 0x5AC635D8AA3A93E7ull };
 static struct ecc_curve nist_p256 = {
 	.name = "nist_256",
+	.nbits = 256,
 	.g = {
 		.x = nist_p256_g_x,
 		.y = nist_p256_g_y,
@@ -75,6 +77,7 @@ static u64 nist_p384_b[] = { 0x2a85c8edd3ec2aefull, 0xc656398d8a2ed19dull,
 				0x988e056be3f82d19ull, 0xb3312fa7e23ee7e4ull };
 static struct ecc_curve nist_p384 = {
 	.name = "nist_384",
+	.nbits = 384,
 	.g = {
 		.x = nist_p384_g_x,
 		.y = nist_p384_g_y,
@@ -95,6 +98,7 @@ static u64 curve25519_a[] = { 0x000000000001DB41, 0x0000000000000000,
 				0x0000000000000000, 0x0000000000000000 };
 static const struct ecc_curve ecc_25519 = {
 	.name = "curve25519",
+	.nbits = 255,
 	.g = {
 		.x = curve25519_g_x,
 		.ndigits = 4,
diff --git a/crypto/ecrdsa_defs.h b/crypto/ecrdsa_defs.h
index 0056335b9d03..1c2c2449e331 100644
--- a/crypto/ecrdsa_defs.h
+++ b/crypto/ecrdsa_defs.h
@@ -47,6 +47,7 @@ static u64 cp256a_b[] = {
 
 static struct ecc_curve gost_cp256a = {
 	.name = "cp256a",
+	.nbits = 256,
 	.g = {
 		.x = cp256a_g_x,
 		.y = cp256a_g_y,
@@ -80,6 +81,7 @@ static u64 cp256b_b[] = {
 
 static struct ecc_curve gost_cp256b = {
 	.name = "cp256b",
+	.nbits = 256,
 	.g = {
 		.x = cp256b_g_x,
 		.y = cp256b_g_y,
@@ -117,6 +119,7 @@ static u64 cp256c_b[] = {
 
 static struct ecc_curve gost_cp256c = {
 	.name = "cp256c",
+	.nbits = 256,
 	.g = {
 		.x = cp256c_g_x,
 		.y = cp256c_g_y,
@@ -166,6 +169,7 @@ static u64 tc512a_b[] = {
 
 static struct ecc_curve gost_tc512a = {
 	.name = "tc512a",
+	.nbits = 512,
 	.g = {
 		.x = tc512a_g_x,
 		.y = tc512a_g_y,
@@ -211,6 +215,7 @@ static u64 tc512b_b[] = {
 
 static struct ecc_curve gost_tc512b = {
 	.name = "tc512b",
+	.nbits = 512,
 	.g = {
 		.x = tc512b_g_x,
 		.y = tc512b_g_y,
diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
index 70964781eb68..63d5754e7614 100644
--- a/include/crypto/ecc_curve.h
+++ b/include/crypto/ecc_curve.h
@@ -23,6 +23,7 @@ struct ecc_point {
  * struct ecc_curve - definition of elliptic curve
  *
  * @name:	Short name of the curve.
+ * @nbits:	The number of bits of a curve.
  * @g:		Generator point of the curve.
  * @p:		Prime number, if Barrett's reduction is used for this curve
  *		pre-calculated value 'mu' is appended to the @p after ndigits.
@@ -34,6 +35,7 @@ struct ecc_point {
  */
 struct ecc_curve {
 	char *name;
+	unsigned int nbits;
 	struct ecc_point g;
 	u64 *p;
 	u64 *n;
-- 
2.43.0


