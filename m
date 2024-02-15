Return-Path: <linux-kernel+bounces-67803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD6857145
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D421F22DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C241468EB;
	Thu, 15 Feb 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pa/H6iWS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4B145B17;
	Thu, 15 Feb 2024 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038875; cv=none; b=o5H8ravn/wRClk4feYkVhnhQtZWwp/GUf5mAca4dhAHZ2DQE8XC2Wh6TxF9T4/Dnqqc4ONJgA7JBEYIcohvSm00pfh/AqJGFRWuKSrrULqy+yTXDyGE6zcTkgYxgYvSAjEuGI1cLQJAO4MmD499pxfShrXTtfs7GgKKM0UFhaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038875; c=relaxed/simple;
	bh=m2TaemDn6VOPXxzBXON39efWcNC70vFPbuEBVxWVBh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4gVkguvySzQ64yEVMrw+LP8J2BqOoMYWSWSkHL2SxBjs6w5JB0QrOtj0eb4zwo0GCELP6FGqma0z9BsueBezpwhk6XCNAu+vioSpoKKA12aBlE/azFFfCxhtb556V85UISkzdl5mqDRuc5+BPMgtKDsBYZENVcPFQZZO669Y/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pa/H6iWS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FMWXGZ031925;
	Thu, 15 Feb 2024 23:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CVFTJNtYaFsMOYtJ9BYMmc6KkF18ql+KPoVKGYyY/VQ=;
 b=pa/H6iWSWC+ENjrfbGadILIf84x8YDMSTIFkQNrtQUtkBuUyKCdHy86bASVoOjccEg/g
 nza2ASRdhXZRGldJb+eDzEI3iMUFLsg+lMKeUujYsxDoOWrd2SkV6+T7ye9qDuW1qvym
 6O2dLUFNWongKyM00HyPcfOorrYmpbhVHhXP9gdl/PJX1M+7x9u16qKGEiNaFqUcXn0h
 yYjvBAN2zcndHQ8l5KYxRqvDVkrb4LVvwlAdlVRRbmDYI5rSLKjTIF11Gi+RMNFS+PDa
 DuSRe+9CUBpPdgfnd0N8ssWgLd/QKUUhY23e4cIWMTJ6xW1/4S/GTKgloi4PZCQxF7sM Ow== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9rmnx12v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:28 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLA9VG009886;
	Thu, 15 Feb 2024 23:14:27 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p637dus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:27 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FNEOj419661504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:14:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7823D58050;
	Thu, 15 Feb 2024 23:14:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDBBE58061;
	Thu, 15 Feb 2024 23:14:23 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 23:14:23 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 05/14] crypto: ecc - For NIST P521 use vli_num_bits to get number of bits
Date: Thu, 15 Feb 2024 18:14:04 -0500
Message-ID: <20240215231414.3857320-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215231414.3857320-1-stefanb@linux.ibm.com>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: toA10TGl9uVo4R5tqWNEMpEeJ2DrZx-6
X-Proofpoint-ORIG-GUID: toA10TGl9uVo4R5tqWNEMpEeJ2DrZx-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150181

In ecc_point_mult use vli_num_bits to determine the number of bits when
using NIST P521. The change is required specifically for NIST P521 to
pass mathematical tests on the public key.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index ea7b28b5e00e..0734cea284a4 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1326,7 +1326,10 @@ static void ecc_point_mult(struct ecc_point *result,
 	carry = vli_add(sk[0], scalar, curve->n, ndigits);
 	vli_add(sk[1], sk[0], curve->n, ndigits);
 	scalar = sk[!carry];
-	num_bits = sizeof(u64) * ndigits * 8 + 1;
+	if (ndigits == 9 && !strcmp(curve->name, "nist_521"))
+		num_bits = vli_num_bits(scalar, ndigits);
+	else
+		num_bits = sizeof(u64) * ndigits * 8 + 1;
 
 	vli_set(rx[1], point->x, ndigits);
 	vli_set(ry[1], point->y, ndigits);
-- 
2.43.0


