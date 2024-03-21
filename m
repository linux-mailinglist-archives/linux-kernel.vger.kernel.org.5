Return-Path: <linux-kernel+bounces-109509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ECF881A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EB01C21248
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234E1C17;
	Thu, 21 Mar 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYhXo7Ut"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D308653
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979864; cv=none; b=nmgrHzwjAvTblVtbeQQ4iWRqLq56OFocB4Ist7dJhnpvXvvaRiG6rA9QisQiCJt/Jt49cJjy3r+FmucQOZMKMyxjdINGaU4agKuewq4zYfNdLILxn3Ig2bMW8fTQHw3aP7wrOrixBfrAZYULAVxZXcH9OpTt34Axd18JK49MoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979864; c=relaxed/simple;
	bh=qLFMjKBHWBbdNmXG9Gp9YCIsExWfJWYt/CixfHOVoOs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G6JJZc9ADHt8eLIVG62AwEU7VSe+QgS+pAvWnUJIux0DD0KAFfgHC1m2PbjsQ/N47rVjwwokUPrz43fEszoMYwFE98dTbd0Rj1ekL06LgHVupYYhhIQ12lx6Y+/l7JoJxF49gOUCJwdZ+LaFfW0t8OOgqsWZjQcZADLKqERq5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYhXo7Ut; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso493454276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710979860; x=1711584660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Y/++eaKr1uF0F/QMSpfiG9X2bG1rR6plkUxL7VYSLI=;
        b=oYhXo7Ute7KFBr2Zi8bcJfQXt3gOUz/tvphMtlqgbKK/qHZyfRJsGnTJHPf0TZeyDv
         ZB+FMnuKMe02AZn/9zhFb7hfQvP2lyL/o0VvwxAaOyPrKGI1IjJxNgVmnOnAEeARndNL
         sOoNbKkEOyJFaLn0JWemQXn3doQj/G8ejtqGpz0cE6CGQ00u5j1w/51WfxiIdVAOp4VC
         VUZWnrAtTYvCIEeg5PtV+xdrRhFVfMHcpo5qMGlWG98Us1mAk1xFGtacVT8ewtzzXv+p
         Qld+FPV+uSpGCR8t6uVBt3MNo07i+St0XZvUNKHEvdiwT8tBGTIWt37r8kD16UmRiGTh
         q41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710979860; x=1711584660;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Y/++eaKr1uF0F/QMSpfiG9X2bG1rR6plkUxL7VYSLI=;
        b=nTqheOCgDg6XnTCVxgvfRwndWqMEwPJyLofcOC7PAnwm5FMmweE3hzpygWg8gqVbkW
         3ey7SHx4d4iDBSfbndpUqWDkpFWKXVOaXMnM2KPBretP9sbV7Gz2aQ0mlLiH9vM/G60M
         o7FSJVybt4qYJr3NpwlEVBHfsVDj7IO6CLwA8UK18RpGfcTLMA8SUkqFfJrZ6msLdX4u
         Hl1WIN3homU6K+XfZumtJK2lKZ5KXTGG0DDRkJHvcS/O2fXhS98e04lHdWUAD4Hcw5Jm
         rbNAfxnnQl4F+Vk9bIj2H1JyscSCKPKUsHGHQStnHctuJtQh2kFy4pUoJYbKAMEZaAKH
         ugGA==
X-Forwarded-Encrypted: i=1; AJvYcCXp4HKASbdPZUA4HQp9PqqVv+rylCKbmoe0sVQKsjKHBu1TjiG06aMc395ms9dW5A5s6uVFVJTsIXtuaD7LWj7JnmTzEZIdLLI5zttO
X-Gm-Message-State: AOJu0YxI2IQxXz7bmbxTq/9QYq33OnmuW715nZUpyymQtV57GR56krzK
	xvTQdvTuTnaEe3BrO5LWjmuz3I8vFJYRqvaLa4/uyLiAkgY20mxq3hJlBotH89xfRtMJUpEc2U4
	TgVH8mNgSuXCgj3W+Gi1Nwg==
X-Google-Smtp-Source: AGHT+IGf505ZVazw6jjUV6V9zvF2/vHvzzK6R5KLbh0GdIFxY2g4V4MVPW/wlAhrkwOVCVplbt5u8DMwwFADJQzvxg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1b91:b0:dcc:6065:2b3d with
 SMTP id ei17-20020a0569021b9100b00dcc60652b3dmr4933165ybb.8.1710979860466;
 Wed, 20 Mar 2024 17:11:00 -0700 (PDT)
Date: Thu, 21 Mar 2024 00:10:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABN7+2UC/x3MQQqDMBBA0avIrB2IUaz0KiLSJjN2wMaQCVIR7
 94gf/U2/wSlJKTwrE5ItIvKFgqaugL3eYWFUHwxWGM701qDmlNw8UBWfEvgb55p5Zl9FIcOB1v q/aNvGwPlEROx/O7/OF3XHyjMQ/hvAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710979859; l=1970;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=qLFMjKBHWBbdNmXG9Gp9YCIsExWfJWYt/CixfHOVoOs=; b=Y9r+dN0unQvQHHcwvbxTa+ghrDkz84FfNC4ehnh5o5e+cMt0sywA8r4Lzk0cBi+LdcSfrlgRj
 +FLMm+BPNOZBHvfDKNPhK/wDxJMzw04FfOepyTH+/VSwi9grFbpRaRm
X-Mailer: b4 0.12.3
Message-ID: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v1-1-fdde26c8989e@google.com>
Subject: [PATCH] binfmt: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

In every other location psinfo->pr_fname is used, it's with strscpy_pad.
It's clear that this field needs to be NUL-terminated and potentially
NUL-padded as well.
binfmt_elf.c +1545:
|	char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
|	{
|		task_lock(tsk);
|		/* Always NUL terminated and zero-padded */
|		strscpy_pad(buf, tsk->comm, buf_size);
|		task_unlock(tsk);
|		return buf;
|	}

Note that this patch relies on the _new_ 2-argument versions of
strscpy() and strscpy_pad() introduced in Commit e6584c3964f2f ("string:
Allow 2-argument strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/binfmt_elf_fdpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 1920ed69279b..0365f14f18fc 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1359,7 +1359,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
-	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
+	strscpy_pad(psinfo->pr_fname, p->comm);
 
 	return 0;
 }

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-strncpy-fs-binfmt_elf_fdpic-c-828286d76310

Best regards,
--
Justin Stitt <justinstitt@google.com>


