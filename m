Return-Path: <linux-kernel+bounces-65348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE1854BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E593D282316
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91F5A7A1;
	Wed, 14 Feb 2024 14:37:19 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF295A4CE;
	Wed, 14 Feb 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921439; cv=none; b=g43jChoBq07UyOpDpdkBuMEUsObK80bEax1pJIVDyKmQL/oAfqZLjo3vhXsQCDPPDeJ+sAJWgaatgRIn0uhzkA8zGaGtaPwNLcUbtpvubPvcj37LBEE+96OzsmRHfNZC7Bz1Syks3RU+s52PhCsbe9b8qXI3RZlYXCNUYxgazB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921439; c=relaxed/simple;
	bh=dd5lEv9neG0wGXXw5kIQsG7LZlptI1wp07O22Ey4Gbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+huaOYIBwvSuhS/fIxZq6QkQhJAYL87YLc1Bo1SAxOGR9NUtsR8BlgPb25V7PXqoBBavMaEKkiUOIo8qh+RVDbeL1xRfjkIns159c3SkyJkHQTdlOu9p7jaddVNt3Y+g3LLSJHYw+j8nzMkLG2IdF2i2SWIf8J5R8X8gQ+K5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TZgPM73kfz9xyNT;
	Wed, 14 Feb 2024 22:21:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8B3EF140A92;
	Wed, 14 Feb 2024 22:37:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXgRrHz8xlZ55_Ag--.52204S7;
	Wed, 14 Feb 2024 15:37:04 +0100 (CET)
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
Subject: [RFC][PATCH 5/8] ima: Record IMA verification result of digest lists in digest cache
Date: Wed, 14 Feb 2024 15:35:21 +0100
Message-Id: <20240214143525.2205481-6-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXgRrHz8xlZ55_Ag--.52204S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW3Cr4Utr4UZr4Duw4DJwb_yoWrXry3pa
	9IkF18trWkJryxCrs3A3W2ka1rK39YqF4UWan5WFn0ka9xZr1vv39Yya4UuFyrXFWUZasr
	tr42grs8Ca1UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj5ZZmgAAsv

From: Roberto Sassu <roberto.sassu@huawei.com>

The digest_cache LSM allows integrity providers to record how the digest
list being used to populate the digest cache was verified.

Integrity providers can register a kernel_post_read_file LSM hook
implementation, and call digest_cache_verif_set() providing the result of
the digest list verification, together with the digest list file
descriptor.

IMA calls digest_cache_verif_set() during the DIGEST_LIST_CHECK hook
(kernel read with file type READING_DIGEST_LIST), and attaches to the
digest cache a u64 variable with the IMA_DIGEST_CACHE_MEASURE_CONTENT and
IMA_DIGEST_CACHE_APPRAISE_CONTENT flags set, if the digest list was
respectively measured and appraised.

The same flags are set in another u64 variable, if 'digest_cache=content'
appears respectively in a measure or appraise rule.

The final decision on whether the digest cache can be used for measurement
and appraisal depends on the AND of these two variables, so it must have
been authorized with the IMA policy and the same action must have been done
on the digest list.

This prevents remote verifiers from receiving an incomplete IMA measurement
list, where measurements are skipped, but there isn't the digest list the
calculated file digest was search into. It also prevents successful
appraisal without appraising the digest list itself.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index deee56d99d6f..2dbcaf0a9402 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -20,6 +20,7 @@
 #include <linux/hash.h>
 #include <linux/tpm.h>
 #include <linux/audit.h>
+#include <linux/digest_cache.h>
 #include <crypto/hash_info.h>
 
 #include "../integrity.h"
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e3ca80098c4c..3fc48214850a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -214,7 +214,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
-	int rc = 0, action, must_appraise = 0;
+	int rc = 0, digest_cache_rc, action, must_appraise = 0;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	struct evm_ima_xattr_data *xattr_value = NULL;
 	struct modsig *modsig = NULL;
@@ -222,6 +222,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	bool violation_check;
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
+	u64 verif_mask = 0;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -399,6 +400,22 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
 		rc = -EACCES;
+	if (!rc && func == DIGEST_LIST_CHECK) {
+		if (iint->flags & IMA_MEASURED)
+			verif_mask |= IMA_DIGEST_CACHE_MEASURE_CONTENT;
+		if (iint->flags & IMA_APPRAISED_SUBMASK)
+			verif_mask |= IMA_DIGEST_CACHE_APPRAISE_CONTENT;
+
+		/* Remember actions done on digest list for later use. */
+		digest_cache_rc = digest_cache_verif_set(file, "ima",
+							 &verif_mask,
+							 sizeof(verif_mask));
+		/* Ignore if fd doesn't have digest cache set (prefetching). */
+		if (digest_cache_rc && digest_cache_rc != -ENOENT)
+			pr_debug("Cannot set verification mask for %s, ret: %d, ignoring\n",
+				 file_dentry(file)->d_name.name,
+				 digest_cache_rc);
+	}
 	mutex_unlock(&iint->mutex);
 	kfree(xattr_value);
 	ima_free_modsig(modsig);
-- 
2.34.1


