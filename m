Return-Path: <linux-kernel+bounces-83095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C152868E59
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413FF1F24D16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D213A243;
	Tue, 27 Feb 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oCw/iF23"
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87CD1386CF;
	Tue, 27 Feb 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031976; cv=none; b=mp0QAo7RMBPQstTb02JEA8qeU3q9272C/3FOPHFLTtxe42LlyVDGyRt9SaEp1SoHOOs4YbfTvQaKywt0GgfaL3EyehOMcRlQzgDGXiKA1YTpNP8MOwsZP/hheafp58EgDNFlNsgVYYJpNnE6GKj+xVTuf4RfzVEx8eseSjKMpH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031976; c=relaxed/simple;
	bh=jPUoWxQfL0gN4M9XnMPtb4OVmzxvQ8jhCx4n49IoT7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWgoNqp/EMPYDlzGfr/dm1v4s3jBOb1/etbsf2ujKFmgnnpOAFKdWQ97Uj0YU+L2tgKbKZ3+bFit66WnaKzmwjE0fXuNExH7nxU5+1Ho7KU2wd7MFYoYrjs4i1VBwSdwezv1yZkFTaUR0bS6L23BSvVI228PepjIchUCXn/V3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oCw/iF23; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TkZRL3hQgzfF;
	Tue, 27 Feb 2024 12:06:06 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TkZRL0Ngrz3k;
	Tue, 27 Feb 2024 12:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709031966;
	bh=jPUoWxQfL0gN4M9XnMPtb4OVmzxvQ8jhCx4n49IoT7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCw/iF23a34Rv0MBwr2Ia6cQ8m8h0jvHC8OAnyauVIncs0HoaFwNz47dPhVBwgEjw
	 R5yruWwiqbByh+WzDRqxenUS46BMI9ak98EP9PcOxTd4ecJ/LXUlBEDCPa5K9iN5Qt
	 hb3lJFSu+CT4yjc6FlcRhOYLyM3bfinMCILgyBUg=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 2/2] landlock: Warn once if a Landlock action is requested while disabled
Date: Tue, 27 Feb 2024 12:05:50 +0100
Message-ID: <20240227110550.3702236-2-mic@digikod.net>
In-Reply-To: <20240227110550.3702236-1-mic@digikod.net>
References: <20240227110550.3702236-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Because sandboxing can be used as an opportunistic security measure,
user space may not log unsupported features.  Let the system
administrator know if an application tries to use Landlock but failed
because it isn't enabled at boot time.  This may be caused by bootloader
configurations with outdated "lsm" kernel's command-line parameter.

Cc: stable@vger.kernel.org
Fixes: 265885daf3e5 ("landlock: Add syscall implementations")
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
* Add Kees's and Günther's Reviewed-by.
* Rename is_not_initialized() to not_initialized() and invert the logic,
  as suggested by Günther.  This is a cosmetic change without global
  behavioral changed.
* Update link to point to a new subsection.
---
 security/landlock/syscalls.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 898358f57fa0..6788e73b6681 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -33,6 +33,18 @@
 #include "ruleset.h"
 #include "setup.h"
 
+static bool is_initialized(void)
+{
+	if (likely(landlock_initialized))
+		return true;
+
+	pr_warn_once(
+		"Disabled but requested by user space. "
+		"You should enable Landlock at boot time: "
+		"https://docs.kernel.org/userspace-api/landlock.html#boot-time-configuration\n");
+	return false;
+}
+
 /**
  * copy_min_struct_from_user - Safe future-proof argument copying
  *
@@ -173,7 +185,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	/* Build-time checks. */
 	build_check_abi();
 
-	if (!landlock_initialized)
+	if (!is_initialized())
 		return -EOPNOTSUPP;
 
 	if (flags) {
@@ -398,7 +410,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	struct landlock_ruleset *ruleset;
 	int err;
 
-	if (!landlock_initialized)
+	if (!is_initialized())
 		return -EOPNOTSUPP;
 
 	/* No flag for now. */
@@ -458,7 +470,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	struct landlock_cred_security *new_llcred;
 	int err;
 
-	if (!landlock_initialized)
+	if (!is_initialized())
 		return -EOPNOTSUPP;
 
 	/*
-- 
2.44.0


