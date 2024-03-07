Return-Path: <linux-kernel+bounces-95253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56049874B51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128A9283EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D784FBC;
	Thu,  7 Mar 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yYRPEETW"
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943A63130
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805150; cv=none; b=HLYI1ox1mYYdOEOBciF3GZWksMP7L5EeotkKbXwhifAgBj4poxkFdY+cLqvKR4ysR4l9nX94pxSIKcNY6XC8CZzLJbInU0U6CRbnDwPtcTB8bO2SWuPJphldyv114zUPLy/x9R54hk9frYvBjEOvdSpTfN9YHoET0lODnapR2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805150; c=relaxed/simple;
	bh=JM8NoDgF9XVBdwTusnBP2iVflDk3qzvwdZH/Z7zpmz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RhO3Szezb/olVY0TugsIhYpLteUdxV4kt+crvHNRdw77crNF2fZoyR2kQa4PLP3Z85rnAjVNiHWJ5YkNBZAC4zTQ53hI4YwfRfapdIJ/MG4fLGJ00uhVE1/YbXzwK/rSqUIdHhwIGmCHo8RM6R8Z99Y3J5gZQcinowSMXQVmGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yYRPEETW; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tr4N22Tzsz1CY0;
	Thu,  7 Mar 2024 10:52:18 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tr4N13FkTzHTh;
	Thu,  7 Mar 2024 10:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709805138;
	bh=JM8NoDgF9XVBdwTusnBP2iVflDk3qzvwdZH/Z7zpmz8=;
	h=From:To:Cc:Subject:Date:From;
	b=yYRPEETWKJNSGjSICEonq68KuR7gZrjZe1sFtdcp++a3Mz3Z51vhUpznrtczkAgq5
	 OYD/xEPqav6NYDfsGWf6BuDxH3uNQSMabP9O3t7fKhCfC5pr/L4mf3L8t4vaqEUIQz
	 PRtLouUWqMAomdv+p/DYiTQpJX+LPazvsdoEo+uw=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jann Horn <jannh@google.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Kees Cook <keescook@chromium.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] landlock: Use f_cred in security_file_open() hook
Date: Thu,  7 Mar 2024 10:52:03 +0100
Message-ID: <20240307095203.1467189-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Use landlock_cred(file->f_cred)->domain instead of
landlock_get_current_domain() in security_file_open() hook
implementation.

This should not change the current behavior but could avoid potential
race conditions in case of current task's credentials change.

This will also ensure consistency with upcoming audit support relying on
file->f_cred.

Add and use a new get_fs_domain() helper to mask non-filesystem domains.

file->f_cred is set by path_openat()/alloc_empty_file()/init_file() just
before calling security_file_alloc().

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240307095203.1467189-1-mic@digikod.net
---
 security/landlock/fs.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6f0bf1434a2c..c15559432d3d 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -248,15 +248,18 @@ get_handled_fs_accesses(const struct landlock_ruleset *const domain)
 	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
-static const struct landlock_ruleset *get_current_fs_domain(void)
+static const struct landlock_ruleset *
+get_fs_domain(const struct landlock_ruleset *const domain)
 {
-	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
-
-	if (!dom || !get_raw_handled_fs_accesses(dom))
+	if (!domain || !get_raw_handled_fs_accesses(domain))
 		return NULL;
 
-	return dom;
+	return domain;
+}
+
+static const struct landlock_ruleset *get_current_fs_domain(void)
+{
+	return get_fs_domain(landlock_get_current_domain());
 }
 
 /*
@@ -1334,7 +1337,8 @@ static int hook_file_open(struct file *const file)
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
 	access_mask_t open_access_request, full_access_request, allowed_access;
 	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
-	const struct landlock_ruleset *const dom = get_current_fs_domain();
+	const struct landlock_ruleset *const dom =
+		get_fs_domain(landlock_cred(file->f_cred)->domain);
 
 	if (!dom)
 		return 0;
-- 
2.44.0


