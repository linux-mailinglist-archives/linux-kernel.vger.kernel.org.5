Return-Path: <linux-kernel+bounces-45342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91E1842ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E031F21FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E5479953;
	Tue, 30 Jan 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EMZ3Bl0K"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3E762DD;
	Tue, 30 Jan 2024 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651213; cv=none; b=vGX3knQN49OQKy6QZk4G6iwgc9/z0mclcfLchU5+7QZmOnzd+b06FUp7csccCDOW0hbwgrS8chsbYIYats4YPypiy1SEVnlhXeheFrW5/vUBfU8ZRjuYhnf4CSGCkksNWk8NPkLKgmgorlsS2RdWepNcttjb52rEYEF6UvlBHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651213; c=relaxed/simple;
	bh=9e8yppFii/adbHh4Wc651Fjp4Pbx1zTSyGcucHY8QPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMODH3KpJiakRwd1Ro3RnvrHACmXEn3LzjOJVn/8RnIsFTbu5+JsTXX6cZTHq1QESUa//ST4liTV0/nZ4AF/oEmLjqdwZqNXesaoySqIXVLSQ6PPkJ/bPaIb/J6bgteNDnd1efy+XiDc7MOpJHeVzXvfMGZnbY17QH5gje1ULBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EMZ3Bl0K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ULMbpO017915;
	Tue, 30 Jan 2024 21:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u33QTQz3zwo8w5gMckYZiE6nW3SK8ZOIksLnuOv7pdo=;
 b=EMZ3Bl0KO8UEP3sJZ9CkLBscEBRVetKOGq2gLhaWsKuTT3Q7VHMmMxf6ISo7dhfh51Eh
 WGKIOk8Uuxql2V2LVyAgMwg+c5P+nHKSEs6jCPIOSwXJXhYNZyBF9ReWzj4GRrzYBGYe
 RJRfr3XgQWSldcAhcXNvgCTICTXnCcrT1khFdDDJIJ/38tB+cDLHCC3GBrVIbf4e98XR
 j3K51RqUCsjtsLzJlTmBBRt6/OIF/Iz6JiU0RZXycbVL1RXSZ97Y4N9B5fgxraxmMIR1
 na8JtTDcdjIsTSDZnQGFugkNj86MA9iCRR8dqK8JguWpvKgaWDA0aokQ/LlBZ5urrBsx 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy6pyutad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:33 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40ULCD8p012740;
	Tue, 30 Jan 2024 21:46:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy6pyuta6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:32 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40UIjMkv017723;
	Tue, 30 Jan 2024 21:46:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchysnhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:31 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40ULkUrM12648960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 21:46:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7BDB58056;
	Tue, 30 Jan 2024 21:46:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C8DA58067;
	Tue, 30 Jan 2024 21:46:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jan 2024 21:46:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 5/5] evm: Enforce signatures on unsupported filesystem for EVM_INIT_X509
Date: Tue, 30 Jan 2024 16:46:20 -0500
Message-ID: <20240130214620.3155380-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130214620.3155380-1-stefanb@linux.ibm.com>
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w54US0XujnxYbbq40R4fIPU11T3fX_Xg
X-Proofpoint-ORIG-GUID: j_5mG8R2wvP_LmnI04u5nCN3YQ-FKZEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_12,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=932 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300162

Unsupported filesystems currently do not enforce any signatures. Add
support for signature enforcement of the "original" and "portable &
immutable" signatures when EVM_INIT_X509 is enabled.

The "original" signature type contains filesystem specific metadata.
Thus it cannot be copied up and verified. However with EVM_INIT_X509
and EVM_ALLOW_METADATA_WRITES enabled, the "original" file signature
may be written.

When EVM_ALLOW_METADATA_WRITES is not set or once it is removed from
/sys/kernel/security/evm by setting EVM_INIT_HMAC for example, it is not
possible to write or remove xattrs on the overlay filesystem.

This change still prevents EVM from writing HMAC signatures on
unsupported filesystem when EVM_INIT_HMAC is enabled.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index e96d127b48a2..f49609dfcbc7 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -192,7 +192,11 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
 		return iint->evm_status;
 
-	if (is_unsupported_fs(dentry))
+	/*
+	 * On unsupported filesystems with EVM_INIT_X509 not enabled, skip
+	 * signature verification.
+	 */
+	if (!(evm_initialized & EVM_INIT_X509) && is_unsupported_fs(dentry))
 		return INTEGRITY_UNKNOWN;
 
 	/* if status is not PASS, try to check again - against -ENOMEM */
@@ -262,7 +266,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 				evm_status = INTEGRITY_PASS_IMMUTABLE;
 			} else if (!IS_RDONLY(inode) &&
 				   !(inode->i_sb->s_readonly_remount) &&
-				   !IS_IMMUTABLE(inode)) {
+				   !IS_IMMUTABLE(inode) &&
+				   !is_unsupported_fs(dentry)) {
 				evm_update_evmxattr(dentry, xattr_name,
 						    xattr_value,
 						    xattr_value_len);
@@ -422,9 +427,6 @@ enum integrity_status evm_verifyxattr(struct dentry *dentry,
 	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
 		return INTEGRITY_UNKNOWN;
 
-	if (is_unsupported_fs(dentry))
-		return INTEGRITY_UNKNOWN;
-
 	if (!iint) {
 		iint = integrity_iint_find(d_backing_inode(dentry));
 		if (!iint)
-- 
2.43.0


