Return-Path: <linux-kernel+bounces-127155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D71894784
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091A31C21FD6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012E056B6F;
	Mon,  1 Apr 2024 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZ59IzDo"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644341A81
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012501; cv=none; b=cWxxHXQ7bn3FY+n1m9uj8MUvftdXpaeOsBRhaFquTb7HtyeUzCEaoRTUG6b7eZXCVY3H9B1qCEgpAfLG7Nf7KVXiSmUzZFendSMNjVxtA3AbqIZ6Hh/tIaoJbWctL++9iikH6a/hzT0kKpi5+E3nJGTYtl8tlhjBYO92Z04ic1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012501; c=relaxed/simple;
	bh=Sw17VZ2rI5t1U7w6lSBn7Tgm6w53GtT34jTTgkY57jY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QtRarP/ea9fjmVjxJg+TuOeo8se/WkBJ7NaUqCGtv8b6S9/3jijg3iV7ZTRkdWRjwKznJ3CaPPom9TsPMkjuYH4kT1l+d/9r5CSOderJdE7j/+idfWOGPV/J/GefQHuilS4QdLIm+klosG72XAXeaf2M18zjHg6vvvFiSLNcJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZ59IzDo; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7cc74ea9c20so545897139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712012498; x=1712617298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4UCTUqrCfJ+dpmdPP9hi+yGQv3LbBnFi/puoG4yXu+A=;
        b=UZ59IzDo+aVZhpLdXkaFdWKK6akcV6wBQsTeuS7s1T6vOJpeIFm24kKSMEUt/XNqFV
         LckB/5FOUU1VrAROUZ3Ec4Rc7Dwt/IoiX552eMZhXr/hlf8RytRoc5qAm7fePh60MwhK
         i+nHMTtFtyZjWQO9tM95SS0E3mYrw2Sha2RFNwSJmmNQ6QytgMZs7E5GR8opaMAOQmEg
         Hl+4K+aagSid0gPJawo3GvntPWHBnigdJfIK+aRivaF/d96c3ayhMha/yBiPjx63n0zj
         Y4SXbyPYTt2ZogvOde3r5SUYbWdHWVb6JgPxikeFv4FuywDzzlhLRuyRJ6JBKhJPbY2+
         mJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712012498; x=1712617298;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UCTUqrCfJ+dpmdPP9hi+yGQv3LbBnFi/puoG4yXu+A=;
        b=ejF3whypJ6dkvbuTsVgi/qVgtFOVL/Cfv1vBq5KUmlj/jL/+wGw9OVtthSnagtFTIy
         VIR/1P5PbgvP2WRkwLBacVfRHAQZXeSDQDq+yKf8nIV02RbcbJ6Om3ZrGIBrvGUNnm3S
         8RO+pDpS1/EYmnBP4fBpJQqF/wDYTg/f8GnOdN/9vjR/hZ8kXIUWR5opfSw9Uljim5Bt
         BqeiNwKQlFqJqDPWst40PMe6S9PzJ7jrs3430JcyzbkkGFUetWB9LdkASeJ5ySqH7hAC
         a+Xc5iXBOtsZcy3zEOgCDuhdK0hLvWaZZRx3GXKFPoohlQQ+cNFV6m3l8RMIZKZjoZ7Y
         HsBg==
X-Forwarded-Encrypted: i=1; AJvYcCW15rwO01FK1f/8SuDXVL0wdQb82C9MEPE8TTYaiP89qTCq8vNGiXBsyTsqeDDwyNAFiNLgSDQwdha7HxFGDz9qJKfmT7x8KZPf+dyu
X-Gm-Message-State: AOJu0YztCZ4cnfW0kKagvh/6wxPxRoYLZt9qZXV1QM5clvQZ1mqbHES5
	O3b/SSA0Nv5Bg0q2pmEwxiw4IaMxlv3C1CaBi1OieuzggF7Xs0jtr3r7BVGd8VwjNbsSEGPJFH0
	0PzWALGiKZh4bvVdo4Q8/mQ==
X-Google-Smtp-Source: AGHT+IFxVfAigFgMJYj0MK1XEtlxuguR9QWg4M5wW3cmX+ehlPJHICAdqbQsd1MUKQyprqYyiz7tRJ0CYxKiBQl4pg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6602:6b84:b0:7cc:39c:143d with
 SMTP id ii4-20020a0566026b8400b007cc039c143dmr390494iob.0.1712012498421; Mon,
 01 Apr 2024 16:01:38 -0700 (PDT)
Date: Mon, 01 Apr 2024 23:01:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANE8C2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwND3eKSorzkgkrdtGLdCgiOz8xPLsnRTda1SEwzT7SwNE1KSzNQAhp QUJSallkBNjw6trYWANLq9zZsAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712012497; l=2623;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Sw17VZ2rI5t1U7w6lSBn7Tgm6w53GtT34jTTgkY57jY=; b=Je+3bNOSl7VFFOi8HXFh39huAOtiEkqd6rPxUqiwOM0mvuBTBLcnq2KhywdxKIOo4cLT9pfWn
 V/SkR0/wmEZCC2e2cJMcsHJHf83GS2EdKd0Xp+fXHoZtq8eOB+5DclX
X-Mailer: b4 0.12.3
Message-ID: <20240401-strncpy-fs-xfs-xfs_ioctl-c-v1-1-02b9feb1989b@google.com>
Subject: [PATCH] xfs: cleanup deprecated uses of strncpy
From: Justin Stitt <justinstitt@google.com>
To: Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

In xfs_ioctl.c:
The current code has taken care NUL-termination by memset()'ing @label.
This is followed by a strncpy() to perform the string copy.

Use strscpy_pad() to get both 1) NUL-termination and 2) NUL-padding
which may be needed as this is copied out to userspace.

Note that this patch uses the new 2-argument version of strscpy_pad
introduced in Commit e6584c3964f2f ("string: Allow 2-argument
strscpy()").

In xfs_xattr.c:
There's a lot of manual memory management to get a prefix and name into
a string. Let's use an easier to understand and more robust interface in
scnprintf() to accomplish the same task.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/xfs/xfs_ioctl.c | 4 +---
 fs/xfs/xfs_xattr.c | 6 +-----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d0e2cec6210d..abef9707a433 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1755,10 +1755,8 @@ xfs_ioc_getlabel(
 	/* Paranoia */
 	BUILD_BUG_ON(sizeof(sbp->sb_fname) > FSLABEL_MAX);
 
-	/* 1 larger than sb_fname, so this ensures a trailing NUL char */
-	memset(label, 0, sizeof(label));
 	spin_lock(&mp->m_sb_lock);
-	strncpy(label, sbp->sb_fname, XFSLABEL_MAX);
+	strscpy_pad(label, sbp->sb_fname);
 	spin_unlock(&mp->m_sb_lock);
 
 	if (copy_to_user(user_label, label, sizeof(label)))
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 364104e1b38a..b9256988830f 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -220,11 +220,7 @@ __xfs_xattr_put_listent(
 		return;
 	}
 	offset = context->buffer + context->count;
-	memcpy(offset, prefix, prefix_len);
-	offset += prefix_len;
-	strncpy(offset, (char *)name, namelen);			/* real name */
-	offset += namelen;
-	*offset = '\0';
+	scnprintf(offset, prefix_len + namelen + 1, "%s%s", prefix, name);
 
 compute_size:
 	context->count += prefix_len + namelen + 1;

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240401-strncpy-fs-xfs-xfs_ioctl-c-8af7a895bff0

Best regards,
--
Justin Stitt <justinstitt@google.com>


