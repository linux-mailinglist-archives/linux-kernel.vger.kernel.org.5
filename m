Return-Path: <linux-kernel+bounces-94647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159398742A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C6D2874DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881D1BF33;
	Wed,  6 Mar 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fwztZbpo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151B1B968;
	Wed,  6 Mar 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763795; cv=none; b=SH1jE70/cXeRTXHkRhVM60FrsKtYPzyu3wG48qMzajTywBtHzF24jrq1wRt1NtEZTCCx9F16HMFvZKRHhaj3W5ci1QMK3V4UMq8FrEpBF3W8sL8+LYDNRB32o8AUDgCKOzE1ZL6HQAynGBLX6VEN+NzKgOMeSeQTmNqnm7DTNBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763795; c=relaxed/simple;
	bh=sDK84lfmuSC7pJr54uqmkMSP4zDEol1K6wtHbdmkwOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcvzHG37tbewQajEzfj0ny85i8r4w175wJueKyuJCArnEo+1g8OEx7i9C5W9CCMbRT5MIomJwo+JW8++VTZy6Y/P0CJpIjEnkdVPGfLmp+dSHBlU7dGgRcQhMZSEUrxgIydvl53J1kcL25FGs8kIMxdI1OYBIZAAmzASt3hdMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fwztZbpo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426LaOMe018903;
	Wed, 6 Mar 2024 22:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fDV+HfDrb1zuUETx7OduHcpgAWKbPykyUgI+/wXrJv0=;
 b=fwztZbpoDRqhNXdoe9wfttXcRMKlpCyVhxCFQEAFpA3ezKTC1364mj9Z47JwZ/4X3/Wk
 LmjlkWQ78A3m9J/xabG9vI0SQv+exPqf6Ro/n9IEORV78XstBK2lgF7nDpTtQcHWo9QF
 vTr3kdjFJJ10R2h9T0TUPLiKw98sleMAoKIDtZH2j36C/5tLYnH5aVeNx6PD1rpFfvDt
 YTIwQNB3XsGOwrkI7cHtQY/PzE6TrzMNldS4X7rYc2nv1PhZE+tp6w6e0VBURQ7YgulV
 skrrleooVkb0EnUmlKjGhcHVUmZlmZ5y9aljorU54he9dMmBMjVu9wINSo8MW3g8qVOv 5w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq0009s7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:05 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426KUOZg025376;
	Wed, 6 Mar 2024 22:23:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetysunn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:23:05 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426MN2TB24904196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 22:23:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 658AE58064;
	Wed,  6 Mar 2024 22:23:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E506B58062;
	Wed,  6 Mar 2024 22:23:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 22:23:01 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 00/12] Add support for NIST P521 to ecdsa
Date: Wed,  6 Mar 2024 17:22:45 -0500
Message-ID: <20240306222257.979304-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cXcqeqof_g4_vBuOkXqv6D0lqEYSQ30w
X-Proofpoint-ORIG-GUID: cXcqeqof_g4_vBuOkXqv6D0lqEYSQ30w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060181

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

Stefan Berger (12):
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
 crypto/ecc.c                              |  38 +++++-
 crypto/ecc_curve_defs.h                   |  49 ++++++++
 crypto/ecdsa.c                            |  62 ++++++---
 crypto/ecrdsa_defs.h                      |   5 +
 crypto/testmgr.c                          |   7 ++
 crypto/testmgr.h                          | 146 ++++++++++++++++++++++
 include/crypto/ecc_curve.h                |   2 +
 include/crypto/ecdh.h                     |   1 +
 include/crypto/internal/ecc.h             |  23 +++-
 include/linux/oid_registry.h              |   1 +
 12 files changed, 334 insertions(+), 17 deletions(-)

-- 
2.43.0


