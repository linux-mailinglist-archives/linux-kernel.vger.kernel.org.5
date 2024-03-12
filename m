Return-Path: <linux-kernel+bounces-100669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71B5879B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3471C21CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9C214290A;
	Tue, 12 Mar 2024 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kpS5rdUa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD41419A1;
	Tue, 12 Mar 2024 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268662; cv=none; b=Ldq8y+IPtw6NJy6OdvCb1T8Q20YFLnLbNuv94+Ck7IlK5SoYTN52DnjlnVT1MPEFEymLQU4eIpwU/C/ATZ73Q7tY3vfErJwaUp//orXwcOugyescc09S++K1TNUn1F7VmbC50r8ESqQVDO5OxNvDo9vpfNUtRqARSIhFAMpOmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268662; c=relaxed/simple;
	bh=adE6PZuzbJhW6t8V+EEesw9uAHlu6hRyYzO+3OHw9WU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZEI5YjV1RQJ0xWYEm+PYUPvLLuor5genywPHM+Se0O4j1mYFQlPu9jIM5gHxlEy7NhM8L3oj+betnKO7lWMiQbawJXdW0mhhQ77qDkiqDBOr8a/CO6IzDwrzuwYt551muXuw0waxQyLR6jUhIY1uQRu916kl2/5yZrOG3cBz4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kpS5rdUa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CINKZ9013196;
	Tue, 12 Mar 2024 18:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5tDRGSYFAaMEnebOOvjF6I0KPKK2H018logOOA4kS/U=;
 b=kpS5rdUayrUPRFMSRwxCjbCURqvxgcK7m0EBLk4q/JgQVLjERPYchFnCAhahTTQ2VzhH
 ogJpq4g748vy7mzNYp7LUwwP3FzxWCYmwf6iZtFFBqTZbaA+acbugy3pQoUTO4JKukow
 Chn4O4DplqhajQC1H3bIth2sihug+lv1wmeRumLgQ3ocYwwKwuCVpFs8lldwxtipY1VS
 LBgnvMUxMsHkAHX2ClZbdJCYqcDoCSB+AX8ns7aJZmANd4rdu2auMJRBA8hDtV2xO54Q
 hQr2r3L9z6u7D970ovAh90HnQr6hRQ8ZTXMUcPbQBuOBzqU/7vgKwh1wVZZ2SHLzECUY SA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtv9d86j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CIIfuG020496;
	Tue, 12 Mar 2024 18:36:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3km0rde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 18:36:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CIaKNA38600990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 18:36:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A37705803F;
	Tue, 12 Mar 2024 18:36:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2D015806A;
	Tue, 12 Mar 2024 18:36:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 18:36:19 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, jarkko@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
Date: Tue, 12 Mar 2024 14:36:05 -0400
Message-ID: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7_oFEvKzZjNa3IPNv9VWgMUw86goXXuW
X-Proofpoint-ORIG-GUID: 7_oFEvKzZjNa3IPNv9VWgMUw86goXXuW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_11,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 spamscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120139

From: Stefan Berger <stefanb@linux.ibm.com>

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


