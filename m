Return-Path: <linux-kernel+bounces-85957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEF286BD98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663DD2894A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15E53362;
	Thu, 29 Feb 2024 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a9DTpU9j"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE84B376F1;
	Thu, 29 Feb 2024 00:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168129; cv=none; b=okKfCmpg4k+S4AEEY8/hNaC/MKkkF239ZehaGwSeekwy9qZa84PRuahNqat2G2Locj9cgfhME5AXLV+rwAZ/ol0Hw46GQ0kNgKR84YiQG47rr+pIY4CfGv8c/5lfKQOHaZ1Bn51YUZw0n5EO/oPtL4dslu/OS7p7mYFUnkTl0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168129; c=relaxed/simple;
	bh=7YCV8/UXYGavpae/A+HWBpVPLJOj2agylwBkz54kvDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=S+KOxdPJYXA/P/FAkBUrz61IF56pkmv4f5xA2sm+lEf+l+AhwIjIZX+kbDnNDY/6JVDfI62I7GlcS7DYCn1M/nKPonslemJP4nMfdWlVSz5ZBQJ2Bmlmor2cjEBNTI/Hmz8TJNapyayF44dvelpKvDku3DHZs16aCkk8gVGZMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a9DTpU9j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 6982420B74C2; Wed, 28 Feb 2024 16:55:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6982420B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709168119;
	bh=+3zgNW+685MFsN7HqA3hVprneZgxBQ8gcVcJZgLoxTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9DTpU9j8bNrf7npbAyCzLS+sLenhaa44GC/X1iROGdDMYvF0eydfvX1dGm/isIIo
	 BppeLxTRxybqkGNgcT44CNcJkOAX/oJtyNC/2y2RGzpeBWCJVfg3+3Znll791bJ8QH
	 3N6ZRASAxXEesLs5M+05jv5c8uAIelbhjEz3kzMQ=
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
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [RFC PATCH v13 18/20] scripts: add boot policy generation program
Date: Wed, 28 Feb 2024 16:55:00 -0800
Message-Id: <1709168102-7677-19-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1709168102-7677-1-git-send-email-wufan@linux.microsoft.com>
References: <1709168102-7677-1-git-send-email-wufan@linux.microsoft.com>
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
---
 MAINTAINERS                   |   1 +
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
 11 files changed, 199 insertions(+)
 create mode 100644 scripts/ipe/Makefile
 create mode 100644 scripts/ipe/polgen/.gitignore
 create mode 100644 scripts/ipe/polgen/Makefile
 create mode 100644 scripts/ipe/polgen/polgen.c
 create mode 100644 security/ipe/.gitignore

diff --git a/MAINTAINERS b/MAINTAINERS
index 834601f158c9..b2db91a215c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10654,6 +10654,7 @@ M:	Fan Wu <wufan@linux.microsoft.com>
 L:	linux-security-module@vger.kernel.org
 S:	Supported
 T:	git https://github.com/microsoft/ipe.git
+F:	scripts/ipe/
 F:	security/ipe/
 
 INTEL 810/815 FRAMEBUFFER DRIVER
diff --git a/scripts/Makefile b/scripts/Makefile
index 576cf64be667..1dbaf3a49aef 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -50,6 +50,7 @@ targets += module.lds
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
index 000000000000..40b6fe07f47b
--- /dev/null
+++ b/scripts/ipe/polgen/polgen.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
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
+	int rc = 0;
+	FILE *fd;
+	char *lbuf;
+	size_t fsize;
+	size_t read;
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
+	int rc = 0;
+	size_t len = 0;
+	char *policy = NULL;
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
index 9dd5c4769d79..a6c5d48dd0a3 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -18,6 +18,16 @@ menuconfig SECURITY_IPE
 	  If unsure, answer N.
 
 if SECURITY_IPE
+config IPE_BOOT_POLICY
+	string "Integrity policy to apply on system startup"
+	help
+	  This option specifies a filepath to a IPE policy that is compiled
+	  into the kernel. This policy will be enforced until a policy update
+	  is deployed via the $securityfs/ipe/policies/$policy_name/active
+	  interface.
+
+	  If unsure, leave blank.
+
 menu "IPE Trust Providers"
 
 config IPE_PROP_DM_VERITY
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index 66de53687d11..ce23101b66ba 100644
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
index b16d87443a3b..8af6e39f9914 100644
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
index 598333d3ef14..c7dc6fe5002d 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -9,6 +9,7 @@
 #include "hooks.h"
 #include "eval.h"
 
+extern const char *const ipe_boot_policy;
 bool ipe_enabled;
 
 static struct lsm_blob_sizes ipe_blobs __ro_after_init = {
@@ -73,9 +74,20 @@ static struct security_hook_list ipe_hooks[] __ro_after_init = {
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
2.43.1


