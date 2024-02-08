Return-Path: <linux-kernel+bounces-58320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748584E4A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043C9285579
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF687D3F6;
	Thu,  8 Feb 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BcIzvkQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6F7C6EF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408176; cv=none; b=WBKx5ZJtnurhhjrkCMbKR3ugz62HYodCsyUsboH7TOmodEpbFnCRuqWd4P2+QPul3Y2oNiGLNdB0V+UwPSm8y7X1evrYkl6Tw/oqCfsAWDiQAUDZOVL0POb9rce3PLLAhUncEP9U7LSH/tvW5BDw14ElKp5prU5gQXWHR9zL8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408176; c=relaxed/simple;
	bh=xp928LhpMo0dQmyBfHTiAL78Ljncr+lZjAsOE2TSsW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVQ4M4KE/Fo1T4dFKC4UXoPp1NXHi4s+BdB1YsA+89Rxag/MmmPuLqvySKgTejSCmDS27G3BnOh5bI3nqQpwLaQDOWAZeL9izOnfZsWTI+MW1ar7zxyJFUsdSx26UPZe2PlT5wMtzqR9Ua8+5+8A+1eGRLs1o8zQvvz6U6hH5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BcIzvkQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82B2C433F1;
	Thu,  8 Feb 2024 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707408176;
	bh=xp928LhpMo0dQmyBfHTiAL78Ljncr+lZjAsOE2TSsW0=;
	h=From:To:Cc:Subject:Date:From;
	b=BcIzvkQjcy6N4+lJzoFQ07C7gT6AqkgllAvTF7bGwkye65nxgeer9rHYYNi3TdP9B
	 NORZYeBGh1oG/uz12wNf620tFD3R1cC/P1/ysWDKsK86CFc4KCz+JgK/6NkIlSa/rF
	 rHAYNgwxikyIGdRermbUmz/2WmUjEWmsN09h5Xq0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel test robot <oliver.sang@intel.com>,
	Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] Revert "kobject: Remove redundant checks for whether ktype is NULL"
Date: Thu,  8 Feb 2024 16:02:50 +0000
Message-ID: <2024020849-consensus-length-6264@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 82
X-Developer-Signature: v=1; a=openpgp-sha256; l=2835; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=xp928LhpMo0dQmyBfHTiAL78Ljncr+lZjAsOE2TSsW0=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlHfms9aSz+v3u7na27m3dej/iSVR9Lpqft6b4fsZ/x1 optrj83dcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEXsQwzBXy2r7fO/hXr9q/ 9JVpZ+v2JC6ff4Rhnu6k2X76u7OeCRZlLgqziXiQybDzKAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

This reverts commit 1b28cb81dab7c1eedc6034206f4e8d644046ad31.

It is reported to cause problems, so revert it for now until the root
cause can be found.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 1b28cb81dab7 ("kobject: Remove redundant checks for whether ktype is NULL")
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Closes: https://lore.kernel.org/oe-lkp/202402071403.e302e33a-oliver.sang@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/kobject.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 59dbcbdb1c91..72fa20f405f1 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -74,10 +74,12 @@ static int create_dir(struct kobject *kobj)
 	if (error)
 		return error;
 
-	error = sysfs_create_groups(kobj, ktype->default_groups);
-	if (error) {
-		sysfs_remove_dir(kobj);
-		return error;
+	if (ktype) {
+		error = sysfs_create_groups(kobj, ktype->default_groups);
+		if (error) {
+			sysfs_remove_dir(kobj);
+			return error;
+		}
 	}
 
 	/*
@@ -589,7 +591,8 @@ static void __kobject_del(struct kobject *kobj)
 	sd = kobj->sd;
 	ktype = get_ktype(kobj);
 
-	sysfs_remove_groups(kobj, ktype->default_groups);
+	if (ktype)
+		sysfs_remove_groups(kobj, ktype->default_groups);
 
 	/* send "remove" if the caller did not do it but sent "add" */
 	if (kobj->state_add_uevent_sent && !kobj->state_remove_uevent_sent) {
@@ -666,6 +669,10 @@ static void kobject_cleanup(struct kobject *kobj)
 	pr_debug("'%s' (%p): %s, parent %p\n",
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
 
+	if (t && !t->release)
+		pr_debug("'%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
+			 kobject_name(kobj), kobj);
+
 	/* remove from sysfs if the caller did not do it */
 	if (kobj->state_in_sysfs) {
 		pr_debug("'%s' (%p): auto cleanup kobject_del\n",
@@ -676,13 +683,10 @@ static void kobject_cleanup(struct kobject *kobj)
 		parent = NULL;
 	}
 
-	if (t->release) {
+	if (t && t->release) {
 		pr_debug("'%s' (%p): calling ktype release\n",
 			 kobject_name(kobj), kobj);
 		t->release(kobj);
-	} else {
-		pr_debug("'%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
-			 kobject_name(kobj), kobj);
 	}
 
 	/* free name if we allocated it */
@@ -1056,7 +1060,7 @@ const struct kobj_ns_type_operations *kobj_child_ns_ops(const struct kobject *pa
 {
 	const struct kobj_ns_type_operations *ops = NULL;
 
-	if (parent && parent->ktype->child_ns_type)
+	if (parent && parent->ktype && parent->ktype->child_ns_type)
 		ops = parent->ktype->child_ns_type(parent);
 
 	return ops;
-- 
2.43.0


