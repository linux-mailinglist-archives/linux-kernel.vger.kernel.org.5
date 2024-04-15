Return-Path: <linux-kernel+bounces-145516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5128A5749
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08731C22BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542268175E;
	Mon, 15 Apr 2024 16:12:19 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266B7FBA4;
	Mon, 15 Apr 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197538; cv=none; b=mty1yRby/HozNOWZL89yCQcTUKANeU0yZuC6szmLGmcaRB2NPEvJ6u1BvVxX8c2FAHkWUVVlfowU0d+JrZ4MXXTFbPcTlNHDD2Z/RrMA7WKgkQzNftPw3iWVszG5pwIe1wJ4uRKCsb6SYURuQzhhQTFt3buedJAPqhG9ecR6UIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197538; c=relaxed/simple;
	bh=0tDFC0Rzwu0TnZ9tH4wkji+B1IUHRT8OEVZwyh0x3is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vaqm1O70rLEsrnliK5Lde4Wz0R5qLzqKHm4JICDCSgnbo7tVmx/lriM1Yl+R0u+5GjP8HUonOUUX3WpaN8OICVF6eX3ctQhDXH6ICYQZK3Tm5TnD4j+h0cYB+/tc2HFdvRtOEVDKCbFp7CP8YulOuBThm1To344bC3EvmqFneRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJBbM3gdzz9v7Nb;
	Mon, 15 Apr 2024 23:55:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AD9271405E1;
	Tue, 16 Apr 2024 00:12:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0iaZUR1m4n9HBg--.16529S5;
	Mon, 15 Apr 2024 17:12:02 +0100 (CET)
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
Subject: [RFC][PATCH v2 3/9] ima: Add digest_cache policy keyword
Date: Mon, 15 Apr 2024 18:10:38 +0200
Message-Id: <20240415161044.2572438-4-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwDn0iaZUR1m4n9HBg--.16529S5
X-Coremail-Antispam: 1UD129KBjvAXoW3Aw1xtFyxKr15WryktryUGFg_yoW8Jw1kAo
	Z3K39rJF48GFy3CayUCFnIyay8W3yrGwn7JFnYgr98Z3Z2vryUGasrWr1UZFW3ZF45Xa90
	kw1xX3y8tFW8Jas3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO07kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	Wl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxU
	4R6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h14AACs2

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the 'digest_cache=' policy keyword, to enable the usage of digest
caches for specific IMA actions and purpose.

At the moment, it accepts only 'data' as value, as digest caches can be
used only for measurement and appraisal of file data. In the future, it
might be possible to use them for file metadata too.

The 'digest_cache=' keyword can be specified for the subset of IMA hooks
listed in ima_digest_cache_func_allowed(). In case the function is not
specified in the policy, digest caches might not be available.

POLICY_CHECK has been excluded for measurement, because policy changes must
be visible in the IMA measurement list. For appraisal, instead, it might be
useful to load custom policies in the initial ram disk (no security.ima
xattr).

Add the digest_cache_usage member to the ima_rule_entry structure, and set
the flag IMA_DIGEST_CACHE_MEASURE_DATA if 'digest_cache=data' was specified
for a measure rule, IMA_DIGEST_CACHE_APPRAISE_DATA for an appraise rule.

Propagate the usage down to ima_match_policy() and ima_get_action(), so
that process_measurement() can make the final decision on whether or not
digest caches should be used to measure/appraise the file being evaluated.

Since using digest caches changes the meaning of the IMA measurement list,
which will include only digest lists and unknown files, enforce specifying
'pcr=' with a non-standard value, when 'digest_cache=data' is specified in
a measure rule.

This removes the ambiguity on the meaning of the IMA measurement list.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/ABI/testing/ima_policy  |  5 +-
 security/integrity/ima/ima.h          | 10 +++-
 security/integrity/ima/ima_api.c      |  6 ++-
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     |  8 +--
 security/integrity/ima/ima_policy.c   | 70 ++++++++++++++++++++++++++-
 6 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 22237fec5532..887ac79f66eb 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,7 +29,7 @@ Description:
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[digest_type=] [template=] [permit_directio]
 				[appraise_type=] [appraise_flag=]
-				[appraise_algos=] [keyrings=]
+				[appraise_algos=] [keyrings=] [digest_cache=]
 		  base:
 			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
@@ -77,6 +77,9 @@ Description:
 			For example, "sha256,sha512" to only accept to appraise
 			files where the security.ima xattr was hashed with one
 			of these two algorithms.
+			digest_cache:= [data]
+			"data" means that the digest cache is used only
+			for file data measurement and/or appraisal.
 
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c9140a57b591..337b3b76b28d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -43,6 +43,10 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
 
+/* Digest cache usage flags. */
+#define IMA_DIGEST_CACHE_MEASURE_DATA	0x0000000000000001
+#define IMA_DIGEST_CACHE_APPRAISE_DATA	0x0000000000000002
+
 /* current content of the policy */
 extern int ima_policy_flag;
 
@@ -367,7 +371,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data, unsigned int *allowed_algos);
+		   const char *func_data, unsigned int *allowed_algos,
+		   u64 *digest_cache_usage);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 			    void *buf, loff_t size, enum hash_algo algo,
@@ -398,7 +403,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data, unsigned int *allowed_algos);
+		     const char *func_data, unsigned int *allowed_algos,
+		     u64 *digest_cache_usage);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flags(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index b37d043d5748..f0a1ce10afe8 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -173,6 +173,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @template_desc: pointer filled in if matched measure policy sets template=
  * @func_data: func specific data, may be NULL
  * @allowed_algos: allowlist of hash algorithms for the IMA xattr
+ * @digest_cache_usage: Actions and purpose for which digest cache is allowed
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -190,7 +191,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data, unsigned int *allowed_algos)
+		   const char *func_data, unsigned int *allowed_algos,
+		   u64 *digest_cache_usage)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
@@ -198,7 +200,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 
 	return ima_match_policy(idmap, inode, cred, secid, func, mask,
 				flags, pcr, template_desc, func_data,
-				allowed_algos);
+				allowed_algos, digest_cache_usage);
 }
 
 static bool ima_get_verity_digest(struct ima_iint_cache *iint,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3497741caea9..27ccc9a2c09f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -81,7 +81,7 @@ int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 	security_current_getsecid_subj(&secid);
 	return ima_match_policy(idmap, inode, current_cred(), secid,
 				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
-				NULL, NULL, NULL);
+				NULL, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry, struct ima_iint_cache *iint)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 18285fc8ac07..e3ca80098c4c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -232,7 +232,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 */
 	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
-				&allowed_algos);
+				&allowed_algos, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -489,11 +489,11 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
-				&pcr, &template, NULL, NULL);
+				&pcr, &template, NULL, NULL, NULL);
 	action |= ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				 current_cred(), secid, MAY_EXEC,
 				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
-				 NULL);
+				 NULL, NULL);
 
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -972,7 +972,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 		security_current_getsecid_subj(&secid);
 		action = ima_get_action(idmap, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
-					func_data, NULL);
+					func_data, NULL, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 7cfd1860791f..9e13b88b0ed5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -122,6 +122,7 @@ struct ima_rule_entry {
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
 	struct ima_rule_opt_list *label; /* Measure data grouped under this label */
 	struct ima_template_desc *template;
+	u64 digest_cache_usage;	/* Actions and purpose for which digest cache is allowed */
 };
 
 /*
@@ -726,6 +727,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
  * @allowed_algos: allowlist of hash algorithms for the IMA xattr
+ * @digest_cache_usage: Actions and purpose for which digest cache is allowed
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -738,7 +740,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data, unsigned int *allowed_algos)
+		     const char *func_data, unsigned int *allowed_algos,
+		     u64 *digest_cache_usage)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -783,6 +786,9 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		if (template_desc && entry->template)
 			*template_desc = entry->template;
 
+		if (digest_cache_usage)
+			*digest_cache_usage |= entry->digest_cache_usage;
+
 		if (!actmask)
 			break;
 	}
@@ -859,6 +865,30 @@ static int ima_appraise_flag(enum ima_hooks func)
 	return 0;
 }
 
+static bool ima_digest_cache_func_allowed(struct ima_rule_entry *entry)
+{
+	switch (entry->func) {
+	case NONE:
+	case FILE_CHECK:
+	case MMAP_CHECK:
+	case MMAP_CHECK_REQPROT:
+	case BPRM_CHECK:
+	case CREDS_CHECK:
+	case FIRMWARE_CHECK:
+	case POLICY_CHECK:
+	case MODULE_CHECK:
+	case KEXEC_KERNEL_CHECK:
+	case KEXEC_INITRAMFS_CHECK:
+		/* Exception: always add policy updates to measurement list! */
+		if (entry->action == MEASURE && entry->func == POLICY_CHECK)
+			return false;
+
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void add_rules(struct ima_rule_entry *entries, int count,
 		      enum policy_rule_list policy_rule)
 {
@@ -1073,7 +1103,7 @@ enum policy_opt {
 	Opt_digest_type,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_label, Opt_digest_cache, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1122,6 +1152,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_digest_cache, "digest_cache=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1245,6 +1276,18 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	if (entry->action != MEASURE && entry->flags & IMA_PCR)
 		return false;
 
+	/* New-style measurements with digest cache cannot be on default PCR. */
+	if (entry->action == MEASURE &&
+	    (entry->digest_cache_usage & IMA_DIGEST_CACHE_MEASURE_DATA)) {
+		if (!(entry->flags & IMA_PCR) ||
+		    entry->pcr == CONFIG_IMA_MEASURE_PCR_IDX)
+			return false;
+	}
+
+	/* Digest caches can be used only for a subset of the IMA hooks. */
+	if (entry->digest_cache_usage && !ima_digest_cache_func_allowed(entry))
+		return false;
+
 	if (entry->action != APPRAISE &&
 	    entry->flags & (IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
 			    IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
@@ -1881,6 +1924,26 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 						 &(template_desc->num_fields));
 			entry->template = template_desc;
 			break;
+		case Opt_digest_cache:
+			ima_log_string(ab, "digest_cache", args[0].from);
+
+			result = -EINVAL;
+
+			if (!strcmp(args[0].from, "data")) {
+				switch (entry->action) {
+				case MEASURE:
+					entry->digest_cache_usage |= IMA_DIGEST_CACHE_MEASURE_DATA;
+					result = 0;
+					break;
+				case APPRAISE:
+					entry->digest_cache_usage |= IMA_DIGEST_CACHE_APPRAISE_DATA;
+					result = 0;
+					break;
+				default:
+					break;
+				}
+			}
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -2271,6 +2334,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "digest_type=verity ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if ((entry->digest_cache_usage & IMA_DIGEST_CACHE_MEASURE_DATA) ||
+	    (entry->digest_cache_usage & IMA_DIGEST_CACHE_APPRAISE_DATA))
+		seq_puts(m, "digest_cache=data ");
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
-- 
2.34.1


