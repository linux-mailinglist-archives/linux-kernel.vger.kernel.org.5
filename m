Return-Path: <linux-kernel+bounces-65346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF05854B98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB89B2479E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97445B20E;
	Wed, 14 Feb 2024 14:36:54 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6185B020;
	Wed, 14 Feb 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921413; cv=none; b=ZK3tMULg9+PiVBXfZGgT54z0V26aRdfzzsFPnB7rrzJzQUzZG/0o/w83Vx+FrO7TRrhR6rtUyJS7HprM3UKHs7bR9qA5Cny2dM8PpSIdP/hZ7p3dVWxw1Y0bIr/8BmQBRUHE3sIpEgq0NvtPBGDmg+V6NzoJWocb0smuaqG1/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921413; c=relaxed/simple;
	bh=F6yhBMq0IzV/A77mbJzu+P9ii37a1qqOqIehKOoSoKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BD6SLg1xJtTRykfeXlAxUmVSIp5kimKHjyZEZDaV8CsH2JW9WgUwLl42on2P91fmLvcrEg5ynsuNj8X0R53y1mPxNopGJetci/l3sswTNVhu/MTXnZzl0IdCBfThozCw4h7XUJ3iCAvJuWUSwAzSf891BuHk79I/h++6v4gJe7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TZgNq2pvGz9xvv5;
	Wed, 14 Feb 2024 22:21:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9822F14086B;
	Wed, 14 Feb 2024 22:36:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXgRrHz8xlZ55_Ag--.52204S5;
	Wed, 14 Feb 2024 15:36:41 +0100 (CET)
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
Subject: [RFC][PATCH 3/8] ima: Add digest_cache policy keyword
Date: Wed, 14 Feb 2024 15:35:19 +0100
Message-Id: <20240214143525.2205481-4-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXgRrHz8xlZ55_Ag--.52204S5
X-Coremail-Antispam: 1UD129KBjvAXoW3ZFWxCF4xCFW5AryrZFyfXrb_yoW8Jw13Xo
	Z3K39rGF48GFy3uayUCFnIyFW8W3yrGw1xJFnYqr98A3Z2vryUGasrWr1UZFy3ZF48XFZI
	k3WxX3y8JFWkJas3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOI7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
	1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUUbAw7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj5pZHgAAsk

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the 'digest_cache=' policy keyword, to enable the usage of digest
caches for specific IMA actions and purposes.

At the moment, it accepts only 'content' as value, as digest caches can be
only used only for measurement and appraisal of file content. In the
future, it might be possible to use them for file metadata too.

The 'digest_cache=' keyword can be specified for the subset of IMA hooks
listed in ima_digest_cache_func_allowed().

POLICY_CHECK has been excluded for measurement, because policy changes must
be visible in the IMA measurement list. For appraisal, instead, it might be
useful to load custom policies in the initial ram disk (no security.ima
xattr).

Add the digest_cache_mask member to the ima_rule_entry structure, and set
the flag IMA_DIGEST_CACHE_MEASURE_CONTENT if 'digest_cache=content' was
specified for a measure rule, IMA_DIGEST_CACHE_APPRAISE_CONTENT for an
appraise rule.

Propagate the mask down to ima_match_policy() and ima_get_action(), so that
process_measurement() can make the final decision on whether or not digest
caches should be used to measure/appraise the file being evaluated.

Since using digest caches changes the meaning of the IMA measurement list,
which will include only digest lists and unknown files, enforce specifying
'pcr=' with a non-standard value, when 'digest_cache=content' is specified
in a measure rule.

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
index 22237fec5532..be045fb60530 100644
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
+			digest_cache:= [content]
+			"content" means that the digest cache is used only
+			for file content measurement and/or appraisal.
 
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c9140a57b591..deee56d99d6f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -43,6 +43,10 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
 
+/* Digest cache usage flags. */
+#define IMA_DIGEST_CACHE_MEASURE_CONTENT	0x0000000000000001
+#define IMA_DIGEST_CACHE_APPRAISE_CONTENT	0x0000000000000002
+
 /* current content of the policy */
 extern int ima_policy_flag;
 
@@ -367,7 +371,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data, unsigned int *allowed_algos);
+		   const char *func_data, unsigned int *allowed_algos,
+		   u64 *digest_cache_mask);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 			    void *buf, loff_t size, enum hash_algo algo,
@@ -398,7 +403,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data, unsigned int *allowed_algos);
+		     const char *func_data, unsigned int *allowed_algos,
+		     u64 *digest_cache_mask);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flags(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index b37d043d5748..87e286ace43c 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -173,6 +173,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @template_desc: pointer filled in if matched measure policy sets template=
  * @func_data: func specific data, may be NULL
  * @allowed_algos: allowlist of hash algorithms for the IMA xattr
+ * @digest_cache_mask: Actions and purposes for which digest cache is allowed
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -190,7 +191,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data, unsigned int *allowed_algos)
+		   const char *func_data, unsigned int *allowed_algos,
+		   u64 *digest_cache_mask)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
@@ -198,7 +200,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 
 	return ima_match_policy(idmap, inode, cred, secid, func, mask,
 				flags, pcr, template_desc, func_data,
-				allowed_algos);
+				allowed_algos, digest_cache_mask);
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
index 7cfd1860791f..4ac83df8d255 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -122,6 +122,7 @@ struct ima_rule_entry {
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
 	struct ima_rule_opt_list *label; /* Measure data grouped under this label */
 	struct ima_template_desc *template;
+	u64 digest_cache_mask;	/* Actions and purposes for which digest cache is allowed */
 };
 
 /*
@@ -726,6 +727,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
  * @allowed_algos: allowlist of hash algorithms for the IMA xattr
+ * @digest_cache_mask: Actions and purposes for which digest cache is allowed
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -738,7 +740,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data, unsigned int *allowed_algos)
+		     const char *func_data, unsigned int *allowed_algos,
+		     u64 *digest_cache_mask)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -783,6 +786,9 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		if (template_desc && entry->template)
 			*template_desc = entry->template;
 
+		if (digest_cache_mask)
+			*digest_cache_mask |= entry->digest_cache_mask;
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
+	    (entry->digest_cache_mask & IMA_DIGEST_CACHE_MEASURE_CONTENT)) {
+		if (!(entry->flags & IMA_PCR) ||
+		    entry->pcr == CONFIG_IMA_MEASURE_PCR_IDX)
+			return false;
+	}
+
+	/* Digest caches can be used only for a subset of the IMA hooks. */
+	if (entry->digest_cache_mask && !ima_digest_cache_func_allowed(entry))
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
+			if (!strcmp(args[0].from, "content")) {
+				switch (entry->action) {
+				case MEASURE:
+					entry->digest_cache_mask |= IMA_DIGEST_CACHE_MEASURE_CONTENT;
+					result = 0;
+					break;
+				case APPRAISE:
+					entry->digest_cache_mask |= IMA_DIGEST_CACHE_APPRAISE_CONTENT;
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
+	if ((entry->digest_cache_mask & IMA_DIGEST_CACHE_MEASURE_CONTENT) ||
+	    (entry->digest_cache_mask & IMA_DIGEST_CACHE_APPRAISE_CONTENT))
+		seq_puts(m, "digest_cache=content ");
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
-- 
2.34.1


