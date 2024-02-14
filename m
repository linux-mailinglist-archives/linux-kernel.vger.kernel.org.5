Return-Path: <linux-kernel+bounces-65351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04C854BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D07F1F24FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB365B5C0;
	Wed, 14 Feb 2024 14:37:52 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63F5B02B;
	Wed, 14 Feb 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921472; cv=none; b=HoONdoXOF3ntGfU0mtt+ahja4JCNICvsqvm7ArtUGUtic4lcpS/SiA+VT6Q539E7aTCpFaFaO6IvVBwD23AddVh3Xqk2v9vZioeVowvg2Wil2sPvrlLgRo02m7gngwlH9iYKrxncp/I0oN8hPH7R23CoN8ZfT+eZGXhrI6qFuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921472; c=relaxed/simple;
	bh=+JzV9zu5I05SQvb2FTgYGGXhXwu6XOdL9AMsciATnr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSqeH98nJMLyogK5e1xPWR+mJnDtpsEsS+EXeC6AZOOe98I4gMa+lZpI0YzoIvgQGQ//1QwYZRgXL4tmzid76nNAH8f6lO712MALWWv2iRRuj2TtJ4nXK+4pZfEN52TX7LwFT4L9zYEcb+1ZjWmgv9REEbvdrsGZghCcg3ePDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZgKW2lKsz9xrnX;
	Wed, 14 Feb 2024 22:18:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 7A0A21405F3;
	Wed, 14 Feb 2024 22:37:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXgRrHz8xlZ55_Ag--.52204S10;
	Wed, 14 Feb 2024 15:37:40 +0100 (CET)
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
Subject: [RFC][PATCH 8/8] ima: Detect if digest cache changed since last measurement/appraisal
Date: Wed, 14 Feb 2024 15:35:24 +0100
Message-Id: <20240214143525.2205481-9-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXgRrHz8xlZ55_Ag--.52204S10
X-Coremail-Antispam: 1UD129KBjvJXoWxXry7ZF4xGF4ruFyxKFy5XFb_yoWrKr4kpa
	9ruF1UKr48ZF43CanxAa42kF4rKrZYgFW7Gws8GwnYyFs3Xr1vvw1Fyw1UuryrGrWUZa1x
	tw42gr4UZ3WjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj5ZZnAABso

From: Roberto Sassu <roberto.sassu@huawei.com>

IMA invalidates the cached verification result on file content/metadata
update, so that the file is evaluated again at next access.

While until now checking modifications on the file was sufficient to
determine if the cached verification result is still valid, that no longer
applies if that verification result was obtained with digest caches.

In that case, it is also necessary to check modifications on the digest
lists and on the security.digest_list xattr of the files for which digest
caches are used.

The digest_cache LSM offers the digest_cache_changed() function, which
tells if a file would use a different digest cache than the one passed as
argument. digest_cache_get() might return a different digest cache if the
digest list was modified/deleted/renamed or the security.digest_list xattr
was modified.

Hold a digest cache reference in the IMA integrity metadata, when using it
for measurement/appraisal. At every file access, check if that reference is
still actual by passing it to digest_cache_changed(). If not, reset the
integrity status and do the verification again.

Finally, move the digest_cache_put() call from process_measurement() to
ima_iint_free(), unless the digest cache changed. In that case, still
release the reference in process_measurement().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_iint.c |  3 +++
 security/integrity/ima/ima_main.c | 22 ++++++++++++++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 36faf2bc81b0..c25bde918cd5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -192,6 +192,7 @@ struct ima_iint_cache {
 	enum integrity_status ima_read_status:4;
 	enum integrity_status ima_creds_status:4;
 	struct ima_digest_data *ima_hash;
+	struct digest_cache *digest_cache;
 };
 
 extern struct lsm_blob_sizes ima_blob_sizes;
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index b4f476fae437..fd369809809f 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -68,6 +68,7 @@ static void ima_iint_init_always(struct ima_iint_cache *iint,
 	iint->ima_read_status = INTEGRITY_UNKNOWN;
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
+	iint->digest_cache = NULL;
 	mutex_init(&iint->mutex);
 	ima_iint_lockdep_annotate(iint, inode, nested);
 }
@@ -75,6 +76,8 @@ static void ima_iint_init_always(struct ima_iint_cache *iint,
 static void ima_iint_free(struct ima_iint_cache *iint)
 {
 	kfree(iint->ima_hash);
+	if (iint->digest_cache)
+		digest_cache_put(iint->digest_cache);
 	mutex_destroy(&iint->mutex);
 	kmem_cache_free(ima_iint_cache, iint);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a66522a22cbc..e1b2f5737753 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -301,6 +301,15 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		}
 	}
 
+	/* Check if digest cache changed since last measurement/appraisal. */
+	if (iint->digest_cache &&
+	    digest_cache_changed(inode, iint->digest_cache)) {
+		iint->flags &= ~IMA_DONE_MASK;
+		iint->measured_pcrs = 0;
+		digest_cache_put(iint->digest_cache);
+		iint->digest_cache = NULL;
+	}
+
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
 	 *  IMA_AUDIT, IMA_AUDITED)
@@ -371,8 +380,15 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * Since we allow IMA policy rules without func=, we have to enforce
 	 * this restriction here.
 	 */
-	if (rc == 0 && policy_mask && func != DIGEST_LIST_CHECK)
-		digest_cache = digest_cache_get(file_dentry(file));
+	if (rc == 0 && policy_mask && func != DIGEST_LIST_CHECK) {
+		if (!iint->digest_cache) {
+			/* Released by ima_iint_free(). */
+			digest_cache = digest_cache_get(file_dentry(file));
+			iint->digest_cache = digest_cache;
+		} else {
+			digest_cache = iint->digest_cache;
+		}
+	}
 
 	if (digest_cache) {
 		found = digest_cache_lookup(file_dentry(file), digest_cache,
@@ -386,8 +402,6 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			if (verif_mask_ptr)
 				allow_mask = policy_mask & *verif_mask_ptr;
 		}
-
-		digest_cache_put(digest_cache);
 	}
 
 	if (action & IMA_MEASURE)
-- 
2.34.1


