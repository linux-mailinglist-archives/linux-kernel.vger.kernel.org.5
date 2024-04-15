Return-Path: <linux-kernel+bounces-145517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347FF8A574D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C56EB2350A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E382869;
	Mon, 15 Apr 2024 16:12:21 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B980C14;
	Mon, 15 Apr 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197541; cv=none; b=c8DGv7RrZbYc8Czt01AgwO7q4q/xZAPIeFA1EYjaULGDS0QoSMHcCkXQQxNLHvOrJD9sAlUhPD0q/nQL2WB56wsYGsz5EPfTpCbShGjr9KliZVRtg+3L/PgTE1yun5lKDxeLDCXKe/RKfqV6LF/3fS7mG9O2mDQNMr8XvUkWknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197541; c=relaxed/simple;
	bh=Lq03hBo9irT2FumkWfUnQv9n2u2+4mLpxr7sOeBCN+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCmjowkns5C6Htbg7NYTPO8SEVvKG7HIY046oY2EyffvL1UaQ5mq7NsKLCNoojONYh8+9Uaxs07IUtcNlgIKSIvswvAZpy8CG4ty1A7tNJsgVTX0ZRFk9pHuwm41fWd1CcYHRw40ynHiBxIZqvDKb0ji91OkfB909G/yGx9QDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VJBbT27rKz9xHvT;
	Mon, 15 Apr 2024 23:55:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1B7F4140627;
	Tue, 16 Apr 2024 00:12:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0iaZUR1m4n9HBg--.16529S6;
	Mon, 15 Apr 2024 17:12:15 +0100 (CET)
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
Subject: [RFC][PATCH v2 4/9] ima: Add digest_cache_measure/appraise boot-time built-in policies
Date: Mon, 15 Apr 2024 18:10:39 +0200
Message-Id: <20240415161044.2572438-5-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwDn0iaZUR1m4n9HBg--.16529S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1kKr1UWF13Zr1DWw48Zwb_yoW7CrWfpa
	9rWFy5trZ8XF9xCw47Ca4xuF4Fy3s2ga17Wws8Ga4jy3Z8Zr1q9w1Fy3W3ZrZ8Ar1jq3Wx
	JFs09r4jkw1qqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h14AAEsw

From: Roberto Sassu <roberto.sassu@huawei.com>

Specify the 'digest_cache_measure' boot-time policy with 'ima_policy=' in
the kernel command line to add the following rule at the beginning of the
IMA policy, before other rules:

measure func=DIGEST_LIST_CHECK pcr=12

which will measure digest lists into PCR 12 (or the value in
CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX).

Specify 'digest_cache_appraise' to add the following rule at the beginning,
before other rules:

appraise func=DIGEST_LIST_CHECK appraise_type=imasig|modsig

which will appraise digest lists with IMA signatures or module-style
appended signatures.

Adding those rule at the beginning rather than at the end is necessary to
ensure that digest lists are measured and appraised in the initial ram
disk, which would be otherwise prevented by the dont_ rules.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 +++++-
 security/integrity/ima/Kconfig                | 10 ++++++
 security/integrity/ima/ima_policy.c           | 35 +++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 902ecd92a29f..df877588decc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2050,7 +2050,8 @@
 	ima_policy=	[IMA]
 			The builtin policies to load during IMA setup.
 			Format: "tcb | appraise_tcb | secure_boot |
-				 fail_securely | critical_data"
+				 fail_securely | critical_data |
+				 digest_cache_measure | digest_cache_appraise"
 
 			The "tcb" policy measures all programs exec'd, files
 			mmap'd for exec, and all files opened with the read
@@ -2072,6 +2073,13 @@
 			The "critical_data" policy measures kernel integrity
 			critical data.
 
+			The "digest_cache_measure" policy measures digest lists
+			into PCR 12 (can be changed with kernel config).
+
+			The "digest_cache_appraise" policy appraises digest
+			lists with IMA signatures or module-style appended
+			signatures.
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
index 9e13b88b0ed5..f049543f6b64 100644
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
@@ -971,6 +992,20 @@ void __init ima_init_policy(void)
 {
 	int build_appraise_entries, arch_entries;
 
+	/*
+	 * We need to load digest cache rules at the beginning, to avoid dont_
+	 * rules causing ours to not be reached.
+	 */
+	if (IS_ENABLED(CONFIG_SECURITY_DIGEST_CACHE)) {
+		if (ima_digest_cache_measure)
+			add_rules(&measure_digest_cache_rule, 1,
+				  IMA_DEFAULT_POLICY);
+
+		if (ima_digest_cache_appraise)
+			add_rules(&appraise_digest_cache_rule, 1,
+				  IMA_DEFAULT_POLICY);
+	}
+
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
 		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
-- 
2.34.1


