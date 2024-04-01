Return-Path: <linux-kernel+bounces-126614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C22893A6A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DDC1F21585
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE60A3D57A;
	Mon,  1 Apr 2024 10:50:50 +0000 (UTC)
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61B1F602;
	Mon,  1 Apr 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968643; cv=none; b=r/mYNWZ0RHyK4keIPqGpkJl44BjOQDAXioAWoWKR/SnGsgD6sr5W1mTpghnUf5+VDhAmBJcp0J2jqEuvwNG6SrxYfhnE94k+Q3zfAjwlmqYeLqw0PpgSNXjV3otZ1RVzy0psjFznVaiMGeSwc4I65IesjVHeucD2ORs+3fS9i2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968643; c=relaxed/simple;
	bh=rKA97AfLu+GZMaIe6Uihngh6PVvcaxh9X9H0L6lGIvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGjDEytVImxBmLlGgXr7UM3k31VoACSqu4iCLVaMK8bFp6JI2tcWvVn47IA9E3oOUJ/d8W3DwVWkjDng5tEx2D/7Qd3eZbry0WcdVaCe//A+i78uqiD7lsDPKc/i7fjFoakph4yMKMX1hfhojzoOQfQIigOBcb+ZWTATC3OJmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 431AoMeY027678;
	Mon, 1 Apr 2024 05:50:22 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 431AoMdj027676;
	Mon, 1 Apr 2024 05:50:22 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v3 06/12] Implement TSEM control plane.
Date: Mon,  1 Apr 2024 05:50:09 -0500
Message-Id: <20240401105015.27614-7-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240401105015.27614-1-greg@enjellic.com>
References: <20240401105015.27614-1-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. Greg" <greg@enjellic.com>

The fs.c file contains the implementation of the TSEM control
plane that is surfaced through the following directory heirarchy
in the securityfs filesystem mount

/sys/kernel/security/tsem

The following file documents the interfaces provided by the
control plane:

Documentation/ABI/testing/tsem

The directory heirarchy partitions into the following two
branches

/sys/kernel/security/tsem/internal_tma

/sys/kernel/security/tsem/external_tma

Where the internal_tma directory surfaces the characteristics of
the in kernel Trusted Modeling Agent implementation.

When an externally modeled namespace is created a file is created
in the external_tma directory that is named for the security
context identifier of the namespace that was created.  An
external trust orchestrator uses this file to read security
events that occur in the context of the namespace.

This file also contains the functionality that generates the JSON
encoded security event descriptions.  These descriptions encode
the information used as input to TSEM security models.
---
 security/tsem/fs.c | 2288 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2288 insertions(+)
 create mode 100644 security/tsem/fs.c

diff --git a/security/tsem/fs.c b/security/tsem/fs.c
new file mode 100644
index 000000000000..171ac3a37dd5
--- /dev/null
+++ b/security/tsem/fs.c
@@ -0,0 +1,2288 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2024 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * This file implements the TSEM control plane that is surfaced
+ * through the following directory heirarchy:
+ *
+ * /sys/kernel/security/tsem
+ *
+ * The TSEM ABI documentation documents the directories and files that
+ * are implemented in this directory heirarchy.
+ *
+ * A significant portion of the functions in this file are used to
+ * generate the JSON encoding of a security event description.  This
+ * encoding is surfaced to the tsem_export_show() function through the
+ * tsem_fs_show_trajectory() function.  This latter function is also
+ * used by the trajectory and forensics pseudo files that output the
+ * characteristics of security events modeled by the internal trusted
+ * modeling agent implementation.
+ *
+ * The pseudo-files implemented are context sensitive in that they
+ * provide output describing the security modeling namespace that the
+ * process that accesses the file is running in.
+ */
+
+#include <linux/seq_file.h>
+#include <linux/poll.h>
+
+#include "tsem.h"
+
+static struct dentry *tsem_dir;
+static struct dentry *control;
+static struct dentry *id;
+static struct dentry *aggregate;
+static struct dentry *internal_tma;
+static struct dentry *model;
+static struct dentry *forensics;
+static struct dentry *forensics_counts;
+static struct dentry *forensics_coeff;
+static struct dentry *trajectory;
+static struct dentry *trajectory_counts;
+static struct dentry *trajectory_coeff;
+static struct dentry *measurement;
+static struct dentry *state;
+static struct dentry *external_tma;
+
+struct control_commands {
+	char *cmd;
+	enum tsem_control_type type;
+};
+
+static const char * const control_commands[] = {
+	"internal",
+	"external",
+	"export",
+	"enforce",
+	"seal",
+	"trusted",
+	"untrusted",
+	"state",
+	"pseudonym",
+	"base"
+};
+
+enum namespace_argument_type {
+	NS_REF = 0,
+	NS_DIGEST,
+	NS_KEY,
+	NS_CACHE
+};
+
+static const char * const namespace_arguments[] = {
+	"nsref",
+	"digest",
+	"key",
+	"cache"
+};
+
+enum control_argument_type {
+	CONTROL_KEY = 0,
+	CONTROL_PID
+};
+
+static const char * const control_arguments[] = {
+	"key",
+	"pid"
+};
+
+static bool can_access_fs(void)
+{
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (ctx->external)
+		return false;
+	if (capable(CAP_MAC_ADMIN))
+		return true;
+	if (ctx->sealed)
+		return false;
+	return true;
+}
+
+static int control_COE(unsigned long cmd, pid_t pid, char *keystr)
+{
+	bool wakeup = false;
+	int retn = -ESRCH;
+	u8 event_key[HASH_MAX_DIGESTSIZE];
+	struct task_struct *COE;
+	struct tsem_task *task;
+	struct tsem_task *tma = tsem_task(current);
+
+	rcu_read_lock();
+	COE = find_task_by_vpid(pid);
+	if (COE != NULL) {
+		task = tsem_task(COE);
+		if (tsem_context(COE)->id != tma->tma_for_ns) {
+			retn = -EINVAL;
+			goto done;
+		}
+
+		retn = tsem_ns_event_key(task->task_key, keystr, event_key);
+		if (retn)
+			goto done;
+
+		if (memcmp(tma->task_key, event_key, tsem_digestsize())) {
+			retn = -EINVAL;
+			goto done;
+		}
+
+		if (cmd == TSEM_CONTROL_UNTRUSTED)
+			task->trust_status = TSEM_TASK_UNTRUSTED;
+		if (cmd == TSEM_CONTROL_TRUSTED) {
+			task->trust_status &= ~TSEM_TASK_TRUST_PENDING;
+			if (tsem_task_trusted(COE))
+				task->trust_status = TSEM_TASK_TRUSTED;
+		}
+		retn = 0;
+		wakeup = true;
+	}
+
+ done:
+	rcu_read_unlock();
+
+	if (retn == -EINVAL)
+		pr_warn("tsem: Invalid process release request.\n");
+
+	if (wakeup)
+		wake_up_process(COE);
+
+	return retn;
+}
+
+static int config_COE(unsigned long cmd, char *arg)
+{
+	char **argv, *argp, *key = NULL;
+	int argc, retn = -EINVAL;
+	unsigned int lp;
+	long pid = 0;
+	enum control_argument_type control_arg;
+
+	if (!*arg)
+		return retn;
+
+	argv = argv_split(GFP_KERNEL, arg, &argc);
+	if (!argv)
+		return -ENOMEM;
+
+	for (lp = 0; lp < argc; ++lp) {
+		argp = strchr(argv[lp], '=');
+		if (!argp)
+			goto done;
+		*argp++ = '\0';
+
+		control_arg = match_string(control_arguments,
+					   ARRAY_SIZE(control_arguments),
+					   argv[lp]);
+		if (control_arg < 0)
+			goto done;
+
+		switch (control_arg) {
+		case CONTROL_KEY:
+			key = argp;
+			if (strlen(key) != tsem_digestsize()*2)
+				goto done;
+			break;
+		case CONTROL_PID:
+			if (kstrtol(argp, 0, &pid))
+				goto done;
+			break;
+		}
+	}
+
+	if (!key || !pid)
+		goto done;
+	retn = control_COE(cmd, pid, key);
+
+ done:
+	argv_free(argv);
+	return retn;
+}
+
+static int config_context(unsigned long cmd, char *bufr)
+{
+	int retn = -EINVAL;
+	unsigned int lp;
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (ctx->sealed)
+		return -EPERM;
+
+	if (cmd == TSEM_CONTROL_SEAL) {
+		ctx->sealed = true;
+		retn = 0;
+	}
+
+	if (cmd == TSEM_CONTROL_ENFORCE) {
+		for (lp = 0; lp < ARRAY_SIZE(tsem_root_actions); ++lp)
+			ctx->actions[lp] = TSEM_ACTION_EPERM;
+		retn = 0;
+	}
+
+	return retn;
+}
+
+static int config_point(enum tsem_control_type type, char *arg)
+{
+	char *argp;
+	int retn = -EINVAL;
+	u8 mapping[HASH_MAX_DIGESTSIZE];
+
+	if (!arg)
+		goto done;
+
+	argp = strchr(arg, '=');
+	if (!argp)
+		goto done;
+	*argp++ = '\0';
+
+	if (strcmp(arg, "value"))
+		goto done;
+
+	if (strlen(argp) != tsem_digestsize()*2)
+		goto done;
+	if (hex2bin(mapping, argp, tsem_digestsize()))
+		goto done;
+
+	if (type == TSEM_CONTROL_MAP_STATE)
+		retn = tsem_model_load_point(mapping);
+	else if (type == TSEM_CONTROL_MAP_PSEUDONYM)
+		retn = tsem_model_load_pseudonym(mapping);
+	else {
+		tsem_model_load_base(mapping);
+		retn = 0;
+	}
+
+ done:
+	return retn;
+}
+
+static int config_namespace(enum tsem_control_type type, const char *arg)
+{
+	char **argv, *argp, *digest = "sha256", *key = NULL;
+	int argc, retn = -EINVAL;
+	unsigned int lp, cache_size = TSEM_MAGAZINE_SIZE_INTERNAL;
+	enum namespace_argument_type ns_arg;
+	enum tsem_ns_reference ns_ref = TSEM_NS_INITIAL;
+
+	if (type == TSEM_CONTROL_EXTERNAL || type == TSEM_CONTROL_EXPORT)
+		cache_size = TSEM_MAGAZINE_SIZE_EXTERNAL;
+
+	if (!arg) {
+		if (type == TSEM_CONTROL_EXTERNAL)
+			return retn;
+		return tsem_ns_create(type, digest, ns_ref, key, cache_size);
+	}
+
+	argv = argv_split(GFP_KERNEL, arg, &argc);
+	if (!argv)
+		return -ENOMEM;
+
+	for (lp = 0; lp < argc; ++lp) {
+		argp = strchr(argv[lp], '=');
+		if (!argp)
+			goto done;
+		*argp++ = '\0';
+
+		ns_arg = match_string(namespace_arguments,
+				    ARRAY_SIZE(namespace_arguments), argv[lp]);
+		if (ns_arg < 0)
+			goto done;
+
+		switch (ns_arg) {
+		case NS_REF:
+			if (!strcmp(argp, "current"))
+				ns_ref = TSEM_NS_CURRENT;
+			else if (!strcmp(argp, "initial"))
+				ns_ref = TSEM_NS_INITIAL;
+			else
+				goto done;
+			break;
+		case NS_DIGEST:
+			digest = argp;
+			if (!crypto_has_shash(digest, 0, 0))
+				goto done;
+			break;
+		case NS_KEY:
+			key = argp;
+			if (strlen(key) % 2)
+				goto done;
+			break;
+		case NS_CACHE:
+			if (kstrtouint(argp, 0, &cache_size))
+				goto done;
+			if (!cache_size)
+				goto done;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (type == TSEM_CONTROL_EXTERNAL && !key)
+		goto done;
+
+	retn = tsem_ns_create(type, digest, ns_ref, key, cache_size);
+
+ done:
+	argv_free(argv);
+	return retn;
+}
+
+static void show_creds(struct seq_file *c, char *key, char *term,
+		       struct tsem_COE *cp)
+{
+	tsem_fs_show_field(c, key);
+	tsem_fs_show_key(c, "uid", ",", "%u", cp->uid);
+	tsem_fs_show_key(c, "euid", ",", "%u", cp->euid);
+	tsem_fs_show_key(c, "suid", ",", "%u", cp->suid);
+	tsem_fs_show_key(c, "gid", ",", "%u", cp->gid);
+	tsem_fs_show_key(c, "egid", ",", "%u", cp->egid);
+	tsem_fs_show_key(c, "sgid", ",", "%u", cp->sgid);
+	tsem_fs_show_key(c, "fsuid", ",", "%u", cp->fsuid);
+	tsem_fs_show_key(c, "fsgid", ",", "%u", cp->fsgid);
+	tsem_fs_show_key(c, "capeff", ",", "0x%llx", cp->capeff.value);
+	tsem_fs_show_key(c, "securebits", "}", "%u", cp->securebits);
+
+	seq_puts(c, term);
+}
+
+static void show_event(struct seq_file *c, struct tsem_event *ep)
+{
+	tsem_fs_show_field(c, "event");
+	if (ep->pid)
+		tsem_fs_show_key(c, "pid", ",", "%u", ep->pid);
+	tsem_fs_show_key(c, "process", ",", "%s", ep->comm);
+	tsem_fs_show_key(c, "type", ",", "%s", tsem_names[ep->event]);
+	tsem_fs_show_key(c, "ttd", ",", "%llu", ep->instance);
+	tsem_fs_show_key(c, "p_ttd", ",", "%llu", ep->p_instance);
+	tsem_fs_show_key(c, "task_id", ",", "%*phN", tsem_digestsize(),
+			 ep->task_id);
+	tsem_fs_show_key(c, "p_task_id", ",", "%*phN", tsem_digestsize(),
+			 ep->p_task_id);
+	tsem_fs_show_key(c, "ts", "}, ", "%llu", ep->timestamp);
+
+	tsem_fs_show_field(c, "COE");
+	tsem_fs_show_key(c, "uid", ",", "%u", ep->COE.uid);
+	tsem_fs_show_key(c, "euid", ",", "%u", ep->COE.euid);
+	tsem_fs_show_key(c, "suid", ",", "%u", ep->COE.suid);
+	tsem_fs_show_key(c, "gid", ",", "%u", ep->COE.gid);
+	tsem_fs_show_key(c, "egid", ",", "%u", ep->COE.egid);
+	tsem_fs_show_key(c, "sgid", ",", "%u", ep->COE.sgid);
+	tsem_fs_show_key(c, "fsuid", ",", "%u", ep->COE.fsuid);
+	tsem_fs_show_key(c, "fsgid", ",", "%u", ep->COE.fsgid);
+	tsem_fs_show_key(c, "capeff", "}, ", "0x%llx", ep->COE.capeff.value);
+
+	tsem_fs_show_field(c, tsem_names[ep->event]);
+}
+
+static void show_path(struct seq_file *c, char *key, char *term,
+		      struct tsem_path *path)
+{
+	tsem_fs_show_field(c, key);
+
+	if (path->dev) {
+		tsem_fs_show_field(c, "dev");
+		tsem_fs_show_key(c, "major", ",", "%u", MAJOR(path->dev));
+		tsem_fs_show_key(c, "minor", "}, ", "%u", MINOR(path->dev));
+	}
+
+	if (path->created) {
+		tsem_fs_show_key(c, "owner", ",", "%*phN", tsem_digestsize(),
+				 path->owner);
+		tsem_fs_show_key(c, "instance", ",", "%llu", path->instance);
+	}
+
+	tsem_fs_show_key(c, "pathname", "}", "%s", path->pathname);
+	seq_puts(c, term);
+}
+
+static void show_inode(struct seq_file *c, char *key, char *term,
+		       struct tsem_inode_cell *inode)
+{
+	tsem_fs_show_field(c, key);
+	tsem_fs_show_key(c, "uid", ",", "%u", inode->uid);
+	tsem_fs_show_key(c, "gid", ",", "%u", inode->gid);
+	tsem_fs_show_key(c, "mode", ",", "0%o", inode->mode);
+	tsem_fs_show_key(c, "s_magic", ",", "0x%0x", inode->s_magic);
+	tsem_fs_show_key(c, "s_id", ",", "%s", inode->s_id);
+	tsem_fs_show_key(c, "s_uuid", "}", "%*phN", sizeof(inode->s_uuid),
+			 inode->s_uuid);
+
+	seq_puts(c, term);
+}
+
+static void show_dentry(struct seq_file *c, char *key, char *term,
+			struct tsem_dentry *dentry)
+{
+	tsem_fs_show_field(c, key);
+	if (dentry->have_inode)
+		show_inode(c, "inode", ", ", &dentry->inode);
+
+	show_path(c, "path", "}", &dentry->path);
+
+	seq_puts(c, term);
+}
+
+static void show_file(struct seq_file *c, char *term,
+		      struct tsem_file_args *args)
+{
+	tsem_fs_show_field(c, "file");
+	tsem_fs_show_key(c, "flags", ",", "%u", args->out.flags);
+
+	show_inode(c, "inode", ", ", &args->out.inode);
+	show_path(c, "path", ", ", &args->out.path);
+	tsem_fs_show_key(c, "digest", "}", "%*phN", tsem_digestsize(),
+			 args->out.digest);
+
+	seq_puts(c, term);
+}
+
+static void show_inode_create(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_args *args = &ep->CELL.inode;
+
+	show_event(c, ep);
+
+	show_inode(c, "dir", ", ", &args->out.dir);
+	show_dentry(c, "dentry", ", ", &args->out.dentry);
+	tsem_fs_show_key(c, "mode", "}", "0%o", args->mode);
+}
+
+static void show_inode_remove(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_args *args = &ep->CELL.inode;
+
+	show_event(c, ep);
+
+	show_inode(c, "dir", ", ", &args->out.dir);
+	show_dentry(c, "dentry", "}", &args->out.dentry);
+}
+
+static void show_inode_link(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_args *args = &ep->CELL.inode;
+
+	show_event(c, ep);
+
+	show_dentry(c, "old_dentry", ", ", &args->out.dentry);
+	show_inode(c, "dir", ", ", &args->out.dir);
+	show_dentry(c, "new_dentry", "}", &args->out.new_dentry);
+}
+
+static void show_syslog(struct seq_file *c, struct tsem_event *ep)
+{
+	show_event(c, ep);
+	tsem_fs_show_key(c, "type", "}", "%d", ep->CELL.value);
+}
+
+static void show_settime(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_time_args *args = &ep->CELL.time;
+
+	show_event(c, ep);
+
+	if (args->have_ts) {
+		tsem_fs_show_field(c, "ts");
+		tsem_fs_show_key(c, "seconds", ",", "%d", args->seconds);
+		tsem_fs_show_key(c, "nsecs", args->have_tz ? "}, " : "}",
+				 "%d", args->nsecs);
+	}
+
+	if (args->have_tz) {
+		tsem_fs_show_field(c, "tz");
+		tsem_fs_show_key(c, "minuteswest", ",", "%d",
+				 args->minuteswest);
+		tsem_fs_show_key(c, "dsttime", "}", "%d", args->dsttime);
+	}
+
+	seq_putc(c, '}');
+}
+
+static void show_inode_symlink(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_args *args = &ep->CELL.inode;
+
+	show_event(c, ep);
+
+	show_inode(c, "dir", ", ", &args->out.dir);
+	show_dentry(c, "dentry", ", ", &args->out.dentry);
+	tsem_fs_show_key(c, "old_name", "}", "%s", args->out.old_name);
+}
+
+static void show_inode_mknod(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_args *args = &ep->CELL.inode;
+
+	show_event(c, ep);
+
+	show_inode(c, "dir", ", ", &args->out.dir);
+
+	show_dentry(c, "dentry", ", ", &args->out.dentry);
+	tsem_fs_show_key(c, "mode", ",", "0%o", args->mode);
+	tsem_fs_show_field(c, "dev");
+	tsem_fs_show_key(c, "major", ",", "%u", MAJOR(args->dev));
+	tsem_fs_show_key(c, "minor", "}}", "%u", MINOR(args->dev));
+}
+
+static void show_inode_rename(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_args *args = &ep->CELL.inode;
+
+	show_event(c, ep);
+
+	show_inode(c, "old_dir", ", ", &args->out.dir);
+	show_dentry(c, "old_dentry", ", ", &args->out.dentry);
+	show_inode(c, "new_dir", ", ", &args->out.new_dir);
+	show_dentry(c, "new_dentry", "}", &args->out.new_dentry);
+}
+
+static void show_inode_killpriv(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_args *args = &ep->CELL.inode;
+
+	show_event(c, ep);
+
+	show_dentry(c, "dentry", "}", &args->out.dentry);
+}
+
+static void show_file_open(struct seq_file *c, struct tsem_event *ep)
+{
+	show_event(c, ep);
+
+	show_file(c, "}", &ep->CELL.file);
+}
+
+static void show_mmap(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_mmap_file_args *args = &ep->CELL.mmap_file;
+
+	show_event(c, ep);
+
+	if (!args->anonymous)
+		show_file(c, ", ", &args->file);
+	tsem_fs_show_key(c, "prot", ",", "%u", args->prot);
+	tsem_fs_show_key(c, "flags", "}", "%u", args->flags);
+}
+
+static void show_file_ioctl(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_file_args *args = &ep->CELL.file;
+
+	show_event(c, ep);
+
+	show_file(c, ", ", args);
+	tsem_fs_show_key(c, "cmd", "}", "%u", args->cmd);
+}
+
+static void show_socket_info(struct seq_file *c, const char *key, char *term,
+			     struct tsem_socket *args)
+{
+	tsem_fs_show_field(c, key);
+	tsem_fs_show_key(c, "family", ",", "%d", args->family);
+	tsem_fs_show_key(c, "type", ",", "%d", args->type);
+	tsem_fs_show_key(c, "protocol", ",", "%d", args->protocol);
+	tsem_fs_show_key(c, "owner", "}", "%*phN", tsem_digestsize(),
+			 args->owner);
+
+	seq_puts(c, term);
+}
+
+static void show_netlink(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_netlink_args *args = &ep->CELL.netlink;
+
+	show_event(c, ep);
+
+	show_socket_info(c, "sock", ", ", &args->out.sock);
+	tsem_fs_show_key(c, "uid", ",", "%u", args->out.uid);
+	tsem_fs_show_key(c, "gid", ",", "%u", args->out.gid);
+	tsem_fs_show_key(c, "portid", ",", "%u", args->out.portid);
+	tsem_fs_show_key(c, "dst_group", ",", "%u", args->out.dst_group);
+	tsem_fs_show_key(c, "flags", ",", "%u", args->out.flags);
+	tsem_fs_show_key(c, "nsid_set", ",", "%u", args->out.nsid_set);
+	tsem_fs_show_key(c, "nsid", "}", "%d", args->out.nsid);
+}
+
+static void show_ipc_cred(struct seq_file *c, char *key, char *term,
+			  struct tsem_ipc_args *args)
+{
+	tsem_fs_show_field(c, key);
+	tsem_fs_show_key(c, "uid", ",", "%u", args->out.perm.uid);
+	tsem_fs_show_key(c, "gid", ",", "%u", args->out.perm.gid);
+	tsem_fs_show_key(c, "cuid", ",", "%u", args->out.perm.cuid);
+	tsem_fs_show_key(c, "cgid", ",", "%u", args->out.perm.cgid);
+	tsem_fs_show_key(c, "mode", ",", "0%o", args->out.perm.mode);
+	tsem_fs_show_key(c, "owner", "}", "%*phN", tsem_digestsize(),
+			 args->out.owner);
+
+	seq_puts(c, term);
+}
+
+static void show_ipc_permission(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_ipc_args *args = &ep->CELL.ipc;
+
+	show_event(c, ep);
+
+	show_ipc_cred(c, "ipcp", ", ", args);
+	tsem_fs_show_key(c, "flag", "}", "%u", args->perm_flag);
+}
+
+static void show_ipc_shm_value(struct seq_file *c, struct tsem_event *ep,
+			       char *name)
+{
+	struct tsem_ipc_args *args = &ep->CELL.ipc;
+
+	show_event(c, ep);
+
+	show_ipc_cred(c, "perm", ", ", args);
+	tsem_fs_show_key(c, name, "}", "%d", args->perm_flag);
+}
+
+static void show_msg_queue_msgrcv(struct seq_file *c, struct tsem_event *ep)
+
+{
+	struct tsem_ipc_args *args = &ep->CELL.ipc;
+
+	show_event(c, ep);
+
+	show_ipc_cred(c, "perm", ", ", args);
+	tsem_fs_show_key(c, "target", ",", "%*phN", tsem_digestsize(),
+			 args->out.target);
+	tsem_fs_show_key(c, "type", ",", "%ld", args->type);
+	tsem_fs_show_key(c, "mode", "}", "%d", args->value);
+}
+
+static void show_sem_semop(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_ipc_args *args = &ep->CELL.ipc;
+
+	show_event(c, ep);
+
+	show_ipc_cred(c, "perm", ", ", args);
+	tsem_fs_show_key(c, "nsops", ",", "%u", args->nsops);
+	tsem_fs_show_key(c, "alter", "}", "%d", args->value);
+}
+
+static void show_socket_pair(struct seq_file *c, struct tsem_event *ep,
+			     char *first, char *second)
+{
+	struct tsem_socket_args *args = &ep->CELL.socket;
+
+	show_event(c, ep);
+
+	show_socket_info(c, first, ", ", &args->out.socka);
+	show_socket_info(c, second, "}", &args->out.sockb);
+}
+
+static void show_socket_create(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_socket_args *args = &ep->CELL.socket;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "family", ",", "%u", args->out.socka.family);
+	tsem_fs_show_key(c, "type", ",", "%u", args->out.socka.type);
+	tsem_fs_show_key(c, "protocol", ",", "%u", args->out.socka.protocol);
+	tsem_fs_show_key(c, "kern", "}", "%u", args->out.socka.kern);
+}
+
+static void show_socket_connect_bind(struct seq_file *c, struct tsem_event *ep)
+{
+	struct sockaddr_in *ipv4;
+	struct sockaddr_in6 *ipv6;
+	struct tsem_socket_args *args = &ep->CELL.socket;
+
+	show_event(c, ep);
+
+	show_socket_info(c, "sock", ", ", &args->out.socka);
+
+	tsem_fs_show_field(c, "addr");
+	switch (args->out.socka.family) {
+	case AF_INET:
+		ipv4 = (struct sockaddr_in *) &args->out.ipv4;
+		tsem_fs_show_field(c, "af_inet");
+		tsem_fs_show_key(c, "port", ",", "%u", ipv4->sin_port);
+		tsem_fs_show_key(c, "address", "}}}", "%u",
+				 ipv4->sin_addr.s_addr);
+		break;
+	case AF_INET6:
+		ipv6 = (struct sockaddr_in6 *) &args->out.ipv6;
+		tsem_fs_show_field(c, "af_inet6");
+		tsem_fs_show_key(c, "port", ",", "%u", ipv6->sin6_port);
+		tsem_fs_show_key(c, "flow", ",", "%u", ipv6->sin6_flowinfo);
+		tsem_fs_show_key(c, "scope", ",", "%u", ipv6->sin6_scope_id);
+		tsem_fs_show_key(c, "address", "}}}", "%*phN",
+			 (int) sizeof(ipv6->sin6_addr.in6_u.u6_addr8),
+			 ipv6->sin6_addr.in6_u.u6_addr8);
+		break;
+	case AF_UNIX:
+		tsem_fs_show_field(c, "af_unix");
+		tsem_fs_show_key(c, "address", "}}}", "%s", args->out.path);
+		break;
+	default:
+		tsem_fs_show_field(c, "af_other");
+		tsem_fs_show_key(c, "address", "}}}", "%*phN",
+				 tsem_digestsize(), args->out.mapping);
+		break;
+	}
+}
+
+static void show_socket_accept(struct seq_file *c, struct tsem_event *ep)
+{
+	char *p;
+	int size;
+	struct tsem_socket_args *args = &ep->CELL.socket;
+
+	show_event(c, ep);
+
+	show_socket_info(c, "sock", ", ", &args->out.socka);
+
+	tsem_fs_show_field(c, "addr");
+	switch (args->out.socka.family) {
+	case AF_INET:
+		tsem_fs_show_field(c, "af_inet");
+		tsem_fs_show_key(c, "port", ",", "%u",
+				 args->out.ipv4.sin_port);
+		tsem_fs_show_key(c, "address", "}}}", "%u",
+				 args->out.ipv4.sin_addr);
+		break;
+	case AF_INET6:
+		tsem_fs_show_field(c, "af_inet6");
+		tsem_fs_show_key(c, "port", ",", "%u",
+				 args->out.ipv6.sin6_port);
+		p = args->out.ipv6.sin6_addr.in6_u.u6_addr8;
+		size = sizeof(args->out.ipv6.sin6_addr.in6_u.u6_addr8);
+		tsem_fs_show_key(c, "address", "}}}", "%*phN", size, p);
+		break;
+	case AF_UNIX:
+		tsem_fs_show_field(c, "af_unix");
+		tsem_fs_show_key(c, "address", "}}}", "%s", args->out.path);
+		break;
+	default:
+		tsem_fs_show_field(c, "af_other");
+		tsem_fs_show_key(c, "address", "}}}", "%*phN",
+				 tsem_digestsize(), args->out.mapping);
+		break;
+	}
+}
+
+static void show_socket_value(struct seq_file *c, struct tsem_event *ep,
+			      char *key)
+{
+	struct tsem_socket_args *args = &ep->CELL.socket;
+
+	show_event(c, ep);
+
+	show_socket_info(c, "sock", ", ", &args->out.socka);
+	tsem_fs_show_key(c, key, "}", "%d", args->value);
+}
+
+static void show_socket_msg(struct seq_file *c, struct tsem_event *ep)
+{
+	int size;
+	struct sockaddr_in *ipv4;
+	struct sockaddr_in6 *ipv6;
+	struct tsem_socket_args *args = &ep->CELL.socket;
+
+	show_event(c, ep);
+
+	show_socket_info(c, "sock", args->out.have_addr ? ", " : "}",
+			 &args->out.socka);
+
+	if (args->out.have_addr) {
+		tsem_fs_show_field(c, "addr");
+		switch (args->out.socka.family) {
+		case AF_INET:
+			ipv4 = &args->out.ipv4;
+			tsem_fs_show_field(c, "af_inet");
+			tsem_fs_show_key(c, "port", ",", "%u", ipv4->sin_port);
+			tsem_fs_show_key(c, "addrress", "}}}", "%u",
+					 ipv4->sin_addr.s_addr);
+			break;
+		case AF_INET6:
+			ipv6 = &args->out.ipv6;
+			size = sizeof(ipv6->sin6_addr.in6_u.u6_addr8);
+			tsem_fs_show_field(c, "af_inet6");
+			tsem_fs_show_key(c, "port", ",", "%u",
+					 ipv6->sin6_port);
+			tsem_fs_show_key(c, "address", "}}}", "%*phN", size,
+					 ipv6->sin6_addr.in6_u.u6_addr8);
+			break;
+		}
+	}
+}
+
+static void show_socket_argument(struct seq_file *c, struct tsem_event *ep)
+{
+	show_event(c, ep);
+
+	show_socket_info(c, "sock", "}", &ep->CELL.socket.out.socka);
+}
+
+static void show_socket_setsockopt(struct seq_file *c, struct tsem_event *ep)
+{
+	show_event(c, ep);
+
+	show_socket_info(c, "sock", ", ", &ep->CELL.socket.out.socka);
+	tsem_fs_show_key(c, "level", ",", "%d", ep->CELL.socket.value);
+	tsem_fs_show_key(c, "optname", "}", "%d", ep->CELL.socket.optname);
+}
+
+static void show_kernel_module_request(struct seq_file *c,
+				       struct tsem_event *ep)
+{
+	struct tsem_kernel_args *args = &ep->CELL.kernel;
+
+	show_event(c, ep);
+	tsem_fs_show_key(c, "kmod_name", "}", "%s", args->out.kmod_name);
+}
+
+static void show_kernel_load_data(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_kernel_args *args = &ep->CELL.kernel;
+
+	show_event(c, ep);
+	tsem_fs_show_key(c, "id", ",", "%d", args->id);
+	tsem_fs_show_key(c, "contents", "}", "%d", args->contents);
+}
+
+static void show_kernel_read_file(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_kernel_args *args = &ep->CELL.kernel;
+
+	show_event(c, ep);
+
+	show_file(c, ", ", &args->out.file);
+	tsem_fs_show_key(c, "id", ",", "%d", args->id);
+	tsem_fs_show_key(c, "contents", "}", "%d", args->contents);
+}
+
+static void show_task_kill(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "target", ",", "%*phN", tsem_digestsize(),
+			 args->target);
+	tsem_fs_show_key(c, "sig", ",", "%u", args->signal);
+	tsem_fs_show_key(c, "cross_ns", "}", "%u", args->cross_model);
+}
+
+static void show_ptrace_access_check(struct seq_file *c,
+				     struct tsem_event *ep)
+{
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "child", ", ", "%*phN", tsem_digestsize(),
+			 args->target);
+	tsem_fs_show_key(c, "mode", "}", "%u", args->u.resource);
+}
+
+static void show_task_ptraceme(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "source", "}", "%*phN", tsem_digestsize(),
+			 args->source);
+}
+
+static void show_capget(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_capability_args *args = &ep->CELL.capability;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "target", ",", "%*phN", tsem_digestsize(),
+			 args->target);
+	tsem_fs_show_key(c, "effective", ",", "0x%llx", args->effective);
+	tsem_fs_show_key(c, "inheritable", ",", "0x%llx", args->inheritable);
+	tsem_fs_show_key(c, "permitted", "}", "0x%llx", args->permitted);
+}
+
+static void show_capset(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_capability_args *args = &ep->CELL.capability;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "effective", ",", "0x%llx", args->effective);
+	tsem_fs_show_key(c, "inheritable", ",", "0x%llx", args->inheritable);
+	tsem_fs_show_key(c, "permitted", "}", "0x%llx", args->permitted);
+}
+
+static void show_capable(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_capability_args *args = &ep->CELL.capability;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "cap", ",", "%d", args->cap);
+	tsem_fs_show_key(c, "opts", "}", "%u", args->opts);
+}
+
+static void show_task_setpgid(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "task", ",", "%*phN", tsem_digestsize(),
+			 args->target);
+	tsem_fs_show_key(c, "source", "}", "%*phN", tsem_digestsize(),
+			 args->source);
+}
+
+static void show_task_getpgid(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "task", "}", "%*phN", tsem_digestsize(),
+			 args->target);
+}
+
+static void show_task_nice(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "task", ",", "%*phN", tsem_digestsize(),
+			 args->target);
+	tsem_fs_show_key(c, "nice", "}", "%d", args->u.value);
+}
+
+static void show_task_prlimit(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_task_prlimit_args *args = &ep->CELL.task_prlimit;
+
+	show_event(c, ep);
+
+	show_creds(c, "cred", ", ", &args->out.cred);
+	show_creds(c, "tcred", ", ", &args->out.tcred);
+	tsem_fs_show_key(c, "flags", "}", "%d", args->flags);
+}
+
+static void show_task_setrlimit(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "task", ",", "%*phN", tsem_digestsize(),
+			 args->target);
+	tsem_fs_show_field(c, "new_rlim");
+	tsem_fs_show_key(c, "resource", ",", "%u", args->u.resource);
+	tsem_fs_show_key(c, "current", ",", "%llu", args->cur);
+	tsem_fs_show_key(c, "max", "}", "%llu", args->max);
+	seq_putc(c, '}');
+}
+
+static void show_task_prctl(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_task_prctl_args *args = &ep->CELL.task_prctl;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "option", ",", "%d", args->option);
+	tsem_fs_show_key(c, "arg2", ",", "%llu", args->arg2);
+	tsem_fs_show_key(c, "arg3", ",", "%llu", args->arg3);
+	tsem_fs_show_key(c, "arg4", ",", "%llu", args->arg4);
+	tsem_fs_show_key(c, "arg5", "}", "%llu", args->arg5);
+}
+
+static void show_task_value(struct seq_file *c, struct tsem_event *ep,
+			    char *key)
+{
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "task", ",", "%*phN", tsem_digestsize(),
+			 args->target);
+	tsem_fs_show_key(c, key, "}", "%d", args->u.value);
+}
+
+static void show_inode_getattr(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_attr_args *args = &ep->CELL.inode_attr;
+
+	show_event(c, ep);
+
+	show_dentry(c, "path", "}", &args->out.dentry);
+}
+
+static void show_inode_setattr(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_attr_args *args = &ep->CELL.inode_attr;
+
+	show_event(c, ep);
+
+	show_dentry(c, "dentry", ", ", &args->out.dentry);
+	tsem_fs_show_field(c, "attr");
+	tsem_fs_show_key(c, "valid", ",", "%u", args->out.valid);
+	tsem_fs_show_key(c, "mode", ",", "0%o", args->out.mode);
+	tsem_fs_show_key(c, "uid", ",", "%u", args->out.uid);
+	tsem_fs_show_key(c, "gid", ",", "%u", args->out.gid);
+	tsem_fs_show_key(c, "size", "}", "%lu", args->out.size);
+	seq_putc(c, '}');
+}
+
+static void show_inode_setxattr(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_xattr_args *args = &ep->CELL.inode_xattr;
+
+	show_event(c, ep);
+
+	show_dentry(c, "dentry", ", ", &args->out.dentry);
+	tsem_fs_show_key(c, "name", ",", "%s", args->out.name);
+	tsem_fs_show_key(c, "value", ",", "%s", args->out.encoded_value);
+	tsem_fs_show_key(c, "flags", "}", "%d", args->out.flags);
+}
+
+static void show_inode_getxattr(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_xattr_args *args = &ep->CELL.inode_xattr;
+
+	show_event(c, ep);
+
+	show_dentry(c, "dentry", ", ", &args->out.dentry);
+	tsem_fs_show_key(c, "name", "}", "%s", args->out.name);
+}
+
+static void show_inode_listxattr(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_inode_xattr_args *args = &ep->CELL.inode_xattr;
+
+	show_event(c, ep);
+
+	show_dentry(c, "dentry", "}", &args->out.dentry);
+}
+
+static void show_key_alloc(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_key_args *args = &ep->CELL.key;
+
+	show_event(c, ep);
+
+	show_creds(c, "cred", ", ", &args->out.cred);
+	tsem_fs_show_key(c, "flags", "}", "%llu", args->flags);
+}
+
+static void show_key_permission(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_key_args *args = &ep->CELL.key;
+
+	show_event(c, ep);
+
+	tsem_fs_show_field(c, "key_ref");
+	tsem_fs_show_key(c, "possessed", ",", "%u", args->out.possessed);
+	tsem_fs_show_key(c, "uid", ",", "%u", args->out.uid);
+	tsem_fs_show_key(c, "gid", ",", "%u", args->out.gid);
+	tsem_fs_show_key(c, "flags", "}, ", "%lu", args->out.flags);
+	show_creds(c, "cred", ", ", &args->out.cred);
+	tsem_fs_show_key(c, "perm", "}", "%u", args->out.perm);
+}
+
+static void show_sb_mount(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_sb_args *args = &ep->CELL.sb;
+
+	show_event(c, ep);
+
+	if (args->out.dev_name)
+		tsem_fs_show_key(c, "dev_name", ",", "%s", args->out.dev_name);
+
+	show_path(c, "path", ", ", &args->out.path);
+
+	if (args->out.type)
+		tsem_fs_show_key(c, "type", ",", "%s", args->out.type);
+
+	tsem_fs_show_key(c, "flags", "}", "%lu", args->flags);
+}
+
+static void show_sb_umount(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_sb_args *args = &ep->CELL.sb;
+
+	show_event(c, ep);
+
+	show_dentry(c, "mnt", ", ", &args->out.dentry);
+	tsem_fs_show_key(c, "flags", "}", "%d", args->flags);
+}
+
+static void show_sb_remount(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_sb_args *args = &ep->CELL.sb;
+
+	show_event(c, ep);
+
+	tsem_fs_show_field(c, "sb");
+	show_dentry(c, "dentry", ", ", &args->out.dentry);
+	tsem_fs_show_key(c, "fstype", ",", "%s", args->out.type);
+	tsem_fs_show_key(c, "s_flags", "}", "%lu", args->flags);
+	seq_putc(c, '}');
+}
+
+static void show_sb_statfs(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_sb_args *args = &ep->CELL.sb;
+
+	show_event(c, ep);
+
+	show_dentry(c, "dentry", "}", &args->out.dentry);
+}
+
+static void show_move_path(struct seq_file *c, struct tsem_event *ep,
+			   char *path1, char *path2)
+{
+	struct tsem_sb_args *args = &ep->CELL.sb;
+
+	show_event(c, ep);
+
+	show_path(c, path1, ", ", &args->out.path);
+	show_path(c, path2, "}", &args->out.path2);
+}
+
+static void show_quotactl(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_quota_args *args = &ep->CELL.quota;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "cmds", ",", "%d", args->cmds);
+	tsem_fs_show_key(c, "type", ",", "%d", args->type);
+	tsem_fs_show_key(c, "id", ",", "%d", args->id);
+
+	tsem_fs_show_field(c, "sb");
+	show_dentry(c, "dentry", ", ", &args->out.dentry);
+	tsem_fs_show_key(c, "fstype", ",", "%s", args->out.fstype);
+	tsem_fs_show_key(c, "s_flags", "}", "%d", args->out.s_flags);
+	seq_putc(c, '}');
+}
+
+static void show_quotaon(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_quota_args *args = &ep->CELL.quota;
+
+	show_event(c, ep);
+
+	show_dentry(c, "dentry", "}", &args->out.dentry);
+}
+
+static void show_bpf(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_bpf_args *args = &ep->CELL.bpf;
+
+	show_event(c, ep);
+
+	tsem_fs_show_key(c, "cmd", ",", "%d", args->bpf.cmd);
+	tsem_fs_show_field(c, "attr");
+	tsem_fs_show_key(c, "size", "}", "%u", args->bpf.size);
+	seq_putc(c, '}');
+}
+
+static void show_bpf_map(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_bpf_args *args = &ep->CELL.bpf;
+
+	show_event(c, ep);
+
+	tsem_fs_show_field(c, "map");
+	tsem_fs_show_key(c, "map_type", "}, ", "%d", args->map.map_type);
+	tsem_fs_show_key(c, "fmode", "}", "%u", args->map.fmode);
+}
+
+static void show_bpf_prog(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_bpf_args *args = &ep->CELL.bpf;
+
+	show_event(c, ep);
+
+	tsem_fs_show_field(c, "prog");
+	tsem_fs_show_key(c, "type", ",", "%d", args->prog.type);
+	tsem_fs_show_key(c, "attach_type", "}", "%d", args->prog.attach_type);
+	seq_putc(c, '}');
+}
+
+static void show_event_generic(struct seq_file *c, struct tsem_event *ep)
+{
+	show_event(c, ep);
+	seq_putc(c, '}');
+}
+
+static void *trajectory_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->trajectory_lock);
+	end = model->trajectory_list.prev;
+	spin_unlock(&model->trajectory_lock);
+
+	mutex_lock(&model->trajectory_end_mutex);
+	model->trajectory_end = end;
+
+	return seq_list_start(&model->trajectory_list, *pos);
+}
+
+static void *trajectory_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->trajectory_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->trajectory_end)
+		model->trajectory_end = NULL;
+
+	return seq_list_next(p, &model->trajectory_list, pos);
+}
+
+static void trajectory_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->trajectory_end_mutex);
+}
+
+static int trajectory_show(struct seq_file *c, void *trajectory)
+{
+	struct tsem_event *ep;
+
+	ep = list_entry(trajectory, struct tsem_event, list);
+
+	seq_putc(c, '{');
+	tsem_fs_show_trajectory(c, ep);
+	seq_puts(c, "}\n");
+
+	return 0;
+}
+
+static const struct seq_operations trajectory_seqops = {
+	.start = trajectory_start,
+	.next = trajectory_next,
+	.stop = trajectory_stop,
+	.show = trajectory_show
+};
+
+static int trajectory_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &trajectory_seqops);
+}
+
+static const struct file_operations trajectory_ops = {
+	.open = trajectory_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static void *trajectory_count_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->point_lock);
+	end = model->point_list.prev;
+	spin_unlock(&model->point_lock);
+
+	mutex_lock(&model->point_end_mutex);
+	model->point_end = end;
+
+	return seq_list_start(&model->point_list, *pos);
+}
+
+static void *trajectory_count_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->point_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->point_end)
+		model->point_end = NULL;
+
+	return seq_list_next(p, &model->point_list, pos);
+}
+
+static void trajectory_count_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->point_end_mutex);
+}
+
+static int trajectory_count_show(struct seq_file *c, void *point)
+{
+	struct tsem_event_point *pt;
+
+	pt = list_entry(point, struct tsem_event_point, list);
+	if (!pt->valid)
+		return 0;
+
+	seq_printf(c, "%llu\n", pt->count);
+	return 0;
+}
+
+static const struct seq_operations trajectory_count_seqops = {
+	.start = trajectory_count_start,
+	.next = trajectory_count_next,
+	.stop = trajectory_count_stop,
+	.show = trajectory_count_show
+};
+
+static int trajectory_count_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &trajectory_count_seqops);
+}
+
+static const struct file_operations trajectory_count_ops = {
+	.open = trajectory_count_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static void *trajectory_point_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->point_lock);
+	end = model->point_list.prev;
+	spin_unlock(&model->point_lock);
+
+	mutex_lock(&model->point_end_mutex);
+	model->point_end = end;
+
+	return seq_list_start(&model->point_list, *pos);
+}
+
+static void *trajectory_point_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->point_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->point_end)
+		model->point_end = NULL;
+
+	return seq_list_next(p, &model->point_list, pos);
+}
+
+static void trajectory_point_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->point_end_mutex);
+}
+
+static int trajectory_point_show(struct seq_file *c, void *point)
+{
+	struct tsem_event_point *pt;
+
+	pt = list_entry(point, struct tsem_event_point, list);
+	if (!pt->valid)
+		return 0;
+
+	seq_printf(c, "%*phN\n", tsem_digestsize(), pt->point);
+	return 0;
+}
+
+static const struct seq_operations trajectory_point_seqops = {
+	.start = trajectory_point_start,
+	.next = trajectory_point_next,
+	.stop = trajectory_point_stop,
+	.show = trajectory_point_show
+};
+
+static int trajectory_point_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &trajectory_point_seqops);
+}
+
+static const struct file_operations trajectory_point_ops = {
+	.open = trajectory_point_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int open_control(struct inode *inode, struct file *filp)
+{
+	if (!capable(CAP_MAC_ADMIN))
+		return -EACCES;
+	if (!(filp->f_flags & O_WRONLY))
+		return -EACCES;
+	return 0;
+}
+
+static ssize_t write_control(struct file *file, const char __user *buf,
+			     size_t datalen, loff_t *ppos)
+{
+	char *p, *arg, cmdbufr[128];
+	ssize_t retn = -EINVAL;
+	enum tsem_control_type type;
+
+	if (*ppos != 0)
+		goto done;
+	if (datalen > sizeof(cmdbufr)-1)
+		goto done;
+
+	memset(cmdbufr, '\0', sizeof(cmdbufr));
+	if (copy_from_user(cmdbufr, buf, datalen)) {
+		retn = -EFAULT;
+		goto done;
+	}
+
+	p = strchr(cmdbufr, '\n');
+	if (!p)
+		goto done;
+	*p = '\0';
+
+	arg = strchr(cmdbufr, ' ');
+	if (arg != NULL) {
+		*arg = '\0';
+		++arg;
+	}
+
+	type = match_string(control_commands, ARRAY_SIZE(control_commands),
+			    cmdbufr);
+	if (type < 0)
+		goto done;
+
+	switch (type) {
+	case TSEM_CONTROL_EXTERNAL:
+	case TSEM_CONTROL_INTERNAL:
+	case TSEM_CONTROL_EXPORT:
+		retn = config_namespace(type, arg);
+		break;
+	case TSEM_CONTROL_ENFORCE:
+	case TSEM_CONTROL_SEAL:
+		retn = config_context(type, cmdbufr);
+		break;
+	case TSEM_CONTROL_TRUSTED:
+	case TSEM_CONTROL_UNTRUSTED:
+		retn = config_COE(type, arg);
+		break;
+	case TSEM_CONTROL_MAP_STATE:
+	case TSEM_CONTROL_MAP_PSEUDONYM:
+	case TSEM_CONTROL_MAP_BASE:
+		retn = config_point(type, arg);
+		break;
+	}
+
+done:
+	if (!retn)
+		retn = datalen;
+	return retn;
+}
+
+static int release_control(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static const struct file_operations control_ops = {
+	.open = open_control,
+	.write = write_control,
+	.release = release_control,
+	.llseek = generic_file_llseek,
+};
+
+static void *forensics_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->forensics_lock);
+	end = model->forensics_list.prev;
+	spin_unlock(&model->forensics_lock);
+
+	mutex_lock(&model->forensics_end_mutex);
+	model->forensics_end = end;
+
+	return seq_list_start(&model->forensics_list, *pos);
+}
+
+static void *forensics_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->forensics_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->forensics_end)
+		model->forensics_end = NULL;
+
+	return seq_list_next(p, &model->forensics_list, pos);
+}
+
+static void forensics_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->forensics_end_mutex);
+}
+
+static int forensics_show(struct seq_file *c, void *event)
+{
+	struct tsem_event *ep;
+
+	ep = list_entry(event, struct tsem_event, list);
+
+	seq_putc(c, '{');
+	tsem_fs_show_trajectory(c, ep);
+	seq_puts(c, "}\n");
+
+	return 0;
+}
+
+static const struct seq_operations forensics_seqops = {
+	.start = forensics_start,
+	.next = forensics_next,
+	.stop = forensics_stop,
+	.show = forensics_show
+};
+
+static int forensics_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &forensics_seqops);
+}
+
+static const struct file_operations forensics_ops = {
+	.open = forensics_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static void *forensics_point_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->point_lock);
+	end = model->point_list.prev;
+	spin_unlock(&model->point_lock);
+
+	mutex_lock(&model->point_end_mutex);
+	model->point_end = end;
+
+	return seq_list_start(&model->point_list, *pos);
+}
+
+static void *forensics_point_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->point_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->point_end)
+		model->point_end = NULL;
+
+	return seq_list_next(p, &model->point_list, pos);
+}
+
+static void forensics_point_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->point_end_mutex);
+}
+
+static int forensics_point_show(struct seq_file *c, void *point)
+{
+	struct tsem_event_point *pt;
+
+	pt = list_entry(point, struct tsem_event_point, list);
+	if (pt->valid)
+		return 0;
+
+	seq_printf(c, "%*phN\n", tsem_digestsize(), pt->point);
+	return 0;
+}
+
+static const struct seq_operations forensics_point_seqops = {
+	.start = forensics_point_start,
+	.next = forensics_point_next,
+	.stop = forensics_point_stop,
+	.show = forensics_point_show
+};
+
+static int forensics_point_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &forensics_point_seqops);
+}
+
+static const struct file_operations forensics_point_ops = {
+	.open = forensics_point_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static void *forensics_count_start(struct seq_file *c, loff_t *pos)
+{
+	struct list_head *end;
+	struct tsem_model *model = tsem_model(current);
+
+	spin_lock(&model->point_lock);
+	end = model->point_list.prev;
+	spin_unlock(&model->point_lock);
+
+	mutex_lock(&model->point_end_mutex);
+	model->point_end = end;
+
+	return seq_list_start(&model->point_list, *pos);
+}
+
+static void *forensics_count_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct list_head *next = ((struct list_head *) p)->next;
+	struct tsem_model *model = tsem_model(current);
+
+	if (!model->point_end) {
+		++*pos;
+		return NULL;
+	}
+
+	if (next == model->point_end)
+		model->point_end = NULL;
+
+	return seq_list_next(p, &model->point_list, pos);
+}
+
+static void forensics_count_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->point_end_mutex);
+}
+
+static int forensics_count_show(struct seq_file *c, void *point)
+{
+	struct tsem_event_point *pt;
+
+	pt = list_entry(point, struct tsem_event_point, list);
+	if (pt->valid)
+		return 0;
+
+	seq_printf(c, "%llu\n", pt->count);
+	return 0;
+}
+
+static const struct seq_operations forensics_count_seqops = {
+	.start = forensics_count_start,
+	.next = forensics_count_next,
+	.stop = forensics_count_stop,
+	.show = forensics_count_show
+};
+
+static int forensics_count_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &forensics_count_seqops);
+}
+
+static const struct file_operations forensics_count_ops = {
+	.open = forensics_count_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int measurement_show(struct seq_file *c, void *event)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	seq_printf(c, "%*phN\n", tsem_digestsize(), model->measurement);
+	return 0;
+}
+
+static int measurement_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return single_open(file, &measurement_show, NULL);
+}
+
+static const struct file_operations measurement_ops = {
+	.open = measurement_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int id_show(struct seq_file *c, void *event)
+{
+	seq_printf(c, "%llu\n", tsem_context(current)->id);
+	return 0;
+}
+
+static int id_open(struct inode *inode, struct file *file)
+{
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (ctx->sealed)
+		return -EACCES;
+	return single_open(file, &id_show, NULL);
+}
+
+static const struct file_operations id_ops = {
+	.open = id_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int state_show(struct seq_file *m, void *v)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	tsem_model_compute_state();
+	seq_printf(m, "%*phN\n", tsem_digestsize(), model->state);
+	return 0;
+}
+
+static int state_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return single_open(file, &state_show, NULL);
+}
+
+static const struct file_operations state_ops = {
+	.open = state_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int aggregate_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%*phN\n", tsem_digestsize(), tsem_trust_aggregate());
+	return 0;
+}
+
+static int aggregate_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return single_open(file, &aggregate_show, NULL);
+}
+
+static const struct file_operations aggregate_ops = {
+	.open = aggregate_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static __poll_t export_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (!ctx->external)
+		return -ENOENT;
+
+	poll_wait(file, &ctx->external->wq, wait);
+
+	if (ctx->external->have_event) {
+		ctx->external->have_event = false;
+		return EPOLLIN | EPOLLRDNORM;
+	}
+	return 0;
+}
+
+static int export_open(struct inode *inode, struct file *file)
+{
+	if (!capable(CAP_MAC_ADMIN))
+		return -EACCES;
+	return single_open(file, &tsem_export_show, NULL);
+}
+
+static const struct file_operations export_ops = {
+	.open = export_open,
+	.poll = export_poll,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+/**
+ * tsem_fs_create_external() - Create an external TMA update file.
+ * @id: A pointer to the ASCII representation of the modeling domain
+ *      that the export file is being created for.
+ *
+ * This function is used to create a pseudo-file that will output security
+ * event descriptions for a namespace.  This routine will create the
+ * following file:
+ *
+ * /sys/kernel/security/tsem/ExternalTMA/N
+ *
+ * Where N is replaced with the security model context identifier.
+ *
+ * Return: If creation of the update file is successful a pointer to the
+ *	   dentry of the file is returned.  If an error was encountered
+ *	   the pointer with an encoded code will be returned.
+ */
+struct dentry *tsem_fs_create_external(const char *name)
+{
+	struct dentry *dentry;
+
+	dentry = securityfs_create_file(name, 0400, external_tma, NULL,
+					&export_ops);
+	if (!IS_ERR(dentry))
+		tsem_inode(dentry->d_inode)->status = TSEM_INODE_CONTROL_PLANE;
+	return dentry;
+}
+
+/**
+ * tsem_fs_show_trajectory() - Generate the output of a security event.
+ * @sf: A pointer to the seq_file structure to which output will
+ *      be set.
+ * @ep: A pointer to the event description that is to be output.
+ *
+ * This function is used to generate a record that will be output to
+ * the pseudo-file that outputs the security events for the
+ * domain being modeled.
+ */
+void tsem_fs_show_trajectory(struct seq_file *c, struct tsem_event *ep)
+{
+	if (ep->no_params)
+		show_event_generic(c, ep);
+
+	switch (ep->event) {
+	case TSEM_SYSLOG:
+		show_syslog(c, ep);
+		break;
+	case TSEM_SETTIME:
+		show_settime(c, ep);
+		break;
+	case TSEM_NETLINK_SEND:
+		show_netlink(c, ep);
+		break;
+	case TSEM_IPC_PERMISSION:
+		show_ipc_permission(c, ep);
+		break;
+	case TSEM_SHM_ASSOCIATE:
+	case TSEM_SHM_SHMAT:
+		show_ipc_shm_value(c, ep, "shmflg");
+		break;
+	case TSEM_SHM_SHMCTL:
+	case TSEM_SEM_SEMCTL:
+	case TSEM_MSG_QUEUE_MSGCTL:
+		show_ipc_shm_value(c, ep, "cmd");
+		break;
+	case TSEM_SEM_SEMOP:
+		show_sem_semop(c, ep);
+		break;
+	case TSEM_SEM_ASSOCIATE:
+		show_ipc_shm_value(c, ep, "semflg");
+		break;
+	case TSEM_MSG_QUEUE_ASSOCIATE:
+	case TSEM_MSG_QUEUE_MSGSND:
+		show_ipc_shm_value(c, ep, "msqflg");
+		break;
+	case TSEM_MSG_QUEUE_MSGRCV:
+		show_msg_queue_msgrcv(c, ep);
+		break;
+	case TSEM_INODE_CREATE:
+	case TSEM_INODE_MKDIR:
+		show_inode_create(c, ep);
+		break;
+	case TSEM_INODE_RMDIR:
+	case TSEM_INODE_UNLINK:
+		show_inode_remove(c, ep);
+		break;
+	case TSEM_INODE_LINK:
+		show_inode_link(c, ep);
+		break;
+	case TSEM_INODE_SYMLINK:
+		show_inode_symlink(c, ep);
+		break;
+	case TSEM_INODE_MKNOD:
+		show_inode_mknod(c, ep);
+		break;
+	case TSEM_INODE_RENAME:
+		show_inode_rename(c, ep);
+		break;
+	case TSEM_INODE_KILLPRIV:
+		show_inode_killpriv(c, ep);
+		break;
+	case TSEM_FILE_OPEN:
+	case TSEM_FILE_RECEIVE:
+		show_file_open(c, ep);
+		break;
+	case TSEM_MMAP_FILE:
+		show_mmap(c, ep);
+		break;
+	case TSEM_FILE_IOCTL:
+	case TSEM_FILE_LOCK:
+	case TSEM_FILE_FCNTL:
+		show_file_ioctl(c, ep);
+		break;
+	case TSEM_UNIX_STREAM_CONNECT:
+	case TSEM_UNIX_MAY_SEND:
+		show_socket_pair(c, ep, "sock", "other");
+		break;
+	case TSEM_SOCKET_SOCKETPAIR:
+		show_socket_pair(c, ep, "socka", "sockb");
+		break;
+	case TSEM_SOCKET_CREATE:
+		show_socket_create(c, ep);
+		break;
+	case TSEM_SOCKET_CONNECT:
+	case TSEM_SOCKET_BIND:
+		show_socket_connect_bind(c, ep);
+		break;
+	case TSEM_SOCKET_SENDMSG:
+	case TSEM_SOCKET_RECVMSG:
+		show_socket_msg(c, ep);
+		break;
+	case TSEM_SOCKET_GETSOCKNAME:
+	case TSEM_SOCKET_GETPEERNAME:
+	case TSEM_TUN_DEV_ATTACH_QUEUE:
+		show_socket_argument(c, ep);
+		break;
+	case TSEM_SOCKET_SETSOCKOPT:
+		show_socket_setsockopt(c, ep);
+		break;
+	case TSEM_SOCKET_ACCEPT:
+		show_socket_accept(c, ep);
+		break;
+	case TSEM_SOCKET_LISTEN:
+		show_socket_value(c, ep, "backlog");
+		break;
+	case TSEM_SOCKET_SHUTDOWN:
+		show_socket_value(c, ep, "how");
+		break;
+	case TSEM_KERNEL_MODULE_REQUEST:
+		show_kernel_module_request(c, ep);
+		break;
+	case TSEM_KERNEL_LOAD_DATA:
+		show_kernel_load_data(c, ep);
+		break;
+	case TSEM_KERNEL_READ_FILE:
+		show_kernel_read_file(c, ep);
+		break;
+	case TSEM_TASK_KILL:
+		show_task_kill(c, ep);
+		break;
+	case TSEM_PTRACE_ACCESS_CHECK:
+		show_ptrace_access_check(c, ep);
+		break;
+	case TSEM_PTRACE_TRACEME:
+		show_task_ptraceme(c, ep);
+		break;
+	case TSEM_CAPGET:
+		show_capget(c, ep);
+		break;
+	case TSEM_CAPSET:
+		show_capset(c, ep);
+		break;
+	case TSEM_CAPABLE:
+		show_capable(c, ep);
+		break;
+	case TSEM_TASK_SETPGID:
+		show_task_setpgid(c, ep);
+		break;
+	case TSEM_TASK_GETPGID:
+	case TSEM_TASK_GETSID:
+	case TSEM_TASK_GETIOPRIO:
+	case TSEM_TASK_SETSCHEDULER:
+	case TSEM_TASK_GETSCHEDULER:
+		show_task_getpgid(c, ep);
+		break;
+	case TSEM_TASK_SETNICE:
+		show_task_nice(c, ep);
+		break;
+	case TSEM_TASK_SETIOPRIO:
+		show_task_value(c, ep, "ioprio");
+		break;
+	case TSEM_TASK_PRLIMIT:
+		show_task_prlimit(c, ep);
+		break;
+	case TSEM_TASK_SETRLIMIT:
+		show_task_setrlimit(c, ep);
+		break;
+	case TSEM_TASK_PRCTL:
+		show_task_prctl(c, ep);
+		break;
+	case TSEM_INODE_GETATTR:
+		show_inode_getattr(c, ep);
+		break;
+	case TSEM_INODE_SETATTR:
+		show_inode_setattr(c, ep);
+		break;
+	case TSEM_INODE_SETXATTR:
+		show_inode_setxattr(c, ep);
+		break;
+	case TSEM_INODE_GETXATTR:
+	case TSEM_INODE_REMOVEXATTR:
+		show_inode_getxattr(c, ep);
+		break;
+	case TSEM_INODE_LISTXATTR:
+		show_inode_listxattr(c, ep);
+		break;
+	case TSEM_KEY_ALLOC:
+		show_key_alloc(c, ep);
+		break;
+	case TSEM_KEY_PERMISSION:
+		show_key_permission(c, ep);
+		break;
+	case TSEM_SB_MOUNT:
+		show_sb_mount(c, ep);
+		break;
+	case TSEM_SB_UMOUNT:
+		show_sb_umount(c, ep);
+		break;
+	case TSEM_SB_REMOUNT:
+		show_sb_remount(c, ep);
+		break;
+	case TSEM_SB_STATFS:
+		show_sb_statfs(c, ep);
+		break;
+	case TSEM_SB_PIVOTROOT:
+		show_move_path(c, ep, "old_path", "new_path");
+		break;
+	case TSEM_MOVE_MOUNT:
+		show_move_path(c, ep, "from_path", "to_path");
+		break;
+	case TSEM_QUOTACTL:
+		show_quotactl(c, ep);
+		break;
+	case TSEM_QUOTA_ON:
+		show_quotaon(c, ep);
+		break;
+	case TSEM_BPF:
+		show_bpf(c, ep);
+		break;
+	case TSEM_BPF_MAP:
+		show_bpf_map(c, ep);
+		break;
+	case TSEM_BPF_PROG:
+		show_bpf_prog(c, ep);
+		break;
+	default:
+		break;
+	}
+}
+
+/**
+ * tesm_fs_show_field() - Output a JSON field description
+ * @sf: A pointer to the seq_file structure that the field description
+ *	is to be written to.
+ * @f:  A pointer to null terminated character buffer containing the
+ *      name of the field to encode
+ *
+ * This function is used to generate a JSON field description that
+ * is used to name a sequence of key/value pairs describing the
+ * characteristcis of the field.
+ */
+void tsem_fs_show_field(struct seq_file *c, const char *field)
+{
+	seq_printf(c, "\"%s\": {", field);
+}
+
+/**
+ * tesm_fs_tsem_fs_show_key() - Output a JSON key/value pair
+ * @sf: A pointer to the seq_file structure that the field description
+ *	is to be written to.
+ * @key: A pointer to the null-terminated character buffer containing
+ *	 the key description.
+ * @term: A pointer to a null-terminated character buffer containing
+ *	  the string that is to be used for terminating the key/value
+ *	  pair.
+ * @fmt: The printf format that is to be used for formatting the
+ *	 value of the key.
+ *
+ * This function is a variadic function that is used to encode a
+ * JSON key/value pair that provides one of characteristics of an
+ * event description field.
+ */
+void tsem_fs_show_key(struct seq_file *c, char *key, char *term, char *fmt,
+		      ...)
+{
+	va_list args;
+
+	seq_printf(c, "\"%s\": \"", key);
+
+	va_start(args, fmt);
+	seq_vprintf(c, fmt, args);
+	va_end(args);
+
+	if (term[0] == ',')
+		seq_printf(c, "\"%s ", term);
+	else
+		seq_printf(c, "\"%s", term);
+}
+
+static bool _init_inode(struct dentry *dp)
+{
+	if (IS_ERR(dp))
+		return false;
+
+	tsem_inode(dp->d_inode)->status = TSEM_INODE_CONTROL_PLANE;
+	return true;
+}
+
+/**
+ * tesm_fs_init() - Initialize the TSEM control filesystem heirarchy
+ *
+ * This function is called as part of the TSEM LSM initialization
+ * process.  The purpose of this function is to create the TSEM
+ * control plane, based on the securityfs filesystem, by creating the
+ * /sys/kernel/security/tsem directory and populating that directory
+ * with the control plane files and internal TMA model information
+ * files.  The /sys/kernel/security/tsem/ExternalTMA directory is
+ * also created.  This directory will be used to hold the modeling
+ * domain specific files that will emit the security event descriptions
+ * for the domain.
+ *
+ * Return: If filesystem initialization is successful a return code of 0
+ *	   is returned.  A negative return value is returned if an error
+ *	   is encountered.
+ */
+int __init tsem_fs_init(void)
+{
+	int retn = -1;
+
+	tsem_dir = securityfs_create_dir("tsem", NULL);
+	if (!_init_inode(tsem_dir))
+		goto done;
+
+	control = securityfs_create_file("control", 0200, tsem_dir, NULL,
+					 &control_ops);
+	if (!_init_inode(control))
+		goto err;
+
+	id = securityfs_create_file("id", 0400, tsem_dir, NULL, &id_ops);
+	if (!_init_inode(id))
+		goto err;
+
+	aggregate = securityfs_create_file("aggregate", 0400, tsem_dir, NULL,
+					   &aggregate_ops);
+	if (!_init_inode(aggregate))
+		goto err;
+
+	internal_tma = securityfs_create_dir("internal_tma", tsem_dir);
+	if (!_init_inode(internal_tma))
+		goto err;
+
+	model = securityfs_create_dir("model0", internal_tma);
+	if (!_init_inode(model))
+		goto err;
+
+	forensics = securityfs_create_file("forensics", 0400, model, NULL,
+					   &forensics_ops);
+	if (!_init_inode(forensics))
+		goto err;
+
+	forensics_counts = securityfs_create_file("forensics_counts", 0400,
+						 model, NULL,
+						 &forensics_count_ops);
+	if (!_init_inode(forensics_counts))
+		goto err;
+
+	forensics_coeff = securityfs_create_file("forensics_coefficients",
+						 0400, model, NULL,
+						 &forensics_point_ops);
+	if (!_init_inode(forensics_coeff))
+		goto err;
+
+	trajectory = securityfs_create_file("trajectory", 0400, model, NULL,
+					     &trajectory_ops);
+	if (!_init_inode(trajectory))
+		goto err;
+
+	trajectory_counts = securityfs_create_file("trajectory_counts", 0400,
+						   model, NULL,
+						   &trajectory_count_ops);
+	if (!_init_inode(trajectory_counts))
+		goto err;
+
+	trajectory_coeff = securityfs_create_file("trajectory_coefficients",
+						  0400, model, NULL,
+						  &trajectory_point_ops);
+	if (!_init_inode(trajectory_coeff))
+		goto err;
+
+	measurement = securityfs_create_file("measurement", 0400,
+						  model, NULL,
+						  &measurement_ops);
+	if (!_init_inode(measurement))
+		goto err;
+
+	state = securityfs_create_file("state", 0400, model, NULL,
+					&state_ops);
+	if (!_init_inode(state))
+		goto err;
+
+	external_tma = securityfs_create_dir("external_tma", tsem_dir);
+	if (!_init_inode(external_tma))
+		goto err;
+
+	retn = 0;
+
+ done:
+	return retn;
+
+ err:
+	securityfs_remove(tsem_dir);
+	securityfs_remove(control);
+	securityfs_remove(id);
+	securityfs_remove(aggregate);
+	securityfs_remove(internal_tma);
+	securityfs_remove(model);
+	securityfs_remove(forensics);
+	securityfs_remove(forensics_counts);
+	securityfs_remove(forensics_coeff);
+	securityfs_remove(trajectory);
+	securityfs_remove(trajectory_counts);
+	securityfs_remove(trajectory_coeff);
+	securityfs_remove(measurement);
+	securityfs_remove(state);
+	securityfs_remove(external_tma);
+
+	return retn;
+}
-- 
2.39.1


