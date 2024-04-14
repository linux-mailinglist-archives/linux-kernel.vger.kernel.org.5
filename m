Return-Path: <linux-kernel+bounces-143468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE58A39E6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4622C1C216E3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18895644B;
	Sat, 13 Apr 2024 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cWu/3puw"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06439A95B;
	Sat, 13 Apr 2024 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969770; cv=none; b=k+jkQxsevOg5mcGRMWyeOFq/i3BCjXnXJSl9Rcs1CmNkx9m7wOAj+9mUeS5bQAlbjilZyJu+TBjdS/Oydi6UOFrZgYwIVYv0DsLC40GQRq2OIEcAupylWM/+sdOBURfPOAGkDTVI9hGeMVXbVZWyV24aNFyDpwkay2lkcKmLk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969770; c=relaxed/simple;
	bh=u4EB7OavlrvQZ7jK4/N0L97r9Xrm1zzGppbS+N3Akes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I6+bigAbNIbM2/LaUPVDdchbk2AfbRhqqfGTW2a0vaeRYG5sgUwYlYHMSh//BQfQshWxeOZZevG6apP+jO9xzvnF9fjCsC/3mqJiaRuLDhSsiw3Y0hlPKxdwktLjvbmiGqMq8haieFpD9+QDRVdAIWVPeLkU8WtqVatauds3SCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cWu/3puw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id DA3FF20F32DE; Fri, 12 Apr 2024 17:56:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA3FF20F32DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712969765;
	bh=LcSXKB9QPXVI6IYs8/MJJnvnhSv6MJ+tEAS0LjTZZdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cWu/3puw7HOSdHoAChzZGHW95qPsWFVaZ+tBz6kr2igf4PbOFymuNrDnpe+2kDXvN
	 hrEp1UvJ2SJipvb6tfJnUC4+eIu2/BEQGPqkt60OO2Xr+lWy+rwY0hGpqn8WPjwSWE
	 HBRLWBltFXJBDowdkBz7k4kYCrLZOzbe2/pyek/o=
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
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v17 07/21] security: add new securityfs delete function
Date: Fri, 12 Apr 2024 17:55:50 -0700
Message-Id: <1712969764-31039-8-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When deleting a directory in the security file system, the existing
securityfs_remove requires the directory to be empty, otherwise
it will do nothing. This leads to a potential risk that the security
file system might be in an unclean state when the intended deletion
did not happen.

This commit introduces a new function securityfs_recursive_remove
to recursively delete a directory without leaving an unclean state.

Co-developed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v1-v8:
  + Not present

v9:
  + Introduced

v10:
  + No changes

v11:
  + Fix code style issues

v12:
  + No changes

v13:
  + No changes

v14:
  + No changes

v15:
  + No changes

v16:
  + No changes

v17:
  + No changes
---
 include/linux/security.h |  1 +
 security/inode.c         | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 14fff542f2e3..f35af7b6cfba 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2089,6 +2089,7 @@ struct dentry *securityfs_create_symlink(const char *name,
 					 const char *target,
 					 const struct inode_operations *iops);
 extern void securityfs_remove(struct dentry *dentry);
+extern void securityfs_recursive_remove(struct dentry *dentry);
 
 #else /* CONFIG_SECURITYFS */
 
diff --git a/security/inode.c b/security/inode.c
index 9e7cde913667..f21847badb7d 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -313,6 +313,31 @@ void securityfs_remove(struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
+static void remove_one(struct dentry *victim)
+{
+	simple_release_fs(&mount, &mount_count);
+}
+
+/**
+ * securityfs_recursive_remove - recursively removes a file or directory
+ *
+ * @dentry: a pointer to a the dentry of the file or directory to be removed.
+ *
+ * This function recursively removes a file or directory in securityfs that was
+ * previously created with a call to another securityfs function (like
+ * securityfs_create_file() or variants thereof.)
+ */
+void securityfs_recursive_remove(struct dentry *dentry)
+{
+	if (IS_ERR_OR_NULL(dentry))
+		return;
+
+	simple_pin_fs(&fs_type, &mount, &mount_count);
+	simple_recursive_removal(dentry, remove_one);
+	simple_release_fs(&mount, &mount_count);
+}
+EXPORT_SYMBOL_GPL(securityfs_recursive_remove);
+
 #ifdef CONFIG_SECURITY
 static struct dentry *lsm_dentry;
 static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
-- 
2.44.0


