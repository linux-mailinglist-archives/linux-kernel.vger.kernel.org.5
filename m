Return-Path: <linux-kernel+bounces-123558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57EB890B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F96F298762
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193513E3F3;
	Thu, 28 Mar 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HPBsuWKq"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E90B13A26B;
	Thu, 28 Mar 2024 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657053; cv=none; b=AS7cCS5zsOtMvS2tU5/CV0AvOcSEB5yqmJsnlSqEUWyDi2VOvmgkIDV3lMMB4IffZIFE3P72Vaqz0j7l+KUIexqY+eKotFUyyZIfBdc544rOWR99tJw3qqHyZi8ALFI6N9jhzocjHcgB00Ltz1Y3WUWoxraOqYGg4CAMfM0YUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657053; c=relaxed/simple;
	bh=SdetzVMvhRxs2WUTB+Ae9frL1BFCiK7sqJkKj6Jsa1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Go1dT8R7kIp1H+aIDbbcPl/20YGtEuFRmM1kg6B3TIhJYBGnrNwzUiVlqdwGO5gcgtumJldjU+d6lr7tBfF3JJMAM1ZmzlKmjcAGqX6Gy37IuEcg8Y1E7EPY+ZpJvAd2kmJfyrMZIAzynmpvTL8d3vqg5/zEpIV9A9HnnBgM9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HPBsuWKq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id A26AA20E6F16; Thu, 28 Mar 2024 13:17:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A26AA20E6F16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711657048;
	bh=I5IovGY4Trx3cdUoHZFFX39nSrI+4UswhCur+YYRSYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPBsuWKqRQ0PSrqRUPvzKVCbzZE6CrkS+eQrrJm+zYStnO7fn5DDWrBO3FC3z9ehT
	 gYTTnZT+hSz0NcpYx8FE9oUJ8ojHY7zpUR38kgfzMZ9d/q4giefaRzuVpCC7n1MaV4
	 ZOCa2zJCbQS6/Fw1Kx7GqaBtn5i0V+D0u1NCR4qY=
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
Subject: [PATCH v16 05/20] initramfs|security: Add a security hook to do_populate_rootfs()
Date: Thu, 28 Mar 2024 13:17:12 -0700
Message-Id: <1711657047-10526-6-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
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

v14:
  + No changes

v15:
  + No changes

v16:
  + No changes
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 init/initramfs.c              |  3 +++
 security/security.c           | 10 ++++++++++
 4 files changed, 23 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 334e00efbde4..7db99ae75651 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -450,3 +450,5 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+LSM_HOOK(void, LSM_RET_VOID, initramfs_populated, void)
diff --git a/include/linux/security.h b/include/linux/security.h
index 41a8f667bdfa..14fff542f2e3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2255,4 +2255,12 @@ static inline int security_uring_cmd(struct io_uring_cmd *ioucmd)
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
index 3127e0bf7bbd..e2e40792dd00 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -17,6 +17,7 @@
 #include <linux/namei.h>
 #include <linux/init_syscalls.h>
 #include <linux/umh.h>
+#include <linux/security.h>
 
 #include "do_mounts.h"
 
@@ -719,6 +720,8 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 #endif
 	}
 
+	security_initramfs_populated();
+
 done:
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
diff --git a/security/security.c b/security/security.c
index 287bfac6b471..b10230c51c0b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5675,3 +5675,13 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
 	return call_int_hook(uring_cmd, ioucmd);
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
2.44.0


