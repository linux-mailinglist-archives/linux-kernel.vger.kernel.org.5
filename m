Return-Path: <linux-kernel+bounces-133319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C4289A229
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F3A28A14A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44D917107C;
	Fri,  5 Apr 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="dXxl0WN7"
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA416ABC3;
	Fri,  5 Apr 2024 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333453; cv=none; b=YwiaEmGuvCPKVsocdJZZCALC9yXjfZ4GLhX30SvqZjgovbeRyXCN+hspwB6OJtNz9d0KYLg75mmV+autOB2MMpZJOGa7Bdcw2e9KFIyC5iYrUjlNC7eU7dJW7s7ZHLz6SZP6dyVzf1GCABkywAoFOOV65IAEX2e0rmiBNRkRXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333453; c=relaxed/simple;
	bh=IuaNYNENXvNmIch8NqAwnftW39eKkt4bYfMCRUrRUqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTLSNg1jSyise6IBLBVJf7nPZ3lJ7G7Eb3KlmLLvdoV8hrlMR/dO7jXjeJYK+7+s7g3vwP7dNsq3rv2Fi0tALTmKI6Z2ZMJEGYctZ+hRgkvr/2mh86gQhq3bi+kOQWDku33zmWnoImFVYtQqzxuSCTXmqDwbFMd+ajQ9NKwyzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=dXxl0WN7; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712333448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=65/EuaYqUYMyrh0I6zU6AC/esz68cGi8d98R5zgiH2U=;
	b=dXxl0WN7HfFkwnkTuaaMbMt9OtWmDDftoOB1zI9kzet2lDnxDjsLqbvA9XTkgxC5Pgpyrz
	AeKhoNlRjr5+EHytPPCtBGq+w2WIsy0lt4UKKFzM5yQaARypzW9ymSDUjQulwCUf2v1uQ7
	FUDL+EKSt54g62TZhir/w99l9tbC+obg2w3NlPeOUjk22zLIV7OYRONu8ItD1De2D1eql0
	DWHznnCm2XKXyWyBELoPA56HPWenVTSo2LbhdjQXfLfAqejFW+rTSVszRJ0rE3mrccDhwA
	g5EqHz4X+C3dw1DE6j7MONCFLLQnAmo1gdxWMM28EfeVIhMiVM2DcCFeDFh4AQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
	Jacob Satterfield <jsatterfield.linux@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selinux: add support for xperms in conditional policies
Date: Fri,  5 Apr 2024 18:10:11 +0200
Message-ID: <20240405161042.260113-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Add support for extended permission rules in conditional policies.
Currently the kernel accepts such rules already, but evaluating a
security decision will hit a BUG() in
services_compute_xperms_decision().  Thus reject extended permission
rules in conditional policies for current policy versions.

Add a new policy version for this feature.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Userspace patches are available at:
https://github.com/SELinuxProject/selinux/pull/432

Maybe the policy version 34 can be reused for the prefix/suffix filetrans
feature to avoid two new versions?
---
 security/selinux/include/security.h |  3 ++-
 security/selinux/ss/avtab.c         | 12 ++++++++++--
 security/selinux/ss/avtab.h         |  2 +-
 security/selinux/ss/conditional.c   |  2 +-
 security/selinux/ss/policydb.c      |  5 +++++
 security/selinux/ss/services.c      | 11 +++++++----
 security/selinux/ss/services.h      |  2 +-
 7 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 289bf9233f71..3a385821c574 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -46,10 +46,11 @@
 #define POLICYDB_VERSION_INFINIBAND	     31
 #define POLICYDB_VERSION_GLBLUB		     32
 #define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename transitions */
+#define POLICYDB_VERSION_COND_XPERMS	     34 /* extended permissions in conditional policies */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COMP_FTRANS
+#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COND_XPERMS
 
 /* Mask for just the mount related flags */
 #define SE_MNTMASK 0x0f
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 2ad98732d052..bc7f1aa3ebfb 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -339,7 +339,7 @@ static const uint16_t spec_order[] = {
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
 				   const struct avtab_datum *d, void *p),
-		    void *p)
+		    void *p, bool conditional)
 {
 	__le16 buf16[4];
 	u16 enabled;
@@ -457,6 +457,14 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		       "was specified\n",
 		       vers);
 		return -EINVAL;
+	} else if ((vers < POLICYDB_VERSION_COND_XPERMS) &&
+	       (key.specified & AVTAB_XPERMS) &&
+	       conditional) {
+		pr_err("SELinux:  avtab:  policy version %u does not "
+		       "support extended permissions rules in conditional "
+		       "policies and one was specified\n",
+		       vers);
+		return -EINVAL;
 	} else if (key.specified & AVTAB_XPERMS) {
 		memset(&xperms, 0, sizeof(struct avtab_extended_perms));
 		rc = next_entry(&xperms.specified, fp, sizeof(u8));
@@ -523,7 +531,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
+		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL, false);
 		if (rc) {
 			if (rc == -ENOMEM)
 				pr_err("SELinux: avtab: out of memory\n");
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 8e8820484c55..b48c15b3698c 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -107,7 +107,7 @@ struct policydb;
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insert)(struct avtab *a, const struct avtab_key *k,
 				  const struct avtab_datum *d, void *p),
-		    void *p);
+		    void *p, bool conditional);
 
 int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
 int avtab_write_item(struct policydb *p, const struct avtab_node *cur,
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index d53c34021dbe..ed4606e3af5d 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -349,7 +349,7 @@ static int cond_read_av_list(struct policydb *p, void *fp,
 	for (i = 0; i < len; i++) {
 		data.dst = &list->nodes[i];
 		rc = avtab_read_item(&p->te_cond_avtab, fp, p, cond_insertf,
-				     &data);
+				     &data, true);
 		if (rc) {
 			kfree(list->nodes);
 			list->nodes = NULL;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 383f3ae82a73..3ba5506a3fff 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -155,6 +155,11 @@ static const struct policydb_compat_info policydb_compat[] = {
 		.sym_num = SYM_NUM,
 		.ocon_num = OCON_NUM,
 	},
+	{
+		.version = POLICYDB_VERSION_COND_XPERMS,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM,
+	},
 };
 
 static const struct policydb_compat_info *
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e88b1b6c4adb..57f09f830a06 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -944,9 +944,10 @@ static void avd_init(struct selinux_policy *policy, struct av_decision *avd)
 }
 
 void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
-					struct avtab_node *node)
+					const struct avtab_node *node)
 {
 	unsigned int i;
+	u16 specified;
 
 	if (node->datum.u.xperms->specified == AVTAB_XPERMS_IOCTLFUNCTION) {
 		if (xpermd->driver != node->datum.u.xperms->driver)
@@ -959,7 +960,9 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 		BUG();
 	}
 
-	if (node->key.specified == AVTAB_XPERMS_ALLOWED) {
+	specified = node->key.specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
+
+	if (specified == AVTAB_XPERMS_ALLOWED) {
 		xpermd->used |= XPERMS_ALLOWED;
 		if (node->datum.u.xperms->specified == AVTAB_XPERMS_IOCTLDRIVER) {
 			memset(xpermd->allowed->p, 0xff,
@@ -970,7 +973,7 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 				xpermd->allowed->p[i] |=
 					node->datum.u.xperms->perms.p[i];
 		}
-	} else if (node->key.specified == AVTAB_XPERMS_AUDITALLOW) {
+	} else if (specified == AVTAB_XPERMS_AUDITALLOW) {
 		xpermd->used |= XPERMS_AUDITALLOW;
 		if (node->datum.u.xperms->specified == AVTAB_XPERMS_IOCTLDRIVER) {
 			memset(xpermd->auditallow->p, 0xff,
@@ -981,7 +984,7 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 				xpermd->auditallow->p[i] |=
 					node->datum.u.xperms->perms.p[i];
 		}
-	} else if (node->key.specified == AVTAB_XPERMS_DONTAUDIT) {
+	} else if (specified == AVTAB_XPERMS_DONTAUDIT) {
 		xpermd->used |= XPERMS_DONTAUDIT;
 		if (node->datum.u.xperms->specified == AVTAB_XPERMS_IOCTLDRIVER) {
 			memset(xpermd->dontaudit->p, 0xff,
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 93358e7a649c..a6d8a06fd13c 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -38,7 +38,7 @@ struct convert_context_args {
 void services_compute_xperms_drivers(struct extended_perms *xperms,
 				     struct avtab_node *node);
 void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
-				      struct avtab_node *node);
+				      const struct avtab_node *node);
 
 int services_convert_context(struct convert_context_args *args,
 			     struct context *oldc, struct context *newc,
-- 
2.43.0


