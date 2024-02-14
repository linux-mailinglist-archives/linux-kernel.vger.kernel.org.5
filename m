Return-Path: <linux-kernel+bounces-65344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4E854B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70A1281FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124345A79D;
	Wed, 14 Feb 2024 14:36:36 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFEB5C5F5;
	Wed, 14 Feb 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921395; cv=none; b=Tq5QDAfFUc5G8AqaM4kJgFiwkQ6cnyOFfX9WKFnhUpodsxTfYSAHlxBqzCg2B79HtJnwiUYgBYGP8pjbDBJB2JUEfQec57TKxZhSLqZlTAW/k9XkNXmeYJ34dbFPuXw9XU1KuGdcyCckMjFExMO3HDVIBbziceI3Z6LHA/yiMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921395; c=relaxed/simple;
	bh=oLZ9wOA6NVpig03PzhNNbgTCZou0ABsvYJpJlIUh/2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5jwHJZgBry4K1B0pu9sXVJOfYOLXovy7UFH3QqNz0PLVsWIrR9pfHc+MCS2uHg3jMMdcOspbBN1Ppr7Aca0MHdK1pgk+OlUsq8qXDwTZ7xbs4BBhB8LnWFMz2RIozgjMlieVKL7NuKM67mymjyffH84XDhYoeCKh4L9ZbI8/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZgJ347QZz9xvNG;
	Wed, 14 Feb 2024 22:17:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8AF20140DDD;
	Wed, 14 Feb 2024 22:36:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXgRrHz8xlZ55_Ag--.52204S4;
	Wed, 14 Feb 2024 15:36:28 +0100 (CET)
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
Subject: [RFC][PATCH 2/8] ima: Nest iint mutex for DIGEST_LIST_CHECK hook
Date: Wed, 14 Feb 2024 15:35:18 +0100
Message-Id: <20240214143525.2205481-3-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXgRrHz8xlZ55_Ag--.52204S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy8AF1fuF4rXF1xZry7Wrg_yoW7JFy7pF
	ZFqa4DJ3s8XFZ7ur4rta9rZryfKFykWFW8Gw45Cw1vyFn8Jr1FqF18try29Fy3CrWFy3WI
	vr4qgw4DZ3Wjyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRRCJPDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj5pZHAAAsm

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
 security/integrity/ima/ima_iint.c | 11 ++++++-----
 security/integrity/ima/ima_main.c |  6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

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
index e7c9c216c1c6..b4f476fae437 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -41,7 +41,7 @@ struct ima_iint_cache *ima_iint_find(struct inode *inode)
  * See ovl_lockdep_annotate_inode_mutex_key() for more details.
  */
 static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
-					     struct inode *inode)
+					     struct inode *inode, bool nested)
 {
 #ifdef CONFIG_LOCKDEP
 	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
@@ -56,7 +56,7 @@ static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
 }
 
 static void ima_iint_init_always(struct ima_iint_cache *iint,
-				 struct inode *inode)
+				 struct inode *inode, bool nested)
 {
 	iint->ima_hash = NULL;
 	iint->version = 0;
@@ -69,7 +69,7 @@ static void ima_iint_init_always(struct ima_iint_cache *iint,
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
 	mutex_init(&iint->mutex);
-	ima_iint_lockdep_annotate(iint, inode);
+	ima_iint_lockdep_annotate(iint, inode, nested);
 }
 
 static void ima_iint_free(struct ima_iint_cache *iint)
@@ -82,13 +82,14 @@ static void ima_iint_free(struct ima_iint_cache *iint)
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
 
@@ -100,7 +101,7 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
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


