Return-Path: <linux-kernel+bounces-100666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C7879B83
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDB7285A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD5142621;
	Tue, 12 Mar 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AbnEu5SC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3379141988;
	Tue, 12 Mar 2024 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268661; cv=none; b=CvtQ3ni+5FOwtFGLyDxOgywul954j+ERIMwzx92DOgDwALbIX7VxCzQwnWDBEFvS/iIMY9WRmsgN6MadpMWAPYbr3v4HhwOPVDnUGzYfmjEPLBCHa2NSgo8bvX+/nC8h9QFN9CNefuIqydg66yj81WIADX3KRxAFQePUPzguSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268661; c=relaxed/simple;
	bh=g6MhNKVNd2sXORCesMKXDsVztERU/zlCVXqxRZ2CUVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agCJ1gURRubUoPs6Vk/ixpL3wNWoS+atgkfUtXTV/JFt/AySx2D73JCEQ5mSbWZkyOyH0ifL2WUw7HSQ+Eax5LmdQLGYdK0g4iO9KG97mKG2Y+BG8n5FaGJETUFJUAYE9ieIoniEkVCvNWbGo01BGAWrCIsHQAXEhEYCO1G/l+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AbnEu5SC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CIWTJQ012215;
	Tue, 12 Mar 2024 18:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z9rsgPyclqEJ8S5g9WAxh75Oeb6VzjDjKOTMGoqYnio=;
 b=AbnEu5SCf74j/3MZVU4U5l0SgZ0D/hXi7PACI89Dknlzs4gXueqK+ajij9TsolStRTZN
 2JTviy25yU+XIcivOC5UCQjteP+tRgPKbH87qI6e3RY+koY+Or+1raZsn5g9aSrp6DnU
 oEm1MoBeT5kVIPiivuotBwi8O3mQuZHjKdH3UPdTY02b8JOYcuYYPRqMqhD2bQ3P+uqn
 OFNgCuLXwB1tTJKGYcGG+FfKK0gmPuhHnSd8cqLiKEIkGeJqz8+t68A8tTals8hRKUMo
 mEZzeItcfYW/Vfjy97MQVajBoXKxttVbFxmJWiJS4MlUCbxyaot4u8+/4ukp5aP7FR4g Yw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtvdrg2bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CI87ug014861;
	Tue, 12 Mar 2024 18:36:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33nrv8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:26 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CIaOsA45809980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 18:36:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02BE058067;
	Tue, 12 Mar 2024 18:36:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 099EA58062;
	Tue, 12 Mar 2024 18:36:23 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 18:36:22 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 03/13] crypto: ecdsa - Adjust tests on length of key parameters
Date: Tue, 12 Mar 2024 14:36:08 -0400
Message-ID: <20240312183618.1211745-4-stefanb@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: tE65JsOMOemlUflzJl1VP2Pg3vE1ekJy
X-Proofpoint-ORIG-GUID: tE65JsOMOemlUflzJl1VP2Pg3vE1ekJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_12,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120141

From: Stefan Berger <stefanb@linux.ibm.com>

In preparation for support of NIST P521, adjust the basic tests on the
length of the provided key parameters to only ensure that the length of the
x plus y coordinates parameter array is not an odd number and that each
coordinate fits into an array of 'ndigits' digits. Mathematical tests on
the key's parameters are then done in ecc_is_pubkey_valid_full rejecting
invalid keys.

The change is necessary since NIST P521 keys do not have keys with
coordinates that each fully require 'full' digits (= u64), unlike
NIST P192/256/384 that all require multiple 'full' digits.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 6653dec17327..64e1e69d53ba 100644
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


