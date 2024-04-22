Return-Path: <linux-kernel+bounces-154058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDD28AD6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1563A283BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032FB1CD29;
	Mon, 22 Apr 2024 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6sxRn7M"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824F1B978
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821618; cv=none; b=uTeEPFjllgLJSfTHfDhXQY2u3KCPDYWSXLKnmYTK+NcYkiipY0Yr7ePPAq3mRIxeXTHMRs1RzTOvn1BSLA2fXK8pyo/s87/bspJrnWGBRW4F9y91md6g0MaEMJtVf4NuBPsLxbakS7i9L/nV/f5GFw2a8TphPOJ0j373gyVK68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821618; c=relaxed/simple;
	bh=KoGkjBaET7UqkuHSu4yCulVlOdC9PQQ8/g3x+7MJQF4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mn7ypGVmOgNDgOQC76m3EGG68Qi/npsfPOEezQse98VUWkUvJtWIM8zBBc8p5m7W11IAj6NgnlkDY9FZJoTmhcnPblvBLAgalofI6t40COzo6uugpT/LSEwQCJGRXqb8Z9Ltf7p29TS33CWS/XWFFGnGJSMMQJBbfdq9zAUErfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6sxRn7M; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so9786918276.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713821614; x=1714426414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JWL/zGxv/3TQuwEboaVdGnhbzcGjgPZ6QRFC5NUsRRk=;
        b=S6sxRn7MOuvkZTZTkos4vBLsGLmq30wjJSbNbrjUYnR+wL02BwolKj6igH9N7zIAiQ
         HBmkfvBCWghWgybR4xyPJlYcWFQnNW/+r8WsTUm40e9exdTnBxREdC+2UXYUxm7tlZTp
         bT5vAjZg8+rt298xICgNgM+xQunylvlFB5EnfBwdT8aAHnW7F7V3kX5WY08IeVceEuJa
         Gy+QcKvKydtSLsqFW+Yan37oWO9iUbpWTz+XVd5Xkpce+Ya08Mbc2JupMhATh9zGyMKt
         2k6imtFImzbRujx2adQzEqo3Xw3RKYLOQbItCDdjwPmvG8/wiGP2HRv+MM7ZeNHckU5p
         nD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821614; x=1714426414;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWL/zGxv/3TQuwEboaVdGnhbzcGjgPZ6QRFC5NUsRRk=;
        b=mF51Btda4+LX+Npxdc0YCjp3XESBbngFlJ2Sbc/Q3NmIMzhgLNsfy4YFhzWoleUuCC
         3Sr8IBA2Dz4QWYGzuI66EKs3BmISZObKgygQvq1972kh6eiHpHF5gTkVJ12lAnlBwP5B
         EJcGbYR/ae9UpZsyC7a2cS25ZZ0jMoakmLZpsE1goptE0NMkcYXhnpbriDP9r4jQPlmx
         no2KpfR375+H9jdGAFbMipjET4UJ0QxtcSI43bH8E1iY5IP0/QR0MacJ9tGwf7+wkhag
         3qPLJ+C/8VkgJuyBMU1Of2m9hMzFV7k/pZ3Ff2yDe8Wo64xbgUNQA+d6S9GBvPy5bpPh
         edlg==
X-Gm-Message-State: AOJu0YyOR8Iy6k8uEMMKUtvoweKJtdyEz6b5o2c8gUTX2mIXE//G7iZu
	tPoMb0rdOK6lafymt84ivWZCAwKaqq/JG2OhQQPnNlIzz1kxcxljwKH8/hNTSK73b/d610dcC31
	Rqx/Rk2kqKygt7t26wCAhhQ==
X-Google-Smtp-Source: AGHT+IHRAYjODQvhZMAVdTut8PSJ03XnA8BSy2cwdXJaeLIsfBRt7ySYzs4u6FV72DEdNS6LhMHGPpJLStfRiO35lg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1148:b0:de4:7bae:3333 with
 SMTP id p8-20020a056902114800b00de47bae3333mr3637771ybu.3.1713821614629; Mon,
 22 Apr 2024 14:33:34 -0700 (PDT)
Date: Mon, 22 Apr 2024 21:33:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKrXJmYC/43NTQ6CMBCG4auYrq3pP9SV9zAuShmgUSlpCdEQ7
 m5hQwzEuHy/ZJ4ZUYTgIKLzYUQBBhedb1PI4wHZxrQ1YFemRowwQRijOLZdcG1fYduAvXemtw0
 2uRJQqgyKkqB02QWo3GtRr7fUjYu9D+/lyUDn9bc3UEwxN1YSJgupFb3U3tcPOFn/RDM4sD8Ql
 hBdGEhCaYCTDcJXhFO5j/CEGCEpZEoJTtQGESsiSL6PiITkSmdWK2O1KL6QaZo+4tp3ZIYBAAA =
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713821613; l=2724;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=KoGkjBaET7UqkuHSu4yCulVlOdC9PQQ8/g3x+7MJQF4=; b=ZZ4+o+IWJCMGEUu2xSN3K1eKCmtXxDDP5ygJn55HSjNFh6F5YsTicn2RWjMXOJO1gRqkE3i5E
 WZXZFNi1azVA+R/VkoSwsJ1XC/uVhmYYv2D4Q1xE1I8qFADgrxkbbu/
X-Mailer: b4 0.12.3
Message-ID: <20240422-snprintf-checkpatch-v5-1-f1e90bf7164e@google.com>
Subject: [PATCH v5] checkpatch: add check for snprintf to scnprintf
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
Changes in v5:
- use capture groups to let the user know which variation they used
- Link to v4: https://lore.kernel.org/r/20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com

Changes in v4:
- also check for vsnprintf variant (thanks Bill)
- Link to v3: https://lore.kernel.org/r/20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com

Changes in v3:
- fix indentation
- add reference link (https://github.com/KSPP/linux/issues/105) (thanks Joe)
- Link to v2: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com

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
index 9c4c4a61bc83..b7404e53c554 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7012,6 +7012,12 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# {v}snprintf uses that should likely be {v}scnprintf
+		if ($line =~ /\b((v|)snprintf\s*\()/) {
+			WARN("SNPRINTF",
+			     "Prefer ${2}scnprintf over $1 - see: https://github.com/KSPP/linux/issues/105\n" . $herecurr);
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


