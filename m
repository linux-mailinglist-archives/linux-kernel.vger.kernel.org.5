Return-Path: <linux-kernel+bounces-75591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B071085EBA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640732834F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504961272CB;
	Wed, 21 Feb 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCtQyMUh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195241292C8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553524; cv=none; b=eyX8CfkFp1LmITIn9h2opms3LvUGnwey4wqYc21gCNJEjNqn2c22Fg/57Vm6KbdHWkamD9S67T0p8g4zz8pwaXokdczs5RNxj4yO5B0URUghLywgQDbjdVCY6+DAAVdVgu9mqadHbxGtYOI1ELbG/SPb2ri6HEmvfEsauih90Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553524; c=relaxed/simple;
	bh=/rPb7XyLIQzOH6lWvHaGCiHeCQoC67DC2adMcM3z+3I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iWGK9HfkAOjP9u/aIty4YCppUNQHLyYLpPpIUoweM5iYYPxg1QPxFE2j6225/pX9Jkv+TpyhQE9+ZnpaMKZ1jZe/IV5MAzL90LokjKwvglE+W+uZkvoYwUYRLiRICU0qNSsN0s0rKvX2UzMIzKJD0Q5Vf6Xgj4F5hhCOzPv6NMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCtQyMUh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608852fc324so19372217b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708553522; x=1709158322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/GG/FYJYyfJG9mT+LJy6IprkJBq09NioglCbunYjLM=;
        b=JCtQyMUhtYltWXjICTa/xzuMQ3VS5sLhIOamUc8JE4gxQmUXdgHKK5bJCetv3AL1u9
         3Hcw7PkQyYOqECI0+F3h2t6pQ9pIh6pSy0ehaw1k1aCTHXHTKOAdZdAuQ+T/35CjaQRM
         U3ICgZce1+eAm8guZxdWD2RubWmOBpJNAnHpEErmLdxgiVBlmtveHKJo4zwKO+Sl0Lin
         l6TmU6rgWrvZNMdl1rwyOBf7+RXu71KbyhEqMieazELR9xNUU+RZ7Au62fpCYS8hXK0b
         olwjuiE3XkI44Urx7bPlDsdBdr+ElfKMyX9Nd6rM2krHXP5DocxnBdGHVYUjQ21lyXvZ
         9H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553522; x=1709158322;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/GG/FYJYyfJG9mT+LJy6IprkJBq09NioglCbunYjLM=;
        b=XhqyRS14hEn3IB6dNZtdKVq3mpnlhejLVooG96nZhT50Ae4eaNGWFoBM8J66zxDVmQ
         V67n13puW7B3i2ezmedcFwukTLCXrB0qnWh2P4BfQDesWyTpjpxYtKe2ahVjBEVZU49x
         Zro9pWYU2rc5etPD4bSRPW28eKYOFHeBcdXD+sn3KCWW183mxNkQpiMhUj/TfvqC6upG
         hkcXcpYa7nMB2Da9UMEETNxWIjL2QjgbvK0x/Z7bAAwZkRWSqvfLx0hMY32BJp9/hXGi
         4y0/QNJsSowcRreC+q4egych22bvElGOFslQS24viUMxHegoOgsIHoCWrEfbO0HGOAQD
         FD3A==
X-Gm-Message-State: AOJu0YwZ1eabXH2QuUQfSl0+ZYKGhzh7+Fs7cwimDGC0uI6aAdLhv5WX
	SeOeLN1a+mIBqMlE9r9NN9UfUs/Fr7SfEbQLBMb0fjynjhb1TCfEAUh0a3zPgH6mPV0Xgt0wN2t
	TWN5xEpiVpz9HJ59avFAvqA==
X-Google-Smtp-Source: AGHT+IEci/5Vf3xvtYbFkcaYw0HOJ1oknd+M3m+3oDNqcWJzcmzdj34YJpIssgfG0DDd2PMTBXI9vzt+k94gCxre9A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:a:b0:608:2104:5c64 with SMTP
 id bc10-20020a05690c000a00b0060821045c64mr3008801ywb.3.1708553522032; Wed, 21
 Feb 2024 14:12:02 -0800 (PST)
Date: Wed, 21 Feb 2024 22:11:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC511mUC/32NQQ7CIBBFr9LMWgxgQe3Ke5guKExhokIDTaNpe
 nexB3D5XvLfX6FgJizQNStkXKhQihXkoQEbTPTIyFUGyWXLpRSsxClTnEdmA9rHZGYbmLnoFp0
 +4+A41OWUcaT3Xr33lQOVOeXPfrKIn/3fWwQT7GSs4lIN6qrFzafkn3i06QX9tm1fFrIsr7cAA AA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708553521; l=2107;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=/rPb7XyLIQzOH6lWvHaGCiHeCQoC67DC2adMcM3z+3I=; b=xNryGjmPlmtJ/xKQh+oTgMUOQUpAJvyNQ5uOeHdanxDPo9fePKNVuKttSZFrsacspISd2N6dZ
 lypaFNdtnD2ALtrrQ5nK7WfoTqd7TPTxD6EQdpfv5X0jpUx7KOZBeHM
X-Mailer: b4 0.12.3
Message-ID: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>
Subject: [PATCH v2] checkpatch: add check for snprintf to scnprintf
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
Changes in v2:
- Had a vim moment and deleted a character before sending the patch.
- Replaced the character :)
- Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com
---
From a discussion here [1].

[1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org/
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..64025a6e6155 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7012,6 +7012,12 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# snprintf uses that should likely be {v}scnprintf
+		if ($line =~ /\bsnprintf\s*\(\s*/) {
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


