Return-Path: <linux-kernel+bounces-87834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1DC86D9A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C17E1C2255C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B73D571;
	Fri,  1 Mar 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f7cQxf2V"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4C3C493;
	Fri,  1 Mar 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259627; cv=none; b=piMY7UF0AA66wHCvUBB15FUR5I8N90BsyO+fr2298xjvEQI8tKv0zPAyJJBqVniXGPQOs6fxtVvDZwIIMN4YbKNC+8OQolZuO/hDQDoDCDNhxrNeh9YM9MuFDBJwQdTL1v51SRI6J/sb6UL6+WDVAmS3OXCw62hZ2owihsiEY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259627; c=relaxed/simple;
	bh=9rykTtpLlBlo2CLkT3nocbnOiQzjZkZM8uVjIXtPa+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWOcTW+GHzfpSPZeQXmaUzZ2mnLY1eK+5OKdD3ZXrMdUoajdhfQRFR6nJDBRSfzGT3mZ5nUKblHeoearS3wJ6E2PK8hRk8s32+aGMnEfI9HW/23zHbhpNowkwlHo6Q4alN+oNfQLwF74trFlisTnsGuMXrMbNTM67SlNySeSQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f7cQxf2V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42122Eqt030470;
	Fri, 1 Mar 2024 02:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Yt3IwoHFlggRrosbmAcrh0eBdF1FVBp7FKVJ70kauYQ=;
 b=f7cQxf2VXzpF3vqE8iCfHAr/i7UY3h9vt6GVgydD7YXbUz1jyXGxmphIF4RT3mlKIkU3
 Ih1OBnxNa0RQF/Gw6sVnPVvTZWQnjrkV5ZGKFqEhhcFVDUqDHB4FQt0tlfvkvVY71kw9
 h6hkDh3XjE4Al1g+NxBkv3FaJRt5a8gi0LBSmc2u7GMdBatrVF4PBnZWtOuWGbpyBpty
 SK3nH+Vaz2TGX/o6wdJBPtrKrlue+VAYR9IszxLk7z0UgLlXCbcFb6avP/ZVGFisXW0E
 P+/+GwzgICueTY7hK8Aib7tLwg+LUifdrDQtjVpDXaELo3RRZiFG7xJXB0m10EA0G3qC iQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk5vhgftg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:19 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4210CAgk012338;
	Fri, 1 Mar 2024 02:20:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2s51g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:18 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4212KGN348693646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 02:20:18 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFD9058052;
	Fri,  1 Mar 2024 02:20:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A7055805D;
	Fri,  1 Mar 2024 02:20:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 02:20:15 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 11/12] crypto: asymmetric_keys - Adjust signature size calculation for NIST P521
Date: Thu, 29 Feb 2024 21:20:06 -0500
Message-ID: <20240301022007.344948-12-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: b0aN-kCjk-OlIPWtWpgKloTZjYuBYqlo
X-Proofpoint-ORIG-GUID: b0aN-kCjk-OlIPWtWpgKloTZjYuBYqlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010018

Adjust the calculation of the maximum signature size for support of
NIST P521. While existing curves may prepend a 0 byte to their coordinates
(to make the number positive), NIST P521 will not do this since only the
first bit in the most significant byte is used.

If the encoding of the x & y coordinates requires more than 128 bytes then
an additional byte is needed for the encoding of the length. Take this into
account when calculating the maximum signature size.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/asymmetric_keys/public_key.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index e5f22691febd..247d42580f7c 100644
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
+		 * If coordinate encoding takes more than 128 bytes then an
+		 * additional byte for length encoding is needed.
+		 */
+		info->max_sig_size = 1 + (slen >= 128) + 1 + slen;
 	} else {
 		info->max_data_size = len;
 		info->max_sig_size = len;
-- 
2.43.0


