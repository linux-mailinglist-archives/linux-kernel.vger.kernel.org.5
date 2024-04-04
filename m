Return-Path: <linux-kernel+bounces-131592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBD8989D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E181C29F88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7F712A16E;
	Thu,  4 Apr 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q+jF/OX7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33100126F11;
	Thu,  4 Apr 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240391; cv=none; b=LwWqBMd7W6PKmzNu0ko0E/4Pj3d9VFQuD5mpaMwkKAGYfVgT44TxX3JDX2IqcWCIWqs/pEUETVJeI+aVwyFxQ7hXImf9E3Zj9OZ6ShC+y7/1XMvcxFwNg9GqA2HvOg1J4PEX+UPp/m41SeINjoK7nu5JkkjTLp7kM/DUg5Hujt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240391; c=relaxed/simple;
	bh=dDoRuXR0h/UtIUwsNQvukoc7HzlkJPZrSDTAfMTCPIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0xlCG3KOeLI2OcH89Tg3gfo5Km9Mlr1Ae141t3fEF8jY3QPRm3W8aqkzlMZwMBn9IpxZSue+3uQ/9/bDqkUzcrZJOKgWT58iVPiMaPu2397O4hhTxxy4trNOPEs5Exto+ozyufwQ07yafmZIrUGG/Z+TQ9qhKGS1Bgdfb537wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q+jF/OX7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434DWku4009020;
	Thu, 4 Apr 2024 14:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=nC4LM1YC9XZZrDEMUOi7ZLDOpXNISdt4owGoR3qHMQ8=;
 b=Q+jF/OX7k091kTbijHJTkSYk9owSXmfVnvvGqBDlT5z8JvsSJiXbCxi442hEbbK11sfV
 QBRgK1B//XlviHvPOFbpO0u38Sg1Zw0/fudEtFbaNdxXzfC1lDzjVXU7zKz9BAjVfX1G
 WMEsHxnCGNtecP5n6u2UaMdKhuZWjdQWqvefguYn7b1RUMR/ZbLihvoIqJuxRFtwXuIc
 WgoQXKIOsFScnrDIkPxUZwbRPSS3RO62ZoMPw/NInssUrpVg1JxqPgXKE3e7fpS83Itj
 NSJ5ihcCh0E9Q2o5eu3Ez4X1UxPl1Pk9oxfRFFr4WUWNg55j/EG/OOarOUZ6cxNEizdk EA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9w65g4t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:34 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434Dsu5R003627;
	Thu, 4 Apr 2024 14:19:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epyck0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:19:33 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434EJU1258327462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 14:19:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E08105803F;
	Thu,  4 Apr 2024 14:19:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CDF058056;
	Thu,  4 Apr 2024 14:19:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 14:19:29 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 00/13] Add support for NIST P521 to ecdsa
Date: Thu,  4 Apr 2024 10:18:43 -0400
Message-ID: <20240404141856.2399142-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ie4Z9mw2pqhOHgXIy7ssFXzNnWcoeRGM
X-Proofpoint-GUID: ie4Z9mw2pqhOHgXIy7ssFXzNnWcoeRGM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1011
 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040098

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

v8:
 - Changed nbits from unsigned int to u32 (5/13)
 - Added MODULE_ALIAS_CRYPTO("ecdsa-nist-p521") (11/13)
 - Applied R-b & T-b tags from Jarkko
 - Rebased on master branch at
   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git

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
 crypto/ecdsa.c                            |  63 +++++++---
 crypto/ecrdsa_defs.h                      |   5 +
 crypto/testmgr.c                          |   7 ++
 crypto/testmgr.h                          | 146 ++++++++++++++++++++++
 include/crypto/ecc_curve.h                |   2 +
 include/crypto/ecdh.h                     |   1 +
 include/crypto/internal/ecc.h             |  24 +++-
 include/linux/oid_registry.h              |   1 +
 12 files changed, 336 insertions(+), 23 deletions(-)


base-commit: a9a72140536fe02d98bce72a608ccf3ba9008a71
-- 
2.43.0


