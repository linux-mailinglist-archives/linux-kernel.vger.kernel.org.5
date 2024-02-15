Return-Path: <linux-kernel+bounces-67811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7585715E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A979FB24B51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5727414901C;
	Thu, 15 Feb 2024 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l0t/KbJD"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550614831F;
	Thu, 15 Feb 2024 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038881; cv=none; b=uKzcDdsENHXt9idApPsapKGjT8PbYINQq/k2nzhNiz40qGB7fs4ubVEzkdLNRqCHldWJvkBTN/bA6l45sWS5kuPuOvoMTVNY1P0BmrFzRsGQ+nG6SJ5IRSoFBB5/YgKAYcWsozK+7iWLTVd1LX9scTsgSj/k4GLpsX7TbYtuaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038881; c=relaxed/simple;
	bh=Z3OEL+EPx//2PPX5akfH6NjY88NSSeAdRzhgVXlU2FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPGzabfRwSNaSIcmICw6BPR5i25qFjUtETH8YYF4MJIcvJAZbLnKDd9WOiJqbySKSRCQ4JF6EM78siZlHLAN7lxjgGTaQ1oX64gnoFP+jzpjg3efLlXn7F6mtoGgO6AqXy0ym2Au4xClcS0ZQ6+6VPokIrWz4Z7zA4B3xSx/tt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l0t/KbJD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FMVlZk029466;
	Thu, 15 Feb 2024 23:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mYgdjqbNen7QY26guvqSRH2EI5oLC0HipXuyG4L6aUg=;
 b=l0t/KbJDbNWRLKk455fieLXtavaZR51pzGJRXubExor826DNo8xjmcTpEG/o4362YCAB
 ys4/Ynhvj0W2bDLadGsClABAKZGkGH0jsU0yNvU8t/nFZAqBhW7A6KhHoxpWrfrOgoY1
 xJgvxgMDoKiRRamJz+w1DTVf6Dw/3zKUwzukZsnO9wePwC7aPkpJRwZOFjH+pRsxm8zh
 mfVBH9TH/tWcr4eO4f9X1o3Mz/UspEzHDk3XhoNbyg6GDuJutG9fI9JbKd528g29M2fi
 V0jn5AZAW70Ah0aaqYIEdEGlM8ewC7q2ugUBPRL1cSPNZQwjwAQzzggId6eIFc4wVZHs Kw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9ug4166k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:34 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FKZ6ce009680;
	Thu, 15 Feb 2024 23:14:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npm7h4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:33 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FNEUPL52626034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:14:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B7F458066;
	Thu, 15 Feb 2024 23:14:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3B8458050;
	Thu, 15 Feb 2024 23:14:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 23:14:29 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 12/14] crypto: ecc - Implement and use ecc_curve_get_nbytes to get curve's nbytes
Date: Thu, 15 Feb 2024 18:14:11 -0500
Message-ID: <20240215231414.3857320-13-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215231414.3857320-1-stefanb@linux.ibm.com>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7mzzmiueXgSosQUZrfe6zxpT-pAbo5TH
X-Proofpoint-ORIG-GUID: 7mzzmiueXgSosQUZrfe6zxpT-pAbo5TH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150181

Implement ecc_curve_get_nbytes to get a curve's number of bytes (nbytes).
The number of bytes can be derived from the nbits field of a curve, if
set, otherwise from the ndigits field.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c                  |  6 ++----
 include/crypto/internal/ecc.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 73fbbfc8d69c..f643719450b8 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1478,10 +1478,8 @@ static int __ecc_is_key_valid(const struct ecc_curve *curve,
 int ecc_is_key_valid(unsigned int curve_id, unsigned int ndigits,
 		     const u64 *private_key, unsigned int private_key_len)
 {
-	int nbytes;
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
-
-	nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	int nbytes = ecc_curve_get_nbytes(curve);
 
 	if (private_key_len != nbytes)
 		return -EINVAL;
@@ -1506,7 +1504,7 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
 {
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 	u64 priv[ECC_MAX_DIGITS];
-	unsigned int nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	unsigned int nbytes = ecc_curve_get_nbytes(curve);
 	unsigned int nbits = vli_num_bits(curve->n, ndigits);
 	int err;
 
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 6229aa3f3218..5d485d3221d3 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -93,6 +93,17 @@ static inline void ecc_digits_to_bytes(const u64 *in, unsigned int ndigits,
 	memcpy(out, &tmp[o], nbytes);
 }
 
+/**
+ * ecc_curve_get_nbytes() - Get the number of bytes the curve requires
+ * @curve:   The curve
+ */
+static inline unsigned int ecc_curve_get_nbytes(const struct ecc_curve *curve)
+{
+	if (curve->nbits)
+		return DIV_ROUND_UP(curve->nbits, 8);
+	return curve->g.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+}
+
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
-- 
2.43.0


