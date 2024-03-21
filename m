Return-Path: <linux-kernel+bounces-110171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408CB885B18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EE528465E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A117285940;
	Thu, 21 Mar 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jMnsfJvm"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164AA947;
	Thu, 21 Mar 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032300; cv=none; b=u56xXdErDJZ2qWcUJYZOkwF/OqX7FhY8x7IplQBVZCIqTLihU34Ruex8wTnR0RJDk6fKrGYNbwwum1FHgj7gXek1q906wmFhfYBnhBOM0jAhrVRxSC4TmYXCe3qAxMvG2dNBSBObJq6MhQMPi1i5vh/onDIc3tHm8osBdPaBhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032300; c=relaxed/simple;
	bh=qCkstqJlVs//3pE+siPC+9D8P8S6p2B+jJLD0515TgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLsT+2o6ogI6lzDZpHe09Slhtu1TOJ4tYriRNMz6wscdon9zLpabzVYAx4SGdSTUfcvTJv0IQTCWxeMP4vvtPI3YlfVFMaxEI/QDeZmS6u3qjN9Wgszp5gMGC+5pE43hWQmB38mtvzrB7ct7xT52kOD6/vKx3i3OqUi6YVbhU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jMnsfJvm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LDRHeU016087;
	Thu, 21 Mar 2024 14:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PQ5xY6ei81TW6VOKWM3ATzHUAb2g3AKdT/Rp3F1kRYk=;
 b=jMnsfJvmVssVcQY9Hk4zfoDgeM9/S7EOy/rabSo3i60VPp83fgxmLAzl6vRAE2s50vfs
 W4vtW9+W+gZDQUJTXF1S6V0LlU0RnQEhv5cN31Rr35H5HNYsPB8pL9VfYU5/kYskUzS7
 LaeJoA/u0BTaHoB2LyZcBWQmTxk6XBC/46FXjl6Bf95n8QWikdBrTdWKNUzy4kH/JBKB
 02a+282ZqzQoFCBzAtm5piZO2Cn/yV45I8xgAendQ5BvnLyxd4Dg7Nw++m+tDbK3hGyZ
 bCXA7/sR0rU0Fhnsmg7pap1THk47qGk4AK7YyOpw7ko1PkUiFmEm0C11dQ9iIA858UYA dg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0hve8wn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 14:44:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LEWI0W015807;
	Thu, 21 Mar 2024 14:44:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp50e0kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 14:44:43 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LEiedj27918724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 14:44:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C109E5805E;
	Thu, 21 Mar 2024 14:44:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4751D5805C;
	Thu, 21 Mar 2024 14:44:40 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 14:44:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] crypto: ecdsa - Fix module auto-load on add-key
Date: Thu, 21 Mar 2024 10:44:33 -0400
Message-ID: <20240321144433.1671394-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P6JNfM7pNRBercAoahdfaTZDGok4O-dq
X-Proofpoint-ORIG-GUID: P6JNfM7pNRBercAoahdfaTZDGok4O-dq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403210105

Add module alias with the algorithm cra_name similar to what we have for
RSA-related and other algorithms.

The kernel attempts to modprobe asymmetric algorithms using the names
"crypto-$cra_name" and "crypto-$cra_name-all." However, since these
aliases are currently missing, the modules are not loaded. For instance,
when using the `add_key` function, the hash algorithm is typically
loaded automatically, but the asymmetric algorithm is not.

Steps to test:

1. Create certificate

  openssl req -x509 -sha256 -newkey ec \
  -pkeyopt "ec_paramgen_curve:secp384r1" -keyout key.pem -days 365 \
  -subj '/CN=test' -nodes -outform der -out nist-p384.der

2. Optionally, trace module requests with: trace-cmd stream -e module &

3. Trigger add_key call for the cert:

   # keyctl padd asymmetric "" @u < nist-p384.der
   641069229
   # lsmod | head -2
   Module                  Size  Used by
   ecdsa_generic          16384  0

Fixes: c12d448ba939 ("crypto: ecdsa - Register NIST P384 and extend test suite")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdsa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index fbd76498aba8..3f9ec273a121 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -373,4 +373,7 @@ module_exit(ecdsa_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Stefan Berger <stefanb@linux.ibm.com>");
 MODULE_DESCRIPTION("ECDSA generic algorithm");
+MODULE_ALIAS_CRYPTO("ecdsa-nist-p192");
+MODULE_ALIAS_CRYPTO("ecdsa-nist-p256");
+MODULE_ALIAS_CRYPTO("ecdsa-nist-p384");
 MODULE_ALIAS_CRYPTO("ecdsa-generic");
-- 
2.43.0


