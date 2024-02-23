Return-Path: <linux-kernel+bounces-78839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E518861996
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA84B22331
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0EF1339B0;
	Fri, 23 Feb 2024 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qXRnRMZe"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2561419B9;
	Fri, 23 Feb 2024 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709151; cv=none; b=ljXCy6xMFSe36kuJpFyvs99J4w3n6fhDzIs1Pd6zkytMZP6KGu1h3+CLRUfPnwHK6H3SAzzJYwrBbSVftSBIn6y35BuICTW6lwloaFL3KVwcSHHxXfr8tBFz0aCzNiHMo5AnzUSnQWjGajyBVznY0bsQ/FMgMSXFojZe21uBHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709151; c=relaxed/simple;
	bh=KBlfL4l7HHLS2JDYYGZS60XseG88QMo5cxqXRQ6KMn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kf87e57v5BIdGBqqVyaK54a4iSvflXjSrfVz+GI+oOFOzIV+eaHKudtoR8KnT2kH9pQoBvJphWyRnXsM17shxByjO9MpyO7MmlmGtPSgKs49l3gb1UqKuc6tpgJe/e2SRi9WG9EBPP4WsMXxwv19zEa3/Tykb21r0kFDLGrOnr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qXRnRMZe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHCRGK000557;
	Fri, 23 Feb 2024 17:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=voZxNJDvMrCX0bE8VBLSoSbIu0NlTe3ECmkA6s8Up7w=;
 b=qXRnRMZeJExxQ+dLUaEfJN9HowfnPIfaSIJz104Fkk91VqgO3kQ7BOe3xkIN3dIvGu6u
 YPUmQhzQOgaUh0DD7HJzYAcghvDa/oaSQkD7VzJKq2a5e5r8oFB3/nV7QX8ysV1xgEx9
 A/q1Nr3eosMaN3w0F11KW6c0VGspcR9ckFANU7ZbKs+zkYAA/6aXHHo3FlKiHVuQMDZD
 svvq+CTEunyGLAynUeWef5vKtJvbEn53czzskPA4c4pdUoTLlN6/xpFDJv9BWa17p6PI
 RIAXE3nad8LoX5mNRauYK8G4ggeBm1eaCtkg0DONBSj5BXd6tx9B8mTK0p1fjWSjHh/V OA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weyj388hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:34 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NHOO30006815;
	Fri, 23 Feb 2024 17:25:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weyj388hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:34 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NGDXxu013532;
	Fri, 23 Feb 2024 17:25:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0y3ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPTmY62259502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5995E58059;
	Fri, 23 Feb 2024 17:25:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3821458067;
	Fri, 23 Feb 2024 17:25:28 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 09/10] fs: Rename SB_I_EVM_UNSUPPORTED to SB_I_EVM_HMAC_UNSUPPORTED
Date: Fri, 23 Feb 2024 12:25:12 -0500
Message-ID: <20240223172513.4049959-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223172513.4049959-1-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TNILrXz1mro10i21v0MB6VNxl1LGqLR9
X-Proofpoint-ORIG-GUID: RjoFG8m9zGnsR22WLRW4FIT1SeymV2bb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

Now that EVM supports RSA signatures for previously completely
unsupported filesystems rename the flag SB_I_EVM_UNSUPPORTED to
SB_I_EVM_HMAC_UNSUPPORTED to reflect that only HMAC is not supported.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c              | 2 +-
 include/linux/fs.h                | 2 +-
 security/integrity/evm/evm_main.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 36d4b8b1f784..e05be454ec7a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1460,7 +1460,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * lead to unexpected results.
 	 */
 	sb->s_iflags |= SB_I_NOUMASK;
-	sb->s_iflags |= SB_I_EVM_UNSUPPORTED;
+	sb->s_iflags |= SB_I_EVM_HMAC_UNSUPPORTED;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d055582a5efb..3920ab94d84a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1177,7 +1177,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
 #define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
 #define SB_I_UNTRUSTED_MOUNTER		0x00000040
-#define SB_I_EVM_UNSUPPORTED		0x00000080
+#define SB_I_EVM_HMAC_UNSUPPORTED	0x00000080
 
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
 #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index cfb4f9809369..c4a6081ce596 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -155,7 +155,7 @@ static int is_unsupported_fs(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	if (inode->i_sb->s_iflags & SB_I_EVM_UNSUPPORTED) {
+	if (inode->i_sb->s_iflags & SB_I_EVM_HMAC_UNSUPPORTED) {
 		pr_info_once("%s not supported\n", inode->i_sb->s_type->name);
 		return 1;
 	}
-- 
2.43.0


