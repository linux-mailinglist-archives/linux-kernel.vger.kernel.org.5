Return-Path: <linux-kernel+bounces-85947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA086BD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A6C2890B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29B47F73;
	Thu, 29 Feb 2024 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iRkvDQkw"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1AA22098;
	Thu, 29 Feb 2024 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168124; cv=none; b=mU29nhOSzMJAIUA+kLU23T7rO6OhsM9c9bYwPsLASe1NP01dTSEcu10pgzvomcFl+uSprK2Fw37SOFchE4OAe4qiOM2LaAVqWVtGK7sh4QnSnm3keQq60557HK2PXPyDktxqeg4utKfYTZRj5hEwDlxzddkQLs3c08eksm5F2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168124; c=relaxed/simple;
	bh=ry6VNps+C1jqPco6oBxdJzTGlVMWTYfrQw9rn8qaGcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Tu7JIot50yxuIk/IhFSDmzt/2fxnXCrX/Ynn6FGH98FmqscQmUCafiHfkeI+6iDufqdXfChZKeuajbd48H4QCrDRlaxrs7YTu67hKRFaAjPoaCaBSAVGL7JW88JfSjzjK3fFhBOmd8KkmE6WbBf1h5JFBqBWkCSPZgy2mnZnYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iRkvDQkw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id A98F320B74C9; Wed, 28 Feb 2024 16:55:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A98F320B74C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709168118;
	bh=keuncve5ufcLxN1qQVY50ZBjqsggfgwUiZs7fdIORow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRkvDQkwchOJNBh5q+PAvkzxaYkW/TN3IWELkPSPlxmm8h6VDniASZkLdcrwyHJhy
	 EpdzG+QlOqOUo31ESE0My20z/b/sNtij5M32e8f4YLd3HMzBTO7kGcFAcEMujEK/A7
	 aD4rE3GNLhfdbTBopuoYHqUcny0bS5SPjKj8aHvw=
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
Subject: [RFC PATCH v13 05/20] initramfs|security: Add a security hook to do_populate_rootfs()
Date: Wed, 28 Feb 2024 16:54:47 -0800
Message-Id: <1709168102-7677-6-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1709168102-7677-1-git-send-email-wufan@linux.microsoft.com>
References: <1709168102-7677-1-git-send-email-wufan@linux.microsoft.com>
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

v13:
  + Rename the hook name to initramfs_populated()
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 init/initramfs.c              |  3 +++
 security/security.c           | 10 ++++++++++
 4 files changed, 23 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 76458b6d53da..e0f50789a18f 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -425,3 +425,5 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+LSM_HOOK(void, LSM_RET_VOID, initramfs_populated, void)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..619e17e59532 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2167,4 +2167,12 @@ static inline int security_uring_cmd(struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_IO_URING */
 
+#ifdef CONFIG_SECURITY
+extern void security_initramfs_populated(void);
+#else
+static inline void security_initramfs_populated(void)
+{
+}
+#endif /* CONFIG_SECURITY */
+
 #endif /* ! __LINUX_SECURITY_H */
diff --git a/init/initramfs.c b/init/initramfs.c
index 76deb48c38cb..140619a583ff 100644
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
 
+	security_initramfs_populated();
+
 done:
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
diff --git a/security/security.c b/security/security.c
index f168bc30a60d..26c28db211fd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5619,3 +5619,13 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
 	return call_int_hook(uring_cmd, 0, ioucmd);
 }
 #endif /* CONFIG_IO_URING */
+
+/**
+ * security_initramfs_populated() - Notify LSMs that initramfs has been loaded
+ *
+ * Tells the LSMs the initramfs has been unpacked into the rootfs.
+ */
+void security_initramfs_populated(void)
+{
+	call_void_hook(initramfs_populated);
+}
-- 
2.43.1


