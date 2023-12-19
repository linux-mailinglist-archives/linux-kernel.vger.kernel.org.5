Return-Path: <linux-kernel+bounces-5745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DC4818EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED3C287FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E133F4B120;
	Tue, 19 Dec 2023 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SPGBc47L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B6E4B13B;
	Tue, 19 Dec 2023 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJHW8xU000888;
	Tue, 19 Dec 2023 17:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/G7gx/nF4hhpjw41JIWC4gDPqAOm1ZXfb+1VpMRGg7o=;
 b=SPGBc47Ld4paTgCmTQmnIEkHioU5l+3SNMkJthqzk1dWaciwrt8hMkKMqw1y8OKHw1+U
 VaUsGGsQAj5OiwG5Dagy6n6zufvaJxQYyP7UpjmkeHTQQnX2ANTVqxh0plOhub6eNjaP
 rq+9qF/7U673O4nTKPj+vZmiYpII7iQGm0iFp4hu9aDXn/2S76W+Nmi2BLIOjpbM1yf0
 jGOqQGU9IfbR3ym3xJSA5UpYQr6ehTGGVaN23MGa1kJJCNITpW6RODhM0hd5J2iC3Khi
 4cO+4umvhceUSQgEukNn7zDjTk4PajomSbt1+gec+uBITTDU0Oz5HXnyZL+7BLDd1/W2 mA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3fngrf6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:17 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJHhatD005939;
	Tue, 19 Dec 2023 17:52:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3fngrf64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJHo6x5010885;
	Tue, 19 Dec 2023 17:52:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nhefh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJHqDZe43450688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 17:52:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5708520040;
	Tue, 19 Dec 2023 17:52:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 166762004D;
	Tue, 19 Dec 2023 17:52:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.138.145])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 17:52:10 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-unionfs@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH v2 0/3] evm: disable EVM on overlayfs
Date: Tue, 19 Dec 2023 12:52:03 -0500
Message-Id: <20231219175206.12342-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pB-8N_KLuBm7kbVeTuD99iuHW2-CzLEL
X-Proofpoint-ORIG-GUID: bvmvuLSS8K3RAQnO1sL-wHBB4yByMKm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=661 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190133

EVM verifies the existing 'security.evm' value, before allowing it
to be updated.  The EVM HMAC and the original file signatures contain
filesystem specific metadata (e.g. i_ino, i_generation and s_uuid).

This poses a challenge when transitioning from the lower backing file
to the upper backing file.

Until a complete solution is developed, disable EVM on overlayfs.

Changelog v2:
Addressed Amir's comments:
- Simplified security_inode_copy_up_xattr() return.
- Identified filesystems that don't support EVM based on a new SB_I flag.

Mimi Zohar (3):
  evm: don't copy up 'security.evm' xattr
  evm: add support to disable EVM on unsupported filesystems
  overlay: disable EVM

 fs/overlayfs/super.c              |  1 +
 include/linux/evm.h               |  6 +++++
 include/linux/fs.h                |  1 +
 security/integrity/evm/evm_main.c | 42 ++++++++++++++++++++++++++++++-
 security/security.c               |  2 +-
 5 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.39.3


