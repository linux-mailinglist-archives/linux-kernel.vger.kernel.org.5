Return-Path: <linux-kernel+bounces-105057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC36B87D8A1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A03282E50
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7BC5A0E8;
	Sat, 16 Mar 2024 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rusoHeoy"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C23EADA;
	Sat, 16 Mar 2024 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710560161; cv=none; b=bF2SvgiulMco8wKR+T+d3XomZCiyOPmVbDUKh4+i8W0c4hkH9mg/NoCcii0HVvfhat+EtBJ2SKYLMiDcv7fCSKXSaVAMdKOYAldmImyP75mQwFp/cMMA7f18fm+aI+cG4ntnjai8KIkd2ERK7RM2tLK20EqRNSK/7HRTmBPX3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710560161; c=relaxed/simple;
	bh=S/LH7AxyfK2fyOusOR2YRktF/5mKHe/1aFVmYHWd2o4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b8fuVud9jksxbjg2Lk0pY7HccRoszTgpTzTnzrydnBuQhKEeDoxm0/WQ6cTq3PMS4TA03Bm8YF3uQwbw8+sIIq8pS3GW/oP7tw/WB6gYUhLoS8vnNKPGTCFLG5XREHXzkRIVnLoMkx+tqlyOPHg8/mmR2gPJfGwhqiyuYj7ahWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rusoHeoy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id DC1CD20B74D7; Fri, 15 Mar 2024 20:35:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC1CD20B74D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710560153;
	bh=v4lY4mSJnrtZv0A6Uq6/sTuYoGyoZIJN7egWmAQun+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rusoHeoy9abWEvfXakxtms4v6DUlN+mJyWjE+AdBnyZkcB3xcvlGcb0fUfoE39Swn
	 7BMAH8f13yGQXi1s3yZ6Sdx+dUn7uEXm9qdxF9EmtBM5DaZiIUPJ+vCryUF4c7Fz4+
	 vlQhGylZN0WoLzscY4uKJkC7XnYSyYxewULX6NWs=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [RFC PATCH v15 12/21] security: add security_bdev_setintegrity() hook
Date: Fri, 15 Mar 2024 20:35:42 -0700
Message-Id: <1710560151-28904-13-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch introduces a new hook to save block device's integrity
data. For example, for dm-verity, LSMs can use this hook to save
the roothash signature of a dm-verity into the security blob,
and LSMs can make access decisions based on the data inside
the signature, like the signer certificate.

Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

--
v1-v14:
  + Not present

v15:
  + Introduced
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 14 ++++++++++++++
 security/security.c           | 28 ++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index c335404470dc..6808ae763913 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -455,4 +455,6 @@ LSM_HOOK(void, LSM_RET_VOID, initramfs_populated, void)
 
 LSM_HOOK(int, 0, bdev_alloc_security, struct block_device *bdev)
 LSM_HOOK(void, LSM_RET_VOID, bdev_free_security, struct block_device *bdev)
+LSM_HOOK(int, 0, bdev_setintegrity, struct block_device *bdev,
+	 enum lsm_intgr_type type, const void *value, size_t size)
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 9965b5c50df4..eaff8868766a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -83,6 +83,10 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+enum lsm_intgr_type {
+	__LSM_INTGR_MAX
+};
+
 /*
  * These are reasons that can be passed to the security_locked_down()
  * LSM hook. Lockdown reasons that protect kernel integrity (ie, the
@@ -511,6 +515,9 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
 int security_bdev_alloc(struct block_device *bdev);
 void security_bdev_free(struct block_device *bdev);
+int security_bdev_setintegrity(struct block_device *bdev,
+			       enum lsm_intgr_type type, const void *value,
+			       size_t size);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1495,6 +1502,13 @@ static inline void security_bdev_free(struct block_device *bdev)
 {
 }
 
+static inline int security_bdev_setintegrity(struct block_device *bdev,
+					     enum lsm_intgr_type, type,
+					     const void *value, size_t size)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index 4274bbee40d0..8d88529ac904 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5637,6 +5637,34 @@ void security_bdev_free(struct block_device *bdev)
 }
 EXPORT_SYMBOL(security_bdev_free);
 
+/**
+ * security_bdev_setintegrity() - Set the bdev's integrity data
+ * @bdev: block device
+ * @type: type of integrity, e.g. hash digest, signature, etc
+ * @value: the integrity value
+ * @size: size of the integrity value
+ *
+ * Register a verified integrity measurement of a bdev with the LSM.
+ *
+ * Return: Returns 0 on success, negative values on failure.
+ */
+int security_bdev_setintegrity(struct block_device *bdev,
+			       enum lsm_intgr_type type, const void *value,
+			       size_t size)
+{
+	int rc = 0;
+	struct security_hook_list *p;
+
+	hlist_for_each_entry(p, &security_hook_heads.bdev_setintegrity, list) {
+		rc = p->hook.bdev_setintegrity(bdev, type, value, size);
+		if (rc)
+			return rc;
+	}
+
+	return LSM_RET_DEFAULT(bdev_setintegrity);
+}
+EXPORT_SYMBOL(security_bdev_setintegrity);
+
 #ifdef CONFIG_PERF_EVENTS
 /**
  * security_perf_event_open() - Check if a perf event open is allowed
-- 
2.44.0


