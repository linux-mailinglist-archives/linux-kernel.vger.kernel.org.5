Return-Path: <linux-kernel+bounces-79125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA68861DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904AC1C23BED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71C514EFE5;
	Fri, 23 Feb 2024 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CLY4I4oT"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE3146E8C;
	Fri, 23 Feb 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720941; cv=none; b=VlpCPSfCxyaozQYpKDzUOseIq5imY+o014bnw9fnjEbkDdLC76/s79mi4uNHruC5zAjmzI/Tjg71O/b+NIV5YDddd1aUXUDO4ahD2kkkYZ/M3Ix18PCdYIVUZhPPJNFXIkaUxmLRGC0QCAPKCeYpef6/gdDk2RWcfbPKziKIP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720941; c=relaxed/simple;
	bh=3YD2nLoVeWDrWiPNpx65a68F+wXSuNVNDDyl/CAP0AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/5dq6Ds4z6IXEapZJN6MmcelZ2qONmA9Yf78e7vvvL5bcT+sCB1t3NsbqEesX/M4m0CkU1tel/WFAFiYq9+xCpR1jZsAkZwHg0DhD46IPvz81mABR9Fnv6bC1g56QwDrIVndlxG5Rkoj6nqlSgaZux8r5m/oh8lfPQ7QE731AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CLY4I4oT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NK1Wmt010645;
	Fri, 23 Feb 2024 20:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oMikrV2Be8nChSoWAP37zjvL3Jd3Ki9N5SP4cHk5r8Y=;
 b=CLY4I4oT6BGs/5jHrifKX01EEe8psEG6Fur07U2temZYRoLzUHhxkwzUXRBNCDzGg1LJ
 mylqhaixMzH45iPVy7C2t9lDZ8Ft3sNEmUhFsoKw3eJsbNAnzdABSK70jO8uaDCm28Mh
 GU2X5YI0dkEMiIiCTRoEB8uUazKoS7aMwtZt7zVD8LdmznQiu8x580Oh5NeLwnx2WhFj
 nDIErsZRzS41M3HmhnbyC2MM85oY8bHbdaRbM0JpYk2IbdRxxi+KuFMoi7UvF+Efslaf
 GR79HFEAvfpTBvwrSzWv5I2tt8tsNSZYgl8vBVL+0/jwQaXgp9A6HNsEdpPNma924mrd sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf1rssdke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NKW8uf013677;
	Fri, 23 Feb 2024 20:42:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf1rssdka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NKVMlv031135;
	Fri, 23 Feb 2024 20:42:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bmfmqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:13 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NKgB1R4063830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 20:42:13 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 169615805D;
	Fri, 23 Feb 2024 20:42:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BD1758058;
	Fri, 23 Feb 2024 20:42:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 20:42:10 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v3 10/10] x509: Add OID for NIST P521 and extend parser for it
Date: Fri, 23 Feb 2024 15:41:49 -0500
Message-ID: <20240223204149.4055630-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223204149.4055630-1-stefanb@linux.ibm.com>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GRaX-Z03NVN6ahjiCS3ehvA4VI4KP4XW
X-Proofpoint-ORIG-GUID: 7onDmfLx-Ln8HijxH0X43zyWeQXrFAbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=927
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230152

Prepare the x509 parser to accept NIST P521 certificates and add the
OID for ansip521r1, which is the identifier for NIST P521.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 3 +++
 include/linux/oid_registry.h              | 1 +
 2 files changed, 4 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 487204d39426..99f809b7910b 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -538,6 +538,9 @@ int x509_extract_key_data(void *context, size_t hdrlen,
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
index 3921fbed0b28..af16d96fbbf2 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -65,6 +65,7 @@ enum OID {
 	OID_Scram,			/* 1.3.6.1.5.5.14 */
 	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
 	OID_id_ansip384r1,		/* 1.3.132.0.34 */
+	OID_id_ansip521r1,		/* 1.3.132.0.35 */
 	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
 	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
 	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
-- 
2.43.0


