Return-Path: <linux-kernel+bounces-58873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E2884EDEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378FD286333
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1C51C3A;
	Thu,  8 Feb 2024 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxL9YA+3"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B550A7B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435398; cv=none; b=Uo+/U+Jmf2fVmGlKpetTFyhdudFl3flyYrWNi+sxdl/ab08O9mEggIUyukWnA2Dd69lD7i5axYc7SueBzIN1KDp/lDiAk53jUxXx4rAbWsEDST+Gq1OomekxZShX6xy5NdS4V6L65udK+68kAuRYTj7q+IHwi4B0SvNJgUI8uLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435398; c=relaxed/simple;
	bh=pU2R7R9pNMSfp6GuYNbwVP8FXKJCv0+8DQFqxWbFRPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aILfKjxJ0SbVDa3HWFvVDinBMT40XJN4IOJHaHuZBTmBRzDi5QZ8KmJUs7eWqyAv2YhWhEa62l2W1lKXmW1UiPrm2VZenzbFRwBSYjbncjL/S+m/uv8jZHm0xhdBAQjn9NvSVNJL9RiY9IlAFkdEJDbNqYGL8Fn7a3ezUmMjzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxL9YA+3; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-363c7d490d1so1047635ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 15:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707435395; x=1708040195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VseNKShEZVIhSp6Z0dgtYv7FYpAIfKiH0JGf3Hfn/7I=;
        b=KxL9YA+3n99csEd3fV4lyiwzgXvH+A2Sfn1xp8ipyqPjlre/eaiE9CB6zfzGBpU79e
         OpMuX7kW9nXrM37AJFQlG/Xkx5p3AFCeIb8b6Y+ZH2IVUYdNSk8xYA0Y25ihqjE0ZEBa
         ZspORSNzk9737ziI0gNXVNp9L03pPMQQOz94LB+bHT0VhDSQvzsTAd1iZdwWpC0ex8+o
         ZHG8z7qhtSeb3THCWb5A9+FnEyyTCcMJgW3jTNPab6/vMdGiq1tk1f743GJ2gr1eYuDh
         8IKeb8cxhNk9ckvBJahLTCR0TBYKsOrgWco9nwM4touBhNAhTco3MOsAVxoAe7CUV4a4
         2AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707435395; x=1708040195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VseNKShEZVIhSp6Z0dgtYv7FYpAIfKiH0JGf3Hfn/7I=;
        b=EALtwUh6ZKqLD8MwFMrhq4batEMpDa9G1QkRuqlBrt/Pni8RdtW1KAmJ1hL0YqUkHd
         ycoCBLtl6KqbrxlTPd/Ku/rw/6lB7DTGB/EqWrA+8OOLdplOy1CMfo6rzTRwhZcYDCHK
         9iN6wrmECgYM1DzWCW15Y3LOcyddqTia2Lpcihor/9Y0EvQ06b+ZtyjIXjOJMptJUFj8
         /g1j9P+QfO8SeFrUOQN6kAnHWeC87rQAaO1ZCptmRsE5dl0Bre5e8sNN3R6MyfJHMLtP
         y57IuEwDBHoixZ23eOdHjRx/mUBtZjMkHC3/5eOgsT+kWYGuxTFezAFJhTQZEuvOKqF7
         8bPw==
X-Gm-Message-State: AOJu0YzSBRFq01R+cbWp7uK3w8Yy33DxqQj2dZbgWqNHF5SxtrTkH6yi
	1nnYDAApXSOTlICr/DGmGXKL+44nuij/br3+/Ck0IxjtHI1H6xLhtBMHdQOxvzg=
X-Google-Smtp-Source: AGHT+IGizapbkbricKBSDT+0fvXp97jrUfex0icTpLvDL0wKrsOfr9q0hFdRdS48NVhy92m7A8cNwA==
X-Received: by 2002:a05:6e02:1d02:b0:363:c288:f8d7 with SMTP id i2-20020a056e021d0200b00363c288f8d7mr149286ila.1.1707435395457;
        Thu, 08 Feb 2024 15:36:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6yhwcXIhu2d+H2QCnSi4jcbwLoQw9JjdV8TO0YWyxEFxDLTxiVhr3f1vZdowk1GnsMCmVtxW3LOLXtElz87R4LA==
Received: from opengear-rohan.test.bne.opengear.com (brisbane.opengear.com. [60.241.24.90])
        by smtp.googlemail.com with ESMTPSA id i15-20020a02c60f000000b004716310b240sm113279jan.124.2024.02.08.15.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 15:36:34 -0800 (PST)
From: Rohan Kollambalath <rohankollambalath@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Rohan Kollambalath <rkollamb@digi.com>
Subject: [PATCH] sysfs:Addresses null pointer dereference in sysfs_merge_group and sysfs_unmerge_group.
Date: Fri,  9 Feb 2024 09:36:26 +1000
Message-Id: <20240208233626.657587-1-rohankollambalath@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rohan Kollambalath <rkollamb@digi.com>

These functions take a struct attribute_group as an input which has an
optional .name field. These functions rely on the .name field being
populated and do not check if its null. They pass this name into other
functions, eventually leading to a null pointer dereference.

This change adds a simple check that returns an error if the .name field
is null and clarifies this requirement in the comments.

Signed-off-by: Rohan Kollambalath <rkollamb@digi.com>
---
 fs/sysfs/group.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 138676463336..a221de8c95a2 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -318,12 +318,12 @@ void sysfs_remove_groups(struct kobject *kobj,
 EXPORT_SYMBOL_GPL(sysfs_remove_groups);
 
 /**
- * sysfs_merge_group - merge files into a pre-existing attribute group.
+ * sysfs_merge_group - merge files into a pre-existing named attribute group.
  * @kobj:	The kobject containing the group.
  * @grp:	The files to create and the attribute group they belong to.
  *
- * This function returns an error if the group doesn't exist or any of the
- * files already exist in that group, in which case none of the new files
+ * This function returns an error if the group doesn't exist, the .name field is NULL or
+ * any of the files already exist in that group, in which case none of the new files
  * are created.
  */
 int sysfs_merge_group(struct kobject *kobj,
@@ -336,6 +336,9 @@ int sysfs_merge_group(struct kobject *kobj,
 	struct attribute *const *attr;
 	int i;
 
+	if (!grp->name)
+		return -ENOENT;
+
 	parent = kernfs_find_and_get(kobj->sd, grp->name);
 	if (!parent)
 		return -ENOENT;
@@ -356,7 +359,7 @@ int sysfs_merge_group(struct kobject *kobj,
 EXPORT_SYMBOL_GPL(sysfs_merge_group);
 
 /**
- * sysfs_unmerge_group - remove files from a pre-existing attribute group.
+ * sysfs_unmerge_group - remove files from a pre-existing named attribute group.
  * @kobj:	The kobject containing the group.
  * @grp:	The files to remove and the attribute group they belong to.
  */
@@ -366,6 +369,9 @@ void sysfs_unmerge_group(struct kobject *kobj,
 	struct kernfs_node *parent;
 	struct attribute *const *attr;
 
+	if (!grp->name)
+		return -ENOENT;
+
 	parent = kernfs_find_and_get(kobj->sd, grp->name);
 	if (parent) {
 		for (attr = grp->attrs; *attr; ++attr)
-- 
2.25.1


