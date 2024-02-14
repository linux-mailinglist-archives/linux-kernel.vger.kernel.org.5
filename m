Return-Path: <linux-kernel+bounces-65343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D6E854B89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2749C1F2861C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA18E5B5C0;
	Wed, 14 Feb 2024 14:36:23 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB45A0F8;
	Wed, 14 Feb 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921383; cv=none; b=Vh8eb/Pyt1rJfYjkr4NNpJGGfmbVieBqHHelVVID+9jnzqCLNV28fmNMRBYtOK3lfwob3Ksp9l6AvU+oMTxOipFBCLlxr9CZSSCscm755Z0UcKvc27Fo2fbX5RNttHjpMeZYY6w+97FWaeLVxJdlcBSzqYI3lD0v/h+i426tQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921383; c=relaxed/simple;
	bh=fzNhu5+L37tz+f9+SsSu8RCO8zKco+WeH9wCYtepQbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiKyuTctFFtxRp3JFxQXPWzr8zCGdl8x2b/hhxEJN8y9uW/Ql/Cf48BMho4NhY9LNYVkg/xlI1ies0X7mIDs8jG7TqrkqpWecWfOCD/r2R+rA6v0BBj5yo9CO5klxElssIsbl/1nnYhh0BtE5GjU7NcSlfphYbIiEFmST9LZ+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZgHp2G9Vz9xtVZ;
	Wed, 14 Feb 2024 22:17:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6F73F1401E0;
	Wed, 14 Feb 2024 22:36:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXgRrHz8xlZ55_Ag--.52204S3;
	Wed, 14 Feb 2024 15:36:16 +0100 (CET)
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
Subject: [RFC][PATCH 1/8] ima: Introduce hook DIGEST_LIST_CHECK
Date: Wed, 14 Feb 2024 15:35:17 +0100
Message-Id: <20240214143525.2205481-2-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXgRrHz8xlZ55_Ag--.52204S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw47Ar1rXF47XFy8Cw1rWFg_yoW5Cw4xpa
	1qga40kryYqFy2gFZ3C3W29FWkKrWSgF4UG39093WvkFnxAF18Xryayr9F9FyfGryFyFn7
	trs0gr47Aa1jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
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
	WIevJa73UjIFyTuYvjfUUYL9UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj5ZZlQAAsg

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce a new hook to check the integrity of digest lists.

The new hook is invoked during a kernel read with file type
READING_DIGEST LIST, which is done by the digest_cache LSM when it is
populating a digest cache with a digest list.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/ABI/testing/ima_policy | 1 +
 security/integrity/ima/ima.h         | 1 +
 security/integrity/ima/ima_main.c    | 3 ++-
 security/integrity/ima/ima_policy.c  | 3 +++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index c2385183826c..22237fec5532 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -36,6 +36,7 @@ Description:
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
 				[SETXATTR_CHECK][MMAP_CHECK_REQPROT]
+				[DIGEST_LIST_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 11d7c0332207..cea4517e73ab 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -310,6 +310,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(KEY_CHECK, key)				\
 	hook(CRITICAL_DATA, critical_data)		\
 	hook(SETXATTR_CHECK, setxattr_check)		\
+	hook(DIGEST_LIST_CHECK, digest_list_check)	\
 	hook(MAX_CHECK, none)
 
 #define __ima_hook_enumify(ENUM, str)	ENUM,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c84e8c55333d..780627b0cde7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -785,7 +785,8 @@ const int read_idmap[READING_MAX_ID] = {
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-	[READING_POLICY] = POLICY_CHECK
+	[READING_POLICY] = POLICY_CHECK,
+	[READING_DIGEST_LIST] = DIGEST_LIST_CHECK,
 };
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c0556907c2e6..7cfd1860791f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1287,6 +1287,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	case MODULE_CHECK:
 	case KEXEC_KERNEL_CHECK:
 	case KEXEC_INITRAMFS_CHECK:
+	case DIGEST_LIST_CHECK:
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
@@ -1530,6 +1531,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = CRITICAL_DATA;
 			else if (strcmp(args[0].from, "SETXATTR_CHECK") == 0)
 				entry->func = SETXATTR_CHECK;
+			else if (strcmp(args[0].from, "DIGEST_LIST_CHECK") == 0)
+				entry->func = DIGEST_LIST_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.34.1


