Return-Path: <linux-kernel+bounces-108872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1C7881134
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB781C2269C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE2D3FBAD;
	Wed, 20 Mar 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bc76I6FM"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA06C3F8C3;
	Wed, 20 Mar 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935282; cv=none; b=ZJP90ykSHui/YKXv3cVj6o9WajypOB+gJslWoHLGTDH3SIAf+Y+AwWys9qCkcyzmcp+rLhTU+pJM7J46ssursI5/vb2nc8EAuJyKBjp29RrhON1PK9n6QgRu6G11rtXDJSxKShaeisBLZQEpIzLGXrgz4dPgwbaQPW+kj2Tpy58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935282; c=relaxed/simple;
	bh=tdv+zR6KY9v8E52vz1Fb060Q1/O3FwV2b1XjMCGO4rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmSTzofZOEe2y8yZoJbxgEcnkiIICIetU1twqOfr3iuw3x8dD+WPEBs8ZALUzDi9a6ulcElTFm7/AnX7k2Y5xkBXHRFqKaWzOdtvtB2AtatL7zHwegRMzdDSpBZ2FSmq3vVXYV+f2BO0fbosAFi5zspFRJbcEQ5PRbkr75VUlSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bc76I6FM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBUhJr017914;
	Wed, 20 Mar 2024 11:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=1F0I83yil5m5V53xrdM9fkbdPUJwUJelO21septNlw4=;
 b=Bc76I6FM+KWJ460xaLpqFREkrbncYzOD5PDYcniZH9W7gHIKwaOnxtSzxF1gP02hRR4n
 AH1intI8gGH5k+T+OpJjetn75IWRa7ZLDUp72ZJ3UMm9ssdWUwu7cRjDpXOWlKtKqFOc
 IG3ucPf5ZpOITXv8Ety2O7vRhV4uzvVC1CgVrg3QejLBgSghNxvr1b1DGcQe33yoXQih
 bxeS+21xVsr6Al2hLislkCHLOS3WUu4NB1lInv0BakI4h+0g4V0Fh5fhcxBYC1PWwZ1q
 vgQI3IADKV1vJC3OpnyKyKKjQt64+P3bwSRZUI5OjU6sCOw2qYL8VMLVkkNQc6w6iWtV ag== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyxbr83sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KAU3S8017194;
	Wed, 20 Mar 2024 11:47:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrte8ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:47:47 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KBljb650594262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 11:47:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 387B158061;
	Wed, 20 Mar 2024 11:47:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A16858057;
	Wed, 20 Mar 2024 11:47:44 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 11:47:44 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Add support for NIST P521 to ecdsa
Date: Wed, 20 Mar 2024 07:47:12 -0400
Message-ID: <20240320114725.1644921-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EafWTgOxpS2Cc-KeOF8wYqGbOxNSvmzR
X-Proofpoint-GUID: EafWTgOxpS2Cc-KeOF8wYqGbOxNSvmzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200093

This series adds support for the NIST P521 curve to the ecdsa module
to enable signature verification with it.

An issue with the current code in ecdsa is that it assumes that input
arrays providing key coordinates for example, are arrays of digits
(a 'digit' is a 'u64'). This works well for all currently supported
curves, such as NIST P192/256/384, but does not work for NIST P521 where
coordinates are 8 digits + 2 bytes long. So some of the changes deal with
converting byte arrays to digits and adjusting tests on input byte
array lengths to tolerate arrays not providing multiples of 8 bytes.

Regards,
   Stefan

v7:
 - Applied T-b tag from Christian to all patches
 - Applied R-b tag from Jarkko to some patches
 - Rephrased some patch descriptions per Jarkko's request

v6:
 - Use existing #defines for number of digits rather than plain numbers
   (1/13, 6/13) following Bharat's suggestion
 - Initialize result from lowest 521 bits of product rather than going
   through tmp variable (6/13)

v5:
 - Simplified ecc_digits_from_bytes as suggested by Lukas (1/12)
 - Using nbits == 521 to detect NIST P521 curve rather than strcmp()
   (5,6/12)
 - Nits in patch description and comments (11/12)

v4:
 - Followed suggestions by Lukas Wummer (1,5,8/12)
 - Use nbits rather than ndigits where needed (8/12)
 - Renaming 'keylen' variablest to bufsize where necessary (9/12)
 - Adjust signature size calculation for NIST P521 (11/12)

v3:
 - Dropped ecdh support
 - Use ecc_get_curve_nbits for getting number of bits in NIST P521 curve
   in ecc_point_mult (7/10)

v2:
 - Reformulated some patch descriptions
 - Fixed issue detected by krobot
 - Some other small changes to the code

Stefan Berger (13):
  crypto: ecc - Use ECC_CURVE_NIST_P192/256/384_DIGITS where possible
  crypto: ecdsa - Convert byte arrays with key coordinates to digits
  crypto: ecdsa - Adjust tests on length of key parameters
  crypto: ecdsa - Extend res.x mod n calculation for NIST P521
  crypto: ecc - Add nbits field to ecc_curve structure
  crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
  crypto: ecc - Add special case for NIST P521 in ecc_point_mult
  crypto: ecc - Add NIST P521 curve parameters
  crypto: ecdsa - Replace ndigits with nbits where precision is needed
  crypto: ecdsa - Rename keylen to bufsize where necessary
  crypto: ecdsa - Register NIST P521 and extend test suite
  crypto: asymmetric_keys - Adjust signature size calculation for NIST
    P521
  crypto: x509 - Add OID for NIST P521 and extend parser for it

 crypto/asymmetric_keys/public_key.c       |  14 ++-
 crypto/asymmetric_keys/x509_cert_parser.c |   3 +
 crypto/ecc.c                              |  44 +++++--
 crypto/ecc_curve_defs.h                   |  49 ++++++++
 crypto/ecdsa.c                            |  62 ++++++---
 crypto/ecrdsa_defs.h                      |   5 +
 crypto/testmgr.c                          |   7 ++
 crypto/testmgr.h                          | 146 ++++++++++++++++++++++
 include/crypto/ecc_curve.h                |   2 +
 include/crypto/ecdh.h                     |   1 +
 include/crypto/internal/ecc.h             |  24 +++-
 include/linux/oid_registry.h              |   1 +
 12 files changed, 335 insertions(+), 23 deletions(-)

-- 
2.43.0


