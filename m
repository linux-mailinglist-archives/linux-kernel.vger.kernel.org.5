Return-Path: <linux-kernel+bounces-168366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB18BB79B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AF01F253D1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5101135A64;
	Fri,  3 May 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cV/xO2HW"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586212A169;
	Fri,  3 May 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775563; cv=none; b=QAIfx7/p/dg2RzB4l5XrPXRgO3GzOu/B5aX5tnnxGByekr4jraG3I3iP4p7fGHddxGKdH/J6ZK7Fu2WC/wyeonCvxLPXxGrAaVcMixw3V+gIvEea32K7k/xRUr5w1IZDVMoBlbZvHox2lQ95sZHGcVkD2p/QMpHY1UYZvPnh4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775563; c=relaxed/simple;
	bh=doS6xVSwKRKecKFqVeqJ5oJimrEYHnLYYejAu/Mhvag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gy7VFNMaq1FyJnoYknRDXb1z0G4luuBXs2EI5Zaadz/7Ci8IQfvKtk6ZHHYJdFnDnurYRgk/1/V/JHLn769TOFVwHIxMReNAysigvxJfZyQrMgRG7hhVlSamYCRa5Uf+k1pw/5L40YRJg8ubYj/VImEDpQbG3x66zFIu0uwnuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cV/xO2HW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id C370C20B2CB1; Fri,  3 May 2024 15:32:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C370C20B2CB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714775553;
	bh=bT6ydlb6kvTcZeK8RejYyVLUJcA52tLy7msKa1/ZS8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cV/xO2HWXItMl6vLN5hmummc9xUSuZ3kYDeITLtewUtHeHO9Q2UxzzQGjj5acGbpT
	 9PbW3yajt8ZS1pRMkMgRfj2iznjYMuru21kEGkLx6XTJr5w1mf8KD5vc8UYlTEanLF
	 LzBvTf9cNqwJ+xQk1Imf86z4Qdns6grXX20Kt2ZU=
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
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v18 18/21] scripts: add boot policy generation program
Date: Fri,  3 May 2024 15:32:28 -0700
Message-Id: <1714775551-22384-19-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Deven Bowers <deven.desai@linux.microsoft.com>

Enables an IPE policy to be enforced from kernel start, enabling access
control based on trust from kernel startup. This is accomplished by
transforming an IPE policy indicated by CONFIG_IPE_BOOT_POLICY into a
c-string literal that is parsed at kernel startup as an unsigned policy.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v2:
  + No Changes

v3:
  + No Changes

v4:
  + No Changes

v5:
  + No Changes

v6:
  + No Changes

v7:
  + Move from 01/11 to 14/16
  + Don't return errno directly.
  + Make output of script more user-friendly
  + Add escaping for tab and '?'
  + Mark argv pointer const
  + Invert return code check in the boot policy parsing code path.

v8:
  + No significant changes.

v9:
  + No changes

v10:
  + Update the init part code for rcu changes in the eval loop patch

v11:
  + Fix code style issues

v12:
  + No changes

v13:
  + No changes

v14:
  + No changes

v15:
  + Fix one grammar issue in Kconfig

v16:
  + No changes

v17:
  + Add years to license header
  + Fix code and documentation style issues

v18:
  + No changes
---
 scripts/Makefile              |   1 +
 scripts/ipe/Makefile          |   2 +
 scripts/ipe/polgen/.gitignore |   2 +
 scripts/ipe/polgen/Makefile   |   5 ++
 scripts/ipe/polgen/polgen.c   | 145 ++++++++++++++++++++++++++++++++++
 security/ipe/.gitignore       |   2 +
 security/ipe/Kconfig          |  10 +++
 security/ipe/Makefile         |  11 +++
 security/ipe/fs.c             |   8 ++
 security/ipe/ipe.c            |  12 +++
 10 files changed, 198 insertions(+)
 create mode 100644 scripts/ipe/Makefile
 create mode 100644 scripts/ipe/polgen/.gitignore
 create mode 100644 scripts/ipe/polgen/Makefile
 create mode 100644 scripts/ipe/polgen/polgen.c
 create mode 100644 security/ipe/.gitignore

diff --git a/scripts/Makefile b/scripts/Makefile
index bc90520a5426..cae8a14fa40d 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -55,6 +55,7 @@ targets += module.lds
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
+subdir-$(CONFIG_SECURITY_IPE) += ipe
 
 # Let clean descend into subdirs
 subdir-	+= basic dtc gdb kconfig mod
diff --git a/scripts/ipe/Makefile b/scripts/ipe/Makefile
new file mode 100644
index 000000000000..e87553fbb8d6
--- /dev/null
+++ b/scripts/ipe/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+subdir-y := polgen
diff --git a/scripts/ipe/polgen/.gitignore b/scripts/ipe/polgen/.gitignore
new file mode 100644
index 000000000000..b6f05cf3dc0e
--- /dev/null
+++ b/scripts/ipe/polgen/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+polgen
diff --git a/scripts/ipe/polgen/Makefile b/scripts/ipe/polgen/Makefile
new file mode 100644
index 000000000000..c20456a2f2e9
--- /dev/null
+++ b/scripts/ipe/polgen/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+hostprogs-always-y	:= polgen
+HOST_EXTRACFLAGS += \
+	-I$(srctree)/include \
+	-I$(srctree)/include/uapi \
diff --git a/scripts/ipe/polgen/polgen.c b/scripts/ipe/polgen/polgen.c
new file mode 100644
index 000000000000..c6283b3ff006
--- /dev/null
+++ b/scripts/ipe/polgen/polgen.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2024 Microsoft Corporation. All rights reserved.
+ */
+
+#include <stdlib.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+
+static void usage(const char *const name)
+{
+	printf("Usage: %s OutputFile (PolicyFile)\n", name);
+	exit(EINVAL);
+}
+
+static int policy_to_buffer(const char *pathname, char **buffer, size_t *size)
+{
+	size_t fsize;
+	size_t read;
+	char *lbuf;
+	int rc = 0;
+	FILE *fd;
+
+	fd = fopen(pathname, "r");
+	if (!fd) {
+		rc = errno;
+		goto out;
+	}
+
+	fseek(fd, 0, SEEK_END);
+	fsize = ftell(fd);
+	rewind(fd);
+
+	lbuf = malloc(fsize);
+	if (!lbuf) {
+		rc = ENOMEM;
+		goto out_close;
+	}
+
+	read = fread((void *)lbuf, sizeof(*lbuf), fsize, fd);
+	if (read != fsize) {
+		rc = -1;
+		goto out_free;
+	}
+
+	*buffer = lbuf;
+	*size = fsize;
+	fclose(fd);
+
+	return rc;
+
+out_free:
+	free(lbuf);
+out_close:
+	fclose(fd);
+out:
+	return rc;
+}
+
+static int write_boot_policy(const char *pathname, const char *buf, size_t size)
+{
+	int rc = 0;
+	FILE *fd;
+	size_t i;
+
+	fd = fopen(pathname, "w");
+	if (!fd) {
+		rc = errno;
+		goto err;
+	}
+
+	fprintf(fd, "/* This file is automatically generated.");
+	fprintf(fd, " Do not edit. */\n");
+	fprintf(fd, "#include <linux/stddef.h>\n");
+	fprintf(fd, "\nextern const char *const ipe_boot_policy;\n\n");
+	fprintf(fd, "const char *const ipe_boot_policy =\n");
+
+	if (!buf || size == 0) {
+		fprintf(fd, "\tNULL;\n");
+		fclose(fd);
+		return 0;
+	}
+
+	fprintf(fd, "\t\"");
+
+	for (i = 0; i < size; ++i) {
+		switch (buf[i]) {
+		case '"':
+			fprintf(fd, "\\\"");
+			break;
+		case '\'':
+			fprintf(fd, "'");
+			break;
+		case '\n':
+			fprintf(fd, "\\n\"\n\t\"");
+			break;
+		case '\\':
+			fprintf(fd, "\\\\");
+			break;
+		case '\t':
+			fprintf(fd, "\\t");
+			break;
+		case '\?':
+			fprintf(fd, "\\?");
+			break;
+		default:
+			fprintf(fd, "%c", buf[i]);
+		}
+	}
+	fprintf(fd, "\";\n");
+	fclose(fd);
+
+	return 0;
+
+err:
+	if (fd)
+		fclose(fd);
+	return rc;
+}
+
+int main(int argc, const char *const argv[])
+{
+	char *policy = NULL;
+	size_t len = 0;
+	int rc = 0;
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	if (argc > 2) {
+		rc = policy_to_buffer(argv[2], &policy, &len);
+		if (rc != 0)
+			goto cleanup;
+	}
+
+	rc = write_boot_policy(argv[1], policy, len);
+cleanup:
+	if (policy)
+		free(policy);
+	if (rc != 0)
+		perror("An error occurred during policy conversion: ");
+	return rc;
+}
diff --git a/security/ipe/.gitignore b/security/ipe/.gitignore
new file mode 100644
index 000000000000..07313d3fd74a
--- /dev/null
+++ b/security/ipe/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+boot-policy.c
diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index 839d63698841..7a82778f93ae 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -21,6 +21,16 @@ menuconfig SECURITY_IPE
 	  If unsure, answer N.
 
 if SECURITY_IPE
+config IPE_BOOT_POLICY
+	string "Integrity policy to apply on system startup"
+	help
+	  This option specifies a filepath to an IPE policy that is compiled
+	  into the kernel. This policy will be enforced until a policy update
+	  is deployed via the $securityfs/ipe/policies/$policy_name/active
+	  interface.
+
+	  If unsure, leave blank.
+
 menu "IPE Trust Providers"
 
 config IPE_PROP_DM_VERITY
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index e1019bb9f0f3..84ad76556170 100644
--- a/security/ipe/Makefile
+++ b/security/ipe/Makefile
@@ -5,7 +5,16 @@
 # Makefile for building the IPE module as part of the kernel tree.
 #
 
+quiet_cmd_polgen = IPE_POL $(2)
+      cmd_polgen = scripts/ipe/polgen/polgen security/ipe/boot-policy.c $(2)
+
+targets += boot-policy.c
+
+$(obj)/boot-policy.c: scripts/ipe/polgen/polgen $(CONFIG_IPE_BOOT_POLICY) FORCE
+	$(call if_changed,polgen,$(CONFIG_IPE_BOOT_POLICY))
+
 obj-$(CONFIG_SECURITY_IPE) += \
+	boot-policy.o \
 	digest.o \
 	eval.o \
 	hooks.o \
@@ -15,3 +24,5 @@ obj-$(CONFIG_SECURITY_IPE) += \
 	policy_fs.o \
 	policy_parser.o \
 	audit.o \
+
+clean-files := boot-policy.c \
diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index b52fb6023904..5b6d19fb844a 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -190,6 +190,7 @@ static const struct file_operations enforce_fops = {
 static int __init ipe_init_securityfs(void)
 {
 	int rc = 0;
+	struct ipe_policy *ap;
 
 	if (!ipe_enabled)
 		return -EOPNOTSUPP;
@@ -220,6 +221,13 @@ static int __init ipe_init_securityfs(void)
 		goto err;
 	}
 
+	ap = rcu_access_pointer(ipe_active_policy);
+	if (ap) {
+		rc = ipe_new_policyfs_node(ap);
+		if (rc)
+			goto err;
+	}
+
 	np = securityfs_create_file("new_policy", 0200, root, NULL, &np_fops);
 	if (IS_ERR(np)) {
 		rc = PTR_ERR(np);
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index da79f66b0010..5e993cbf3428 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -9,6 +9,7 @@
 #include "hooks.h"
 #include "eval.h"
 
+extern const char *const ipe_boot_policy;
 bool ipe_enabled;
 
 static struct lsm_blob_sizes ipe_blobs __ro_after_init = {
@@ -74,9 +75,20 @@ static struct security_hook_list ipe_hooks[] __ro_after_init = {
  */
 static int __init ipe_init(void)
 {
+	struct ipe_policy *p = NULL;
+
 	security_add_hooks(ipe_hooks, ARRAY_SIZE(ipe_hooks), &ipe_lsmid);
 	ipe_enabled = true;
 
+	if (ipe_boot_policy) {
+		p = ipe_new_policy(ipe_boot_policy, strlen(ipe_boot_policy),
+				   NULL, 0);
+		if (IS_ERR(p))
+			return PTR_ERR(p);
+
+		rcu_assign_pointer(ipe_active_policy, p);
+	}
+
 	return 0;
 }
 
-- 
2.44.0


