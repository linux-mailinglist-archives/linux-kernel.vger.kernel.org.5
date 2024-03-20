Return-Path: <linux-kernel+bounces-108879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32DD881148
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D155283F40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F4481DD;
	Wed, 20 Mar 2024 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lF3uyeg8"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CD4084A;
	Wed, 20 Mar 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935285; cv=none; b=lG0F36U4804FKX86IHcDilJDhgkznkdXVA2j/BTAkolUjdrX9BzVP1x9kQuUNWrSWEJYseS9LabR7vgnurCAyDN0dgi96M1+jHACsDkZToz2qup0tc3Q16woQs++k88KGV/BJNm5+v8BlraQsxOT3/XRC+SrnPKq1cZJTBi/j7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935285; c=relaxed/simple;
	bh=Gigjr/bHLz2UjNIadWKEflZhtNaSFNtdH5YurBfAouE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owiFp6ZtvG5DtxeAxJD8ueBDDcBuQmQhv+RG+WAE5moiaF87XnQiYTRGBBQNqi8OlWK/NFueAz64zeFeOfHq3N4tG605CTiMmJXyKTFpyyT8tkMhq64ofhudo2Ub/eprYuouH/+1cWzlLYIz3/yxIsJBF7OAnnlPzTEUNQ3I25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lF3uyeg8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KA2kWn009078;
	Wed, 20 Mar 2024 11:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7IM1YHaga2ku2j8y6g72srugDpTMyi8+U2bvdE7s4b0=;
 b=lF3uyeg8qvTwtnZg3dIWYukm2v6Y+2aym1sybRAyyNjvoZzT1PASwKxLvkQemmHITbz8
 kIiD1i3UH6h8wzqpy+9J7SeVez2U/KXmgbzqG7+YrM3Ng4RTBeo+7fimxmOiPvakRkxw
 8C4hbitoxul7D/z6eXB9oX/jn3L5oy8AU9zj9IPNRCXfcxMIrCS2KznqowAd0h/NiKYL
 egRDhjndxNHQzbrbMCx/tx1Izeo/ZoJVB2CRka8Z/cJxJlz2hOda8JYoIV26xBFrPUUX
 S5nomufa7GZ+GgYMt+l2n8QsA63TicxVitPQOfMb+cDg7D9RpFcY+rLYspeU4WLgApOV tg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wywpt871k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42K8mOpf011595;
	Wed, 20 Mar 2024 11:47:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8m5wf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBlsRw42533220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A88958057;
	Wed, 20 Mar 2024 11:47:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEF1C58062;
	Wed, 20 Mar 2024 11:47:53 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:53 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 12/13] crypto: asymmetric_keys - Adjust signature size calculation for NIST P521
Date: Wed, 20 Mar 2024 07:47:24 -0400
Message-ID: <20240320114725.1644921-13-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: p38XdgJmOKNe84aQR5wTWYkOz06xJ2uG
X-Proofpoint-ORIG-GUID: p38XdgJmOKNe84aQR5wTWYkOz06xJ2uG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200093

Adjust the calculation of the maximum signature size for support of
NIST P521. While existing curves may prepend a 0 byte to their coordinates
(to make the number positive), NIST P521 will not do this since only the
first bit in the most significant byte is used.

If the encoding of the x & y coordinates requires at least 128 bytes then
an additional byte is needed for the encoding of the length. Take this into
account when calculating the maximum signature size.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/asymmetric_keys/public_key.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index e5f22691febd..16cc0be28929 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -233,6 +233,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	info->key_size = len * 8;
 
 	if (strncmp(pkey->pkey_algo, "ecdsa", 5) == 0) {
+		int slen = len;
 		/*
 		 * ECDSA key sizes are much smaller than RSA, and thus could
 		 * operate on (hashed) inputs that are larger than key size.
@@ -246,8 +247,19 @@ static int software_key_query(const struct kernel_pkey_params *params,
 		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
 		 * which is actually 2 'key_size'-bit integers encoded in
 		 * ASN.1.  Account for the ASN.1 encoding overhead here.
+		 *
+		 * NIST P192/256/384 may prepend a '0' to a coordinate to
+		 * indicate a positive integer. NIST P521 never needs it.
 		 */
-		info->max_sig_size = 2 * (len + 3) + 2;
+		if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") != 0)
+			slen += 1;
+		/* Length of encoding the x & y coordinates */
+		slen = 2 * (slen + 2);
+		/*
+		 * If coordinate encoding takes at least 128 bytes then an
+		 * additional byte for length encoding is needed.
+		 */
+		info->max_sig_size = 1 + (slen >= 128) + 1 + slen;
 	} else {
 		info->max_data_size = len;
 		info->max_sig_size = len;
-- 
2.43.0


