Return-Path: <linux-kernel+bounces-87823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 967B486D983
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37903B2208F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB23AC10;
	Fri,  1 Mar 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fZ8drxjY"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936DD3A8CB;
	Fri,  1 Mar 2024 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259622; cv=none; b=ML1U1IhGSDKMOE0HD3LMENQpb0zyvNfBPqP/Hxg8JNY9JIiDaCLpjkgyropQ9c4hUk4Ybb5jqPvR2LdWNFISCR9W7jhscQjB3XOnexRShDaQ+U/RTUoJ/tv4jJIhHS9enuDuN6Mu57IrfghWrs5LtLBb72R0yzLhCuH8R4S3raY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259622; c=relaxed/simple;
	bh=0ASI0QBgr5mKYcrNbcJsHaME97RTiEsh8W1nyHlpaQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rkd0LOtmALmJgadav1Y2qqGqqsazh38cwL0TDx+WioE0fDvrnuY162lRs2Q3N035wcS9gW28q2luUDhSvKQ4CyMPlc7ZaOwGlvveLQvNlS4+LAjp2OV/SrkS3BRsdJWOzAgQKW1r0FqIXi6JGuRcrQimMhbW2B8LHxoy1FzpqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fZ8drxjY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4211HTfR007771;
	Fri, 1 Mar 2024 02:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JjpeBF+HPJkru1kwSAxmoUSoOHgw4cHjXPFWE8PXlk4=;
 b=fZ8drxjYeMezieTKQYIixC8G6cnDHzfcRStFfbjXpiG7wQ4Re7XwSMOAK5nd3e5VTf1t
 ptf747minO8FF92Q9BCNaRfXqWqBYa2viLFL8mWa63cP/k5UpxObSXfT53bH+5h+AXH2
 fkZgEKiwZ3ATAqSEX7drCrec9s2Sth1sd+bICmVrhE4nW+4BGKxUE3ect6MwgkrJIntq
 RtUj3dUkOsxdVzJObM6sSu5FmnN/X+o0NyhTozrZs27h7Qn9GTggqTIOrRJiGV/cHL7z
 SUJjZpDm93BzOq0Vd3u0Tvk/pG7SqwYEXg4UrZZ3yT6FCGqXyZmAXW7hBlX76bpSMn+j ew== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk57h1dec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4211FCMs008189;
	Fri, 1 Mar 2024 02:20:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9msefa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:20:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4212K9988323772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 02:20:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A0F458067;
	Fri,  1 Mar 2024 02:20:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03DEB58069;
	Fri,  1 Mar 2024 02:20:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 02:20:08 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 00/12] Add support for NIST P521 to ecdsa
Date: Thu, 29 Feb 2024 21:19:55 -0500
Message-ID: <20240301022007.344948-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5FlnokoOG48JoA31FUNuV0UKgGBxWpkA
X-Proofpoint-ORIG-GUID: 5FlnokoOG48JoA31FUNuV0UKgGBxWpkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010018

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


Stefan Berger (12):
  crypto: ecdsa - Convert byte arrays with key coordinates to digits
  crypto: ecdsa - Adjust tests on length of key parameters
  crypto: ecdsa - Extend res.x mod n calculation for NIST P521
  crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
  crypto: ecc - Add nbits field to ecc_curve structure
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
 crypto/ecc.c                              |  38 +++++-
 crypto/ecc_curve_defs.h                   |  49 ++++++++
 crypto/ecdsa.c                            |  62 ++++++---
 crypto/ecrdsa_defs.h                      |   5 +
 crypto/testmgr.c                          |   7 ++
 crypto/testmgr.h                          | 146 ++++++++++++++++++++++
 include/crypto/ecc_curve.h                |   3 +
 include/crypto/ecdh.h                     |   1 +
 include/crypto/internal/ecc.h             |  27 +++-
 include/linux/oid_registry.h              |   1 +
 12 files changed, 339 insertions(+), 17 deletions(-)

-- 
2.43.0


