Return-Path: <linux-kernel+bounces-150385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA88A9E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A491C21A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4899816C6BD;
	Thu, 18 Apr 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y9XGMIJd"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B018161935;
	Thu, 18 Apr 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453907; cv=none; b=QeYd4u4meRaqkeb+S/xR1RF6pZ3DXi0kpMHHgSd/F4AFI/7qDGhV5BAdikBuDIWYMEip5jNfWeitZD4OgCmYcllbzwHFOLXdXP1Bh24A2fD2NpeYFSt/FgdqQ97pL9u7oiMXlD/LwhhtIE8ZhGNsvrQiabtdNf9mKJns/BsIVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453907; c=relaxed/simple;
	bh=wWjAJ4S4d5MkuoDto+B9EKc+OQaYQW91f7+3yJ8CSGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hBALLCfHrJmSpWb1fvJyHDUNrfwULbh+pHt3uBh+q0a4Xx8uAbhGkd2HIfR9L+tyvdMyrLbL0WV8gmfktOdY80/cPLFDB+1vBsEP25sv2UECb8Y/QE86FKPP2PBTkjAWuGEq+qaS0eIeEsG+5yKcsZDmTsqMm0DoJp23c6KYyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y9XGMIJd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43IFAlkY022338;
	Thu, 18 Apr 2024 15:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=EE4+WRzBA2XlcVrOR4MaW+MheWrkZfAx+4CxF8kZI3A=;
 b=Y9XGMIJdw8pIh26Kv5tuCG5YkbxarcHWr+2LYjBNLCz06YviWlHuLjldYCsfzeameyoF
 D4EArf3/NCClB+W5ygjfDHW/T8PsIKfPHKcFROX74DNuUAkK2QGd5pBegfmuoXu+CUHH
 S9PZDldF6j2dmts4WvuZZhH2SIo1LlH1ZgwAbr1eIMNNXH16co9P9u0H/5Dj0Fy81l/k
 y9tUkpXQOTETLM8WUtseJMeZV2MgzEQ7Ovdr8IawaVU6GGPhpgNcsRP7nVal5XNI8rgo
 pw7/wqpxQY4JTMHGsTw8Z8S+GRa+psxspPme+XMLRNxFj3P0FKoMHyPqQm38H62eR6I3 lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xk5wyr1p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:24:57 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43IFMIuI010880;
	Thu, 18 Apr 2024 15:24:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xk5wyr1p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:24:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43ID4UGj011110;
	Thu, 18 Apr 2024 15:24:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg732txwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:24:56 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43IFOrKJ43778346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 15:24:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 376CB58070;
	Thu, 18 Apr 2024 15:24:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DFAE5805A;
	Thu, 18 Apr 2024 15:24:52 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Apr 2024 15:24:52 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
        git@jvdsn.com, hkario@redhat.com, simo@redhat.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/2] crypto: ecdh & ecc: Fix private key byte ordering issues
Date: Thu, 18 Apr 2024 11:24:43 -0400
Message-ID: <20240418152445.2773042-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gsKcfQhTL37dpVpm05UACsqRAnOnmLVu
X-Proofpoint-ORIG-GUID: EbGWLyzxZR7DDrbKBSd3Lct6H6lKL2IC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_13,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=998 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180109

The 1st patch fixes a byte ordering issue where ctx->private_key is
currently passed to ecc_is_key_valid but the key is in reverse byte order.
To solve this issue it introduces the variable 'priv', that is already used
throughout the ecc and ecdh code bases for a private key in proper byte
order, and calls ecc_is_key_valid with 'priv'. Note that ecc_gen_privkey
also calls __ecc_is_key_valid with 'priv' already.

The 2nd patch gets rid of the 'priv' variable wherever it is used to hold
a private key (byte-swapped initialized from ctx->private_key) in proper
byte order and uses ctx->private_key directly that is now initialized in
proper byte order.

Regards,
  Stefan

v3:
  - Added Jarkko's A-b tag
  - Expanded on the description of changes to ecc_gen_privkey (2/2)

v2:
  - Added missing zeroizing of priv variable (1/2)
  - Improved patch description (2/2)




Stefan Berger (2):
  crypto: ecdh - Pass private key in proper byte order to check valid
    key
  crypto: ecdh & ecc - Initialize ctx->private_key in proper byte order

 crypto/ecc.c                  | 29 ++++++++++-------------------
 crypto/ecdh.c                 |  9 ++++++---
 include/crypto/internal/ecc.h |  3 ++-
 3 files changed, 18 insertions(+), 23 deletions(-)

-- 
2.43.0


