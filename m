Return-Path: <linux-kernel+bounces-87831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 255D986D99B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EF32831EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4093D38E;
	Fri,  1 Mar 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cMFML+bG"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC33AC0C;
	Fri,  1 Mar 2024 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259624; cv=none; b=Y5agyxDQAqySxX3gE0IsT8Qlr4tSYD+HWlJWaoPEWJV8Akyf6IXPBMz3hgwaeiPD8JM2ctH0TRUKPjLb7mhaKDA8wSYT1z1ypOWpRvB9vqqAGG9SkHIqlZK3b/NyWSzS+crVGmeJvcDoMupsWr6/lvKxasBEBO+J3cwjQKGrynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259624; c=relaxed/simple;
	bh=r/XPlIwOx+uOF1egmurRBV0dtm13BRmrDJsmtuvs3j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGX+00w5nP4k1gvnBeHPCq44+fYWMLH9Fxf+MhPsXctZ88Q909QA4a774NLBuWSmo95BrjL4bm/1jjy86/pxIoyiH2105ty/9of8GYhrg09sqhltGpMtC408HTCGSwe01zJmxQkf61MH4zSoSc6LCcFSi8hqBeJbZpdS9/+S3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cMFML+bG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4211l8Ut001455;
	Fri, 1 Mar 2024 02:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FAenkrcsPmE6X4u4W2oCGdrzL3Aa2x866KY3vIYRULU=;
 b=cMFML+bG6tTY4yVJZIHl2HMUx7VFJXkzcy49A4L41/n56AVhPBizGkrlJ/ylMXhzgIyS
 UJ4E2KrZ01uxMOlHACalpyHsNY1AyDMxYurEkOj8HvQkhP60twD9h502VVFNw28Wb6VL
 4zaj1cNh+ozl5dvcCG5jFtHdm4jSsPj2AlXOrnwrR8Ha8n32utKGBeBXEc2ZckgjVVvO
 Y7KebGNrv/7gMxAgvafVwt2vsW5qTlxXVaVn4YP9ZanuYmmhzQx6Vc4hTnNAfWIYknWL
 lUproCk0XLp92//aiknW0oSAT5IaZkYXtLmEyJfVcTjAUzCBrNVhFhScQdrj/1/QUHDF 0Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk5nhrxyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:16 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42100Aq2012319;
	Fri, 1 Mar 2024 02:20:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2s511-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:16 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4212KDvZ57213402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 02:20:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CD4E58052;
	Fri,  1 Mar 2024 02:20:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8185D5806B;
	Fri,  1 Mar 2024 02:20:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 02:20:12 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 06/12] crypto: ecc - Add special case for NIST P521 in ecc_point_mult
Date: Thu, 29 Feb 2024 21:20:01 -0500
Message-ID: <20240301022007.344948-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301022007.344948-1-stefanb@linux.ibm.com>
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FQkX0L5JlD8jhpm5-JRuhCmQDYrudCE7
X-Proofpoint-GUID: FQkX0L5JlD8jhpm5-JRuhCmQDYrudCE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010018

In ecc_point_mult use the number of bits of the NIST P521 curve + 2. The
change is required specifically for NIST P521 to pass mathematical tests
on the public key.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index ea7b28b5e00e..3430c2c4e62c 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1326,7 +1326,10 @@ static void ecc_point_mult(struct ecc_point *result,
 	carry = vli_add(sk[0], scalar, curve->n, ndigits);
 	vli_add(sk[1], sk[0], curve->n, ndigits);
 	scalar = sk[!carry];
-	num_bits = sizeof(u64) * ndigits * 8 + 1;
+	if (ndigits == 9 && !strcmp(curve->name, "nist_521"))
+		num_bits = curve->nbits + 2;
+	else
+		num_bits = sizeof(u64) * ndigits * 8 + 1;
 
 	vli_set(rx[1], point->x, ndigits);
 	vli_set(ry[1], point->y, ndigits);
-- 
2.43.0


