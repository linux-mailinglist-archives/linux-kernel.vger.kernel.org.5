Return-Path: <linux-kernel+bounces-53202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A85D84A219
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD17228588B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB092482DB;
	Mon,  5 Feb 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pwO/4muW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5C47F7E;
	Mon,  5 Feb 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157536; cv=none; b=DA17R9uYk7Xt/UTo8bGw1XLE90CCBzc90nvmvCG8/jIZSuu4tb6JLgETr5W+1jb5WCPeTsB6LfGd9BLkiVtqRo5L4R7ZEVUajTIvZFb08c9S3r8VtGeaem4pHemixOkhmbtGoc9iyWf481P4nCQF6xY+f5fu9I8+sbRSe/awqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157536; c=relaxed/simple;
	bh=lZOFVZ5BrPGJAEI+dGcHnVNQVExP4X/ULhxLPHyVzzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtWxl6u6y0LWZMajqsr1bUX5AttWZgC1i3c0HeZ9RPf+TMoK68ncS2PDgaJcCKMCMRBClYrkgzM5IguGT4DgcsFpZXvWJK2hzZ7yA5L3pdEcfNPi1psnJZxSAYN0AsCCKk0K0O/++9xgl03ZNC0f8gzBIblj/zGjFWXgmG+pJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pwO/4muW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415IGbmm002098;
	Mon, 5 Feb 2024 18:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=AmNsHJB73FQSeLBEzIki50uToPeDyz0KaEgQoaLpJ8c=;
 b=pwO/4muWMbR6r1IFqGLQE4n41IhsTgr1wKuHS5TqM5EdzwJd8UvysDseqnfg5KhFNDm4
 Nf4mE8HzAGivfwyz+F1tMCnxQ7Rr/e/ClncOmkcleTkJRhwo5A3vRnSjY2PSfw6ovcUg
 GJoE7tV3+Uiy+3DYgH5meumAh9Qf88uwd1/+0iAXB1seK6xb9yBJitlI29Kn/Fl+rJr7
 OOFoSovq6HE8rmD07Ng9h5Y2AgyKO62plYsDkhfTu6hzP+Lt2f7kULV6W2q+X16lDnZa
 vCw4ef+aEu/ZUTYrP3KwTwGq2MAEduwRU2HRBNCJq0WzCOcfGiKf7jIq53x6+UYYCese RA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w33s31pnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:13 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415IGmt1003408;
	Mon, 5 Feb 2024 18:25:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w33s31pnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415Fs5w5019996;
	Mon, 5 Feb 2024 18:25:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytstesg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415IPAxX50004426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 18:25:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B62AF58060;
	Mon,  5 Feb 2024 18:25:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12DE15803F;
	Mon,  5 Feb 2024 18:25:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 18:25:09 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/9] evm: Support signatures on stacked filesystem
Date: Mon,  5 Feb 2024 13:24:57 -0500
Message-ID: <20240205182506.3569743-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 78G_aEGCnAk9ZPOsa2bKqt9_FAXlRoI6
X-Proofpoint-GUID: Y98mxjG3XNgG3hkTLs2LogCyBM_Iga9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=753
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050138

EVM signature verification on stacked filesystem has recently been
completely disabled by declaring some filesystems as unsupported
(only overlayfs). This series now enables copy-up of "portable
and immutable" signatures on those filesystems and enables the
enforcement of "portable and immultable" as well as the "original"
signatures on previously unsupported filesystem when evm is enabled
with EVM_INIT_X509. HMAC verification and generation remains disabled.

"Portable and immutable" signatures can be copied up since they are
not created over file-specific metadata, such as UUID or generation.
Instead, they are only covering file metadata such as mode bits, uid, and
gid, that will all be preserved during a copy-up of the file metadata.

Regards,
   Stefan

v2:
  - Added patch to rename backing_inode to real_inode (1/9)
  - Added patches renaming flag and function due to RSA enablement (7,8/9)
  - Added patch to record i_version of real_inode for change detection (9/9)
  - Use Amir's function to get inode holding metadata now (4,5/9)

Stefan Berger (9):
  ima: Rename backing_inode to real_inode
  security: allow finer granularity in permitting copy-up of security
    xattrs
  evm: Implement per signature type decision in
    security_inode_copy_up_xattr
  ima: Reset EVM status upon detecting changes to the real file
  evm: Use the inode holding the metadata to calculate metadata hash
  evm: Enforce signatures on unsupported filesystem for EVM_INIT_X509
  fs: Rename SB_I_EVM_UNSUPPORTED to SB_I_EVM_HMAC_UNSUPPORTED
  evm: Rename is_unsupported_fs to is_unsupported_hmac_fs
  ima: Record i_version of real_inode for change detection

 fs/overlayfs/copy_up.c              |  2 +-
 fs/overlayfs/super.c                |  2 +-
 include/linux/evm.h                 | 13 +++++-
 include/linux/fs.h                  |  2 +-
 include/linux/lsm_hook_defs.h       |  3 +-
 include/linux/security.h            |  4 +-
 security/integrity/evm/evm_crypto.c |  2 +-
 security/integrity/evm/evm_main.c   | 69 ++++++++++++++++++++++-------
 security/integrity/ima/ima_api.c    | 28 ++++++------
 security/integrity/ima/ima_main.c   | 23 ++++++----
 security/security.c                 |  7 +--
 security/selinux/hooks.c            |  2 +-
 security/smack/smack_lsm.c          |  2 +-
 13 files changed, 107 insertions(+), 52 deletions(-)

-- 
2.43.0


