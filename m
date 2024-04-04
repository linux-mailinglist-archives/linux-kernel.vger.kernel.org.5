Return-Path: <linux-kernel+bounces-131598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF6B8989E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07173B28719
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B5812F5A8;
	Thu,  4 Apr 2024 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EhED25vu"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64312AAE3;
	Thu,  4 Apr 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240394; cv=none; b=hbyHo0W3qeetvkvew181EPuxx5Rg0Y7vE7EwzoSUzti6hSpgrf2B1DUJFdp9e89MXjagcFFfJ4gdeYdyBxr3JlSX7vLf7dAiz7AfQQCVmcon269vHyeTVqI4KmogjEYLM/KZKzp++/jsk7NIxHJ9n1FEJa3qNF56i1FOa6BkfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240394; c=relaxed/simple;
	bh=tZyptqI//g+KVp+9okP7+M3CahlNK/O8/zq9hHHsAQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjYZt4baVUrkWZIrkOLx4gc23jmvnBaufJ4vJ/SWK+TQZdj5iShjCqsPcXGk66J9L8mG7kjMhAmCdGahv4yf05pRTUF1glSog48OEFL05NoCiIvNM+FaIXqBoUA81TXYFbPzAh86IojNVQuWqZnN+/0jTLtCndOb3WSvZyytjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EhED25vu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434EH9ij027803;
	Thu, 4 Apr 2024 14:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Djd55nUQ85LxBlb+r5zXGNe/eYnywTo5cTUo7JnwO8w=;
 b=EhED25vu1kJnlDmbYQyF+q1Q3TidZ/y7BVcAUquuoEQfH5nz82NJWw9q7ro0HLpUOhUw
 PhyWlW5iC0chQPz8ppF6Iw27edBizVrWCf5aH11ludac8bxWlfiB2IFjQPjI2+tmha16
 rodlh39j62GTg5a4Dsbu3DX1LvTmLDJfQXiFFe+IH39wPe1p0rpSDn6BfMmwmslypvQn
 YC7sDhmnzH9FHgc7y5QcUj3cra2AE69OWq7/Fr7DlidINRdBrlb+Vw+206nu0nSNJA/8
 pdQSmCekXfC0donRNvlDKJ2hRRRMi0DZrBafsaOz4PslO06XLtF7bhwOwgtPt77Jn7aD Wg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wd6r2fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:37 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434DdTuB007723;
	Thu, 4 Apr 2024 14:19:36 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epwmjen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:36 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJYZZ29884850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8ED858064;
	Thu,  4 Apr 2024 14:19:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 161C958055;
	Thu,  4 Apr 2024 14:19:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:32 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 03/13] crypto: ecdsa - Adjust tests on length of key parameters
Date: Thu,  4 Apr 2024 10:18:46 -0400
Message-ID: <20240404141856.2399142-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404141856.2399142-1-stefanb@linux.ibm.com>
References: <20240404141856.2399142-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: azuVYCjbsu9YeUtIOS20Ecs3ZyaRr-h9
X-Proofpoint-GUID: azuVYCjbsu9YeUtIOS20Ecs3ZyaRr-h9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040098

In preparation for support of NIST P521, adjust the basic tests on the
length of the provided key parameters to only ensure that the length of the
x plus y coordinates parameter array is not an odd number and that each
coordinate fits into an array of 'ndigits' digits. Mathematical tests on
the key's parameters are then done in ecc_is_pubkey_valid_full rejecting
invalid keys.

The change is necessary since NIST P521 keys do not have keys with
coordinates that each require 'full' digits (= all bits in u64 used).
NIST P521 only requires 2 bytes (9 bits) in the most significant digit
unlike NIST P192/256/384 that each require multiple 'full' digits.

Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index e819d0983bd3..9462a4d640a7 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -230,7 +230,7 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 	if (ret < 0)
 		return ret;
 
-	if (keylen < 1 || (((keylen - 1) >> 1) % sizeof(u64)) != 0)
+	if (keylen < 1 || ((keylen - 1) & 1) != 0)
 		return -EINVAL;
 	/* we only accept uncompressed format indicated by '4' */
 	if (d[0] != 4)
-- 
2.43.0


