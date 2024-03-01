Return-Path: <linux-kernel+bounces-87825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281286D98B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB9E1F2375C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9493B296;
	Fri,  1 Mar 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DiD9OQ/m"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937013A8CE;
	Fri,  1 Mar 2024 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259622; cv=none; b=sf8Abmoffxr32evvY9BMuDJLfIm7bZxHeZNQRKX7aIXvs3KtLcmKVJF4gWBLE84moQNFv6YiowC7Y/xGxHJ6+1VJmH6J01+kKOD7xuUyQtOXT5B+bCv2oQQBfqPLAoylm2LJdlwkwPNA6JExaglnwN4VxY3Tkp65UTvzVueZb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259622; c=relaxed/simple;
	bh=Mw4S8Mathx6d1wOd81xYFMN9D7V8nkcT9m4+08HY+q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFqIbZUugsq2oeLUH0A5J/3PbUrrrT2qbLza5QmWzx3UsDCsoouyzIVDHj7bcIflrNdbZYz1Lwmiscu7hsnh6zYVVCM+2msfBgP4aiHaQSuTsRI+hGbqg5wxBgK92ynrKJVmlXDX/uNn2GLeWLEM3LasPHXgoJdn+mZhARMK9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DiD9OQ/m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42122BLV030375;
	Fri, 1 Mar 2024 02:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2auxadmknAnWxSi7+6MCIOJLf41r1833HhtrUKpLSYg=;
 b=DiD9OQ/meWrjr/r6QorkOFgqidFBRC49Jz5G2OaVDzSQAwGeJbd4OzmimBTudAnqvBHb
 y7tMmF606oqeR73es6g/8SwiHfZPr8VhHQLRh3gViG1+h/rpbVJSdUp5pCUQSY/0APn4
 PV28NHu3Yyd088PEs3xxj7NXp0CE34Z4S8Ee4ed6l2DSDml6VrUJSPmNAAWe7HXvwqlJ
 zJ0rSiwO7LGje4wzTGRB6dPKCv85pemuxUjXemMsFwYihUEvn9+EcV9Se4ETx/RlNH74
 zTp3xxaI14lbDtAkloP3QibjZ3vCNRhV1Ea00pSMaJz/StjVg9/blPhTDhTOwqr6EvvT kQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk5vhgfnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:14 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TNwnoC008827;
	Fri, 1 Mar 2024 02:20:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftsu1w6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4212KBgt5112814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 02:20:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430CB58069;
	Fri,  1 Mar 2024 02:20:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C08B058056;
	Fri,  1 Mar 2024 02:20:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 02:20:10 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 03/12] crypto: ecdsa - Extend res.x mod n calculation for NIST P521
Date: Thu, 29 Feb 2024 21:19:58 -0500
Message-ID: <20240301022007.344948-4-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: NUdTvlOJMN49_EN6KRXZkRgINv-vZmyq
X-Proofpoint-ORIG-GUID: NUdTvlOJMN49_EN6KRXZkRgINv-vZmyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010018

res.x has been calculated by ecc_point_mult_shamir, which uses
'mod curve_prime'. The curve_prime 'p' is typically larger than the
curve_order 'n' and therefore it is possible that p > res.x >= n.

If res.x >= n then res.x mod n can be calculated by iteratively sub-
tracting n from res.x until n > res.x. For NIST P192/256/384 this can be
done in a single subtraction. This can also be done in a single
subtraction for NIST P521.

The mathematical reason why a single subtraction is sufficient is
due to the values of 'p' and 'n' of the NIST curves where the following
holds true:

   note: max(res.x) = p - 1

   max(res.x) - n < n
       p - 1  - n < n
       p - 1      < 2n  => true for the NIST curves

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 64e1e69d53ba..1814f009f971 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -122,7 +122,7 @@ static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash, const u64 *r, con
 
 	/* res.x = res.x mod n (if res.x > order) */
 	if (unlikely(vli_cmp(res.x, curve->n, ndigits) == 1))
-		/* faster alternative for NIST p384, p256 & p192 */
+		/* faster alternative for NIST p521, p384, p256 & p192 */
 		vli_sub(res.x, res.x, curve->n, ndigits);
 
 	if (!vli_cmp(res.x, r, ndigits))
-- 
2.43.0


