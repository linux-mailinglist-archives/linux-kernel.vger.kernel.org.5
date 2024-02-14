Return-Path: <linux-kernel+bounces-65347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6062854B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04642B28164
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3C35D461;
	Wed, 14 Feb 2024 14:36:59 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC55B696;
	Wed, 14 Feb 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921419; cv=none; b=ZdfhyoUsw1DVNNZH9q7QUXDDkct55q00dS68Q/ogUGBiUHbGDiIgka/KRLl57k63EL0Odznu2DEjFTGm8wvXUwoyLeg0/2GgCxXD7y7+5jrSeHpUMAcXC7s0hACSpYn7OROdLdRgs5mAPnFLapoiom8X+hx22eCk3/YyM7zzluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921419; c=relaxed/simple;
	bh=3aIY3/beM47BnEfxD9WCTOeo+t/mvwwSZaUemlmYUyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3dYRpeKvpIRLUFi0xJlECoPkCFmfVoGFO3SYOe0pjveT5+v0E1GFmZ2jPPXIYKRDfe4Qkw6M10jXGsiDXUuqUa3+6perZ3lWXtOL5kMny+b2C56u9lGKfsHHVSkOCHbzvFkzJLy6kUupGjL7/3FfCuGHZxVNQ9l5FSFcarmLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TZgNw6zC9z9xvvR;
	Wed, 14 Feb 2024 22:21:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8FEE31401E0;
	Wed, 14 Feb 2024 22:36:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXgRrHz8xlZ55_Ag--.52204S6;
	Wed, 14 Feb 2024 15:36:53 +0100 (CET)
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
Subject: [RFC][PATCH 4/8] ima: Add digest_cache_measure and digest_cache_appraise boot-time policies
Date: Wed, 14 Feb 2024 15:35:20 +0100
Message-Id: <20240214143525.2205481-5-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXgRrHz8xlZ55_Ag--.52204S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1kKr1UWF13Zr1DWw48Zwb_yoWxCF4Upa
	9rWFyrtrZxZF93Cw43Aa4xuF4rt34vqF47Gw4UK34UAFn8Ar1q9w18AF13ZFZ5Zr10qa1x
	JFs8Kw4jkw1qqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_
	GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRRyxRDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj5pZHwAAsl

From: Roberto Sassu <roberto.sassu@huawei.com>

Specify the 'digest_cache_measure' boot-time policy with 'ima_policy=' in
the kernel command line to add the following rule at the beginning of the
IMA policy, before other rules:

measure func=DIGEST_LIST_CHECK pcr=12

which will measure digest lists into PCR 12 (or the value in
CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX).

'digest_cache_measure' also adds 'digest_cache=content pcr=12' to the other
measure rules, if they have a compatible IMA hook. The PCR value still
comes from CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX.

Specify 'digest_cache_appraise' to add the following rule at the beginning,
before other rules:

appraise func=DIGEST_LIST_CHECK appraise_type=imasig|modsig

which will appraise digest lists with IMA signatures or module-style
appended signatures.

'digest_cache_appraise' also adds 'digest_cache=content' to the other
appraise rules, if they have a compatible IMA hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         | 15 ++++++-
 security/integrity/ima/Kconfig                | 10 +++++
 security/integrity/ima/ima_policy.c           | 45 +++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..a79967fcba7d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2011,7 +2011,8 @@
 	ima_policy=	[IMA]
 			The builtin policies to load during IMA setup.
 			Format: "tcb | appraise_tcb | secure_boot |
-				 fail_securely | critical_data"
+				 fail_securely | critical_data |
+				 digest_cache_measure | digest_cache_appraise"
 
 			The "tcb" policy measures all programs exec'd, files
 			mmap'd for exec, and all files opened with the read
@@ -2033,6 +2034,18 @@
 			The "critical_data" policy measures kernel integrity
 			critical data.
 
+			The "digest_cache_measure" policy measures digest lists
+			into PCR 12 (can be changed with kernel config), enables
+			the digest cache to be used for the other selected
+			measure rules (if compatible), and measures the files
+			with digest not found in the digest list into PCR 12
+			(changeable).
+
+			The "digest_cache_appraise" policy appraises digest
+			lists with IMA signatures or module-style appended
+			signatures, and enables the digest cache to be used for
+			the other selected appraise rules (if compatible).
+
 	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
 			Load a policy which meets the needs of the Trusted
 			Computing Base.  This means IMA will measure all
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 475c32615006..6a481019fb6e 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
 	help
 	   This option disables htable to allow measurement of duplicate records.
 
+config IMA_DIGEST_CACHE_MEASURE_PCR_IDX
+	int
+	range 8 14
+	default 12
+	help
+	  This option determines the TPM PCR register index that IMA uses to
+	  maintain the integrity aggregate of the measurement list, when the
+	  digest_cache LSM is used (different measurement style).  If unsure,
+	  use the default 12.
+
 endif
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 4ac83df8d255..04127f962ef4 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -254,6 +254,21 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
 	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
 };
 
+static struct ima_rule_entry measure_digest_cache_rule __ro_after_init = {
+#ifdef CONFIG_SECURITY_DIGEST_CACHE
+	.action = MEASURE, .func = DIGEST_LIST_CHECK,
+	.pcr = CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX,
+	.flags = IMA_FUNC | IMA_PCR
+#endif
+};
+
+static struct ima_rule_entry appraise_digest_cache_rule __ro_after_init = {
+#ifdef CONFIG_SECURITY_DIGEST_CACHE
+	.action = APPRAISE, .func = DIGEST_LIST_CHECK,
+	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED,
+#endif
+};
+
 /* An array of architecture specific rules */
 static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 
@@ -278,6 +293,8 @@ static bool ima_use_appraise_tcb __initdata;
 static bool ima_use_secure_boot __initdata;
 static bool ima_use_critical_data __initdata;
 static bool ima_fail_unverifiable_sigs __ro_after_init;
+static bool ima_digest_cache_measure __ro_after_init;
+static bool ima_digest_cache_appraise __ro_after_init;
 static int __init policy_setup(char *str)
 {
 	char *p;
@@ -295,6 +312,10 @@ static int __init policy_setup(char *str)
 			ima_use_critical_data = true;
 		else if (strcmp(p, "fail_securely") == 0)
 			ima_fail_unverifiable_sigs = true;
+		else if (strcmp(p, "digest_cache_measure") == 0)
+			ima_digest_cache_measure = true;
+		else if (strcmp(p, "digest_cache_appraise") == 0)
+			ima_digest_cache_appraise = true;
 		else
 			pr_err("policy \"%s\" not found", p);
 	}
@@ -897,6 +918,20 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 	for (i = 0; i < count; i++) {
 		struct ima_rule_entry *entry;
 
+		if (IS_ENABLED(CONFIG_SECURITY_DIGEST_CACHE) &&
+		    entries[i].action == MEASURE && ima_digest_cache_measure &&
+		    ima_digest_cache_func_allowed(&entries[i])) {
+			entries[i].digest_cache_mask |= IMA_DIGEST_CACHE_MEASURE_CONTENT;
+			entries[i].pcr = CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX;
+			entries[i].flags |= IMA_PCR;
+		}
+
+		if (IS_ENABLED(CONFIG_SECURITY_DIGEST_CACHE) &&
+		    entries[i].action == APPRAISE &&
+		    ima_digest_cache_appraise &&
+		    ima_digest_cache_func_allowed(&entries[i]))
+			entries[i].digest_cache_mask |= IMA_DIGEST_CACHE_APPRAISE_CONTENT;
+
 		if (policy_rule & IMA_DEFAULT_POLICY)
 			list_add_tail(&entries[i].list, &ima_default_rules);
 
@@ -971,6 +1006,16 @@ void __init ima_init_policy(void)
 {
 	int build_appraise_entries, arch_entries;
 
+	/*
+	 * We need to load digest cache rules at the beginning, to avoid dont_
+	 * rules causing ours to not be reached.
+	 */
+	if (ima_digest_cache_measure)
+		add_rules(&measure_digest_cache_rule, 1, IMA_DEFAULT_POLICY);
+
+	if (ima_digest_cache_appraise)
+		add_rules(&appraise_digest_cache_rule, 1, IMA_DEFAULT_POLICY);
+
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
 		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
-- 
2.34.1


