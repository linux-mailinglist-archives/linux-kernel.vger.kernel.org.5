Return-Path: <linux-kernel+bounces-71860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2A85ABE5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E98284101
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773825027F;
	Mon, 19 Feb 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vX0UKSCQ"
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1975026E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370304; cv=none; b=s9QrYcSHUCH+MYgXmLKU8radzWMrF0x18mni26ZYw5pfeZVm864We99VJJenX/uZ7qJaBlLF2rEE3qEE+mlJXw+R80uLXuExiYnCh4wO3bSfhpi01orQP0F4mG1fxnFctpi04lr7KXbUkwSE5aLWDfbpJJpklrl8EQqzJdpafKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370304; c=relaxed/simple;
	bh=lWp1mvnF6XdLVxAwayXsUI7kHokjjbIIQ8IV4f8d2fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GBKdlMNpz49RLE02AYqctzAVOPUmoRWgUIr0vAZqPWKLX0YObpF784XMr95nPfZQ+Ln0nV4ygMifo+6uANrp+jd8VouWpyMb6PmJqy90YHoxiqg8wnpvIlN5WId2Vw7qyd/mYJ8fHdqQNgKNWR8Ka8PK4Amei9+lH9l7xowblRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vX0UKSCQ; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tdsks0cSsznBQ;
	Mon, 19 Feb 2024 20:18:13 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tdskr0wsqzHNV;
	Mon, 19 Feb 2024 20:18:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708370292;
	bh=lWp1mvnF6XdLVxAwayXsUI7kHokjjbIIQ8IV4f8d2fc=;
	h=From:To:Cc:Subject:Date:From;
	b=vX0UKSCQSIn+wlfY47YBGvvF7KwJaXD7ijzCLv/U/WDG0LHjbyGxgSQhOIDPlmWWQ
	 vi2Dkp6AVjK6V9IqjgVRfi7e0rq4/qStY9YSQbUUwZtQXZOGf6Y9XoXbnp4YByabAO
	 LhvcVHDitDj0ZJvKLkWU7AeIpW5uQjot3UxaVR5Q=
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
	stable@vger.kernel.org
Subject: [PATCH] landlock: Warn once if a Landlock action is requested while disabled
Date: Mon, 19 Feb 2024 20:18:04 +0100
Message-ID: <20240219191804.2978911-1-mic@digikod.net>
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

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: 265885daf3e5 ("landlock: Add syscall implementations")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/syscalls.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index f0bc50003b46..b5b424819dee 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -33,6 +33,18 @@
 #include "ruleset.h"
 #include "setup.h"
 
+static bool is_not_initialized(void)
+{
+	if (likely(landlock_initialized))
+		return false;
+
+	pr_warn_once(
+		"Disabled but requested by user space. "
+		"You should enable Landlock at boot time: "
+		"https://docs.kernel.org/userspace-api/landlock.html#kernel-support\n");
+	return true;
+}
+
 /**
  * copy_min_struct_from_user - Safe future-proof argument copying
  *
@@ -173,7 +185,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	/* Build-time checks. */
 	build_check_abi();
 
-	if (!landlock_initialized)
+	if (is_not_initialized())
 		return -EOPNOTSUPP;
 
 	if (flags) {
@@ -407,7 +419,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	struct landlock_ruleset *ruleset;
 	int err;
 
-	if (!landlock_initialized)
+	if (is_not_initialized())
 		return -EOPNOTSUPP;
 
 	/* No flag for now. */
@@ -467,7 +479,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	struct landlock_cred_security *new_llcred;
 	int err;
 
-	if (!landlock_initialized)
+	if (is_not_initialized())
 		return -EOPNOTSUPP;
 
 	/*
-- 
2.43.0


