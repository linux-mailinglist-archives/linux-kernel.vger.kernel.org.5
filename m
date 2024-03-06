Return-Path: <linux-kernel+bounces-94676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035338742FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43B7287090
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049321C6B2;
	Wed,  6 Mar 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OfLF2DTP"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6551B7E4;
	Wed,  6 Mar 2024 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765299; cv=none; b=m/NSPIY9M3sD9yRInrMIUNPceUDvbFXOv4vw/iDrONX8e+huyli6vx2KULYzld1HtlJ2GUn0zG8PMaZ2atasx7Y0oJLIYXwqaiOHJgtrozFBEaU8NznPNYCoIX8TbXeny076+NpcXTrf8AvTw3BA+CyoEIv/UDtbNqTjFM9dAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765299; c=relaxed/simple;
	bh=osERkD6x25VFZbh9JDDNJ74m6/+fUzUgTEQNEFwZkFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/Drxhr1x1i/vkdL2/cB5zJhDZP4+p4bvqmzHiM+awUTrITnp73etvj8+JbQZ4txinJQXDkxFDLlnK/cjjvxk/U5KGNWxmOarRTxCEFcb58uzjIN6rNpLnsv90axTJWxJzLJXBO2HF8D3liu/RVW5S+/DJ+yBBMFtRRz1M+T75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OfLF2DTP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426M7F4M000882;
	Wed, 6 Mar 2024 22:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EULON2aVDwRpBJ8sxfIz3QiJcn11hx0E9aBparFisOA=;
 b=OfLF2DTPxZ5FgpsjOCxZcwhu7mHid+SaSs1htm+3oY8J5Vnk0Y/2Ny9u50CANSj3xxNt
 Y0Yf8QeJB5oaM0/O4CzqleUgRQllpKYXDn0URYfn+yQSCw2SgLoamqXr6HIr6/zvt5dz
 rlNYWWWKleRh2nszjo1GCFrBM5tlpuQGn/P2+l5//N6rprVQhb0G00FWjQAh4dpNT1ag
 c2ucG9OLpJG1HBFmwP9yLXKt9dgWtARwFCPQ4sLV3egNBtxoQK0lkEzIRifmW2Y3giSZ
 5ukVLgBUKzoc9q3B9lUHOeSXPE7rXxAh96zF4p2j1SRPR1kBvhwbQRratSlYVHwh1P4q pg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq10h1242-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:48:11 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426MDHVi021082;
	Wed, 6 Mar 2024 22:48:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq10h123d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:48:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426LeRFJ026296;
	Wed, 6 Mar 2024 22:23:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfep1nqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426MN9P334013508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:23:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62B8658057;
	Wed,  6 Mar 2024 22:23:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9A2958058;
	Wed,  6 Mar 2024 22:23:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:23:08 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v5 12/12] crypto: x509 - Add OID for NIST P521 and extend parser for it
Date: Wed,  6 Mar 2024 17:22:57 -0500
Message-ID: <20240306222257.979304-13-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: oJrNBdjshfqGf9L06AE7AW56KtYOZjem
X-Proofpoint-ORIG-GUID: 46JsISEMnIgFnEqMgpzRdpct4XXE9s8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060183

Enable the x509 parser to accept NIST P521 certificates and add the
OID for ansip521r1, which is the identifier for NIST P521.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Lukas Wunner <lukas@wunner.de>
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


