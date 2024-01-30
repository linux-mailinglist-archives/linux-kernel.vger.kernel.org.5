Return-Path: <linux-kernel+bounces-45410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB708843002
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9980D28817D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED27F478;
	Tue, 30 Jan 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kb3osDtA"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8467AE58;
	Tue, 30 Jan 2024 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706654247; cv=none; b=TRoFg1JJybm+0VC2tjOu0g/87whaOKSMgtLsL+9nymxPBDe8o1xnasiOSR0J8fiU32IpdVpihRPBiesQ+nx3/cIu2TA2uc9F1HBwk9PEhGMGHvUx6A12w6WEEZzSjp8a4pHG7SYpBDk8uy5HaUHT6cwdem63e1yNY9WV1W1OPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706654247; c=relaxed/simple;
	bh=0RImSfWDsuyQqbPQ7O0zuTEsVGxwEIfo2Pi/EPZFoTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ps/rhGejO1JIStjD60J1ise5JYXF04ODRJSKXv4shiKQY/DxGAGSw9k+AfJzAJRShlL2/rQLyZMMdvHPW7D0nnDOE1h1DtDduVxpx+IdGg9ZIHC3qRm1QLe8BvbwPTG0V16L/qXYrUP4Pqku8YxIujQAcXacT1JyQK8PlKhG2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kb3osDtA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 3453420B2007; Tue, 30 Jan 2024 14:37:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3453420B2007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706654242;
	bh=EWbimXT3r5uH71kUC3HLmOsJ78VUidHK3BehWmfo0EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kb3osDtAmHwsOccuH9u6TwU95Jq8JuBfHnVuQZHYmd26ntOZz8M+uWn+Y3ybxzpAN
	 B/hiT0nHXepAgKg417YnwMJC06UjaF8Wa03agztD+UqzRFqE2kvIp4nmlGHcftqHCP
	 O0DOL0rH2JeRXb7Z/u9Z9gfBbUMXbJZ5LNMD40uI=
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
	linux-fscrypt@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [RFC PATCH v12 05/20] initramfs|security: Add security hook to initramfs unpack
Date: Tue, 30 Jan 2024 14:36:53 -0800
Message-Id: <1706654228-17180-6-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1706654228-17180-1-git-send-email-wufan@linux.microsoft.com>
References: <1706654228-17180-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch introduces a new hook to notify security system that the
content of initramfs has been unpacked into the rootfs.

Upon receiving this notification, the security system can activate
a policy to allow only files that originated from the initramfs to
execute or load into kernel during the early stages of booting.

This approach is crucial for minimizing the attack surface by
ensuring that only trusted files from the initramfs are operational
in the critical boot phase.

Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v1-v11:
  + Not present

v12:
  + Introduced
---
 include/linux/lsm_hook_defs.h |  4 ++++
 include/linux/security.h      | 10 ++++++++++
 init/initramfs.c              |  3 +++
 security/security.c           | 12 ++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 185924c56378..b247388786a9 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -425,3 +425,7 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+#ifdef CONFIG_BLK_DEV_INITRD
+LSM_HOOK(void, LSM_RET_VOID, unpack_initramfs_security, void)
+#endif /* CONFIG_BLK_DEV_INITRD */
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..1545c69edc1b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2167,4 +2167,14 @@ static inline int security_uring_cmd(struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_IO_URING */
 
+#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_SECURITY
+extern void security_unpack_initramfs(void);
+#else
+static inline void security_unpack_initramfs(void)
+{
+}
+#endif /* CONFIG_SECURITY */
+#endif /* CONFIG_BLK_DEV_INITRD */
+
 #endif /* ! __LINUX_SECURITY_H */
diff --git a/init/initramfs.c b/init/initramfs.c
index 76deb48c38cb..075a5794cde5 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -18,6 +18,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/task_work.h>
 #include <linux/umh.h>
+#include <linux/security.h>
 
 static __initdata bool csum_present;
 static __initdata u32 io_csum;
@@ -720,6 +721,8 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 #endif
 	}
 
+	security_unpack_initramfs();
+
 done:
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
diff --git a/security/security.c b/security/security.c
index ddf2e69cf8f2..2a527d4c69bc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5581,3 +5581,15 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
 	return call_int_hook(uring_cmd, 0, ioucmd);
 }
 #endif /* CONFIG_IO_URING */
+
+#ifdef CONFIG_BLK_DEV_INITRD
+/**
+ * security_unpack_initramfs() - Notify LSM that initramfs has been loaded
+ *
+ * Tells the LSM the initramfs has been unpacked into the rootfs.
+ */
+void security_unpack_initramfs(void)
+{
+	call_void_hook(unpack_initramfs_security);
+}
+#endif /* CONFIG_BLK_DEV_INITRD */
-- 
2.43.0


