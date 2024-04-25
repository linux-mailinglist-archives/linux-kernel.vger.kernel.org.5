Return-Path: <linux-kernel+bounces-158153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C118B1C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817B92823CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580A478C68;
	Thu, 25 Apr 2024 07:51:37 +0000 (UTC)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A278B4C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031496; cv=none; b=lhGHtBHzez2igG+sUU2OKzfjAvhSgpqgqpBi6uTLF7Czrs9AGyOzJp26iwLtvN5JhEgxBg8HBxyahnKJVkSPxEf4g1Nf4OeThLbxM3/R/A3g964LdOlpmzI0HrSVgVQJx/wwMqAHEBKMCBdcnVr9q4eG4eG4I2er0psKIEan5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031496; c=relaxed/simple;
	bh=Y9dx/WwcpcflNCFGmLro4NFAEdgR2KN+bCs5qWVd7bU=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=H8OMrC7MBBH+gABqR3zt4bJf23ve/HoqeF6R1MK9+zJVJJhX22W51WwLtNnvuJGhx4w4vstXNGkYhH0sTXT0oUhF3XlW506texctPvsRamFD+o/ays67yRG50O1vWEaqPtBjluSo3dqVcnWkE0kjPD/GM4dPMGiSMadfmyHAFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id D9B5D10189E13;
	Thu, 25 Apr 2024 09:44:42 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id A811E602F91F;
	Thu, 25 Apr 2024 09:44:42 +0200 (CEST)
X-Mailbox-Line: From e140f6bf8dc99c24cc387f7ac3c7908c8830587f Mon Sep 17 00:00:00 2001
Message-ID: <e140f6bf8dc99c24cc387f7ac3c7908c8830587f.1714030457.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 25 Apr 2024 09:44:22 +0200
Subject: [PATCH] sysfs: Allow bin_attributes to be added to groups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Dan Williams <dan.j.williams@intel.com>

Commit dfa87c824a9a ("sysfs: allow attributes to be added to groups")
introduced dynamic addition of sysfs attributes to groups.

Allow the same for bin_attributes, in support of a forthcoming commit
which adds various bin_attributes every time a PCI device is
authenticated.

Addition of bin_attributes to groups differs from regular attributes in
that different kernfs_ops are selected by sysfs_add_bin_file_mode_ns()
vis-à-vis sysfs_add_file_mode_ns().

So call either of those two functions from sysfs_add_file_to_group()
based on an additional boolean parameter and add two wrapper functions,
one for bin_attributes and another for regular attributes.

Removal of bin_attributes from groups does not require a differentiation
for bin_attributes and can use the same code path as regular attributes.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
Submitting this ahead of my PCI device authentication v2 patches.
Not sure if the patch is acceptable without an accompanying user,
but even if it's not, perhaps someone has early review feedback
or wants to provide an Acked-by?  Thank you!

 fs/sysfs/file.c       | 69 ++++++++++++++++++++++++++++++++++++-------
 include/linux/sysfs.h | 19 ++++++++++++
 2 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d1995e2d6c94..9268232781b5 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -383,14 +383,14 @@ int sysfs_create_files(struct kobject *kobj, const struct attribute * const *ptr
 }
 EXPORT_SYMBOL_GPL(sysfs_create_files);
 
-/**
- * sysfs_add_file_to_group - add an attribute file to a pre-existing group.
- * @kobj: object we're acting for.
- * @attr: attribute descriptor.
- * @group: group name.
- */
-int sysfs_add_file_to_group(struct kobject *kobj,
-		const struct attribute *attr, const char *group)
+static const struct bin_attribute *to_bin_attr(const struct attribute *attr)
+{
+	return container_of(attr, struct bin_attribute, attr);
+}
+
+static int __sysfs_add_file_to_group(struct kobject *kobj,
+				     const struct attribute *attr,
+				     const char *group, bool is_bin_attr)
 {
 	struct kernfs_node *parent;
 	kuid_t uid;
@@ -408,14 +408,49 @@ int sysfs_add_file_to_group(struct kobject *kobj,
 		return -ENOENT;
 
 	kobject_get_ownership(kobj, &uid, &gid);
-	error = sysfs_add_file_mode_ns(parent, attr, attr->mode, uid, gid,
-				       NULL);
+	if (is_bin_attr)
+		error = sysfs_add_bin_file_mode_ns(parent, to_bin_attr(attr),
+						   attr->mode, uid, gid, NULL);
+	else
+		error = sysfs_add_file_mode_ns(parent, attr,
+					       attr->mode, uid, gid, NULL);
 	kernfs_put(parent);
 
 	return error;
 }
+
+/**
+ * sysfs_add_file_to_group - add an attribute file to a pre-existing group.
+ * @kobj: object we're acting for.
+ * @attr: attribute descriptor.
+ * @group: group name.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int sysfs_add_file_to_group(struct kobject *kobj,
+			    const struct attribute *attr,
+			    const char *group)
+{
+	return __sysfs_add_file_to_group(kobj, attr, group, false);
+}
 EXPORT_SYMBOL_GPL(sysfs_add_file_to_group);
 
+/**
+ * sysfs_add_bin_file_to_group - add bin_attribute file to pre-existing group.
+ * @kobj: object we're acting for.
+ * @attr: attribute descriptor.
+ * @group: group name.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int sysfs_add_bin_file_to_group(struct kobject *kobj,
+				const struct bin_attribute *attr,
+				const char *group)
+{
+	return __sysfs_add_file_to_group(kobj, &attr->attr, group, true);
+}
+EXPORT_SYMBOL_GPL(sysfs_add_bin_file_to_group);
+
 /**
  * sysfs_chmod_file - update the modified mode value on an object attribute.
  * @kobj: object we're acting for.
@@ -565,6 +600,20 @@ void sysfs_remove_file_from_group(struct kobject *kobj,
 }
 EXPORT_SYMBOL_GPL(sysfs_remove_file_from_group);
 
+/**
+ * sysfs_remove_bin_file_from_group - remove bin_attribute file from group.
+ * @kobj: object we're acting for.
+ * @attr: attribute descriptor.
+ * @group: group name.
+ */
+void sysfs_remove_bin_file_from_group(struct kobject *kobj,
+				      const struct bin_attribute *attr,
+				      const char *group)
+{
+	sysfs_remove_file_from_group(kobj, &attr->attr, group);
+}
+EXPORT_SYMBOL_GPL(sysfs_remove_bin_file_from_group);
+
 /**
  *	sysfs_create_bin_file - create binary file for object.
  *	@kobj:	object.
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index a7d725fbf739..aff1d81e8971 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -451,6 +451,12 @@ int sysfs_add_file_to_group(struct kobject *kobj,
 			const struct attribute *attr, const char *group);
 void sysfs_remove_file_from_group(struct kobject *kobj,
 			const struct attribute *attr, const char *group);
+int sysfs_add_bin_file_to_group(struct kobject *kobj,
+				const struct bin_attribute *attr,
+				const char *group);
+void sysfs_remove_bin_file_from_group(struct kobject *kobj,
+				      const struct bin_attribute *attr,
+				      const char *group);
 int sysfs_merge_group(struct kobject *kobj,
 		       const struct attribute_group *grp);
 void sysfs_unmerge_group(struct kobject *kobj,
@@ -660,6 +666,19 @@ static inline void sysfs_remove_file_from_group(struct kobject *kobj,
 {
 }
 
+static inline int sysfs_add_bin_file_to_group(struct kobject *kobj,
+					      const struct bin_attribute *attr,
+					      const char *group)
+{
+	return 0;
+}
+
+static inline void sysfs_remove_bin_file_from_group(struct kobject *kobj,
+					      const struct bin_attribute *attr,
+					      const char *group)
+{
+}
+
 static inline int sysfs_merge_group(struct kobject *kobj,
 		       const struct attribute_group *grp)
 {
-- 
2.43.0


