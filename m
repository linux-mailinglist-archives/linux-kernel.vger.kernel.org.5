Return-Path: <linux-kernel+bounces-45346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B03842EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C2D2836CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7032128379;
	Tue, 30 Jan 2024 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZSEWej8d"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE738DDA;
	Tue, 30 Jan 2024 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651215; cv=none; b=fi5mWXFEtQsNwtjn4u0G2YegxowtUVqc0fm6wLdZ+J2FoB7edQgGAEPxFH14TK31Pywc6TO+cK3TGbKF+BYtkRx83h5a5TuYN/iAwzmca+HBIDp/PFWOREsGtohHsXZf3Rs2MNDGxp1r4bugsFsUNwlj3njau0HIMdkpWJ+LV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651215; c=relaxed/simple;
	bh=fko3Q4lRRl/Wm+5Yw78C6kwXS/X7KRn5qG2g32rszas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+1VuneVt5CU6/aNUmBOp8MQo+EKtYfvthtNbJnEBxHrHgxobU+geF7cR3XhN2ACt38WStgWmAFTUvN8VzRuzYmncPMfZ2I8Fgy+neArcwaGbyrz5jEYaPxkscot1zvKoipEI5z1pfytuNFFkR0zmXSaZlxg4i/8mK3uaZvfkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZSEWej8d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ULTh2Y003205;
	Tue, 30 Jan 2024 21:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wz5alzgZGA75p+vJiiGpPWF6YGNkfFb4qVjYIWwiQkg=;
 b=ZSEWej8dLpXjrEqaQYR8mHCBu4q3GE8L0B2pDTHE+KYUjYp4v7GvHEi3xYABJqzNBWat
 nCJPjL2l2luWSflXSOvun4nXUrT0XcGkHgt3A5lbTwdBvBLT4etIYhMOcMFdxuIFSQLa
 frKOHfoUOr0Akk5GEUXtlA2+gKwG3LnUtXkLWjVFomjl/kVQdBxAvI/XtOHRoBOKJgH4
 l2NRZMErZ8/GXa87JJ1o0+PqyA1rr/iDeqPsMvl2d5zq+OgSq8pT7B3BK9SXoaemblKI
 oOiFaqOsy2X1T16pmuE/dNt1WIL0RduRe4XuGwbbtDOWAWyjjtk0+8vP2F1xdCRVOn/D 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy5uw56rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:29 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40ULW9Xg012224;
	Tue, 30 Jan 2024 21:46:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy5uw56rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40UJesnG007955;
	Tue, 30 Jan 2024 21:46:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnm1bym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40ULkRxq17433218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 21:46:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34A7D58065;
	Tue, 30 Jan 2024 21:46:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C77D58052;
	Tue, 30 Jan 2024 21:46:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jan 2024 21:46:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/5] evm: Support signatures on stacked filesystem
Date: Tue, 30 Jan 2024 16:46:15 -0500
Message-ID: <20240130214620.3155380-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TB76e65MHegKJwRbcqDWeRL7pB2LAT7B
X-Proofpoint-ORIG-GUID: dYbKoqnTv7l7GkknzWH68E3FaT5i1mkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_12,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxlogscore=704
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300162

EVM has recently been completely disabled on unsupported (e.g.,
overlayfs). This series now enables copy-up of "portable and immutable"
signatures on those filesystems and enables the enforcement of
"portable and immutable" as well as the "original" signatures on
previously unsupported filesystem when EVM is enabled with EVM_INIT_X509.
HMAC verification and generation remains disabled on those filesystems.

Regards,
   Stefan

Stefan Berger (5):
  security: allow finer granularity in permitting copy-up of security
    xattrs
  evm: Implement per signature type decision in
    security_inode_copy_up_xattr
  ima: Reset EVM status upon detecting changes to overlay backing file
  evm: Use the real inode's metadata to calculate metadata hash
  evm: Enforce signatures on unsupported filesystem for EVM_INIT_X509

 fs/overlayfs/copy_up.c              |  2 +-
 include/linux/evm.h                 | 10 +++++-
 include/linux/lsm_hook_defs.h       |  3 +-
 include/linux/security.h            |  4 +--
 security/integrity/evm/evm_crypto.c |  2 +-
 security/integrity/evm/evm_main.c   | 48 +++++++++++++++++++++++------
 security/integrity/ima/ima_main.c   |  2 ++
 security/security.c                 |  7 +++--
 security/selinux/hooks.c            |  2 +-
 security/smack/smack_lsm.c          |  2 +-
 10 files changed, 62 insertions(+), 20 deletions(-)

-- 
2.43.0


