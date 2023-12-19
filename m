Return-Path: <linux-kernel+bounces-5279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB1A8188E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718091C210D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCFA1B291;
	Tue, 19 Dec 2023 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SFjzEG3g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EC1A71B;
	Tue, 19 Dec 2023 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJDbkY1029337;
	Tue, 19 Dec 2023 13:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=4N237+y4JuL68L0Vfcja/M7DRPpqMhObSzld6xfYsw4=;
 b=SFjzEG3gg+UEvbmYcuw5Js2j3UEAF4Z3VwBk5NR2E5zvSP50CjgDSevw4tR8gbmspJB3
 RQphETmDz+Yk7IrrQQ6vrkDKnzAP1AxgMoIGyHvTeOWcxdgG4O4fOSYcO0NkO4KW6mDZ
 xxp8MCPk0kvnIeFCzVEzOY6TaiAzXuwcq2LwlRnz1sPnOhH6rdKmkhMGIAA+DzjkK5Vd
 iGmhV/uKzjMLPQ2V1UOuN5jb+qAltl8AO9Ebeqs+PjyG56uCKVfxUcfKGBu1PmvdGcKF
 ch2WEKXtB3Ig/NYlowQiVnusaIJrOLyhstvee8wGOOEQFEf5LBLJDmm9BeeYkBiQVNal jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3c7f8abc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:49:32 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJDeUUH005251;
	Tue, 19 Dec 2023 13:49:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3c7f8aah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:49:31 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJCq6U7004792;
	Tue, 19 Dec 2023 13:49:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1pkyr5ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:49:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJDnSgs23855836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 13:49:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 225D72004F;
	Tue, 19 Dec 2023 13:49:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 305AC20043;
	Tue, 19 Dec 2023 13:49:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.183.131])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 13:49:25 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-unionfs@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH 0/2] evm: disable EVM on overlayfs
Date: Tue, 19 Dec 2023 08:48:59 -0500
Message-Id: <20231219134901.96300-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CO7rPos_c23hfFuAAoLouGjOZSLhc1Bc
X-Proofpoint-GUID: aEYcIDB_FFion9Zow4xPOu-rsQ2zpXWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=503 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190103

EVM verifies the existing 'security.evm' value, before allowing it
to be updated.  The EVM HMAC and the original file signatures contain
filesystem specific metadata (e.g. i_ino, i_generation and s_uuid).

This poses a challenge when transitioning from the lower backing file
to the upper backing file.

Until a complete solution is developed, disable EVM on overlayfs.

Mimi Zohar (2):
  evm: don't copy up 'security.evm' xattr
  evm: add support to disable EVM on unsupported filesystems

 include/linux/evm.h               |  6 +++++
 security/integrity/evm/evm_main.c | 42 ++++++++++++++++++++++++++++++-
 security/security.c               |  4 +++
 3 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.39.3


