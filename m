Return-Path: <linux-kernel+bounces-128845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C189606C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8356B283491
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F415D5D7;
	Tue,  2 Apr 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRz2Ao/X"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F386243
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101976; cv=none; b=MUtY40GRyjjYBgMqxo3Qa0V8wmSjpeXYzWB7Zmu9F1EgkNh/U+OnV66bpxs4ODXLLUsPbeVJHymMDdWGOoo398GG2yBV1htXk7pBREhqeDHJebgRVvTMLxmkUFVAOr7SMnvFtvbavXskrp2tR2XOCkVW12zRV0O9+/8zI7nT/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101976; c=relaxed/simple;
	bh=9LtQU8UiOsgDWvjTc1/6rw/QlwvMZqMAcV47wDqmoxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I/XkJ+pqPxZow5BL1Za3Ucp66wa/cyZ3e6oSfhZGhQ3iGmabf3+QXsUC71UVmzJnwXzFky8aO2PsOP9iZmBORa1M/eJupfPN3RX8zbXJOgUM1a5uOg4W0L5s6xE5GzHKR+UxzdwD6sUjA/fkC85BPaC2VtkeeISjYP4WPZRsbYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRz2Ao/X; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7cc74ea8606so692266539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712101974; x=1712706774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tvk0aVaJ4x37W0/x3VCM6LH3wJVHl8Qg2TqljtL5b2o=;
        b=oRz2Ao/XoQ7glDcZCVLaAH99iMHnihwaiXmPLUjnpCJzsmrJj9QPLgP2RH/LqNS2V0
         zJnvdXYjQG1dX+8VXDEK7UHbJvTmqUX/v0gm7XAlvrVLT91RmVfT/EMQGjpJJJZnUo9L
         /6ZScogHwW9Ki2feNrKoMu1q5wBmASCw2lqCZTZiHBPLXetiQLdq8afsFjg2rN0ScgMi
         cMaxEh+bXAP2mK2oi2VrewM9b1BVKFSceKO+tav6xS/xy0HGUIPlCD9LzapevdwZyINl
         6Le4hRPF3mmO0c40jvMWcGzq2bxfJt2L0bS4s8QwLP7KVbePFsQISGOriRjIgUAUVcAY
         zcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712101974; x=1712706774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tvk0aVaJ4x37W0/x3VCM6LH3wJVHl8Qg2TqljtL5b2o=;
        b=M8QafPKOyxQIklPbdVIOuou17pxffqTF6WlqyYieNIyC0Td1w9453RjoeT2I19UVEp
         3fR/s0QmXNAsqU1AJUEcZeKtLzdLYoaoxiJY/S/hu7bMJl9tB5rgbGt9KNCmbwz2sWzY
         q41zoub+VS1lNt3F365hJHgT5rp/2T/CM6HX9JUudDs9AbQ1/iEvX8ldZRKPIdEgv7Ek
         SbLKbgHguftwk+Oasa+a6+HTGjyLsV64RqWqrCNOG0FH1MhmsFYc6lRgLu9S7tDzdnLa
         Pqd0z4Ac2qf3VhtMvO4TrD7kwzFinXnWKXBAFj/4b6th3d//vY1+0DS9cT1QDfnzRQcu
         lQhg==
X-Forwarded-Encrypted: i=1; AJvYcCVcj873LSLDdO6GrDjYT4z6NAZC2sYs7Jtu/YqgH1Lus5OE3MmSTt2ecBz8VNcdY2/wYyu7nycP7je4XzTTK2fHSB+dkiq2uFk+cjwm
X-Gm-Message-State: AOJu0YyM1WZc//M57FwyeEZnQkwX7OkpriUcgCzmTeJBzpIjwdjwsvEK
	xbxMClWfka3TkVWuNMmvPPVDT22tpiTZEG5Yb8/fMKmJHcDEEQhSsC0ZWWtYvN208CKiRadizU1
	oFxmj4qzvPw1BwjfVz4wAww==
X-Google-Smtp-Source: AGHT+IHqfntMZvEh1IDSUP5f1hWGOYNSwBw+18ziFh0WsvD10M9EC1a4tUtqLDDJLrDg+I4iAyRRGaMZVfbPd0kinA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6602:2c09:b0:7d0:3aa9:94db with
 SMTP id w9-20020a0566022c0900b007d03aa994dbmr603145iov.3.1712101974132; Tue,
 02 Apr 2024 16:52:54 -0700 (PDT)
Date: Tue, 02 Apr 2024 23:52:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFGaDGYC/x3MywqDMBBG4VeRWXcghoiXV5EuavzTDi0xTEQq4
 rsbXH6Lcw7KUEGmoTpIsUmWJRbUj4r85xXfYJmLyRrrjDOW86rRp52/0IgfTymwXxTs2c2d7dv QN6g7Kn1SBPnf7/F5nhfph1hDawAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712101973; l=2998;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9LtQU8UiOsgDWvjTc1/6rw/QlwvMZqMAcV47wDqmoxI=; b=9eawufW76cipSSrsORhJnGqUMNurLvEpfUyoII8eluIWnnZohNwLUI4Ga3x/2S39PDuLyAWM7
 vhLFRLTK1VuAkgtgTTd42TrWoz+DfOiAW/9po4OuSCw0r10GMfSFmV4
X-Mailer: b4 0.12.3
Message-ID: <20240402-strncpy-kernel-bpf-core-c-v1-1-7cb07a426e78@google.com>
Subject: [PATCH] bpf: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

bpf sym names get looked up and compared/cleaned with various string
apis. This suggests they need to be NUL-terminated (strncpy() suggests
this but does not guarantee it).

|	static int compare_symbol_name(const char *name, char *namebuf)
|	{
|		cleanup_symbol_name(namebuf);
|		return strcmp(name, namebuf);
|	}

|	static void cleanup_symbol_name(char *s)
|	{
|		...
|		res = strstr(s, ".llvm.");
|		...
|	}

Use strscpy() as this method guarantees NUL-termination on the
destination buffer.

This patch also replaces two uses of strncpy() used in log.c. These are
simple replacements as postfix has been zero-initialized on the stack
and has source arguments with a size less than the destination's size.

Note that this patch uses the new 2-argument version of strscpy
introduced in Commit e6584c3964f2f ("string: Allow 2-argument
strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 kernel/bpf/core.c | 4 ++--
 kernel/bpf/log.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 696bc55de8e8..8c9078f4549c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -747,7 +747,7 @@ const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
 		unsigned long symbol_start = ksym->start;
 		unsigned long symbol_end = ksym->end;
 
-		strncpy(sym, ksym->name, KSYM_NAME_LEN);
+		strscpy(sym, ksym->name, KSYM_NAME_LEN);
 
 		ret = sym;
 		if (size)
@@ -813,7 +813,7 @@ int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		if (it++ != symnum)
 			continue;
 
-		strncpy(sym, ksym->name, KSYM_NAME_LEN);
+		strscpy(sym, ksym->name, KSYM_NAME_LEN);
 
 		*value = ksym->start;
 		*type  = BPF_SYM_ELF_TYPE;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 2a243cf37c60..4bd8f17a9f24 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -467,9 +467,9 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 
 	if (type & PTR_MAYBE_NULL) {
 		if (base_type(type) == PTR_TO_BTF_ID)
-			strncpy(postfix, "or_null_", 16);
+			strscpy(postfix, "or_null_");
 		else
-			strncpy(postfix, "_or_null", 16);
+			strscpy(postfix, "_or_null");
 	}
 
 	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",

---
base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
change-id: 20240402-strncpy-kernel-bpf-core-c-4d8297f95e18

Best regards,
--
Justin Stitt <justinstitt@google.com>


