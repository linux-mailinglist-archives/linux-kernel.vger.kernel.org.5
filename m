Return-Path: <linux-kernel+bounces-110626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7FA88616D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7499E1C21EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871C134735;
	Thu, 21 Mar 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9UBmgHd"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968413441F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051453; cv=none; b=TkDhmEtxsM1p5NdlxOlcwJDMcQN6sE/kGHITqv7jyGdCsq6BP5Why5SpQveBuUlefqqcmutQk1yNzWoLhpUkdIYHt3+VO4+jahHmhqLm1eDaPpXdWXbks24tfBEjQQZvQTLulUzj40FTEYkX5mPwoaR2430Rojvr6NgeFgHWMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051453; c=relaxed/simple;
	bh=S6RP6uWmLdlEXkKQny/wqkGVsqJcl1gAUGPqZ6bCYiM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ndf7hhnGoOPE3FJqSYoF04gy5hBtAu68sUbt6QdoSH1W2zgahkQ+gF5ksOJXdyzjLUghvjAsFNo55nXbsLV8ZwtyIBuAgtq/ztIc1wcnZSTzK8CEEX2Lwd7YQJXEIo5JQrXDOpoKo1UkOTEtoT8SLqYBMl43QaeO20sRVSNh6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9UBmgHd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso1905828276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711051449; x=1711656249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TCBKqThFKtYqhjiY4RMqU+IuZ1w6cv8EE0k+cJlDNnk=;
        b=t9UBmgHd/q5utv6qWZdP7eKjHmnVZeNPsHJMDwPYc4VzSykPCFSN7CTgGuWTVhHh+a
         aKYy3oo4FCmLVj+XEkYF67gVoWr+EGVpoDy9KDhU+KV1z8h0vybFigUzJVjuqcBcQVDi
         9UmqlsMy2iJRkUHNR8I9EdPTQxdvTqqtsFqsliQ7cuFrF7hYiNguxgHqbnR4oDDOHWj+
         FPJxBjH6zXp5rlwhy0fpxHw6jCbrbESsqvo5Ky7MZSvoDJz7FjZyvxMnyPP53mO65s3h
         AWBYcWP74+R9YGP7LJSclVyEpCt5zYHP+H8lumtOK1/34k4CFGACNJ5Ja89dzoaPxFV4
         U8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711051449; x=1711656249;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCBKqThFKtYqhjiY4RMqU+IuZ1w6cv8EE0k+cJlDNnk=;
        b=MKWa+X4znWJ63lqhXmWrMaQoIR73Z0RqWOkT+dd8d9CEPzfu/qAtL8UCnbCghTl8Hm
         B+DNVVfJvryXKB85VGRUUl+9cOK709dWs1zO0ifCveFbd6/YSGe6KF76GNrbluH8+z7i
         umeKKQadPwNToCnipQvqI28oe8/3NTR7x12IUeDvKFlJAsL8B7ZyXNkDKgvhS7RYfcOy
         rGIpz3doSJaEFj5vdWTxlZwVfnbtc0rB8RqPZ6U/fzXJLyz8NKKh7jvBXH1rhvMXGKnc
         k66YsgUJQUzkp7KnyXgCuPXLCnPjREreX5cIoO9JyvL9nBTIflsi5zuvHmvPIZHgwSzh
         lqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMYUj5dpK5+Vy0bqbhukZVuxu8D3IzTSSvOl/8GyrYDDpifOmIU7KMGCkUWdhOLZJ/Sz6hPMKBFu6uwZlsLQsZs8dznMYG8dWfd8gA
X-Gm-Message-State: AOJu0YymG0P1Kkz3+JiePTkhVkAUrCyJNN0W63C0RP8nVpxndIwBj9eW
	zNWWExtXejMwU67UtBF5Ses5phpYIH2rchBa5Xxjpiv5PHwbw6KGsu1uP2DIMhScm6WRXWz6auu
	umi06loLiW0oxfqd4XZ293w==
X-Google-Smtp-Source: AGHT+IE5VBN/+0LV/WPi06J13PSBodS0OdOu9MsbtLw0uhdLxrW4h4oP0M2VfdY/eM1a/8qsQNDCacEmRg4kGkc2ng==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2484:b0:dbd:b165:441 with
 SMTP id ds4-20020a056902248400b00dbdb1650441mr74857ybb.0.1711051449209; Thu,
 21 Mar 2024 13:04:09 -0700 (PDT)
Date: Thu, 21 Mar 2024 20:04:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALeS/GUC/4XNQQqDMBCF4avIrDslicVqV71HEWmTiQ5oEhKRi
 nj3pkLXZVb/LL63QaLIlOBWbBBp4cTe5VCnAvTwdD0hm9yghLqIUglMc3Q6rGgTvtjZae5otJ0
 1gTVqrFW+ylyrUgrIRohk+X34jzb3wGn2cT3mFvn9/mT5R14kSrTGkKp03dQN3Xvv+5HO2k/Q7 vv+AbD0yg3LAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711051448; l=1634;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=S6RP6uWmLdlEXkKQny/wqkGVsqJcl1gAUGPqZ6bCYiM=; b=ltUxZ2cpj94pnvyIBEzmfBEHQXiRRLeDTlLyWbffUabFpLWPDEAtsiKsRij39k9phe/VyFBxJ
 50r/4jHF4KlATUMzXLzQG9U+LPWH6633/Y5LV4uwnne1EeG7KX+npD1
X-Mailer: b4 0.12.3
Message-ID: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v2-1-0b6daec6cc56@google.com>
Subject: [PATCH v2] binfmt: replace deprecated strncpy
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

There is a _nearly_ identical implementation of fill_psinfo present in
binfmt_elf.c -- except that one uses get_task_comm over strncpy(). Let's
mirror that in binfmt_elf_fdpic.c

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use get_task_comm (thanks Eric)
- Link to v1: https://lore.kernel.org/r/20240321-strncpy-fs-binfmt_elf_fdpic-c-v1-1-fdde26c8989e@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/binfmt_elf_fdpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 1920ed69279b..3314249e8674 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1359,7 +1359,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
-	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
+	get_task_comm(psinfo->pr_fname, p);
 
 	return 0;
 }

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-strncpy-fs-binfmt_elf_fdpic-c-828286d76310

Best regards,
--
Justin Stitt <justinstitt@google.com>


