Return-Path: <linux-kernel+bounces-145523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C801B8A5762
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D35828592D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700584A5C;
	Mon, 15 Apr 2024 16:13:12 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A308062E;
	Mon, 15 Apr 2024 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197591; cv=none; b=M37w2uPz+K431nxDFbFDSDBAq4a0rllXbNBcipYR+r1woNESKyfXZAAB/OWeiOSuuZGb9uWn9ayJtaC9Mp1qkheqRe0jLDtMARGcoMyJ9XwePj4Gn1+i1fWMCWF05YFluVft18LlzGz8TVMU+5fQi2BYgNQD3Y2qRLIAVP14bis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197591; c=relaxed/simple;
	bh=pEmknL2/6lnmt81ftfpClFRTiK0Me9ZoDCWCf4uH/Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYNShQvQha3MCGd2McF3XO4Q1tfQscwQuOvS+5JOf4OHjM2fV06hU3n7LvsEUnJi/4PboLxFTlEy786AsVJiu69xMZ5q7Rv+moXSRUHXD9qeD1dtpMdAmp8JoNPrA/SRC5vd5odSaC0OPTNyudz7eMj2A70on7Govvp6UiuSEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VJBcR3Q1qz9xGnS;
	Mon, 15 Apr 2024 23:56:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 57CCE1405E3;
	Tue, 16 Apr 2024 00:12:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0iaZUR1m4n9HBg--.16529S9;
	Mon, 15 Apr 2024 17:12:55 +0100 (CET)
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
Subject: [RFC][PATCH v2 7/9] ima: Use digest caches for measurement
Date: Mon, 15 Apr 2024 18:10:42 +0200
Message-Id: <20240415161044.2572438-8-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwDn0iaZUR1m4n9HBg--.16529S9
X-Coremail-Antispam: 1UD129KBjvJXoW3ZrWxuw1fArW3ArWxWr4xXrb_yoWDZF1fpa
	9IgF1UKr1kZFy7Cr1fA3ZruF4Fk3yktF4UJ398Xw1akFs8Xr1jywnYkr1UZFy3JrWjva4x
	ta1jgw1UAw1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h14wAAs3

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce a new measurement style using digest caches, which can be
performed exclusively on non-standard PCRs, to avoid ambiguity.

While a measurement on the standard PCR means that a file was accessed and
had the measured data, a measurement with the digest cache means only that
the calculated file digest was not found in any of the measured digest
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

If the IMA policy allows the usage of digest caches for the current file
access (except for DIGEST_LIST_CHECK hook, not supported), call the newly
introduced function ima_digest_cache_update_allowed_usage(), to make a
final decision on whether or not a digest cache can be used for measurement
and/or appraisal.

First, call digest_cache_get() to get a digest cache from the file being
accessed. Second, perform a lookup of the calculated file digest in the
digest cache. Third, retrieve the allowed usage from the integrity metadata
flags of the digest list and AND it with the allowed usage from the policy.

If any of the previous step fails, set the allowed usage to zero.

Finally, pass the allowed usage to ima_store_measurement() and, if it has
the IMA_DIGEST_CACHE_MEASURE_DATA flag set, behave as if the file was
successfully added to the IMA measurement list (i.e. set the IMA_MEASURED
flag and the PCR flag from the value specified in the matching policy
rule), but actually don't do it.

Finally, release the digest cache reference acquired with
digest_cache_get(), by calling digest_cache_put().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h              |  3 +-
 security/integrity/ima/ima_api.c          | 15 +++++++-
 security/integrity/ima/ima_digest_cache.c | 47 +++++++++++++++++++++++
 security/integrity/ima/ima_digest_cache.h |  9 +++++
 security/integrity/ima/ima_main.c         | 14 ++++++-
 5 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 337b3b76b28d..865137dfcf22 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -381,7 +381,8 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
-			   struct ima_template_desc *template_desc);
+			   struct ima_template_desc *template_desc,
+			   u64 allowed_usage);
 int process_buffer_measurement(struct mnt_idmap *idmap,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index f0a1ce10afe8..0bbe19e33584 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -345,7 +345,8 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
-			   struct ima_template_desc *template_desc)
+			   struct ima_template_desc *template_desc,
+			   u64 allowed_usage)
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
+	if (allowed_usage & IMA_DIGEST_CACHE_MEASURE_DATA) {
+		iint->flags |= IMA_MEASURED;
+		iint->measured_pcrs |= (0x1 << pcr);
+		return;
+	}
+
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
 	if (result < 0) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
diff --git a/security/integrity/ima/ima_digest_cache.c b/security/integrity/ima/ima_digest_cache.c
index 0b0fd26cc0d7..013c69f265d8 100644
--- a/security/integrity/ima/ima_digest_cache.c
+++ b/security/integrity/ima/ima_digest_cache.c
@@ -43,3 +43,50 @@ void ima_digest_cache_store_allowed_usage(struct file *file,
 		pr_debug("Cannot set verification mask for %s, ret: %d, ignoring\n",
 			 file_dentry(file)->d_name.name, rc);
 }
+
+/**
+ * ima_digest_cache_update_allowed_usage - Update digest cache allowed usage
+ * @file: Digest list file descriptor
+ * @iint: Inode integrity metadata
+ * @allowed_usage: Digest cache allowed usage to update
+ *
+ * Update the digest cache allowed usage obtained from the IMA policy. First,
+ * retrieve the digest cache for the passed inode, and do a lookup of the
+ * calculated digest. If the digest is found, update the digest cache allowed
+ * usage with the allowed usage from integrity metadata flags, previously stored
+ * in the digest cache itself with ima_digest_cache_store_allowed_usage().
+ */
+void ima_digest_cache_update_allowed_usage(struct file *file,
+					   struct ima_iint_cache *iint,
+					   u64 *allowed_usage)
+{
+	struct digest_cache *digest_cache, *found_cache;
+	u64 *iint_allowed_usage;
+	digest_cache_found_t found;
+
+	digest_cache = digest_cache_get(file_dentry(file));
+	if (!digest_cache) {
+		*allowed_usage = 0;
+		return;
+	}
+
+	found = digest_cache_lookup(file_dentry(file), digest_cache,
+				    iint->ima_hash->digest,
+				    iint->ima_hash->algo);
+	if (!found) {
+		*allowed_usage = 0;
+		goto out;
+	}
+
+	/* AND what is allowed by the policy, and what IMA verified. */
+	found_cache = digest_cache_from_found_t(found);
+	iint_allowed_usage = digest_cache_verif_get(found_cache, "ima");
+	if (!iint_allowed_usage) {
+		*allowed_usage = 0;
+		goto out;
+	}
+
+	*allowed_usage &= *iint_allowed_usage;
+out:
+	digest_cache_put(digest_cache);
+}
diff --git a/security/integrity/ima/ima_digest_cache.h b/security/integrity/ima/ima_digest_cache.h
index f2534a01bb18..cb47c15e975d 100644
--- a/security/integrity/ima/ima_digest_cache.h
+++ b/security/integrity/ima/ima_digest_cache.h
@@ -12,10 +12,19 @@
 #ifdef CONFIG_SECURITY_DIGEST_CACHE
 void ima_digest_cache_store_allowed_usage(struct file *file,
 					  struct ima_iint_cache *iint);
+void ima_digest_cache_update_allowed_usage(struct file *file,
+					   struct ima_iint_cache *iint,
+					   u64 *allowed_usage);
 #else
 static inline void
 ima_digest_cache_store_allowed_usage(struct file *file,
 				     struct ima_iint_cache *iint)
 { }
 
+static inline void
+ima_digest_cache_update_allowed_usage(struct file *file,
+				      struct ima_iint_cache *iint,
+				      u64 *allowed_usage)
+{ }
+
 #endif /* CONFIG_SECURITY_DIGEST_CACHE */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 7c968cdb5678..0ff5de9bef70 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -223,6 +223,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	bool violation_check;
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
+	u64 digest_cache_usage = 0;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -233,7 +234,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 */
 	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
-				&allowed_algos, NULL);
+				&allowed_algos, &digest_cache_usage);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -364,10 +365,19 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
+	/*
+	 * For now we don't support nested verification with digest caches.
+	 * Since we allow IMA policy rules without func=, we have to enforce
+	 * this restriction here.
+	 */
+	if (rc == 0 && digest_cache_usage && func != DIGEST_LIST_CHECK)
+		ima_digest_cache_update_allowed_usage(file, iint,
+						      &digest_cache_usage);
+
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, modsig, pcr,
-				      template_desc);
+				      template_desc, digest_cache_usage);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
 		if (rc != -EPERM) {
-- 
2.34.1


