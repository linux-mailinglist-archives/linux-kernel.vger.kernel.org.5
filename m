Return-Path: <linux-kernel+bounces-163123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 272408B6605
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4803E1C21AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3FD7EF02;
	Mon, 29 Apr 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mH6FW0XD"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850D1E886
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432017; cv=none; b=cJiqVZ6vd65pZw/Bc43mydEAcH0QuLafyghj9S5jW79LGOoOoX30Xama3a2rF+6T3bNgUppI9cWNrSh/VIIfrcropyAo8VKIqk79+KJSng2qef8dBRc6Hisj5gWv6usiZMgZmkAEd3eF0m/cNZG+okSM5Dyrbw8qv1WkRVsydSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432017; c=relaxed/simple;
	bh=T5msb/FwiOM2B8FoBye3KYi+F/yGogHxh2GWH/afDsU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qPvmJiv0G00+N20ezoigyMWk0R26+JkC2vNt1YC7wWsZ6Zog1zFHzO82xD2Y+01eWn9J/i1oedZRqoaMyZlzwhQn4yNkNbfxxl40S+odDT5qk1IwUA9k1C8I93ZqI2T5yGDJXYx5PCDAFXpxf2v7rcab4lRsIid2M8Yg6ca2gJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mH6FW0XD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de6054876efso1462710276.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714432014; x=1715036814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LXyAxLtGa1196wXalz5OFqmoW+jEqlgIdoAjVVHAISs=;
        b=mH6FW0XDHWrH8rvdfSWcP29vIPZPluqm/G0zE999cWr25zeMpNTdURnTPeHDtghf6r
         6I/Cu3FQ2nma4A7IB1HcLDSFx+hnQDqWZREb2cRLiaf/t7uGra/UQldQ+xMC6+sosFxx
         3imhigqQGmSRZGof5B1fpbaOiOxyqW+xMd7iHU8WeTqvUf5LJCjpE7X5IS/p7Fvz/9O6
         zJXnrwMdejs8J8e3Pu5GTbymfVqypvv8nBfAKgJ0p28XpV6WpFKLy1wGCbDViQd/DOww
         L/ADrvnOp/EmZiTVqmGA2IQYok3EEVQDPc7cNQJ5F3e71oKX0ykpaGNpWmJith1kUkvz
         Mjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714432014; x=1715036814;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXyAxLtGa1196wXalz5OFqmoW+jEqlgIdoAjVVHAISs=;
        b=aPo9RN9cFqWwPsH0j3pHSiI6Teq2uCi8b9OOKGApxYl9utLtt9Xg3/g8GQuThnGrAR
         LP4t0xzQLTHI6IoGLmJBByiIHe3IMQqt56OWVs2oyjss+W2DmQ9ZZ1hmAh+OBE3G9lo+
         EnO6Qqr2u2uVMa5nU/5eFfOTdX0tjEjzs5ptXyJ+cLgP1mVxT2Aju81gYFvkRAJRihG9
         t0K6eu70750U4z5pLkODRR+gmLSYixKJD+xZaa1v7br1UvTTTWQA8022sXlCVjSRTINv
         1qpB0Onn++FzBVFFpJuSR8GI0fCB9XkzrmktJSoegW/nTQF7c7lK2AQK2dnUZtU8KnAA
         1mHg==
X-Gm-Message-State: AOJu0Yz4SwTWMsi+AWHbvBnXM2oME1vh+EodPAnT3ORywbYrpV4/aPzX
	3KtkLpSNxFcYJVbspQ3dwzXHjQgvbIncthhtGGiDP3EDbQ2/1HdQ8nnXQ1rcnYhO4VpSft9OrNr
	tSSpvTbQyAVNy6Ilk4mQTvg==
X-Google-Smtp-Source: AGHT+IGeIbhUCHMAFmraPY9YQhVZzsy985ANsGkhLyO1PUv0ne2OlVhD5fpVPeG5st0Esedb7gmgGjG+DqpsiLavSg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2b03:b0:de4:845b:8f08 with
 SMTP id fi3-20020a0569022b0300b00de4845b8f08mr3758442ybb.2.1714432014609;
 Mon, 29 Apr 2024 16:06:54 -0700 (PDT)
Date: Mon, 29 Apr 2024 23:06:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA0oMGYC/zWN2wpAQBBAf0XzbGptLvEr8qA1mGhssxLJv9uUp
 9N5OeeGQMoUoEluUDo48CZRsjQBN/cyEfIQHayxucltjWFXcf7ChVRoRa8s+/LDYdlXdqRyMFV WQIx4pZHPb9B2z/MCzwNM8HAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714432013; l=4237;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=T5msb/FwiOM2B8FoBye3KYi+F/yGogHxh2GWH/afDsU=; b=Sl5cyYRJ2u3ZR6g8GOSU49y8O3CeWfvN4QwouXDwsRoiAcxCVm+Ietg6oUzBENx/qK1zjQykn
 07KFwNfS42mCzYeg0uLLrwnJ+OPMzXluQE2Nle26OKU9EGHO710tWOg
X-Mailer: b4 0.12.3
Message-ID: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
Subject: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
From: Justin Stitt <justinstitt@google.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Cleanup some deprecated uses of strncpy() and strcpy() [1].

There doesn't seem to be any bugs with the current code but the
readability of this code could benefit from a quick makeover while
removing some deprecated stuff as a benefit.

The most interesting replacement made in this patch involves
concatenating "ttyS" with a digit-led user-supplied string. Instead of
doing two distinct string copies with carefully managed offsets and
lengths, let's use the more robust and self-explanatory scnprintf().
scnprintf will 1) respect the bounds of @buf, 2) null-terminate @buf, 3)
do the concatenation. This allows us to drop the manual NUL-byte assignment.

Also, since isdigit() is used about a dozen lines after the open-coded
version we'll replace it for uniformity's sake.

All the strcpy() --> strscpy() replacements are trivial as the source
strings are literals and much smaller than the destination size. No
behavioral change here.

Use the new 2-argument version of strscpy() introduced in Commit
e6584c3964f2f ("string: Allow 2-argument strscpy()"). However, to make
this work fully (since the size must be known at compile time), also
update the extern-qualified declaration to have the proper size
information.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
---
 include/linux/printk.h |  2 +-
 kernel/printk/printk.c | 20 +++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 955e31860095..b3a29c27abe9 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -71,7 +71,7 @@ extern void console_verbose(void);
 
 /* strlen("ratelimit") + 1 */
 #define DEVKMSG_STR_MAX_SIZE 10
-extern char devkmsg_log_str[];
+extern char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE];
 struct ctl_table;
 
 extern int suppress_printk;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index adf99c05adca..64617bcda070 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -178,9 +178,9 @@ static int __init control_devkmsg(char *str)
 	 * Set sysctl string accordingly:
 	 */
 	if (devkmsg_log == DEVKMSG_LOG_MASK_ON)
-		strcpy(devkmsg_log_str, "on");
+		strscpy(devkmsg_log_str, "on");
 	else if (devkmsg_log == DEVKMSG_LOG_MASK_OFF)
-		strcpy(devkmsg_log_str, "off");
+		strscpy(devkmsg_log_str, "off");
 	/* else "ratelimit" which is set by default. */
 
 	/*
@@ -209,7 +209,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 			return -EINVAL;
 
 		old = devkmsg_log;
-		strncpy(old_str, devkmsg_log_str, DEVKMSG_STR_MAX_SIZE);
+		strscpy(old_str, devkmsg_log_str);
 	}
 
 	err = proc_dostring(table, write, buffer, lenp, ppos);
@@ -227,7 +227,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 
 			/* ... and restore old setting. */
 			devkmsg_log = old;
-			strncpy(devkmsg_log_str, old_str, DEVKMSG_STR_MAX_SIZE);
+			strscpy(devkmsg_log_str, old_str);
 
 			return -EINVAL;
 		}
@@ -2506,21 +2506,19 @@ static int __init console_setup(char *str)
 	/*
 	 * Decode str into name, index, options.
 	 */
-	if (str[0] >= '0' && str[0] <= '9') {
-		strcpy(buf, "ttyS");
-		strncpy(buf + 4, str, sizeof(buf) - 5);
+	if (isdigit(str[0])) {
+		scnprintf(buf, sizeof(buf), "ttyS%s", str);
 	} else {
-		strncpy(buf, str, sizeof(buf) - 1);
+		strscpy(buf, str);
 	}
-	buf[sizeof(buf) - 1] = 0;
 	options = strchr(str, ',');
 	if (options)
 		*(options++) = 0;
 #ifdef __sparc__
 	if (!strcmp(str, "ttya"))
-		strcpy(buf, "ttyS0");
+		strscpy(buf, "ttyS0");
 	if (!strcmp(str, "ttyb"))
-		strcpy(buf, "ttyS1");
+		strscpy(buf, "ttyS1");
 #endif
 	for (s = buf; *s; s++)
 		if (isdigit(*s) || *s == ',')

---
base-commit: 9e4bc4bcae012c98964c3c2010debfbd9e5b229f
change-id: 20240429-strncpy-kernel-printk-printk-c-6a72fe6d0715

Best regards,
--
Justin Stitt <justinstitt@google.com>


