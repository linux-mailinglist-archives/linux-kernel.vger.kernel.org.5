Return-Path: <linux-kernel+bounces-145524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B058A5766
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9351C22C16
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B9685279;
	Mon, 15 Apr 2024 16:13:15 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB984D0F;
	Mon, 15 Apr 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197594; cv=none; b=PMmjLiA5VKM7yhLwGmL6/ci5jpEVIDsLMQ+GA5682rQ2mSq/EB41NhBQ6RmITGxR16iLt6eMuWKAonYeJ0Htr+5/kx7SZ2msdVQRvasghoun61eORxkFUo1KyBE1n32pcj8/m/szLeV1aNSt7OgIO/bU/D/peMAEsDU1zWcbIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197594; c=relaxed/simple;
	bh=PoVu1zT5xkQsZ4kp0hfNGuar5mykAljYwYgLbKEw6OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=li3+otRapvQGQBo2cz4kJLS4rucPglYr6BbbGV8s8fx1qaWP3qmgGQr2l7PVZisma3MYylJlugrVUgWdgx9XtlPifNDM2YJgFS1MMdf4aDczK2XsZcGq46OZ5Y30NU12FiyHQOw62Yr+5a/pbY6YD9vbwD51zKFtfOPScHI+RTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJBcS4DNQz9xGhS;
	Mon, 15 Apr 2024 23:56:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A7F63140159;
	Tue, 16 Apr 2024 00:13:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0iaZUR1m4n9HBg--.16529S10;
	Mon, 15 Apr 2024 17:13:09 +0100 (CET)
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
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 8/9] ima: Use digest caches for appraisal
Date: Mon, 15 Apr 2024 18:10:43 +0200
Message-Id: <20240415161044.2572438-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415161044.2572438-1-roberto.sassu@huaweicloud.com>
References: <20240415161044.2572438-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDn0iaZUR1m4n9HBg--.16529S10
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWDAFW8CF45CFyxXr4fXwb_yoW7Zr15pa
	9xKF1UKry8WFW29rZ3A39xua1Sk340gFWUWws8X3429FnxXr10vryrtw129Fy5Gr18trn7
	tw4qgw1UAan5K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5x3GgAAsL

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

Take the allowed usage after the call to
ima_digest_cache_update_allowed_usage(), and pass it to
ima_appraise_measurement().

If EVM is disabled or the file does not have any protected xattr
(evm_verifyxattr() returns INTEGRITY_UNKNOWN or INTEGRITY_NOXATTRS) and the
allowed usage has the IMA_DIGEST_CACHE_APPRAISE_DATA flag set, mark the
file as successfully appraised (i.e. set the integrity status to
INTEGRITY_PASS and return zero).

The digest cache method is tried first, for performance reasons, in the
event there are for example IMA signatures in the system (which are
computationally more expensive to verify). The usage of the digest_cache
LSM has anyway to be authorized in the IMA policy.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  6 ++++--
 security/integrity/ima/ima_appraise.c | 30 ++++++++++++++++++++-------
 security/integrity/ima/ima_main.c     |  3 ++-
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 865137dfcf22..1f0810be9f8a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -432,7 +432,8 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig);
+			     int xattr_len, const struct modsig *modsig,
+			     u64 allowed_usage);
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct ima_iint_cache *iint, struct file *file);
@@ -457,7 +458,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
 					   int xattr_len,
-					   const struct modsig *modsig)
+					   const struct modsig *modsig,
+					   u64 allowed_usage)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 27ccc9a2c09f..3b4d6491e69e 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -478,7 +478,8 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig)
+			     int xattr_len, const struct modsig *modsig,
+			     u64 allowed_usage)
 {
 	static const char op[] = "appraise_data";
 	const char *cause = "unknown";
@@ -488,12 +489,18 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
 
-	/* If not appraising a modsig, we need an xattr. */
-	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
+	/*
+	 * If not appraising a modsig/there is no digest cache match, we need
+	 * an xattr.
+	 */
+	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig && !allowed_usage)
 		return INTEGRITY_UNKNOWN;
 
-	/* If reading the xattr failed and there's no modsig, error out. */
-	if (rc <= 0 && !try_modsig) {
+	/*
+	 * If reading the xattr failed and there's no modsig/digest cache match,
+	 * error out.
+	 */
+	if (rc <= 0 && !try_modsig && !allowed_usage) {
 		if (rc && rc != -ENODATA)
 			goto out;
 
@@ -524,8 +531,11 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	case INTEGRITY_UNKNOWN:
 		break;
 	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
-		/* It's fine not to have xattrs when using a modsig. */
-		if (try_modsig)
+		/*
+		 * It's fine not to have xattrs when using a modsig or the
+		 * digest cache.
+		 */
+		if (try_modsig || allowed_usage)
 			break;
 		fallthrough;
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
@@ -542,6 +552,12 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		WARN_ONCE(true, "Unexpected integrity status %d\n", status);
 	}
 
+	if (allowed_usage & IMA_DIGEST_CACHE_APPRAISE_DATA) {
+		status = INTEGRITY_PASS;
+		rc = 0;
+		goto out;
+	}
+
 	if (xattr_value)
 		rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
 				  &cause);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 0ff5de9bef70..7ae2bd888d41 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -384,7 +384,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
 						      pathname, xattr_value,
-						      xattr_len, modsig);
+						      xattr_len, modsig,
+						      digest_cache_usage);
 			inode_unlock(inode);
 		}
 		if (!rc)
-- 
2.34.1


