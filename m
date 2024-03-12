Return-Path: <linux-kernel+bounces-100667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ECD879B89
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C2D1F21CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B1C13E7DD;
	Tue, 12 Mar 2024 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtWVy0wU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8001419AA;
	Tue, 12 Mar 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268662; cv=none; b=c5ogobWLCeIQPmQkEG08l9xLOA70uNA69LYfYWrpNDsDnPOnSgHQ9sX0MmtXN5491P69YwMMPH8j7CHMB2pWdd9gigBmYMsppohzHJMDtOckGwvHRfvtdtC1VtTk8PPVfXUXZSilxQdwF8rVZowq5D52G+dSiLE7wjtqmVtwj7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268662; c=relaxed/simple;
	bh=TSLPr7b+wAm3zSgyN3CDdOEgJdMlO6qG1aDMGbo1bP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzcxMlaL162LFJkErhww6dBICn4gq/Gimp4bQUa5fn62w39QMb+F9RqCIhXt4fVLFL/4zswGp2BwC7us6EGnP7oit3J6WUQZHVrJU75g51yHo2lzsp68cbl8Ft1bvZV9eb4fv1cBu7O/RuG56C0GrwNmi6SyfGApuTRmdX3ToYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtWVy0wU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CINcDh013879;
	Tue, 12 Mar 2024 18:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=V6WyQxUw5Ewc5jNaJf6wut9pClXeaXW1p8bi4fDWFjc=;
 b=qtWVy0wUP7agme7sP6hphmXh0rCcBok27dhsHiO8yyrvNqX6kK2L8yE6DhmtA2BR77xk
 g7MeTB1m2ymso77LjAeUgiYvAHHN8hkXiPu6HmIUwgaTI1m9RwT/B0hSwx287Ymrkc5w
 P3qzpLAZWSYYumhI2QFlgL5CODBlXB8OxNr82AVEjvp/EkkHvIhOKX+E6gOR/ljG7S5J
 py+1BTnoAvk+o+f1jeG7i/mcy0dTVdW/4uyJkV3DQ2t8RrCw3SooC5ix6uIxe9owWANu
 mWi3Uycbyh6cvWDKvvDiYaiA0UlQiM/OOkCUYG2leY9k37IzeL+C2hKMmQAQQA1HE21j 9Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtv9d86ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:29 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CHZQ16018575;
	Tue, 12 Mar 2024 18:36:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t20d1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:28 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CIaQwH18612754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 18:36:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EF6158067;
	Tue, 12 Mar 2024 18:36:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ED7B58062;
	Tue, 12 Mar 2024 18:36:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 18:36:25 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 05/13] crypto: ecc - Add nbits field to ecc_curve structure
Date: Tue, 12 Mar 2024 14:36:10 -0400
Message-ID: <20240312183618.1211745-6-stefanb@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: pH-69WpVsERvfCjyFIgR7gBboZN9gIMf
X-Proofpoint-ORIG-GUID: pH-69WpVsERvfCjyFIgR7gBboZN9gIMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_11,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120139

From: Stefan Berger <stefanb@linux.ibm.com>

Add the number of bits a curve has to the ecc_curve definition and set it
on all curve definitions.

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


