Return-Path: <linux-kernel+bounces-65350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE1A854BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CDD1C221EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D91F5D749;
	Wed, 14 Feb 2024 14:37:43 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81C355C2B;
	Wed, 14 Feb 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921462; cv=none; b=cxiVGIoigDSyFQ8sYM0XhjPZW2+RH9PVFEFqa7Cq1mXx1tNrMLjaFRsx5mOEJyLS/6v1vl0FuX8F+bWUr4RNheab0ROtOfhe2WuNAoLv6AiFnI25NsGWceLZshFjtKDwMihDmpJNXhWTV7OXVJaSIl6HoeWy+wPxsCyXeFZZ1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921462; c=relaxed/simple;
	bh=1uHbgUQNt5fzE/RWCYXBumAhqJ5Eit2krWy+OxbqU3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvBAU3jlryvTW0MPgpfPQrBRL+HLhbg2+UmBrKPQ/tqi4YNn+WWD2NhLI8u3t2EmFEQFtnRXuYNKaXsxiYLAMzMf0uLkpMaG25sxuIN8NLmOwgxcWkABOoAoONazqMXFdQq5AqZMZ+/8FseJ6bwy/UW6o9JoS4qbffxqMyEz0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZgKM1C3Gz9xrnP;
	Wed, 14 Feb 2024 22:18:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 7FE861406BF;
	Wed, 14 Feb 2024 22:37:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXgRrHz8xlZ55_Ag--.52204S9;
	Wed, 14 Feb 2024 15:37:28 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	petrtesarik@huaweicloud.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 7/8] ima: Use digest cache for appraisal
Date: Wed, 14 Feb 2024 15:35:23 +0100
Message-Id: <20240214143525.2205481-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXgRrHz8xlZ55_Ag--.52204S9
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWDAFykAw47tFyUWFykKrg_yoW7AFyxpa
	9xKF1UKry8GFWfuFZxAanxCa1Sk34vgFWUWw4DJ342kFsxXr10vryrtw47ZFy5Jr1rJFn7
	tw4qgr1UAa1Fy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j
	6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryU
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUv
	cSsGvfC2KfnxnUUI43ZEXa7sRRtCztUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj5ZZnAAAsp

From: Roberto Sassu <roberto.sassu@huawei.com>

Similarly to measurement, enable the new appraisal style too using digest
caches.

Instead of verifying individual file signatures, verify the signature of
lists of digests and search calculated file digests in those lists.

The benefits are that signed lists of digests already exist (e.g. RPM
package headers), although their format needs to be supported by the
digest_cache LSM, and appraisal with digest lists is computationally much
less expensive than with individual file signatures (see the performance
evaluation of the digest_cache LSM).

As for measurement, pass the AND of the policy mask and the digest list
verification mask to ima_appraise_measurement().

If EVM is disabled or the file does not have any protected xattr
(evm_verifyxattr() returns INTEGRITY_UNKNOWN or INTEGRITY_NOXATTRS), the
other appraisal methods (xattr and modsig) are not available, and the AND
of the masks has the IMA_DIGEST_CACHE_APPRAISE_CONTENT flag set, mark the
file as successfully appraised (i.e. set the integrity status to
INTEGRITY_PASS and return zero).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  6 ++++--
 security/integrity/ima/ima_appraise.c | 31 +++++++++++++++++++++------
 security/integrity/ima/ima_main.c     |  3 ++-
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cf04f5a22234..36faf2bc81b0 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -433,7 +433,8 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig);
+			     int xattr_len, const struct modsig *modsig,
+			     u64 digest_cache_mask);
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct ima_iint_cache *iint, struct file *file);
@@ -458,7 +459,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
 					   int xattr_len,
-					   const struct modsig *modsig)
+					   const struct modsig *modsig,
+					   u8 digest_cache_mask)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 27ccc9a2c09f..dcea88d502a9 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -478,7 +478,8 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig)
+			     int xattr_len, const struct modsig *modsig,
+			     u64 digest_cache_mask)
 {
 	static const char op[] = "appraise_data";
 	const char *cause = "unknown";
@@ -488,12 +489,19 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
 
-	/* If not appraising a modsig, we need an xattr. */
-	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
+	/*
+	 * If not appraising a modsig/there is no digest cache match, we need
+	 * an xattr.
+	 */
+	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig &&
+	    !digest_cache_mask)
 		return INTEGRITY_UNKNOWN;
 
-	/* If reading the xattr failed and there's no modsig, error out. */
-	if (rc <= 0 && !try_modsig) {
+	/*
+	 * If reading the xattr failed and there's no modsig/digest cache match,
+	 * error out.
+	 */
+	if (rc <= 0 && !try_modsig && !digest_cache_mask) {
 		if (rc && rc != -ENODATA)
 			goto out;
 
@@ -524,8 +532,11 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	case INTEGRITY_UNKNOWN:
 		break;
 	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
-		/* It's fine not to have xattrs when using a modsig. */
-		if (try_modsig)
+		/*
+		 * It's fine not to have xattrs when using a modsig or the
+		 * digest cache.
+		 */
+		if (try_modsig || digest_cache_mask)
 			break;
 		fallthrough;
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
@@ -555,6 +566,12 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	     rc == -ENOKEY))
 		rc = modsig_verify(func, modsig, &status, &cause);
 
+	if (!xattr_value && !try_modsig &&
+	    (digest_cache_mask & IMA_DIGEST_CACHE_APPRAISE_CONTENT)) {
+		status = INTEGRITY_PASS;
+		rc = 0;
+	}
+
 out:
 	/*
 	 * File signatures on some filesystems can not be properly verified.
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 48a09747ae7a..a66522a22cbc 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -400,7 +400,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
 						      pathname, xattr_value,
-						      xattr_len, modsig);
+						      xattr_len, modsig,
+						      allow_mask);
 			inode_unlock(inode);
 		}
 		if (!rc)
-- 
2.34.1


