Return-Path: <linux-kernel+bounces-58782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937E84EBA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4B0287952
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D281537EB;
	Thu,  8 Feb 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BJCuXiTl"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824950257;
	Thu,  8 Feb 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430753; cv=none; b=hV8Bsl5AZgrvz6grjYDJ4RYoY05XYtmy6mkJdVTwqIt0XHhbfh0EY/vpx4Nqry50GTw3AFeuPl7cs0PgSEXd3gj8K5iZQmtzkY8aAfAns1VnPLA4CjAkZXLJtWy9WP5BdtwdfF/8SmPzROTlG73e33h0E9MmvZY5+QgcpJ7JIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430753; c=relaxed/simple;
	bh=lSoOkYYsVW4aBYcXadaLQ8gkygfxoMOtlpjDVeReq3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJ3Z39z04+v0HAq+vOnfe4XWKYJZwUJOte++ChcZ9tam5723npjQRl9CX/477JWbDLVdfW+pjSiClR0iX8TRhhdyrXX/fVWW8TcCNnadm54AjdXYRl3ppgpFWZUCxqhb6MeGtETDmPFz5Fh77x4kxYTjb8Sd4a9j/t1DhsjS7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BJCuXiTl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418M9DsU015509;
	Thu, 8 Feb 2024 22:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4gb/xM1RzjQvmQ0ZwXYBpssFs/IRULIv+qGMZ0Nq2nM=;
 b=BJCuXiTlEeCLZCP25UJn9rpBT1EwbsoGiC1KcTwEJpNrRtVMazP6DKhnASZYAIVZcOfi
 MSyCREcswg/rpaNcVQqG0hZkdt51ISbSH+pGlTdxwQb/d3GgvHy2TDKgBPNpzP0fo9wt
 hce0LMre7KsaCCkhtcPewvtvwxWnIp47DMZjyXxC/2/KHXFIGy++CgO4YraGa7X6aBF9
 rOsO0o4YM7LtIC96gOSM4dtL2cAZtysyuPr+tmhhHLpowi0LlcA4baH87rkwKRZinL/v
 40+t17OimxGKKa1yl14GLApSLW1BN3Pol8BqLVZJfzqhJ4g95vfndDmXCoHCwz49elV3 Eg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w55n82y9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418KSnG7014837;
	Thu, 8 Feb 2024 22:19:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tp7hax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 22:19:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418MJ51211469400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 22:19:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E95658060;
	Thu,  8 Feb 2024 22:19:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D3B758068;
	Thu,  8 Feb 2024 22:19:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 22:19:05 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 10/14] crypto: ecc - Implement ecc_digits_to_array to convert digits to byte array
Date: Thu,  8 Feb 2024 17:18:36 -0500
Message-ID: <20240208221840.3665874-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208221840.3665874-1-stefanb@linux.ibm.com>
References: <20240208221840.3665874-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ros67y281KSkCo9nQbnSbrJiRFqenxKQ
X-Proofpoint-GUID: Ros67y281KSkCo9nQbnSbrJiRFqenxKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=874 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080124

Implement ecc_digits_to_array to convert an array of ndigits into an
nbytes-sized byte array.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/crypto/internal/ecc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 22931f0c7295..75ee113f58f9 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -75,6 +75,24 @@ static inline void ecc_digits_from_array(const u8 *in, unsigned int nbytes,
 	ecc_swap_digits(tmp, out, ndigits);
 }
 
+/**
+ * ecc_digits_to_array() - Copy nbytes from an ndigits array into a byte array
+ * @in:      Input digits array
+ * @ndigits: Number of digits in input digits array
+ * @out:     Output byte array
+ * @nbytes:  Number of digits to create from byte array
+ */
+static inline void ecc_digits_to_array(const u64 *in, unsigned int ndigits,
+				       u8 *out, unsigned int nbytes)
+{
+	unsigned int sz = ndigits * sizeof(u64);
+	u8 tmp[ECC_MAX_DIGITS * sizeof(u64)];
+	unsigned int o = sz - nbytes;
+
+	ecc_swap_digits(in, (u64 *)tmp, ndigits);
+	memcpy(out, &tmp[o], nbytes);
+}
+
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
-- 
2.43.0


