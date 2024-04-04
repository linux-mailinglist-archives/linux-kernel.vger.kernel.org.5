Return-Path: <linux-kernel+bounces-131604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B258989F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B39291B96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC39133982;
	Thu,  4 Apr 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GqQudBx/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43624131E33;
	Thu,  4 Apr 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240400; cv=none; b=LyG4qAlSdf6VpqrxMc8eW8iMtI5Ca+GKqxssUlOmj0JEcPGfynXdiKAweFl6jJvnGx4ZwQWpD4BdjhY6uUbd0tsqp8CsNAkZ5ybPUmF/+V7Sym4KL4crt4cGPxvgnV2klVdeCEngE4ITGWMHQRGIAX+6nJaW4MZncaKMy95gq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240400; c=relaxed/simple;
	bh=Hf0PPsZ7D1TT52HMhhYOht+eo76dZigrhq5vJu0x51c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGoczqCTpBQz296Qe8qsFNHnxNRFJym4YGQwjpsGEsdBkzi0oDd5ivigwcmj2uekoEbQcoNGCt5OIB7LE5rbn8s1I2QbnL+5RjFfyy0aGX0XJZmguHEtxr27SNjghdWfMXp3/VNXbakZdkcmhVxkOmpAsfdtaGGzyesZECTQ1kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GqQudBx/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434EINV6017808;
	Thu, 4 Apr 2024 14:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DrAFKyDwM3V+uZrzNJ/4FTspS+wQVw1FNLbs46FgJcs=;
 b=GqQudBx/UR+jv/MEf6EF6cA5EpGpcp+k1Dy49eyYmA6HBJFZhJNWPM27Iil+UIIgUIIa
 uwGXniNorgsN4eG4PbRb31rxItsa250jPPekvdWZAVZjxeLoyCMTSUwCsTk8QkuIQCQu
 GSipZOYXcnJJ/EGhW9vxYokwTwPRQFojm6naBavip02QBluFLvQHW+GPwoY+UL5+BoSx
 BnGWGp7ZeKQs2EU8dEOfEQnMIjtn80XUPrsdSPDWePws6qNzYDFfYg/4EiGqV/zlKefh
 C7Mr8U+g4JKTUm/LF7hztYPMaYnESNSB0yHrT0gsQ8YIdDeSW1cSGkazlnLplMRyAbD4 CA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wuk803j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:47 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 434EJlYc019334;
	Thu, 4 Apr 2024 14:19:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9wuk803g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:47 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434DjcjF022281;
	Thu, 4 Apr 2024 14:19:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9eq0cjwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJiBg23790176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 363E758060;
	Thu,  4 Apr 2024 14:19:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47AF05804E;
	Thu,  4 Apr 2024 14:19:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:43 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v8 13/13] crypto: x509 - Add OID for NIST P521 and extend parser for it
Date: Thu,  4 Apr 2024 10:18:56 -0400
Message-ID: <20240404141856.2399142-14-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: dlcjAQMYFL2vmTZbVC7Ght5X0DMBnfxO
X-Proofpoint-GUID: PnUmDWevwLnLWB_tFJO8MFXQOfCi4ZY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040098

Enable the x509 parser to accept NIST P521 certificates and add the
OID for ansip521r1, which is the identifier for NIST P521.

Cc: David Howells <dhowells@redhat.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 3 +++
 include/linux/oid_registry.h              | 1 +
 2 files changed, 4 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index bb0bffa271b5..964208d1a35f 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -546,6 +546,9 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 		case OID_id_ansip384r1:
 			ctx->cert->pub->pkey_algo = "ecdsa-nist-p384";
 			break;
+		case OID_id_ansip521r1:
+			ctx->cert->pub->pkey_algo = "ecdsa-nist-p521";
+			break;
 		default:
 			return -ENOPKG;
 		}
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 51421fdbb0ba..6f9242259edc 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -69,6 +69,7 @@ enum OID {
 	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
 	OID_sha1,			/* 1.3.14.3.2.26 */
 	OID_id_ansip384r1,		/* 1.3.132.0.34 */
+	OID_id_ansip521r1,		/* 1.3.132.0.35 */
 	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
 	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
 	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
-- 
2.43.0


