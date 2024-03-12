Return-Path: <linux-kernel+bounces-100672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26617879B98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596211C22BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140F21420D4;
	Tue, 12 Mar 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ru4GYQK9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB114373A;
	Tue, 12 Mar 2024 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268668; cv=none; b=TWbBRsuOrpmn9QnrAtqCHXvWbOw3difYmDvXSccOx1eP6dUW/5BiYGVpEVB7kfTUlvc+yUZQyf2yfFoNyZdPbSScmII5NCEPTMZAE5Evk0Qj/A16hAV2hgnEKfTSluItHyniSbS7/AIan46M3uIcThlteYxotc+1ZYMq2nGUaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268668; c=relaxed/simple;
	bh=b6jwmng7vzAkrmupelqMadrLjhYJvFlGWif2ubfT4D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go5/lSZia/gl92Ik0Jes/e552YGdMrT8QDWqENevnAVQwA1RTS64hx3pYzLiUoCvFhieLrQBUGmvg890jXTqB92DGazdr5Efnu+ws5OFBtnDDPwMb7hR02w1D+SjUHwpA9MZG1MPo/i8iOZLoo9E+4dcIZuYS051imwovpNn1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ru4GYQK9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CI8Og2009071;
	Tue, 12 Mar 2024 18:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ngPPAY4dx0LuwcnzoAqLCstGMQqpEy7cQK28WmndoYk=;
 b=Ru4GYQK9zXcq0VEsyT7Pgtv1C5fEYcvn4SKwPh8sef8Pv1s91zEgBJFTiDznc3AWhdvX
 H3r6GOaGN7XV8UOHxlSJ4MnGiyR5hWW0+4KvAR1UlDQ+OpsN3QDtUIrl6f7X/09dx1dJ
 p7InYGyE2EpoyYdgGO8bFC6F4XjMkpCsxzccJMpXG4Wg+bDkX7k8sYK8bH6VXDQ9bBxh
 Vt8YCczjLedVe/uc4Z+LyDgYaAbztQEKM4YhpVQhIqzpuTS7eVVMbko5vgm9kUQleWD0
 323+xqzTtZ9ZgzRThumwDv0au/MUbZko9EiLWCK4zTJbEoWfB+Qz4uZMFjU3HsJHd5yO ww== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtv2a8cua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:35 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CG7rBx020601;
	Tue, 12 Mar 2024 18:36:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3km0ree-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CIaV9d47120754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 18:36:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A978358064;
	Tue, 12 Mar 2024 18:36:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAE6D5804E;
	Tue, 12 Mar 2024 18:36:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 18:36:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 10/13] crypto: ecdsa - Rename keylen to bufsize where necessary
Date: Tue, 12 Mar 2024 14:36:15 -0400
Message-ID: <20240312183618.1211745-11-stefanb@linux.vnet.ibm.com>
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
X-Proofpoint-ORIG-GUID: kPUxiat4JqQ3jRFHsIqX6f6pDdpqPyAy
X-Proofpoint-GUID: kPUxiat4JqQ3jRFHsIqX6f6pDdpqPyAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_11,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120139

From: Stefan Berger <stefanb@linux.ibm.com>

In some cases the name keylen does not reflect the purpose of the variable
anymore once NIST P521 is used but it is the size of the buffer. There-
for, rename keylen to bufsize where appropriate.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecdsa.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 4daefb40c37a..4e847b59622a 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -35,8 +35,8 @@ struct ecdsa_signature_ctx {
 static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
 				  const void *value, size_t vlen, unsigned int ndigits)
 {
-	size_t keylen = ndigits * sizeof(u64);
-	ssize_t diff = vlen - keylen;
+	size_t bufsize = ndigits * sizeof(u64);
+	ssize_t diff = vlen - bufsize;
 	const char *d = value;
 	u8 rs[ECC_MAX_BYTES];
 
@@ -58,7 +58,7 @@ static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
 		if (diff)
 			return -EINVAL;
 	}
-	if (-diff >= keylen)
+	if (-diff >= bufsize)
 		return -EINVAL;
 
 	if (diff) {
@@ -138,7 +138,7 @@ static int ecdsa_verify(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
-	size_t keylen = ctx->curve->g.ndigits * sizeof(u64);
+	size_t bufsize = ctx->curve->g.ndigits * sizeof(u64);
 	struct ecdsa_signature_ctx sig_ctx = {
 		.curve = ctx->curve,
 	};
@@ -165,14 +165,14 @@ static int ecdsa_verify(struct akcipher_request *req)
 		goto error;
 
 	/* if the hash is shorter then we will add leading zeros to fit to ndigits */
-	diff = keylen - req->dst_len;
+	diff = bufsize - req->dst_len;
 	if (diff >= 0) {
 		if (diff)
 			memset(rawhash, 0, diff);
 		memcpy(&rawhash[diff], buffer + req->src_len, req->dst_len);
 	} else if (diff < 0) {
 		/* given hash is longer, we take the left-most bytes */
-		memcpy(&rawhash, buffer + req->src_len, keylen);
+		memcpy(&rawhash, buffer + req->src_len, bufsize);
 	}
 
 	ecc_swap_digits((u64 *)rawhash, hash, ctx->curve->g.ndigits);
-- 
2.43.0


