Return-Path: <linux-kernel+bounces-79115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD16B861DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB6E1F22415
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F1F1487CD;
	Fri, 23 Feb 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OYjnNBi/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08FEAD2;
	Fri, 23 Feb 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720934; cv=none; b=pzvcLxv1u/CbR7CxOLAkBLaSjLVDDaEGqflEForLi1uP43FmrL5B245siwDhH9BbnmT33540chU2NLNfEOSqE1bqANKJUea9iJO2apXJETqPntOgKCYRsSqP8qOrBZQO8daE9It77t2EC8E+ppUMrY9Z7hxeznclXMFL850ZhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720934; c=relaxed/simple;
	bh=sEs6vijaB9Edmeoq3BWV/Ii1U+JkXoXAoLGoCG3foyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPD3azM/fKtZLnD20sYPt2Kjpxlskt/i4acF6pA/N2zrRe8JzahC1sm1baF8G3AQEAd4Y4//3UsibgM6ux8/iHRVpICK7nmq0E92j2VK6js04+jFqcudRTiSjlU1lT45VLNkLVDaiEQz0LqwsT5UppRcG9J3+oyxFQpyanUZ6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OYjnNBi/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NKRIuH017998;
	Fri, 23 Feb 2024 20:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=VLlFtFDBHgou09f1kfcjHqUWeU0A+n7YPSS2lnWnVNI=;
 b=OYjnNBi/ZGFgTly4IOOZlGx0IsW2DGrcOEwNXuzZeZji8reMJw+9a5ooa8n6ZbnGjOeg
 icWhPa7SYWrc2lC0aMmv8uTSS1De1Ypwktc81JCVD7v6jueMASxFotUt/sq8zkz/ygH2
 OtmaG3tV5oyNyrtXcnPMDxz55S7Gumbo5un7DPNprZSp5TmtH+rThjOfue5lL8zrGwjz
 XX3vcvdy2Xvv7ZHTHjLrvNTsOrnHIx8pOlF+ZlrWq+mfNOqI9AnEUH0yi/dLWKQc79lc
 oQGPHKeelKS1GpwANH9tUyxVskVE8+jcNwmE32d0OdvcS4RYTJtWVeAJh6SYpPmHENMB MQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wf2dh8ab2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:06 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NIUiB7003671;
	Fri, 23 Feb 2024 20:42:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u8bbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 20:42:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NKg2C03473986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 20:42:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46E0A5805C;
	Fri, 23 Feb 2024 20:42:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CC285805B;
	Fri, 23 Feb 2024 20:42:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 20:42:01 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 00/10] Add support for NIST P521 to ecdsa
Date: Fri, 23 Feb 2024 15:41:39 -0500
Message-ID: <20240223204149.4055630-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xfG55matZWQnnFtfnhKmC7ft7MdH6e0z
X-Proofpoint-ORIG-GUID: xfG55matZWQnnFtfnhKmC7ft7MdH6e0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230152

This series adds support for the NIST P521 curve to the ecdsa module.

An issue with the current code in ecdsa is that it assumes that input
arrays providing key coordinates for example, are arrays of digits
(a 'digit' is a 'u64'). This works well for all currently supported
curves, such as NIST P192/256/384, but does not work for NIST P521 where
coordinates are 8 digits + 2 bytes long. So some of the changes deal with
converting byte arrays to digits and adjusting tests on input byte
array lengths to tolerate arrays not providing multiples of 8 bytes.

Regards,
   Stefan

v3:
 - Dropped ecdh support
 - Use ecc_get_curve_nbits for getting number of bits in NIST P521 curve
   in ecc_point_mult (7/10)

v2:
 - Reformulated some patch descriptions
 - Fixed issue detected by krobot
 - Some other small changes to the code


Stefan Berger (10):
  crypto: ecdsa - Convert byte arrays with key coordinates to digits
  crypto: ecdsa - Adjust tests on length of key parameters
  crypto: ecdsa - Extend res.x mod n calculation for NIST P521
  crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
  crypto: ecc - Add nbits field to ecc_curve structure
  crypte: ecc - Implement ecc_curve_get_nbits to get number of bits
  crypto: ecc - Use ecc_get_curve_nbits to get number of bits for NIST
    P521
  crypto: ecc - Add NIST P521 curve parameters
  crypto: ecdsa - Register NIST P521 and extend test suite
  x509: Add OID for NIST P521 and extend parser for it

 crypto/asymmetric_keys/x509_cert_parser.c |   3 +
 crypto/ecc.c                              |  38 +++++-
 crypto/ecc_curve_defs.h                   |  45 +++++++
 crypto/ecdsa.c                            |  48 +++++--
 crypto/testmgr.c                          |   7 ++
 crypto/testmgr.h                          | 146 ++++++++++++++++++++++
 include/crypto/ecc_curve.h                |   3 +
 include/crypto/ecdh.h                     |   1 +
 include/crypto/internal/ecc.h             |  32 ++++-
 include/linux/oid_registry.h              |   1 +
 10 files changed, 315 insertions(+), 9 deletions(-)

-- 
2.43.0


