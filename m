Return-Path: <linux-kernel+bounces-65349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7294B854BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D25B1C21AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3D5C906;
	Wed, 14 Feb 2024 14:37:32 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECFB55C2B;
	Wed, 14 Feb 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921452; cv=none; b=sEEYwMgE5yYtzDLP5B59BDj4Y859WO7DEpyP/OoRqXh118+dRyamGk/bFKVH6Tzqoz4ArvDfU0tqTdR3UqwzIi1IF8dOBbzzXtvcqpGL5ajHP2Ou9xmJyhEM1F1+7ne4KJU2jjwnKU66gKZ1APnZuAVTbagcSksQBY1xALXTcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921452; c=relaxed/simple;
	bh=CZRO5B/gxXj965Pp/u0Igeo5LWZi2YUeef0ZAVcoCmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KlTI096DfwAeU2FemDACk8KJgy5q0zawk6QWRY6quBP1mXyYsu0RTz37ZoVdYZU77/kPFL3YuiB62TJuUScg5z7QM+kDrA46FiZ4s2Wv7UblQae5vGDCWn+/gwHQFamr4wqJFL5581NrRkCBtCaH8zZBOQJ1NKdTmdBFyFt9WUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZgK82S4cz9xGWc;
	Wed, 14 Feb 2024 22:18:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 858641405A2;
	Wed, 14 Feb 2024 22:37:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXgRrHz8xlZ55_Ag--.52204S8;
	Wed, 14 Feb 2024 15:37:16 +0100 (CET)
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
Subject: [RFC][PATCH 6/8] ima: Use digest cache for measurement
Date: Wed, 14 Feb 2024 15:35:22 +0100
Message-Id: <20240214143525.2205481-7-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXgRrHz8xlZ55_Ag--.52204S8
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy7KrWkXF1UJw4UZFW5ZFb_yoW3tryxpa
	9I9F1Ykr4kZFyfCr1fA3W7ZF4Fg395tF4UJws8Ww1akFsxXr10vw1Fyw1jvFy5JrWUZa47
	ta1Ygw4UCw1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj5pZIgAAsY

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce a new measurement style using digest caches, which can be
performed exclusively on non-standard PCRs, to avoid ambiguity.

While a measurement on the standard PCR means that a file was accessed and
had the measured content, a measurement with the digest cache means only
that the calculated file digest was not found in any of the measured digest
lists (any digest list used for the search must be measured, otherwise IMA
wouldn't use it).

The new measurement style does not tell: whether or not the file was
actually accessed (since its measurement is skipped even if it was); in
which sequence files were accessed. So, one has to guess that the system
might have possibly accessed any of the files whose digest is in the
measured digest lists, in any order.

However, it has the following benefits: the IMA measurement list can be
much shorter, system performance can be much better due to less PCR extend
operations (see the performance evaluation in the digest_cache LSM
documentation); the PCR can be predictable as long as the set of measured
digest lists does not change (which obviously happens during software
updates).

The PCR can be predictable because the digest_cache LSM has a prefetching
mechanism that reads digest lists in a deterministic order, until it
finds the digest list containing the digest calculated by IMA from an
accessed file. If IMA measures digest lists, the PCR is extended in a
deterministic order too.

Predictable PCR means that a TPM key can be made dependent on specific PCR
values (or a OR of them, depending on the key policy). Accessing a file
with an unknown digest immediately makes that TPM key unusable, requiring a
reboot to use it again.

This mechanism can be used for the so called implicit remote attestation,
where the ability of a system to respond to challenges based on the private
part of the TPM key means that the system has the expected PCR values
(which would mean that the integrity of the system is ok). This is opposed
to the explicit remote attestation, where a system has to send all its
measurements, to prove to a remote party about its integrity.

If the IMA policy allows the usage of the digest cache for the current file
access (except for DIGEST_LIST_CHECK hook, not supported), call
digest_cache_get() in process_measurement() to get a digest cache for that
file, and call digest_cache_lookup() to search the calculated file digest.

Doing the lookup is necessary to retrieve the digest cache containing the
digest, since digest_cache_get() might only return a directory digest
cache, useful only to iterate over the digest caches of the directory
entries.

If digest_cache_lookup() returns a positive value (digest cache reference
in the digest_cache_found_t form), call digest_cache_from_found_t() to get
an usable digest cache pointer, and digest_cache_verif_get() to get
the verification result of the corresponding digest list, and AND it with
the policy mask.

Then, pass the AND result to ima_store_measurement() and, if the result has
the IMA_DIGEST_CACHE_MEASURE_CONTENT flag set, behave as if the file was
successfully added to the IMA measurement list (i.e. set the IMA_MEASURED
flag and the PCR flag from the value specified in the matching policy
rule), but actually don't do it.

Finally, release the digest cache reference acquired with
digest_cache_get(), by calling digest_cache_put().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h      |  3 ++-
 security/integrity/ima/ima_api.c  | 15 ++++++++++++++-
 security/integrity/ima/ima_main.c | 32 ++++++++++++++++++++++++++++---
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2dbcaf0a9402..cf04f5a22234 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -382,7 +382,8 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
-			   struct ima_template_desc *template_desc);
+			   struct ima_template_desc *template_desc,
+			   u64 digest_cache_mask);
 int process_buffer_measurement(struct mnt_idmap *idmap,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 87e286ace43c..b216f86c983d 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -345,7 +345,8 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
-			   struct ima_template_desc *template_desc)
+			   struct ima_template_desc *template_desc,
+			   u64 digest_cache_mask)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "ENOMEM";
@@ -369,6 +370,18 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 	if (iint->measured_pcrs & (0x1 << pcr) && !modsig)
 		return;
 
+	/*
+	 * If digest cache usage was authorized with the IMA policy, the digest
+	 * list the digest cache was populated from was measured, and the file
+	 * digest was found in the digest cache, mark the file as successfully
+	 * measured.
+	 */
+	if (digest_cache_mask & IMA_DIGEST_CACHE_MEASURE_CONTENT) {
+		iint->flags |= IMA_MEASURED;
+		iint->measured_pcrs |= (0x1 << pcr);
+		return;
+	}
+
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
 	if (result < 0) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 3fc48214850a..48a09747ae7a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -222,7 +222,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	bool violation_check;
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
-	u64 verif_mask = 0;
+	u64 verif_mask = 0, *verif_mask_ptr, policy_mask = 0, allow_mask = 0;
+	struct digest_cache *digest_cache = NULL, *found_cache;
+	digest_cache_found_t found;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -233,7 +235,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 */
 	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
-				&allowed_algos, NULL);
+				&allowed_algos, &policy_mask);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -364,10 +366,34 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
+	/*
+	 * For now we don't support nested verification with digest caches.
+	 * Since we allow IMA policy rules without func=, we have to enforce
+	 * this restriction here.
+	 */
+	if (rc == 0 && policy_mask && func != DIGEST_LIST_CHECK)
+		digest_cache = digest_cache_get(file_dentry(file));
+
+	if (digest_cache) {
+		found = digest_cache_lookup(file_dentry(file), digest_cache,
+					    iint->ima_hash->digest,
+					    iint->ima_hash->algo);
+		/* AND what is allowed by the policy, and what IMA verified. */
+		if (found) {
+			found_cache = digest_cache_from_found_t(found);
+			verif_mask_ptr = digest_cache_verif_get(found_cache,
+								"ima");
+			if (verif_mask_ptr)
+				allow_mask = policy_mask & *verif_mask_ptr;
+		}
+
+		digest_cache_put(digest_cache);
+	}
+
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, modsig, pcr,
-				      template_desc);
+				      template_desc, allow_mask);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
 		if (rc != -EPERM) {
-- 
2.34.1


