Return-Path: <linux-kernel+bounces-145515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F36D8A5745
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DA41C22BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC3882C8E;
	Mon, 15 Apr 2024 16:11:55 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520C8175E;
	Mon, 15 Apr 2024 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197514; cv=none; b=GqgFATNJ30Xw6T1GPO0u6vYOgVMuJSIqZndE7vmFgvAmQShI4NNfQmB54WpQJ2DEYRN92mkaXVZ/XOrMzDBR9h+UI2tyZPv4SGa/iAcYzH70dCF85Crb+BMWGqKcwYw+XlPW8Sdwd31xo9PRGUaEbiqoBxUNUet2lp2Oc3jxDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197514; c=relaxed/simple;
	bh=Qmnl4eIUFNBIMJkcZ6lG8jyypOm/wejoN+kXBSHxVZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/Q+RXURF7LE6D+TX4XN5ly/pTYQx/6aeoJtwO0sPM+ZQE3LJMGHOtqLASTgZrp3cKeMcfxF+oMzMGe7FZQEc55+Qy7qDPN9NZhDqk4AisSMIgjAbJoQ9q7qcbvEtpLrFkp/OkLLvxvdz+WZsPGTXOmYU6YXy6bQpvXSX3Wg2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VJBTr1t71z9xrnb;
	Mon, 15 Apr 2024 23:50:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 5C7FE1402A5;
	Tue, 16 Apr 2024 00:11:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0iaZUR1m4n9HBg--.16529S4;
	Mon, 15 Apr 2024 17:11:48 +0100 (CET)
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
Subject: [RFC][PATCH v2 2/9] ima: Nest iint mutex for DIGEST_LIST_CHECK hook
Date: Mon, 15 Apr 2024 18:10:37 +0200
Message-Id: <20240415161044.2572438-3-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwDn0iaZUR1m4n9HBg--.16529S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary8AFW5Wr1rGF4DKF1UGFg_yoW7Cr48pa
	9rta4DJ3s8XFZ7ur4rta9rZryfKFykWFW8Gw45A3WvyFn8Xr1FqF18try29Fy5CrWFv3WI
	vr4jgws8Z3Wjyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j7
	hLnUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h14AABs1

From: Roberto Sassu <roberto.sassu@huawei.com>

Invoking digest_cache_get() inside the iint->mutex critical region can
cause deadlocks due to the fact that IMA can be recursively invoked for
reading the digest list. The deadlock would occur if the digest_cache LSM
attempts to read the same inode that is already locked by IMA.

However, since the digest_cache LSM makes sure that the above situation
never happens, as it checks the inodes, it is safe to call
digest_cache_get() inside the critical region and nest the iint->mutex
when the DIGEST_LIST_CHECK hook is executed.

Add a lockdep subclass to the iint->mutex, that is 0 if the IMA hook
executed is not DIGEST_LIST_CHECK, and 1 when it is. Since lockdep allows
nesting with higher classes and subclasses, that effectively eliminates the
warning about the unsafe lock.

Pass the new lockdep subclass (nested variable) from ima_inode_get() to
ima_iint_init_always() and ima_iint_lockdep_annotate().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h      |  2 +-
 security/integrity/ima/ima_iint.c | 17 +++++++++++------
 security/integrity/ima/ima_main.c |  6 +++---
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cea4517e73ab..c9140a57b591 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -216,7 +216,7 @@ static inline void ima_inode_set_iint(const struct inode *inode,
 }
 
 struct ima_iint_cache *ima_iint_find(struct inode *inode);
-struct ima_iint_cache *ima_inode_get(struct inode *inode);
+struct ima_iint_cache *ima_inode_get(struct inode *inode, bool nested);
 void ima_inode_free(struct inode *inode);
 void __init ima_iintcache_init(void);
 
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index e7c9c216c1c6..c98a30815c8a 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -39,9 +39,12 @@ struct ima_iint_cache *ima_iint_find(struct inode *inode)
  * files both on overlayfs and on underlying fs, we need to annotate the iint
  * mutex to avoid lockdep false positives related to IMA + overlayfs.
  * See ovl_lockdep_annotate_inode_mutex_key() for more details.
+ *
+ * In addition to that, safely ignored nested locks for digest lists, since
+ * the digest_cache LSM prevents circular dependencies.
  */
 static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
-					     struct inode *inode)
+					     struct inode *inode, bool nested)
 {
 #ifdef CONFIG_LOCKDEP
 	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
@@ -51,12 +54,13 @@ static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
 	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
 		depth = 0;
 
-	lockdep_set_class(&iint->mutex, &ima_iint_mutex_key[depth]);
+	lockdep_set_class_and_subclass(&iint->mutex, &ima_iint_mutex_key[depth],
+				       nested);
 #endif
 }
 
 static void ima_iint_init_always(struct ima_iint_cache *iint,
-				 struct inode *inode)
+				 struct inode *inode, bool nested)
 {
 	iint->ima_hash = NULL;
 	iint->version = 0;
@@ -69,7 +73,7 @@ static void ima_iint_init_always(struct ima_iint_cache *iint,
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
 	mutex_init(&iint->mutex);
-	ima_iint_lockdep_annotate(iint, inode);
+	ima_iint_lockdep_annotate(iint, inode, nested);
 }
 
 static void ima_iint_free(struct ima_iint_cache *iint)
@@ -82,13 +86,14 @@ static void ima_iint_free(struct ima_iint_cache *iint)
 /**
  * ima_inode_get - Find or allocate an iint associated with an inode
  * @inode: Pointer to the inode
+ * @nested: Whether or not the iint->mutex lock can be nested
  *
  * Find an iint associated with an inode, and allocate a new one if not found.
  * Caller must lock i_mutex.
  *
  * Return: An iint on success, NULL on error.
  */
-struct ima_iint_cache *ima_inode_get(struct inode *inode)
+struct ima_iint_cache *ima_inode_get(struct inode *inode, bool nested)
 {
 	struct ima_iint_cache *iint;
 
@@ -100,7 +105,7 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 	if (!iint)
 		return NULL;
 
-	ima_iint_init_always(iint, inode);
+	ima_iint_init_always(iint, inode, nested);
 
 	inode->i_flags |= S_IMA;
 	ima_inode_set_iint(inode, iint);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 780627b0cde7..18285fc8ac07 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -248,7 +248,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	inode_lock(inode);
 
 	if (action) {
-		iint = ima_inode_get(inode);
+		iint = ima_inode_get(inode, func == DIGEST_LIST_CHECK);
 		if (!iint)
 			rc = -ENOMEM;
 	}
@@ -699,7 +699,7 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 		return;
 
 	/* Nothing to do if we can't allocate memory */
-	iint = ima_inode_get(inode);
+	iint = ima_inode_get(inode, false);
 	if (!iint)
 		return;
 
@@ -731,7 +731,7 @@ static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 		return;
 
 	/* Nothing to do if we can't allocate memory */
-	iint = ima_inode_get(inode);
+	iint = ima_inode_get(inode, false);
 	if (!iint)
 		return;
 
-- 
2.34.1


