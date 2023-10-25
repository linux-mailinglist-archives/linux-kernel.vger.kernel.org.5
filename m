Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED197D6A25
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjJYL3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYL3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:29:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4082131;
        Wed, 25 Oct 2023 04:29:49 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PBRSoU015299;
        Wed, 25 Oct 2023 11:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=mqDfhih7j3wQTErG0klpgD2C7RTGAMQhjz6isaoU4jQ=;
 b=mZAID6EtBmldFW6VwS5atzn5Ew94H9vbaandle632y8oqmyRHUFeDV2HbBQrWmS+ETeD
 WUntW9t1DlFjVZ+OTXxy/3eccktRBb+4xWPZrQDz7CiJdNZsL6Qtaq6e9/1hni2YbJt3
 Vaw+xiDrIVJkQCu5YSX6Z7P1SsSxOf2X32TPEKaeWSfswUinGvjXjnJQNP/VZlfb3+nT
 YUMGztgBZOdVKhRHZwnuO9xNxso3kBZMrYQoqmEoHTWoeFkA53UqJjbb7P1nmj3/6WOi
 +onQBDxxwe5raW9xROY/uUEsYnMUvJgk4fUat6HT21XGUs9mXG9OY6o7otT00EbYoP4G cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty25j821q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 11:29:46 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PBRTAg015311;
        Wed, 25 Oct 2023 11:29:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty25j8210-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 11:29:46 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39PBQSsi005011;
        Wed, 25 Oct 2023 11:29:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvtfknysk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 11:29:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PBTgo622282836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 11:29:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7D6520040;
        Wed, 25 Oct 2023 11:29:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 531912004B;
        Wed, 25 Oct 2023 11:29:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.173.216])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Oct 2023 11:29:41 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Raul Rangel <rrangel@chromium.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2] ima: detect changes to the backing overlay file
Date:   Wed, 25 Oct 2023 07:29:32 -0400
Message-Id: <20231025112932.84336-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 967CZrKIpLTVW4ArEgBceQ6YBibh8nJy
X-Proofpoint-GUID: wZvGreXNn2RlqdpnwKmD4ThEqibI2lX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for
IMA") forced signature re-evaulation on every file access.

Instead of always re-evaluating the file's integrity, detect a change
to the backing file, by comparing the cached file metadata with the
backing file's metadata.  Verifying just the i_version has not changed
is insufficient.  In addition save and compare the i_ino and i_rdev
as well.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog:
- Changes made based on Amir's review: removal of unnecessary overlay
magic test, verify i_version, i_ino and i_rdev haven't changed.

 fs/overlayfs/super.c              |  2 +-
 security/integrity/ima/ima_api.c  |  4 ++++
 security/integrity/ima/ima_main.c | 16 +++++++++++++++-
 security/integrity/integrity.h    |  2 ++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 3fa2416264a4..c71d185980c0 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1489,7 +1489,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 		ovl_trusted_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	sb->s_iflags |= SB_I_SKIP_SYNC;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 452e80b541e5..f191bdcceef8 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -243,6 +243,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
+	struct inode *real_inode = d_real_inode(file_dentry(file));
 	const char *filename = file->f_path.dentry->d_name.name;
 	struct ima_max_digest_data hash;
 	struct kstat stat;
@@ -272,6 +273,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 				   AT_STATX_SYNC_AS_STAT);
 	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
 		i_version = stat.change_cookie;
+
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
@@ -302,6 +304,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	iint->ima_hash = tmpbuf;
 	memcpy(iint->ima_hash, &hash, length);
 	iint->version = i_version;
+	iint->real_ino = real_inode->i_ino;
+	iint->real_rdev = real_inode->i_rdev;
 
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
 	if (!result)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 365db0e43d7c..4a6a22f8805b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -25,6 +25,7 @@
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/fs.h>
+#include <linux/iversion.h>
 
 #include "ima.h"
 
@@ -207,7 +208,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *backing_inode, *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
@@ -284,6 +285,19 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		iint->measured_pcrs = 0;
 	}
 
+	/* Detect and re-evaluate changes made to the backing file. */
+	backing_inode = d_real_inode(file_dentry(file));
+	if (backing_inode != inode &&
+	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
+		if (!IS_I_VERSION(backing_inode) ||
+		    backing_inode->i_rdev != iint->real_rdev ||
+		    backing_inode->i_ino != iint->real_ino ||
+		    !inode_eq_iversion(backing_inode, iint->version)) {
+			iint->flags &= ~IMA_DONE_MASK;
+			iint->measured_pcrs = 0;
+		}
+	}
+
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
 	 *  IMA_AUDIT, IMA_AUDITED)
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index d7553c93f5c0..dd2bb2d150f6 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -164,6 +164,8 @@ struct integrity_iint_cache {
 	unsigned long flags;
 	unsigned long measured_pcrs;
 	unsigned long atomic_flags;
+	unsigned long real_ino;
+	dev_t real_rdev;
 	enum integrity_status ima_file_status:4;
 	enum integrity_status ima_mmap_status:4;
 	enum integrity_status ima_bprm_status:4;
-- 
2.39.3

