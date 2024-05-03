Return-Path: <linux-kernel+bounces-168347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E31C8BB726
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14D31C22859
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621E28593E;
	Fri,  3 May 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q2o+8Itj"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937D82C88;
	Fri,  3 May 2024 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775556; cv=none; b=PiSaX8uU0lpalNDCgAMFimB/ydEJ80L7mzb6u5hGjYRWv/GHr9ajtEQfHRSB5uhN6qufRZpYEz6IjZw0o9OCDBv6ITierT1m2FcHGq8uFZeDOZiCIsS18eGbf2V1y051w5DA9pmwdiMGwChe7Y2xiURnht3DQhXve49gPb3tQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775556; c=relaxed/simple;
	bh=0v1Zo4qQhCF7cuYTLut+HMo3yAsxmP/yI/WQ69PCOmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QyloGsJRScd5Odydx3c0sl3M+nyY9ZCofJM68XY3+rOlebw4lgfp0oR/nbvWwQLpPkKaHcYmHYGHG6z9m1gTm2gz7frblMUvR1tTQFsCK58aoJ9jh2BSDokPcTf4Hznro+CkbnS3Kb5QC+5BMppez43kpLMjAhsSQOIwivX/vHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q2o+8Itj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id E34DB20B2C86; Fri,  3 May 2024 15:32:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E34DB20B2C86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714775552;
	bh=tyU1fdZY/WjFMXTyscqC7UlqchwkgkYLBYHiiOkh8ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2o+8Itjt3Iw4RNaLXn124tIpN4Jn8ECRCP67LWRLozL6m9fn6+00bOWvbmPsIFlM
	 Nd5i/458FGhk2lF9zwIlOCJDjv0hZzbVb/uOJAF4UlkzYgOhVo5wte3FvfiVi98PGT
	 gmwSzVVKs5xs92mzLt/VaikyM+6gxhvte2JPCq2A=
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
Subject: [PATCH v18 03/21] ipe: add evaluation loop
Date: Fri,  3 May 2024 15:32:13 -0700
Message-Id: <1714775551-22384-4-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Deven Bowers <deven.desai@linux.microsoft.com>

Introduce a core evaluation function in IPE that will be triggered by
various security hooks (e.g., mmap, bprm_check, kexec). This function
systematically assesses actions against the defined IPE policy, by
iterating over rules specific to the action being taken. This critical
addition enables IPE to enforce its security policies effectively,
ensuring that actions intercepted by these hooks are scrutinized for policy
compliance before they are allowed to proceed.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v2:
+ Split evaluation loop, access control hooks, and evaluation loop from policy parser and userspace interface to pass mailing list character limit

v3:
+ Move ipe_load_properties to patch 04.
+ Remove useless 0-initializations Prefix extern variables with ipe_
+ Remove kernel module parameters, as these are exposed through sysctls.
+ Add more prose to the IPE base config option help text.
+ Use GFP_KERNEL for audit_log_start.
+ Remove unnecessary caching system.
+ Remove comments from headers
+ Use rcu_access_pointer for rcu-pointer null check
+ Remove usage of reqprot; use prot only.
+Move policy load and activation audit event to 03/12

v4:
+ Remove sysctls in favor of securityfs nodes
+ Re-add kernel module parameters, as these are now exposed through securityfs.
+ Refactor property audit loop to a separate function.

v5:
+ fix minor grammatical errors
+ do not group rule by curly-brace in audit record,
+ reconstruct the exact rule.

v6:
+ No changes

v7:
+ Further split lsm creation into a separate commit from the evaluation loop and audit system, for easier review.
+ Propagating changes to support the new ipe_context structure in the evaluation loop.

v8:
+ Remove ipe_hook enumeration; hooks can be correlated via syscall record.

v9:
+ Remove ipe_context related code and simplify the evaluation loop.

v10:
+ Split eval part and boot_verified part

v11:
+ Fix code style issues

v12:
+ Correct an rcu_read_unlock usage
+ Add a WARN to unknown op during evaluation

v13:
+ No changes

v14:
+ No changes

v15:
+ No changes

v16:
+ No changes

v17:
+ Add years to license header
+ Fix code and documentation style issues

v18:
+ No changes
---
 security/ipe/Makefile |   1 +
 security/ipe/eval.c   | 102 ++++++++++++++++++++++++++++++++++++++++++
 security/ipe/eval.h   |  24 ++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 security/ipe/eval.c
 create mode 100644 security/ipe/eval.h

diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index 3093de1afd3e..4cc17eb92060 100644
--- a/security/ipe/Makefile
+++ b/security/ipe/Makefile
@@ -6,6 +6,7 @@
 #
 
 obj-$(CONFIG_SECURITY_IPE) += \
+	eval.o \
 	ipe.o \
 	policy.o \
 	policy_parser.o \
diff --git a/security/ipe/eval.c b/security/ipe/eval.c
new file mode 100644
index 000000000000..41331afdef7c
--- /dev/null
+++ b/security/ipe/eval.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2024 Microsoft Corporation. All rights reserved.
+ */
+
+#include <linux/fs.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/sched.h>
+#include <linux/rcupdate.h>
+
+#include "ipe.h"
+#include "eval.h"
+#include "policy.h"
+
+struct ipe_policy __rcu *ipe_active_policy;
+
+/**
+ * evaluate_property() - Analyze @ctx against a rule property.
+ * @ctx: Supplies a pointer to the context to be evaluated.
+ * @p: Supplies a pointer to the property to be evaluated.
+ *
+ * This is a placeholder. The actual function will be introduced in the
+ * latter commits.
+ *
+ * Return:
+ * * %true	- The current @ctx match the @p
+ * * %false	- The current @ctx doesn't match the @p
+ */
+static bool evaluate_property(const struct ipe_eval_ctx *const ctx,
+			      struct ipe_prop *p)
+{
+	return false;
+}
+
+/**
+ * ipe_evaluate_event() - Analyze @ctx against the current active policy.
+ * @ctx: Supplies a pointer to the context to be evaluated.
+ *
+ * This is the loop where all policy evaluation happens against IPE policy.
+ *
+ * Return:
+ * * %0		- Success
+ * * %-EACCES	- @ctx did not pass evaluation
+ */
+int ipe_evaluate_event(const struct ipe_eval_ctx *const ctx)
+{
+	const struct ipe_op_table *rules = NULL;
+	const struct ipe_rule *rule = NULL;
+	struct ipe_policy *pol = NULL;
+	struct ipe_prop *prop = NULL;
+	enum ipe_action_type action;
+	bool match = false;
+
+	rcu_read_lock();
+
+	pol = rcu_dereference(ipe_active_policy);
+	if (!pol) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	if (ctx->op == IPE_OP_INVALID) {
+		if (pol->parsed->global_default_action == IPE_ACTION_DENY) {
+			rcu_read_unlock();
+			return -EACCES;
+		}
+		if (pol->parsed->global_default_action == IPE_ACTION_INVALID)
+			WARN(1, "no default rule set for unknown op, ALLOW it");
+		rcu_read_unlock();
+		return 0;
+	}
+
+	rules = &pol->parsed->rules[ctx->op];
+
+	list_for_each_entry(rule, &rules->rules, next) {
+		match = true;
+
+		list_for_each_entry(prop, &rule->props, next) {
+			match = evaluate_property(ctx, prop);
+			if (!match)
+				break;
+		}
+
+		if (match)
+			break;
+	}
+
+	if (match)
+		action = rule->action;
+	else if (rules->default_action != IPE_ACTION_INVALID)
+		action = rules->default_action;
+	else
+		action = pol->parsed->global_default_action;
+
+	rcu_read_unlock();
+	if (action == IPE_ACTION_DENY)
+		return -EACCES;
+
+	return 0;
+}
diff --git a/security/ipe/eval.h b/security/ipe/eval.h
new file mode 100644
index 000000000000..b137f2107852
--- /dev/null
+++ b/security/ipe/eval.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2024 Microsoft Corporation. All rights reserved.
+ */
+
+#ifndef _IPE_EVAL_H
+#define _IPE_EVAL_H
+
+#include <linux/file.h>
+#include <linux/types.h>
+
+#include "policy.h"
+
+extern struct ipe_policy __rcu *ipe_active_policy;
+
+struct ipe_eval_ctx {
+	enum ipe_op_type op;
+
+	const struct file *file;
+};
+
+int ipe_evaluate_event(const struct ipe_eval_ctx *const ctx);
+
+#endif /* _IPE_EVAL_H */
-- 
2.44.0


