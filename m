Return-Path: <linux-kernel+bounces-53204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FE84A21B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226BF1C2270B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C80482FC;
	Mon,  5 Feb 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WUa/sqwA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00E47F67;
	Mon,  5 Feb 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157536; cv=none; b=jdF4cBny2D6M8AKy3DaqK4NsGkGDaHem65RYyBFqgaEXShWRr+zwcPYUzXQ7u5sUNiNtz9KTw9gzYdR2WBAYzz84EQywxsRkNRtVaL6x8MaY3rQuzpI9OS60+PuKjn/H+b8sZM9s9XB7iC13HkoLKLIgSLsooC852RoHYGH9lzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157536; c=relaxed/simple;
	bh=5ovmbDL8TgzYYgt0pPekfYrFhH/6Jo7bF3GDAoppycI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCz9IuYlyesCt5b65XNTP2jPmmCqHaeYaOe5ylJOif8cqEmrhIqbVh8OC+NnR00FzdcErr46yc8RxKaLvKeHSUONWvFDlOGccuVxkumYUEKTRwIAm+ucfPuxd1t+ABGVznqs3JBjfCrAN6nh58pCQcYuEkfU1PbHa2lUJWW4Qjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WUa/sqwA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415H70fr022464;
	Mon, 5 Feb 2024 18:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Iu1yqZGkyfRidn9bKmmsu3ry5k15iBxIXmJVFzKpKEo=;
 b=WUa/sqwAF+c+Fyy/bQ08itWLUqup1q6lIsCRrHTLEREfaNjWD3IeO20kn90XMWm1USHI
 keAAZ83ZvAm/ekxceL+2q0Iuovj2vWBEBsxAc1/2yPY7q8Haojg8oudSg1fsRKx2gbzb
 vVigUl8KKj6/GV+b/QmCYvJVHtxrlveHXo2/5RlqbK4zHlhRqlveIj6KF1sp1u8YQozJ
 TMmiVoKKKQ4wpxaoamwguWPtrjVbFICn33GZmCgtsB6+jMYdgXu7hyUNBEzsCi9INBWW
 yPmr9sKJ4LkWiSyrVzUM1yF14+1OX0nKu+qfTpcKbxYIYIIUKn4MiDalR0aOyeNmamOc rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w337cjx7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:18 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415IF9DW015337;
	Mon, 5 Feb 2024 18:25:17 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w337cjx7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:17 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415I17OS008487;
	Mon, 5 Feb 2024 18:25:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221jstme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:16 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415IPGRT9306750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 18:25:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0904E58056;
	Mon,  5 Feb 2024 18:25:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C02C5803F;
	Mon,  5 Feb 2024 18:25:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 18:25:15 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 7/9] fs: Rename SB_I_EVM_UNSUPPORTED to SB_I_EVM_HMAC_UNSUPPORTED
Date: Mon,  5 Feb 2024 13:25:04 -0500
Message-ID: <20240205182506.3569743-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205182506.3569743-1-stefanb@linux.ibm.com>
References: <20240205182506.3569743-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0GD8qUIJiPa6jHllBx7kErJDZPBFb3G1
X-Proofpoint-ORIG-GUID: XsFjmlsM-V4V-86ZvsqS8IB3ijPnk-ML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=928 priorityscore=1501
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050138

Now that EVM supports RSA signatures for previously completely
unsupported filesystems rename the flag SB_I_EVM_UNSUPPORTED to
SB_I_EVM_HMAC_UNSUPPORTED to reflect that only HMAC is not supported.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/overlayfs/super.c              | 2 +-
 include/linux/fs.h                | 2 +-
 security/integrity/evm/evm_main.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 460126b7e1cd..db132d437e14 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1445,7 +1445,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * lead to unexpected results.
 	 */
 	sb->s_iflags |= SB_I_NOUMASK;
-	sb->s_iflags |= SB_I_EVM_UNSUPPORTED;
+	sb->s_iflags |= SB_I_EVM_HMAC_UNSUPPORTED;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1823a93202bd..37306a09b4dc 100644
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
index c3bd88aba78c..ff659e622f4a 100644
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


