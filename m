Return-Path: <linux-kernel+bounces-168352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DACB8BB785
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1C31C24524
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8258712E1C4;
	Fri,  3 May 2024 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OV5ul+y7"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7343D84A3B;
	Fri,  3 May 2024 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775558; cv=none; b=qUsiyGn0SMLmbm/TMV9OwIMcKPBEHIrw8HugK73VEA4je+9zpgziMedrEBhy5Q4mQyIfShEYvVSFXXllHTDE7zrnzQiy4SIrStMks7lNgjsiRt1YZJFXDeOw1+0ThfxGXTp0I7uYKwF79uFAkKCqDf/AHTNvl5fpT3CAVXbWvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775558; c=relaxed/simple;
	bh=ERgJ8QErBUAs4aXAUkvI6rZWtRqnWzQyU4fW533RFBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uh+o4HbFignBiFCTKFne3xmmIeeieQFJVgze96TPwYMugEpceIovemVtxkLH5VL9/wgRqmGVreYo3dz4gOs4ja2/qOLbrshux47pwopHk5z0GV37DGm/HN3q++YJ2YnuvPQkOdRZM8ktJkxwHl1o8/Cs9ayrsad3WK6KQM1MwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OV5ul+y7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 0C0DD20B2C8C; Fri,  3 May 2024 15:32:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C0DD20B2C8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714775553;
	bh=Dxk0LOJviWIwuTaOZglimpTmOofJidRSrYvWDmc1i8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OV5ul+y7s8WwrLl9txdIPcmvRvmJq/Rhse2pb1HcDYNLMbHklL/osaVs/cKOEBD3R
	 4opiI8M12oOCkPa4WDl3byxBhn8wSKywl+0U0fzQLvqI8KB1Mc+FbCxezfSx9zOMIH
	 B74R47Scfd/GpPa2BUyFScfV3HqwournECQoHAKc=
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
Subject: [PATCH v18 05/21] initramfs|security: Add a security hook to do_populate_rootfs()
Date: Fri,  3 May 2024 15:32:15 -0700
Message-Id: <1714775551-22384-6-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
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

v17:
  + Fix ocumentation style issues

v18:
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
index a298a3854a80..feedb47d0f55 100644
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
index 820e0d437452..0db5a6b32aab 100644
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


