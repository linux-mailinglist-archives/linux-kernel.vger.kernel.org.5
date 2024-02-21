Return-Path: <linux-kernel+bounces-75587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE885EB90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE301C216EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C112880E;
	Wed, 21 Feb 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcQQq+4W"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0CE127B6F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553130; cv=none; b=HSZkLX4IdQtmEupVj02RmYU53jO/sfIj2OtxYD3e973K0gfgXU8Uq8yreRZmYH7spGolzDkWR2QMynu7FykHa232zp0rDmVjaZyKeLoi3mkxAtMN23EdgRdeMWWzL8ZOX6A8JU04cUXa6hqQLr2MHMHo7gBM9G2uQP8j9/5vmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553130; c=relaxed/simple;
	bh=glDEKtdwdqyJIt9bRVsA7OStBeZEdBkYYd62ei+rhmE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O88k/pI/RIatvM8mcmMOPlr9kNx9XK8AHcEUh7PKg21FJkX9DzYIUSgSt11HT9YR2ml4+HabC4SkyRnMjhPWdOYWhbyK1/e5fzUlEmrJuYPVzTwXBuf2JKZOWt8QyLdIxcmpJTIS2/hMU2aEfy3Gz4s5ZNgEOV4VG3KLyYoCEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcQQq+4W; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so1973658276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708553127; x=1709157927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CEXpQXg5vnSo+q/Y96zcMRb8jRrXDHbwFt0Ekcc6U9I=;
        b=XcQQq+4WQ1MZQLL9UPv+1x6qXBcOYK3405lqc8h21vpYT40o+1qyoF65kO7QQoAxfX
         tu3xF5X+uHntG6SQiFjgQiXHm9jp89M38ocEsmZbC7JPiJjoOmij/01JePm38rWj7GG/
         aPIY0J6mzWJb+lGQGmTSqA1m2KNS7NlmBNxCq0Lyic+9/ssQGwPKlaEsN2SSRzXIjV0V
         hlVop0ZgMR3fZyrv+WS2rlFGMrNjHAuK1IWIEjQceICZvJo8o5bO5jp6nrtVovp5VJ1Z
         ifF9WqKSZsnyhMg14kG01h57KId4B0gI5dj16ThNTgtEyyoYL4OT+fJmO2LfZrIXZ51i
         4DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553127; x=1709157927;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEXpQXg5vnSo+q/Y96zcMRb8jRrXDHbwFt0Ekcc6U9I=;
        b=abLBah6ZPF/nPe1auRHfVnKHt1KUmHelgx/5wy48zpEP3B9n1ZPhu9/7TPHCapG7UN
         UT9XIi8fJON65po4/arRYWUxAreg29GoqbYUyQWYNYsn/R1scJh2STEt+JsPOFXkeGAz
         YtvfClxb0LQojkk/CQVl07Y9Uq693o6o/gjO6sCa5uefqDKbtG5WzqtpewTKbhZ5hXF4
         LHLRWFfVXmpoD0ZAt15z93cskGh3WVLOYmlxRDcRYYCnXoK6m1DGIFSnTvK/HdT8hVWK
         epCXXb4F6snW71t/ruxb+nj5SH9FX1weX+hrmFMXHlN+GsrohKb8tlVyOzTCIkb1MwLB
         Llzw==
X-Gm-Message-State: AOJu0Ywscbqs+JgH5NrQ7p/1kTStNDJuy0Ly76datFb1SukVPJZd5tjX
	AXdTZek1vXd3kH/l2FoHp5VkzjtHTVy3OL6huwJWGbQ53SlteZx08nTQN0dAIjbXHQm0RTRP24V
	vQ7NoBVotYkVf0ZtB0ARK+A==
X-Google-Smtp-Source: AGHT+IH65ETPwbThwk5AYf7wJ0+qz1pjROYQoRed6Nxu0TgqLyz0Kj79tkAiKpPEL1LlETwVW/wVTtfz+bTZkf2Qfw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:100a:b0:dc9:5ef8:2b2d with
 SMTP id w10-20020a056902100a00b00dc95ef82b2dmr158311ybt.4.1708553127595; Wed,
 21 Feb 2024 14:05:27 -0800 (PST)
Date: Wed, 21 Feb 2024 22:05:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJtz1mUC/x3MQQqAIBBA0avIrBNUwqKrRAvTMYfARCWC8O5Jy
 7f4/4WCmbDAwl7IeFOhK3bIgYENJh7IyXWDEmoUSkleYsoUq+c2oD2TqTZwM+sRnZ5wdwJ6mTJ 6ev7rurX2AVsF9GhlAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708553126; l=1887;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=glDEKtdwdqyJIt9bRVsA7OStBeZEdBkYYd62ei+rhmE=; b=uyJIZ0LPetF0XN9X4zCF00e6OsEkDTxKePErRG4rK3MlHowXuvM/g/ti/1N5Q7c9JLpIRHmzb
 jOOSpBX2gahDxCJ40oMTEt9NWPSyrvjCWqzNtseVW8J0tQWA4ku2Dd7
X-Mailer: b4 0.12.3
Message-ID: <20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com>
Subject: [PATCH] checkpatch: add check for snprintf to scnprintf
From: Justin Stitt <justinstitt@google.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Finn Thain <fthain@linux-m68k.org>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

I am going to quote Lee Jones who has been doing some snprintf ->
scnprintf refactorings:

"There is a general misunderstanding amongst engineers that
{v}snprintf() returns the length of the data *actually* encoded into the
destination array.  However, as per the C99 standard {v}snprintf()
really returns the length of the data that *would have been* written if
there were enough space for it.  This misunderstanding has led to
buffer-overruns in the past.  It's generally considered safer to use the
{v}scnprintf() variants in their place (or even sprintf() in simple
cases).  So let's do that."

To help prevent new instances of snprintf() from popping up, let's add a
check to checkpatch.pl.

Suggested-by: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
From a discussion here [1].

[1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org/
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..bb4e99c818a9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7012,6 +7012,12 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# snprintf uses that should likely be {v}scnprintf
+		if ($line =~ /\snprintf\s*\(\s*/) {
+				WARN("SNPRINTF",
+				     "Prefer scnprintf over snprintf\n" . $herecurr);
+		}
+
 # ethtool_sprintf uses that should likely be ethtool_puts
 		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
 			if (WARN("PREFER_ETHTOOL_PUTS",

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240221-snprintf-checkpatch-a864ed67ebd0

Best regards,
--
Justin Stitt <justinstitt@google.com>


