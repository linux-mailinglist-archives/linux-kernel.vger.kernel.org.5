Return-Path: <linux-kernel+bounces-139321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD088A0164
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EC728BDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A9181CE8;
	Wed, 10 Apr 2024 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DoLxMmlR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2817F37A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781818; cv=none; b=pxQN8t/LELwQ0teGCAnU0jL3mvY+FJaREFu7EUTmXssn+aDB9dc2WOUQGEN4/gr0o6VXgWHuLdE1SHC3S43sc+wK57gV+sKpzPlk19zpHB9NRSQBaUY7G5d+PixXTg/qJ5TTEhYSjo6pSygF6hR+w1gchUj6LhiT1cCV/FbTqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781818; c=relaxed/simple;
	bh=haeE2c1uQMVwuBCh6nmKoLx0syvsO5cganYlWpRKAFo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LytSTIXlCZrjJbU94fhJS/UUn5dHQ9ef82jZiecIQ1NnOrFG5Jq1CMvp0aDCBifI8E4zGTzSjGmRjQweInRQFJRoHN0HmXxE+U1eDd/xuQY04zJkt2Csqx/ujs6piTNZtgUdLNRoyeMqCbNGOmOPJijw02h8hiCBz4lHpbdyRDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DoLxMmlR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de0b4063e59so4796665276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712781816; x=1713386616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K4SubXYu8kjsVJfXEh2At6iMxBrwK+80VVQTqnF6NMs=;
        b=DoLxMmlRxqj9arQZ7eoYfdnWzW8J0AVmixqNjiiG3oQSzMGOioMmkIKAszPVstbEAa
         /d1pqu+Q+Zcc9iUvLEf7EoST606wod6KCurrvT4gkY1qP9HaqkaukVfz/NbfgccpOrey
         37XxLpYfGaMNqVvy4kubX8ofDT6F5f7QkmQwkmrHB02DzFINctIA8dFnGvnC1AfBbXeS
         RIlmpAkcPVqXKBfPyp29lBncfRqxFrrTtWJM2665utW5mkE9mNbN+plZLcfprZzjGyVj
         P8qN5xisr9vXjuDUjB/SUVXhDfHjefxSx1ddQqKfFwv5Xgfx+8C8PbweB02cMPnRzLUN
         fiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712781816; x=1713386616;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4SubXYu8kjsVJfXEh2At6iMxBrwK+80VVQTqnF6NMs=;
        b=kbrdPBbhe+iE7Lzt7rN9y6PF/QEfKOiU+Y3eVOQpXl+aWhtTEnxbZC8h3j1XdYQDfX
         83GELKEn9NP2VpAFtLYWW81UHfCoCz1+R66/vgGwA2N49rZxVRLufmPiS9RnrAjDofUl
         Uu71pdA1tF9lW+rk8oujlPR85kbzojBRg8jISYqR4T7ee4YNGiv7XWEjXDfmL8B7mBSe
         nk2TprCU7Bo68fVMSWUMdCt++FFHq9iW4G0kYcdjq+E0WkMlpku8Qb17TdfyYSS1OeNK
         CIZoGLrwDPCIaCkumLoAJAZX0e8sNVJIINer1KWg/y+3XEcVBibCCyqvkvk+Q/uSZWA8
         19tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVflTlfGJgAKMhKmrIEadrXFz/Xm7uqvSu5M6pEKji5HhCE3UNsHd0qfvPwM/Nm1MVQVLyPbe4v018aoD1Lmwmxgk/FEVUm7EshcZ0y
X-Gm-Message-State: AOJu0Yy7y5ESPfFX4AwCntucIAvvM7D3/N5tU1xDcHjpFOOaHldMDfa1
	CpLfwTlFkYTRFWnO8jwqnFnCirqPOc+OjOQ7s1LyiCdTTeQXDUXnbqjMSx2LEGwotPIeQTq5uzC
	9OeyA5eJZnjZ5rarSbyk3Ww==
X-Google-Smtp-Source: AGHT+IG8XPLzn461t7HYg7HcnLuaG3TVHzRMb9P4mUgIRvjW7s/eDccTG/ZbSuOJUAz9pc1Ch9tK3cW5uAl1bxnTTA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2b83:b0:dd9:1db5:8348 with
 SMTP id fj3-20020a0569022b8300b00dd91db58348mr1031841ybb.8.1712781815890;
 Wed, 10 Apr 2024 13:43:35 -0700 (PDT)
Date: Wed, 10 Apr 2024 20:43:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPX5FmYC/32NQQqDMBBFryKz7pQkRqld9R7FhcZRB6wJGRFFv
 HtTD9Dle/DfP0AoMgk8swMirSzs5wTmloEbm3kg5C4xGGWssqpAWeLswo5bLyhh4kVjY5xVj7b
 KrSshDUOknrcr+q4TjyyLj/v1seqf/ZtbNWrMKe96WxZN11avwfthorvzH6jP8/wCoGz2orUAA AA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712781815; l=2128;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=haeE2c1uQMVwuBCh6nmKoLx0syvsO5cganYlWpRKAFo=; b=MhjGam0PtObrc68tbZTGvY4oh5Wwyx6w16vBGbchHocaRdOCwzZBBtx0op7ozZ3jmt6i7GPf0
 AHDzHrYUreVB0COSb1VjQEFFd78V5pwZ7RkSJJY/rJb9V3oI6KkT8tN
X-Mailer: b4 0.12.3
Message-ID: <20240410-strncpy-xfs-split1-v2-1-7c651502bcb0@google.com>
Subject: [PATCH v2] xfs: replace deprecated strncpy with memtostr_pad
From: Justin Stitt <justinstitt@google.com>
To: Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

sbp->sb_fname may not be NUL-terminated while label is expected to be.
memtostr best describes this behavior, specifically, use the pad variant
since we're copying out to userspace.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use memtostr_pad (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20240405-strncpy-xfs-split1-v1-1-3e3df465adb9@google.com
---
Note: This patch relies on the memtostr{_pad} implementation from Kees' patch:
https://lore.kernel.org/all/20240410023155.2100422-1-keescook@chromium.org/

Split from https://lore.kernel.org/all/20240401-strncpy-fs-xfs-xfs_ioctl-c-v1-1-02b9feb1989b@google.com/
with feedback from Christoph H.
---
 fs/xfs/xfs_ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d0e2cec6210d..7ed7a5d57094 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1750,15 +1750,14 @@ xfs_ioc_getlabel(
 	char			__user *user_label)
 {
 	struct xfs_sb		*sbp = &mp->m_sb;
+	/* 1 larger than sb_fname, for a NULL byte */
 	char			label[XFSLABEL_MAX + 1];
 
 	/* Paranoia */
 	BUILD_BUG_ON(sizeof(sbp->sb_fname) > FSLABEL_MAX);
 
-	/* 1 larger than sb_fname, so this ensures a trailing NUL char */
-	memset(label, 0, sizeof(label));
 	spin_lock(&mp->m_sb_lock);
-	strncpy(label, sbp->sb_fname, XFSLABEL_MAX);
+	memtostr_pad(label, sbp->sb_fname);
 	spin_unlock(&mp->m_sb_lock);
 
 	if (copy_to_user(user_label, label, sizeof(label)))

---
base-commit: c85af715cac0a951eea97393378e84bb49384734
change-id: 20240405-strncpy-xfs-split1-a2c408b934c6

Best regards,
--
Justin Stitt <justinstitt@google.com>


