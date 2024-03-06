Return-Path: <linux-kernel+bounces-94652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37008742B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED300B21866
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C2A1CF92;
	Wed,  6 Mar 2024 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NyyY6qTa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFA71CD2D;
	Wed,  6 Mar 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763801; cv=none; b=CGoM0CupRnQCwIYfo7KHaXn2ejhhOgrbo6r0IvvBagTyPnlfCBKQBtwVKxxZjYtlbGDFYV7u276RO3CJniNKzKo2tFJCANATqlqup4uoPDTbJQhifMekPZni2uIb7gtqoaRHVm281pQUx3EZtN2/YhkL3MLgmRjhXc6zSHV7XxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763801; c=relaxed/simple;
	bh=Gigjr/bHLz2UjNIadWKEflZhtNaSFNtdH5YurBfAouE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZKGcRhiQszq7LjFBr3XVlxtclIiv4f+LCmVO6nM+HglDWOhgFGZTBOh//TqGz0gzRrAzqVBywz5OmbuRgQHyQ+7B4HCD9Nwne58XXsylCf/iYwyTLV42V+5vmrqzCaDEputkDegGkSpdqXTuG+zCPpyAi2UdkvO2fHozZa6BdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NyyY6qTa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426LaSp0019722;
	Wed, 6 Mar 2024 22:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7IM1YHaga2ku2j8y6g72srugDpTMyi8+U2bvdE7s4b0=;
 b=NyyY6qTahilnnZRotCCo5Ev97p+Tu8BdljhzavUUfWDKBlqsR6akut4EKJTmTTdIk9Vq
 LLnrTRPVpGYQSssM8F3XfYg7BGqWeZzVqtpCt0gdoLHPTXrV4nKI/uguMcdcZke8rtMk
 HF87mkVKwiXX7WhKHOmb2MVt+9be0Xc84qP43xhLajkWDXCkA2gALO9MSZl0jhUdn3at
 sWmfH/WMnFqsaUybZ2EX4bGwIbcp77A8Nznl84/PF8thMLmgv2zkKM/FEJhE/Dd0wmWT
 HH+GlaQ39MlIAAtxijZl5txpy+lKht5bG5nPPlaLidoXjgft7aumAwpMg9vF2nfvr5Qm UQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq0009sd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426KPGDv024185;
	Wed, 6 Mar 2024 22:23:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwscxqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426MNASQ28508472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:23:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2AF558062;
	Wed,  6 Mar 2024 22:23:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FC4D58058;
	Wed,  6 Mar 2024 22:23:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:23:08 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 11/12] crypto: asymmetric_keys - Adjust signature size calculation for NIST P521
Date: Wed,  6 Mar 2024 17:22:56 -0500
Message-ID: <20240306222257.979304-12-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306222257.979304-1-stefanb@linux.ibm.com>
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _O9rktJyayujSsv9haRpYPw9T09uALa4
X-Proofpoint-ORIG-GUID: _O9rktJyayujSsv9haRpYPw9T09uALa4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060181

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


