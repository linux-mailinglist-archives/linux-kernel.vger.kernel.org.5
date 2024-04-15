Return-Path: <linux-kernel+bounces-145525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC48A576A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE34286CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9D08286A;
	Mon, 15 Apr 2024 16:13:34 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394B82862;
	Mon, 15 Apr 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197613; cv=none; b=Fk33ZLvthvRUIsD5NeA3SjlEvXvMhg6uqOh0937PIHAmRaq9F0iaDXvt7mktnexI9gpgslLeQ1mx01VlkZHyjFXTRGInXwDGDPLFtOryDkZYOHbTD0jkg5mM4WqPhWT1fOTszCTDqmX2PLx3IqOX6HyyFwvgTGM04mZj/vBIhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197613; c=relaxed/simple;
	bh=OstlfuSyRFOTycwkFPIRoGHthbADv/RkObuMjJltxto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qBD6yVTZtH4Bp19r7NML1qrP1XIuSS5MbFMSXCqIJ7oKDqd0XyTjUBKcPmRofpdjLb2Nv+H38RWvPa5C5+9nDGJRpY6mhJTRkrlfHq77K+vhbAbKpHf+TiwqRGQo9aPN+EaNjtSku8x1C/yKcuDIopet+jMCyu2t+OAdwwupYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJBcp5D7Cz9xHvk;
	Mon, 15 Apr 2024 23:56:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 120C41408C5;
	Tue, 16 Apr 2024 00:13:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0iaZUR1m4n9HBg--.16529S11;
	Mon, 15 Apr 2024 17:13:22 +0100 (CET)
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
Subject: [RFC][PATCH v2 9/9] ima: Register to the digest_cache LSM notifier and process events
Date: Mon, 15 Apr 2024 18:10:44 +0200
Message-Id: <20240415161044.2572438-10-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwDn0iaZUR1m4n9HBg--.16529S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZr47Gr1xXw47ZFy8ArW7twb_yoWrXF1fpa
	9rG3WrKrW8Zry7ur4fAFnFyayrK3yktayxW395X3sIyF4DXr1jy395Jr1UuFyrJr4Yqw4x
	tw45Kry5uw1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxUxrcTDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5x3HAAAsN

From: Roberto Sassu <roberto.sassu@huawei.com>

A digest cache used for measurement/appraisal might change over the time
(due to file modification, directory changes). When that happens, IMA
should invalidate the cached integrity result for affected inodes and
evaluate those inodes again.

Implement ima_digest_cache_change(), to be invoked at every notification by
the digest_cache LSM, and register it as a callback with
digest_cache_register_notifier().

For every notification, and if the type of event is DIGEST_CACHE_RESET,
retrieve the inode integrity metadata (if any), and set the
IMA_CHANGE_XATTR atomic flag, so that IMA fully reevaluates the inode in
process_measurement().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_digest_cache.c | 31 +++++++++++++++++++++++
 security/integrity/ima/ima_digest_cache.h |  6 +++++
 security/integrity/ima/ima_main.c         | 11 +++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_digest_cache.c b/security/integrity/ima/ima_digest_cache.c
index 013c69f265d8..0ab35575ff7c 100644
--- a/security/integrity/ima/ima_digest_cache.c
+++ b/security/integrity/ima/ima_digest_cache.c
@@ -90,3 +90,34 @@ void ima_digest_cache_update_allowed_usage(struct file *file,
 out:
 	digest_cache_put(digest_cache);
 }
+
+static int ima_digest_cache_change(struct notifier_block *nb,
+				   unsigned long event, void *data)
+{
+	struct ima_iint_cache *iint;
+	struct digest_cache_event_data *event_data = data;
+
+	if (event != DIGEST_CACHE_RESET)
+		return NOTIFY_DONE;
+
+	iint = ima_iint_find(event_data->inode);
+	if (!iint) {
+		pr_debug("Integrity metadata not found for inode %lu\n",
+			 event_data->inode->i_ino);
+		return NOTIFY_OK;
+	}
+
+	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
+	pr_debug("Integrity metadata of inode %lu successfully reset\n",
+		 event_data->inode->i_ino);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block digest_cache_notifier = {
+	.notifier_call = ima_digest_cache_change,
+};
+
+int ima_digest_cache_register_notifier(void)
+{
+	return digest_cache_register_notifier(&digest_cache_notifier);
+}
diff --git a/security/integrity/ima/ima_digest_cache.h b/security/integrity/ima/ima_digest_cache.h
index cb47c15e975d..44c188c2fb93 100644
--- a/security/integrity/ima/ima_digest_cache.h
+++ b/security/integrity/ima/ima_digest_cache.h
@@ -15,6 +15,7 @@ void ima_digest_cache_store_allowed_usage(struct file *file,
 void ima_digest_cache_update_allowed_usage(struct file *file,
 					   struct ima_iint_cache *iint,
 					   u64 *allowed_usage);
+int ima_digest_cache_register_notifier(void);
 #else
 static inline void
 ima_digest_cache_store_allowed_usage(struct file *file,
@@ -27,4 +28,9 @@ ima_digest_cache_update_allowed_usage(struct file *file,
 				      u64 *allowed_usage)
 { }
 
+static inline int ima_digest_cache_register_notifier(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SECURITY_DIGEST_CACHE */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 7ae2bd888d41..fe826755acd1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1159,8 +1159,17 @@ static int __init init_ima(void)
 		return error;
 
 	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
-	if (error)
+	if (error) {
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
+		return error;
+	}
+
+	error = ima_digest_cache_register_notifier();
+	if (error) {
+		pr_warn("Couldn't register digest cache notifier, error %d\n",
+			error);
+		unregister_blocking_lsm_notifier(&ima_lsm_policy_notifier);
+	}
 
 	if (!error)
 		ima_update_policy_flags();
-- 
2.34.1


