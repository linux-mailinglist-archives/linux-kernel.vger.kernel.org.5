Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A067A9D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjIUT3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIUT3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:25 -0400
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9812463
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:06:56 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RrlYF10fszMpnvZ;
        Thu, 21 Sep 2023 06:17:05 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RrlYD43PYzMppDY;
        Thu, 21 Sep 2023 08:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1695277025;
        bh=cinTwRA+WcJIbifJHzOy8LJVvQYuI7/JZgdtZ57GtzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=up0um0B1XHsyeQkuudhIT3U+5pTFTjDV0n7klWUvkP46xo+7VG6DPTYrZ+EB1ewzb
         pkHEEkMfvi0v0Vu+/YLb64C0x9i3a9Hm07og2eq4jJz/7pVdStNskZGiAewR1Py4Ye
         hPTIYrcmWLdYpcX3yAH37Zz0KL/duU1m/sFGabHE=
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
Subject: [RFC PATCH v1 7/7] landlock: Log ptrace requests
Date:   Thu, 21 Sep 2023 08:16:41 +0200
Message-ID: <20230921061641.273654-8-mic@digikod.net>
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

Add audit support for ptrace and ptrace_traceme requests.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/audit.c  |  2 ++
 security/landlock/audit.h  |  4 +++-
 security/landlock/ptrace.c | 47 ++++++++++++++++++++++++++++++++++----
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 89bd701d124f..2ec2a00822d2 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -18,6 +18,8 @@ static const char *op_to_string(enum landlock_operation operation)
 {
 	const char *const desc[] = {
 		[0] = "",
+		[LANDLOCK_OP_PTRACE] = "ptrace",
+		[LANDLOCK_OP_PTRACE_TRACEME] = "ptrace_traceme",
 		[LANDLOCK_OP_MOUNT] = "mount",
 		[LANDLOCK_OP_MOVE_MOUNT] = "move_mount",
 		[LANDLOCK_OP_UMOUNT] = "umount",
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index e559fb6a89dd..b69bba7b908c 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -14,7 +14,9 @@
 #include "ruleset.h"
 
 enum landlock_operation {
-	LANDLOCK_OP_MOUNT = 1,
+	LANDLOCK_OP_PTRACE = 1,
+	LANDLOCK_OP_PTRACE_TRACEME,
+	LANDLOCK_OP_MOUNT,
 	LANDLOCK_OP_MOVE_MOUNT,
 	LANDLOCK_OP_UMOUNT,
 	LANDLOCK_OP_REMOUNT,
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
index 8a06d6c492bf..dbe219449a32 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/ptrace.c
@@ -10,10 +10,12 @@
 #include <linux/cred.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/lsm_audit.h>
 #include <linux/lsm_hooks.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 
+#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "ptrace.h"
@@ -64,11 +66,9 @@ static bool task_is_scoped(const struct task_struct *const parent,
 static int task_ptrace(const struct task_struct *const parent,
 		       const struct task_struct *const child)
 {
-	/* Quick return for non-landlocked tasks. */
-	if (!landlocked(parent))
-		return 0;
 	if (task_is_scoped(parent, child))
 		return 0;
+
 	return -EPERM;
 }
 
@@ -88,7 +88,26 @@ static int task_ptrace(const struct task_struct *const parent,
 static int hook_ptrace_access_check(struct task_struct *const child,
 				    const unsigned int mode)
 {
-	return task_ptrace(current, child);
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_PTRACE,
+		.missing_permission = LANDLOCK_PERM_PTRACE,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = child,
+		},
+	};
+	int err;
+
+	if (!dom)
+		return 0;
+
+	err = task_ptrace(current, child);
+	if (!err)
+		return 0;
+
+	return landlock_log_request(err, &request, dom, 0, NULL);
 }
 
 /**
@@ -105,7 +124,25 @@ static int hook_ptrace_access_check(struct task_struct *const child,
  */
 static int hook_ptrace_traceme(struct task_struct *const parent)
 {
-	return task_ptrace(parent, current);
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_PTRACE_TRACEME,
+		.missing_permission = LANDLOCK_PERM_PTRACE,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = parent,
+		},
+	};
+	int err;
+
+	if (!landlock_get_task_domain(parent))
+		return 0;
+
+	err = task_ptrace(parent, current);
+	if (!err)
+		return 0;
+
+	return landlock_log_request(err, &request,
+				    landlock_get_current_domain(), 0, NULL);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
-- 
2.42.0

