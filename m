Return-Path: <linux-kernel+bounces-100673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3F8879B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360AA288006
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512E142648;
	Tue, 12 Mar 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SFe4AF/S"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88205141995;
	Tue, 12 Mar 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268677; cv=none; b=bt+0KPHf1nX1nzXTrEemSR2sgYW7DRLFiswMaH6MXaRycMu/oV4/ZW+BBfLCxcSCsOmofZcCG2i4wqjLd2A+0Y1WE3218b4tPGQZJ5Mwc+rzu5W0Fop3rnPWY5xmjp5pohWAYryXtKKKsOmu8FfGzzDp1WiaKF4etNe4jAh+iUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268677; c=relaxed/simple;
	bh=e868qhckN4SBrUJqugG2K3P/Eq7YNZ9Y+KcBaue9J6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6BFkjzH5BmAOS9Pv+BV5Zb0v1KtPFfamNclKYna03hHYukfak7BChu4ip7A64X2Q8pO+vDHdBmMFOluyBALzgx84w+NyDcbcZXYSQSEouorhUwmRciZz9e6DXt6Yo+LwaMmrig6f9mynfqq/sMZxfE1siM/Rqi1yr0+KIHiKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SFe4AF/S; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CI2fw0030848;
	Tue, 12 Mar 2024 18:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YYaA5Kk5aamdsAiFj+Y8ed0BRV8/S/u4SuSeA8pftwk=;
 b=SFe4AF/SJbdZrlHKQGniAwLuEV8dWkICmLQ3Z4smegMdW9/etwmCxQ+LQszZ30fINl/l
 17K868h9M1KuQ0mwrLPTP5QGYADZg0ipNHPpBe6lwIPLs1ov4gUwVzBkE4uVnX1j8rn0
 Y18rGkwg5fpXUClq2GEV+/YqKegt3YeA0dpBVeTKjIy1h3djhddEo+PlvL4m2C9B0e+c
 bCteYw/RqdXqbMSUw3D5vJzTqjCRiohJS1pH0gdct3cjMDAA7VwFdSBJKIzvreOTg83d
 W9PSMdnrfpcluWSuEL+nHeGg64IsaTvYEMpZGtHphtVGvOW6bm6y1h7k4ZCdSiWKoaou 9w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtuywrh7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:37 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CHv6wt015492;
	Tue, 12 Mar 2024 18:36:36 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fys1dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:36 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CIaX2R43057450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 18:36:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3A8158054;
	Tue, 12 Mar 2024 18:36:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54545804E;
	Tue, 12 Mar 2024 18:36:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 18:36:32 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 12/13] crypto: asymmetric_keys - Adjust signature size calculation for NIST P521
Date: Tue, 12 Mar 2024 14:36:17 -0400
Message-ID: <20240312183618.1211745-13-stefanb@linux.vnet.ibm.com>
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
X-Proofpoint-ORIG-GUID: QFy383tt40bY__MhcAmx2ja8GHD8Gb0-
X-Proofpoint-GUID: QFy383tt40bY__MhcAmx2ja8GHD8Gb0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_11,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120139

From: Stefan Berger <stefanb@linux.ibm.com>

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


