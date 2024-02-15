Return-Path: <linux-kernel+bounces-67799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB3857138
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C16D281EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C9145346;
	Thu, 15 Feb 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qX96FAx7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875C55E7F;
	Thu, 15 Feb 2024 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038871; cv=none; b=BaoJWZy+ITMdYnnrYyiGttvZJD+zAolY5wwhKX2DuxDDabXJD6hluJjlIuWTL9VQ1pyx9bw699n+Of8XIgEb+TYj35w/UUHRQnMgSoZk9mhz7dL8TRxNu9OdtMUalp9QypDECTGrJMRi2MxEDZ0LUSKluft6+CEx/RX0qTetORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038871; c=relaxed/simple;
	bh=WuUHPMu1eWQ75Vj/lr23x5MIR7SQlH/CobtERlpyzlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgNilDCGTuDtRrZFlm+3f4gnMWi14EmbZHqan1g2gU+9R4vh+26WA1rOs5RWwwJ1bjqJjYkJIgHaLkASFv/0MCN8pi0JLKD4k51XuyBfYMCd+ntJJV8/WrU4kJNdRWVl1u4XYWivaiP+wMEgrQn+3iJEyMYY3yXVY3022rXKmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qX96FAx7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FMQRFm004742;
	Thu, 15 Feb 2024 23:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UZjHkAk5b7WPa1+8FHCmTb+h5x9Nltenptgg7RNqjrw=;
 b=qX96FAx7AoT5fTwexq3JmE/ddN8bwy5Iner4RempUg9wfnFsQeXHKk+/KZf4WG06WZpk
 JauYlCz1m6zB9Q0Loiqd+2Y0xrtQsH+Q185nwE+Q8AoAhBSJRRt0Cx+j82DPy2o5TPeY
 8J7c4L+Wwgg83KS9JnY4bfsNaVYh75LITuzfDwbXNqBX6NEnRuJxomJYV2eAS7kzjh5E
 3ZqXZ8SRj9HHs9kvf7xNP0cFDOxaC1ffoRFfVipXMo26oqs4CXokqGdfpl2naboGiMC5
 M8ENeT09Bux+eLSkpJf+hZLjH0HvzMEocLuPycuZVQDTSXwQF7RkuVRPeCOOb2BBmDFb rA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9u52a53x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FM0EFN004287;
	Thu, 15 Feb 2024 23:14:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0r3ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:22 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FNEK236750858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:14:22 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5516E58045;
	Thu, 15 Feb 2024 23:14:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3D7858061;
	Thu, 15 Feb 2024 23:14:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 23:14:19 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 00/14]  Add support for NIST P521 to ecdsa and ecdh
Date: Thu, 15 Feb 2024 18:13:59 -0500
Message-ID: <20240215231414.3857320-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cLcKk5n4A3Q6OGGGd1mpx9aUo5mQeIvc
X-Proofpoint-GUID: cLcKk5n4A3Q6OGGGd1mpx9aUo5mQeIvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=979 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150181

This series of patches adds support for the NIST P521 curve to ecdsa and
ecdh. Test cases for NIST P521 are added to both modules.

An issue with the current code in ecdsa and ecdh is that it assumes that
input arrays providing key coordinates for example, are arrays of digits
(a 'digit' is a 'u64'). This works well for all currently supported
curves, such as NIST P192/256/384, but does not work for NIST P521 where
coordinates are 8 digits + 2 bytes long. So some of the changes deal with
converting byte arrays to digits and digits to byte arrays.


Regards,
   Stefan

v2:
 - Reformulated some patch descriptions
 - Fixed issue detected by krobot
 - Some other small changes to the code

Stefan Berger (14):
  crypto: ecdsa - Convert byte arrays with key coordinates to digits
  crypto: ecdsa - Adjust tests on length of key parameters
  crypto: ecdsa - Extend res.x mod n calculation for NIST P521
  crypto: ecc - Implement vli_mmod_fast_521 for NIST p521
  crypto: ecc - For NIST P521 use vli_num_bits to get number of bits
  crypto: ecc - Add NIST P521 curve parameters
  crypto: ecdsa - Register NIST P521 and extend test suite
  x509: Add OID for NIST P521 and extend parser for it
  crypto: ecdh - Use properly formatted digits to check for valid key
  crypto: ecc - Implement ecc_digits_to_bytes to convert digits to byte
    array
  crypto: Add nbits field to ecc_curve structure
  crypto: ecc - Implement and use ecc_curve_get_nbytes to get curve's
    nbytes
  crypto: ecdh - Use functions to copy digits from and to byte array
  crypto: ecdh - Add support for NIST P521 and add test case

 crypto/asymmetric_keys/x509_cert_parser.c |   3 +
 crypto/ecc.c                              |  71 +++++--
 crypto/ecc_curve_defs.h                   |  45 +++++
 crypto/ecdh.c                             |  59 +++++-
 crypto/ecdsa.c                            |  48 ++++-
 crypto/testmgr.c                          |  14 ++
 crypto/testmgr.h                          | 225 ++++++++++++++++++++++
 include/crypto/ecc_curve.h                |   3 +
 include/crypto/ecdh.h                     |   1 +
 include/crypto/internal/ecc.h             |  61 +++++-
 include/linux/oid_registry.h              |   1 +
 11 files changed, 495 insertions(+), 36 deletions(-)

-- 
2.43.0


