Return-Path: <linux-kernel+bounces-145521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7B08A575A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E061F2373F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79D82D98;
	Mon, 15 Apr 2024 16:12:57 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72982494;
	Mon, 15 Apr 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197577; cv=none; b=ipLsvXl8l4GUtaVgJY5qZ6es7+bCi5bbWAYA5zNSSOrguPs4YtMD/v28P8Uy6gDXskN2a4bMwwt4wN5fg0vEPRCcpKBGJ5QCOpL4JOkoanmfoVEe82VZ6H7ZzEkSxEJFTglCs2YX5L/kdVhH0MVriFhVLwOUH3Sg1FMo3AVWD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197577; c=relaxed/simple;
	bh=LwSw9uoE6uVD+zxxnCEZ4oH8uTTzcvhlas/3ik0KdLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HJtkMZUGL4ovxX8H/iZTO0OLNbeN4Id08+RZtFz999ePoOaC0t5URyEjrUjR9LKcm0DnmX4Vt+iJPpUKZyymsfHA/0Cj6vH6eD0EtXyE22uH6QmLjIj3Hz7GRNEpazFGfhMDr2YZvDRGtsoXRStrxKfP5MjuYFXblEVTL9qTxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VJBW34rZYz9xqv8;
	Mon, 15 Apr 2024 23:51:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DC18C1405E3;
	Tue, 16 Apr 2024 00:12:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0iaZUR1m4n9HBg--.16529S8;
	Mon, 15 Apr 2024 17:12:42 +0100 (CET)
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
Subject: [RFC][PATCH v2 6/9] ima: Store allowed usage in digest cache based on integrity metadata flags
Date: Mon, 15 Apr 2024 18:10:41 +0200
Message-Id: <20240415161044.2572438-7-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwDn0iaZUR1m4n9HBg--.16529S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1rtF4xJw47uw15JFy7ZFb_yoW7Kr1rpa
	93KF15Kr18Zry7Crn3A3W2ka1rK39YvF4UWws8XrnayFW5Xr1jvw4kAry7ZFy3Jr4qya1x
	tr43Kr13Aw1DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h14gAAs2

From: Roberto Sassu <roberto.sassu@huawei.com>

The digest_cache LSM allows integrity providers to record how the digest
list being used to populate the digest cache was verified.

Integrity providers can register a kernel_post_read_file LSM hook
implementation, and call digest_cache_verif_set() providing the result of
the digest list verification, together with the digest list file
descriptor.

IMA implements ima_digest_cache_store_allowed_usage(), storing allowed
usage of the digest cache based on whether or not the digest list the
digest cache is being populated from was measured/appraised.

If the digest list was measured (IMA_MEASURED set in iint->flags),
ima_digest_cache_store_allowed_usage() sets the
IMA_DIGEST_CACHE_MEASURE_DATA in the allowed usage. If the digest list was
appraised (IMA_APPRAISED_SUBMASK), ima_digest_cache_store_allowed_usage()
sets the IMA_DIGEST_CACHE_APPRAISE_DATA in the allowed usage.

Allowed usage based on integrity metadata will be ANDed with the allowed
usage from the IMA policy. Then, the final decision will ultimately depend
on whether or not the calculated digest of the accessed file was found in
the digest cache.

ANDing the usage prevents remote verifiers from receiving an incomplete
IMA measurement list, where measurements are skipped, but there isn't the
digest list the calculated file digest was searched into. It also prevents
successful appraisal without appraising the digest list itself.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/Makefile           |  1 +
 security/integrity/ima/ima_digest_cache.c | 45 +++++++++++++++++++++++
 security/integrity/ima/ima_digest_cache.h | 21 +++++++++++
 security/integrity/ima/ima_main.c         |  3 ++
 4 files changed, 70 insertions(+)
 create mode 100644 security/integrity/ima/ima_digest_cache.c
 create mode 100644 security/integrity/ima/ima_digest_cache.h

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index b376d38b4ee6..edd74a7374de 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,6 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_SECURITY_DIGEST_CACHE) += ima_digest_cache.o
 
 ifeq ($(CONFIG_EFI),y)
 ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
diff --git a/security/integrity/ima/ima_digest_cache.c b/security/integrity/ima/ima_digest_cache.c
new file mode 100644
index 000000000000..0b0fd26cc0d7
--- /dev/null
+++ b/security/integrity/ima/ima_digest_cache.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Integrate with the digest_cache LSM.
+ */
+
+#include <linux/digest_cache.h>
+
+#include "ima_digest_cache.h"
+
+/**
+ * ima_digest_cache_store_allowed_usage - Store allowed usage in digest cache
+ * @file: Digest list file descriptor
+ * @iint: Inode integrity metadata
+ *
+ * Set digest cache allowed usage in the digest cache associated to the
+ * digest list file descriptor. Allowed usage is based on whether or not the
+ * digest list was measured/appraised.
+ */
+void ima_digest_cache_store_allowed_usage(struct file *file,
+					  struct ima_iint_cache *iint)
+{
+	u64 allowed_usage = 0;
+	int rc;
+
+	if (iint->flags & IMA_MEASURED)
+		allowed_usage |= IMA_DIGEST_CACHE_MEASURE_DATA;
+	if (iint->flags & IMA_APPRAISED_SUBMASK)
+		allowed_usage |= IMA_DIGEST_CACHE_APPRAISE_DATA;
+
+	/*
+	 * Set digest cache allowed usage from integrity metadata flags for
+	 * later use.
+	 */
+	rc = digest_cache_verif_set(file, "ima", &allowed_usage,
+				    sizeof(allowed_usage));
+
+	/* Ignore if fd doesn't have digest cache set (prefetching). */
+	if (rc && rc != -ENOENT)
+		pr_debug("Cannot set verification mask for %s, ret: %d, ignoring\n",
+			 file_dentry(file)->d_name.name, rc);
+}
diff --git a/security/integrity/ima/ima_digest_cache.h b/security/integrity/ima/ima_digest_cache.h
new file mode 100644
index 000000000000..f2534a01bb18
--- /dev/null
+++ b/security/integrity/ima/ima_digest_cache.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file of ima_digest_cache.c.
+ */
+
+#include "ima.h"
+
+#ifdef CONFIG_SECURITY_DIGEST_CACHE
+void ima_digest_cache_store_allowed_usage(struct file *file,
+					  struct ima_iint_cache *iint);
+#else
+static inline void
+ima_digest_cache_store_allowed_usage(struct file *file,
+				     struct ima_iint_cache *iint)
+{ }
+
+#endif /* CONFIG_SECURITY_DIGEST_CACHE */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e3ca80098c4c..7c968cdb5678 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -28,6 +28,7 @@
 #include <linux/iversion.h>
 
 #include "ima.h"
+#include "ima_digest_cache.h"
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
@@ -399,6 +400,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
 		rc = -EACCES;
+	if (!rc && func == DIGEST_LIST_CHECK)
+		ima_digest_cache_store_allowed_usage(file, iint);
 	mutex_unlock(&iint->mutex);
 	kfree(xattr_value);
 	ima_free_modsig(modsig);
-- 
2.34.1


