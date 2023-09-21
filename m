Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E067AA18A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjIUVDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjIUVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:02:50 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71BAFFBF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:30 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RrlY91sQLzMpnTw;
        Thu, 21 Sep 2023 06:17:01 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RrlY85V4rzMpnPj;
        Thu, 21 Sep 2023 08:17:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1695277021;
        bh=0yxdKsrrn283gB/3X+vWCGUVPztG5L56CxeUEdJPWtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fj5Ru4uW6OQ7QjgtJyzjur3mooTtOBgfvlxfyD0fUPgvpHFo+5+6Tq6bGWuvIYHAJ
         3f0SDzTMFCXwFcCek1QH0jplv7pHnCJiAwsv05UctrD0e7DyBkygZF+Qta5eL0F117
         7BnDLAgkUqYPsQ9XuCYFnzAXcQXC/dOT0TK3VtF0=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Ben Scarlato <akhna@google.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 3/7] landlock: Log ruleset creation and release
Date:   Thu, 21 Sep 2023 08:16:37 +0200
Message-ID: <20230921061641.273654-4-mic@digikod.net>
In-Reply-To: <20230921061641.273654-1-mic@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audit support for ruleset/domain creation and release. Ruleset and
domain IDs are generated from the same 64-bit counter to avoid confusing
them. There is no need to hide the sequentiality to users that are
already allowed to read logs.  In the future, if these IDs were to be
viewable by unprivileged users, then we'll need to scramble them.

Add a new AUDIT_LANDLOCK record type.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/uapi/linux/audit.h   |   1 +
 security/landlock/Makefile   |   2 +
 security/landlock/audit.c    | 119 +++++++++++++++++++++++++++++++++++
 security/landlock/audit.h    |  35 +++++++++++
 security/landlock/ruleset.c  |   6 ++
 security/landlock/ruleset.h  |  10 +++
 security/landlock/syscalls.c |   8 +++
 7 files changed, 181 insertions(+)
 create mode 100644 security/landlock/audit.c
 create mode 100644 security/landlock/audit.h

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index d676ed2b246e..385e134277b1 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -122,6 +122,7 @@
 #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
 #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
 #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
+#define AUDIT_LANDLOCK		1340	/* Landlock event */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 7bbd2f413b3e..c3e048df7fec 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -2,3 +2,5 @@ obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
 landlock-y := setup.o syscalls.o object.o ruleset.o \
 	cred.o ptrace.o fs.o
+
+landlock-$(CONFIG_AUDIT) += audit.o
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
new file mode 100644
index 000000000000..f58bd529784a
--- /dev/null
+++ b/security/landlock/audit.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Audit helpers
+ *
+ * Copyright © 2023 Microsoft Corporation
+ */
+
+#include <linux/atomic.h>
+#include <linux/audit.h>
+#include <linux/lsm_audit.h>
+
+#include "audit.h"
+#include "cred.h"
+
+atomic64_t ruleset_and_domain_counter = ATOMIC64_INIT(0);
+
+#define BIT_INDEX(bit) HWEIGHT(bit - 1)
+
+static void log_accesses(struct audit_buffer *const ab,
+			 const access_mask_t accesses)
+{
+	const char *const desc[] = {
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = "execute",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = "write_file",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = "read_file",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] = "read_dir",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] = "remove_dir",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_FILE)] = "remove_file",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_CHAR)] = "make_char",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_DIR)] = "make_dir",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] = "make_reg",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SOCK)] = "make_sock",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_FIFO)] = "make_fifo",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_BLOCK)] = "make_block",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SYM)] = "make_sym",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "refer",
+		[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "truncate",
+	};
+	const unsigned long access_mask = accesses;
+	unsigned long access_bit;
+	bool is_first = true;
+
+	BUILD_BUG_ON(ARRAY_SIZE(desc) != LANDLOCK_NUM_ACCESS_FS);
+
+	for_each_set_bit(access_bit, &access_mask, ARRAY_SIZE(desc)) {
+		audit_log_format(ab, "%s%s", is_first ? "" : ",",
+				 desc[access_bit]);
+		is_first = false;
+	}
+}
+
+/* Inspired by dump_common_audit_data(). */
+static void log_task(struct audit_buffer *const ab)
+{
+	/* 16 bytes (TASK_COMM_LEN) */
+	char comm[sizeof(current->comm)];
+
+	/*
+	 * Uses task_pid_nr() instead of task_tgid_nr() because of how
+	 * credentials and Landlock work.
+	 */
+	audit_log_format(ab, "tid=%d comm=", task_pid_nr(current));
+	audit_log_untrustedstring(ab,
+				  memcpy(comm, current->comm, sizeof(comm)));
+}
+
+void landlock_log_create_ruleset(struct landlock_ruleset *const ruleset)
+{
+	struct audit_buffer *ab;
+
+	WARN_ON_ONCE(ruleset->id);
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LANDLOCK);
+	if (!ab)
+		/* audit_log_lost() call */
+		return;
+
+	ruleset->id = atomic64_inc_return(&ruleset_and_domain_counter);
+	log_task(ab);
+	audit_log_format(ab,
+			 " op=create-ruleset ruleset=%llu handled_access_fs=",
+			 ruleset->id);
+	log_accesses(ab, ruleset->fs_access_masks[ruleset->num_layers - 1]);
+	audit_log_end(ab);
+}
+
+/*
+ * This is useful to know when a domain or a ruleset will never show again in
+ * the audit log.
+ */
+void landlock_log_release_ruleset(const struct landlock_ruleset *const ruleset)
+{
+	struct audit_buffer *ab;
+	const char *name;
+	u64 id;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LANDLOCK);
+	if (!ab)
+		/* audit_log_lost() call */
+		return;
+
+	/* It should either be a domain or a ruleset. */
+	if (ruleset->hierarchy) {
+		name = "domain";
+		id = ruleset->hierarchy->id;
+		WARN_ON_ONCE(ruleset->id);
+	} else {
+		name = "ruleset";
+		id = ruleset->id;
+	}
+	WARN_ON_ONCE(!id);
+
+	/*
+	 * Because this might be called by kernel threads, logging
+	 * related task information with log_task() would be useless.
+	 */
+	audit_log_format(ab, "op=release-%s %s=%llu", name, name, id);
+	audit_log_end(ab);
+}
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
new file mode 100644
index 000000000000..2666e9151627
--- /dev/null
+++ b/security/landlock/audit.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Audit helpers
+ *
+ * Copyright © 2023 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_AUDIT_H
+#define _SECURITY_LANDLOCK_AUDIT_H
+
+#include <linux/audit.h>
+#include <linux/lsm_audit.h>
+
+#include "ruleset.h"
+
+#ifdef CONFIG_AUDIT
+
+void landlock_log_create_ruleset(struct landlock_ruleset *const ruleset);
+void landlock_log_release_ruleset(const struct landlock_ruleset *const ruleset);
+
+#else /* CONFIG_AUDIT */
+
+static inline void
+landlock_log_create_ruleset(struct landlock_ruleset *const ruleset)
+{
+}
+
+static inline void
+landlock_log_release_ruleset(const struct landlock_ruleset *const ruleset)
+{
+}
+
+#endif /* CONFIG_AUDIT */
+
+#endif /* _SECURITY_LANDLOCK_AUDIT_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 996484f98bfd..585ee0f77e67 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
+#include "audit.h"
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
@@ -379,6 +380,11 @@ static void free_ruleset_work(struct work_struct *const work)
 	struct landlock_ruleset *ruleset;
 
 	ruleset = container_of(work, struct landlock_ruleset, work_free);
+
+	/* Only called by hook_cred_free(), hence for a domain. */
+	WARN_ON_ONCE(!ruleset->hierarchy);
+	landlock_log_release_ruleset(ruleset);
+
 	free_ruleset(ruleset);
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 55b1df8f66a8..c74f1ab60c33 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -74,6 +74,11 @@ struct landlock_rule {
  * struct landlock_hierarchy - Node in a ruleset hierarchy
  */
 struct landlock_hierarchy {
+#ifdef CONFIG_AUDIT
+	/* domain's ID */
+	u64 id;
+#endif /* CONFIG_AUDIT */
+
 	/**
 	 * @parent: Pointer to the parent node, or NULL if it is a root
 	 * Landlock domain.
@@ -93,6 +98,11 @@ struct landlock_hierarchy {
  * match an object.
  */
 struct landlock_ruleset {
+#ifdef CONFIG_AUDIT
+	/* ruleset's ID, must be 0 for a domain */
+	u64 id;
+#endif /* CONFIG_AUDIT */
+
 	/**
 	 * @root: Root of a red-black tree containing &struct landlock_rule
 	 * nodes.  Once a ruleset is tied to a process (i.e. as a domain), this
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 245cc650a4dc..373997a356e7 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -26,6 +26,7 @@
 #include <linux/uaccess.h>
 #include <uapi/linux/landlock.h>
 
+#include "audit.h"
 #include "cred.h"
 #include "fs.h"
 #include "limits.h"
@@ -98,6 +99,10 @@ static int fop_ruleset_release(struct inode *const inode,
 {
 	struct landlock_ruleset *ruleset = filp->private_data;
 
+	/* Only called by ruleset_fops, hence for a ruleset. */
+	WARN_ON_ONCE(ruleset->hierarchy);
+	landlock_log_release_ruleset(ruleset);
+
 	landlock_put_ruleset(ruleset);
 	return 0;
 }
@@ -198,6 +203,9 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 				      ruleset, O_RDWR | O_CLOEXEC);
 	if (ruleset_fd < 0)
 		landlock_put_ruleset(ruleset);
+	else
+		landlock_log_create_ruleset(ruleset);
+
 	return ruleset_fd;
 }
 
-- 
2.42.0

