Return-Path: <linux-kernel+bounces-37788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F073983B504
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3501C22675
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD30136641;
	Wed, 24 Jan 2024 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJ8e5VE2"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17E2C683;
	Wed, 24 Jan 2024 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136854; cv=none; b=FNeotzcUQyr3GYac/jt9yMjQyLHp4O+efjnwwLlwj62qXquTENxqVUQoqlE2yhR4NOQB4wpsMc3I4A6L7fAPkgPLkNos51aaeKnzhbmyoB+jIoXA2V4CL/9BjGPTk6gYWOmMSTVOlqf7Dm6/A0fJqqWwVvk9ildKGaAC0TyBFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136854; c=relaxed/simple;
	bh=BCYMLTsBfws+WNhhkrG0RQGLASBNHhX4U1FzKwSGfBY=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Nk2vkgNDbT6ELJIEtqY3zvzKD5sUtf/liIcVlFu3qvCdbFxmSzp16i5CAx2VhCQ+ov6OAmoPX88Rm5x3P1LZtRU4s8gY8X2BDSedXOMa0BXlN+AtATJfXkhC0LcGH4bDlvpQCcc+4kapVRzKY7ux14S8swX4mr0iIPk4HBCk/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJ8e5VE2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OLVHSS022476;
	Wed, 24 Jan 2024 22:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=8gBdsWZxZ/0sikWnrpWbSjcy7IBoOqUxOPpQvY1o8mY=;
 b=qJ8e5VE2oTbCAk23FSRg+qWZCOo7WRUcab4uUgPa2Ha/bpHUVazKgCdj6vdLajNCOO1W
 fRS7No54n8OBBPBqM9AVWeCTxqNuUw1EZMiu9W9u7FXzWUL3K63KI5/XlVxTTSorHzlO
 JTCQumS9cdcgwXbtW8eLOj8LwIRBINVNnC9N5SpHk9wQH1SYfpoCeR7TeyTIrQ/jPHDL
 2qm8C0dLnMzk2sLFaTuRuCShYNBOybN3HCTn847+0WY8nTq3eNJWQIxdhfBEmQ/SeKPD
 VvSvXsmLkw/k98VBbPYdNNzl+GmQ0MlWXan4bXeol4VYURCjMuyO71zNolPWHlOs1aLi 6g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu8c8w1k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 22:54:09 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OLWoKU010850;
	Wed, 24 Jan 2024 22:54:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrrw010pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 22:54:08 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OMs7fp14025320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 22:54:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 898775805C;
	Wed, 24 Jan 2024 22:54:07 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 386375805A;
	Wed, 24 Jan 2024 22:54:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.48.186])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 22:54:07 +0000 (GMT)
Message-ID: <6287f771f498fc189204bd15665561c70d3ed0e1.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem updates for v6.8-rc1
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
	 <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>
Date: Wed, 24 Jan 2024 17:54:06 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zC87VWbEmgKBwmWlLHPw_4WoXCXmNgQj
X-Proofpoint-ORIG-GUID: zC87VWbEmgKBwmWlLHPw_4WoXCXmNgQj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_10,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=606
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240166

Hi Linus,

Please revert the one "encrypted" key patch.

thanks,

Mimi


The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.8-rc1

for you to fetch changes up to 1ed4b563100230ea68821a2b25a3d9f25388a3e6:

  Revert "KEYS: encrypted: Add check for strsep" (2024-01-24 16:11:59 -0500)

----------------------------------------------------------------
integrity-6.8-rc1

----------------------------------------------------------------
Mimi Zohar (1):
      Revert "KEYS: encrypted: Add check for strsep"

 security/keys/encrypted-keys/encrypted.c | 4 ----
 1 file changed, 4 deletions(-)


