Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A197A9751
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjIURWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjIURWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:22:25 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5510901
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:29 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RrlYC18FHzMqhBG;
        Thu, 21 Sep 2023 06:17:03 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RrlYB4Xq2zMppKP;
        Thu, 21 Sep 2023 08:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1695277023;
        bh=tfluk0tM+VKusjLjyhKOpiGufsPkbpoIakP1eY7gXNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNfrZh6IDKZrDicB2+bARdYE6NtmcpduNn5qRqObGXEJru5ZIJQDWeYW2R7BGlgl7
         f0s3As+HsvTImQURLGsLLzza6ouTcvPDM/dWFoI1eXF24ERqXtW6GNBOuIJxftRo4U
         BpJI1H8QL3dQ+Lr0nGxZbxCi4kd9hWSbWYBe4/mM=
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
Subject: [RFC PATCH v1 5/7] landlock: Log file-related requests
Date:   Thu, 21 Sep 2023 08:16:39 +0200
Message-ID: <20230921061641.273654-6-mic@digikod.net>
In-Reply-To: <20230921061641.273654-1-mic@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audit support for mkdir, mknod, symlink, unlink, rmdir, truncate,
and open requests.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/audit.c | 114 ++++++++++++++++++++++++++++++++++++++
 security/landlock/audit.h |  32 +++++++++++
 security/landlock/fs.c    |  62 ++++++++++++++++++---
 3 files changed, 199 insertions(+), 9 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index d9589d07e126..148fc0fafef4 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -14,6 +14,25 @@
 
 atomic64_t ruleset_and_domain_counter = ATOMIC64_INIT(0);
 
+static const char *op_to_string(enum landlock_operation operation)
+{
+	const char *const desc[] = {
+		[0] = "",
+		[LANDLOCK_OP_MKDIR] = "mkdir",
+		[LANDLOCK_OP_MKNOD] = "mknod",
+		[LANDLOCK_OP_SYMLINK] = "symlink",
+		[LANDLOCK_OP_UNLINK] = "unlink",
+		[LANDLOCK_OP_RMDIR] = "rmdir",
+		[LANDLOCK_OP_TRUNCATE] = "truncate",
+		[LANDLOCK_OP_OPEN] = "open",
+	};
+
+	if (WARN_ON_ONCE(operation < 0 || operation > ARRAY_SIZE(desc)))
+		return "unknown";
+
+	return desc[operation];
+}
+
 #define BIT_INDEX(bit) HWEIGHT(bit - 1)
 
 static void log_accesses(struct audit_buffer *const ab,
@@ -141,3 +160,98 @@ void landlock_log_release_ruleset(const struct landlock_ruleset *const ruleset)
 	audit_log_format(ab, "op=release-%s %s=%llu", name, name, id);
 	audit_log_end(ab);
 }
+
+/* Update request.youngest_domain and request.missing_access */
+static void
+update_request(struct landlock_request *const request,
+	       const struct landlock_ruleset *const domain,
+	       const access_mask_t access_request,
+	       const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
+{
+	const unsigned long access_req = access_request;
+	unsigned long access_bit;
+	long youngest_denied_layer = -1;
+	const struct landlock_hierarchy *node = domain->hierarchy;
+	size_t i;
+
+	WARN_ON_ONCE(request->youngest_domain);
+	WARN_ON_ONCE(request->missing_access);
+
+	if (WARN_ON_ONCE(!access_request))
+		return;
+
+	if (WARN_ON_ONCE(!layer_masks))
+		return;
+
+	for_each_set_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks)) {
+		long domain_layer;
+
+		if (!(*layer_masks)[access_bit])
+			continue;
+
+		domain_layer = __fls((*layer_masks)[access_bit]);
+
+		/*
+		 * Gets the access rights that are missing from
+		 * the youngest (i.e. closest) domain.
+		 */
+		if (domain_layer == youngest_denied_layer) {
+			request->missing_access |= BIT_ULL(access_bit);
+		} else if (domain_layer > youngest_denied_layer) {
+			youngest_denied_layer = domain_layer;
+			request->missing_access = BIT_ULL(access_bit);
+		}
+	}
+
+	WARN_ON_ONCE(!request->missing_access);
+	WARN_ON_ONCE(youngest_denied_layer < 0);
+
+	/* Gets the nearest domain ID that denies request.missing_access */
+	for (i = domain->num_layers - youngest_denied_layer - 1; i > 0; i--)
+		node = node->parent;
+	request->youngest_domain = node->id;
+}
+
+static void
+log_request(const int error, struct landlock_request *const request,
+	    const struct landlock_ruleset *const domain,
+	    const access_mask_t access_request,
+	    const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
+{
+	struct audit_buffer *ab;
+
+	if (WARN_ON_ONCE(!error))
+		return;
+	if (WARN_ON_ONCE(!request))
+		return;
+	if (WARN_ON_ONCE(!domain || !domain->hierarchy))
+		return;
+
+	/* Uses GFP_ATOMIC to not sleep. */
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_LANDLOCK);
+	if (!ab)
+		return;
+
+	update_request(request, domain, access_request, layer_masks);
+
+	log_task(ab);
+	audit_log_format(ab, " domain=%llu op=%s errno=%d missing-fs-accesses=",
+			 request->youngest_domain,
+			 op_to_string(request->operation), -error);
+	log_accesses(ab, request->missing_access);
+	audit_log_lsm_data(ab, &request->audit);
+	audit_log_end(ab);
+}
+
+// TODO: Make it generic, not FS-centric.
+int landlock_log_request(
+	const int error, struct landlock_request *const request,
+	const struct landlock_ruleset *const domain,
+	const access_mask_t access_request,
+	const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
+{
+	/* No need to log the access request, only the missing accesses. */
+	log_request(error, request, domain, access_request, layer_masks);
+	return error;
+}
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index bc17dc8ca6f1..8edc68b98fca 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -13,6 +13,23 @@
 
 #include "ruleset.h"
 
+enum landlock_operation {
+	LANDLOCK_OP_MKDIR = 1,
+	LANDLOCK_OP_MKNOD,
+	LANDLOCK_OP_SYMLINK,
+	LANDLOCK_OP_UNLINK,
+	LANDLOCK_OP_RMDIR,
+	LANDLOCK_OP_TRUNCATE,
+	LANDLOCK_OP_OPEN,
+};
+
+struct landlock_request {
+	const enum landlock_operation operation;
+	access_mask_t missing_access;
+	u64 youngest_domain;
+	struct common_audit_data audit;
+};
+
 #ifdef CONFIG_AUDIT
 
 void landlock_log_create_ruleset(struct landlock_ruleset *const ruleset);
@@ -20,6 +37,12 @@ void landlock_log_restrict_self(struct landlock_ruleset *const domain,
 				struct landlock_ruleset *const ruleset);
 void landlock_log_release_ruleset(const struct landlock_ruleset *const ruleset);
 
+int landlock_log_request(
+	const int error, struct landlock_request *const request,
+	const struct landlock_ruleset *const domain,
+	const access_mask_t access_request,
+	const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS]);
+
 #else /* CONFIG_AUDIT */
 
 static inline void
@@ -38,6 +61,15 @@ landlock_log_release_ruleset(const struct landlock_ruleset *const ruleset)
 {
 }
 
+static inline int landlock_log_request(
+	const int error, struct landlock_request *const request,
+	const struct landlock_ruleset *const domain,
+	const access_mask_t access_request,
+	const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
+{
+	return error;
+}
+
 #endif /* CONFIG_AUDIT */
 
 #endif /* _SECURITY_LANDLOCK_AUDIT_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 978e325d8708..104dfb2abc32 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/list.h>
+#include <linux/lsm_audit.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
@@ -30,6 +31,7 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
 
+#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "fs.h"
@@ -636,7 +638,8 @@ static bool is_access_to_paths_allowed(
 }
 
 static int current_check_access_path(const struct path *const path,
-				     access_mask_t access_request)
+				     access_mask_t access_request,
+				     struct landlock_request *const request)
 {
 	const struct landlock_ruleset *const dom =
 		landlock_get_current_domain();
@@ -650,7 +653,10 @@ static int current_check_access_path(const struct path *const path,
 				       NULL, 0, NULL, NULL))
 		return 0;
 
-	return -EACCES;
+	request->audit.type = LSM_AUDIT_DATA_PATH;
+	request->audit.u.path = *path;
+	return landlock_log_request(-EACCES, request, dom, access_request,
+				    &layer_masks);
 }
 
 static inline access_mask_t get_mode_access(const umode_t mode)
@@ -1097,6 +1103,7 @@ static int hook_path_link(struct dentry *const old_dentry,
 			  const struct path *const new_dir,
 			  struct dentry *const new_dentry)
 {
+	// TODO: Implement fine-grained audit
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
 					false);
 }
@@ -1115,38 +1122,67 @@ static int hook_path_rename(const struct path *const old_dir,
 static int hook_path_mkdir(const struct path *const dir,
 			   struct dentry *const dentry, const umode_t mode)
 {
-	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_DIR);
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_MKDIR,
+	};
+
+	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_DIR,
+					 &request);
 }
 
 static int hook_path_mknod(const struct path *const dir,
 			   struct dentry *const dentry, const umode_t mode,
 			   const unsigned int dev)
 {
-	return current_check_access_path(dir, get_mode_access(mode));
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_MKNOD,
+	};
+
+	return current_check_access_path(dir, get_mode_access(mode), &request);
 }
 
 static int hook_path_symlink(const struct path *const dir,
 			     struct dentry *const dentry,
 			     const char *const old_name)
 {
-	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_SYM);
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_SYMLINK,
+	};
+
+	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_SYM,
+					 &request);
 }
 
 static int hook_path_unlink(const struct path *const dir,
 			    struct dentry *const dentry)
 {
-	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE);
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_UNLINK,
+	};
+
+	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE,
+					 &request);
 }
 
 static int hook_path_rmdir(const struct path *const dir,
 			   struct dentry *const dentry)
 {
-	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_RMDIR,
+	};
+
+	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR,
+					 &request);
 }
 
 static int hook_path_truncate(const struct path *const path)
 {
-	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_TRUNCATE,
+	};
+
+	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE,
+					 &request);
 }
 
 /* File hooks */
@@ -1199,6 +1235,13 @@ static int hook_file_open(struct file *const file)
 	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
 	const struct landlock_ruleset *const dom =
 		landlock_get_current_domain();
+	struct landlock_request request = {
+		.operation = LANDLOCK_OP_OPEN,
+		.audit = {
+			.type = LSM_AUDIT_DATA_PATH,
+			.u.path = file->f_path,
+		},
+	};
 
 	if (!dom)
 		return 0;
@@ -1249,7 +1292,8 @@ static int hook_file_open(struct file *const file)
 	if ((open_access_request & allowed_access) == open_access_request)
 		return 0;
 
-	return -EACCES;
+	return landlock_log_request(-EACCES, &request, dom, open_access_request,
+				    &layer_masks);
 }
 
 static int hook_file_truncate(struct file *const file)
-- 
2.42.0

