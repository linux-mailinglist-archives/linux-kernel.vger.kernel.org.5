Return-Path: <linux-kernel+bounces-133539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F189A543
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85731F230D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7055517335B;
	Fri,  5 Apr 2024 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wiV/V0Aq"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBFA17334B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346750; cv=none; b=siLMk+3w03lxHu+4GqAVrHniOP/RCjN5DjZEfNjLTXOGsR9I2LAUQjwRNgF5/Wu3qGfWjaWXvAKYihRaONFbZyFaEIUl/gK+7CqRW457qTOFlgo0uhLHkb0OID9K+xNa7XGLAETYY+oQp6N9r9HBRLrsVqxYC+Iopm72bJxJ+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346750; c=relaxed/simple;
	bh=vYvlobC0IDZBVBOa7YOXs1X5Fi3hYHEaAkBcmMYioy0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jmK/A+zbYsPXgw5Ydhspf81NqOPKNaAFYbKU9Tdpq1gesPcLY8jLpIlB5/MrgWP4W00Acho94hyWPmXY4+NHhnxTMAtLREkOo3qB10kS+eBYNRcJ/dkmBDrx3Xu25A81T02Phis8/HRN5SFpx+tiR1BhkURFIkXHS480RVCR5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wiV/V0Aq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso4815845276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712346748; x=1712951548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BLLJ3cI5n31IjZX+orm1PoAy1NOT9LFeskEoaayxLEw=;
        b=wiV/V0AqKJvZ5tfzZe0+mA5svkjycZIJqbxyDR+9yD3xgz0Zax0grKHLJQP90rrOeo
         Uob5ocw5up39cjmw3VpkaKDnIJhcwhDJb5sgbPKV95ul6aSqIRw26gxcNJDpnvl0KrsW
         JeQu1R9KXAUy5qCZj/m6RnyaHvErzNYx9TmzYJidMHlWWn5fcQtiu8e35lijJs8DuQn0
         vu8ZuVNExVFLtokf73UPPyJtAX8mASOQENgEj079KST8Ac65XcGvGnQftAHe4p9VWk+r
         LT0+ev+/FNjt5CHwscryvKQ03hhA9dHA9AP+g5KYZ2fDFfLmDbzhFDrTbqtaONGoxqf+
         D6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712346748; x=1712951548;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLLJ3cI5n31IjZX+orm1PoAy1NOT9LFeskEoaayxLEw=;
        b=Ligm1rs8JDDc4EHaMBXYOfSdbW9p+oALNr/1Uec4olCJEhrl7QGHKeC1o80lVKZz8B
         uBP6lLXw8JLprAixQkgCeqhe6WI+yi1fru9xN8Nr6bO56i/e1L0FTWfKNP5mPqPx8r9s
         afUHJIm5T+7M+zXks8c8sXcMXsyYYZQVi27aSdDbJ9KjzAHyxxXFPIS/dBr/GpgWadUR
         FiE+fakqx9JIxP0B7dPXSxYZLsZDikAtr/ucqJgrLHp/IxS2mRjA/up3Cec6iX5X3woc
         t+REkPSONWmRXjc1qALnoiKKjA4ycjhEf59vclvJ4g/bvmhdO+Xs9b0OiRO5iHmzZcsz
         GdYw==
X-Forwarded-Encrypted: i=1; AJvYcCW/SN0lD2yg9UJxs0JZcWJyv/mJMOW4avbABcmjr8BKd1sJKMQsx4JngxWjp6TcEKL2bZjznACRn2N+GiRnqNUEzbwSZlukeQHYWi9h
X-Gm-Message-State: AOJu0Yy9C5hUFEY2J/e5/52FLZzViz7BV2XXyiqMJoceolyk7F/Bg6YU
	I6JKBi0my6GlGrc0oO5+vnjZeRpUAfT+I71g14RxKuvvK75Uy1QcGiwrVLOTfRSdVmJINqKWup1
	AzR9sujkMIZVx31u68WuSyQ==
X-Google-Smtp-Source: AGHT+IFrf+0Q+RKxYR88LmacrwQBohGh6afFQV57l8KEQEbm00Iur/rM9hcf7VoWKLuIVrPhKmQ6d0cvQBc2OXcndg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2b8e:b0:dd9:2782:d1c6 with
 SMTP id fj14-20020a0569022b8e00b00dd92782d1c6mr831468ybb.1.1712346748349;
 Fri, 05 Apr 2024 12:52:28 -0700 (PDT)
Date: Fri, 05 Apr 2024 19:52:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHpWEGYC/x3MQQ5AMBBA0avIrE1SVYKriAU1mESq6TRCxN01l
 m/x/wNCgUmgyx4IdLLw4RKKPAO7jW4l5DkZtNJGGVWhxOCsv/FaBMXvHAsctTWqmdrS2BpS6AM tfP3TfnjfDwka6btkAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712346747; l=2056;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=vYvlobC0IDZBVBOa7YOXs1X5Fi3hYHEaAkBcmMYioy0=; b=4rabEFihQGgrT9i4tCWotZawQeByWYwd6mONPL4Qi8FFBEQ0cnToIfpharV2nq/9OKdtArjxD
 vbgQj4qA8poBnnKHzrz0nWkPWkSKokPN2egccLZ+4bP6npPrh+gfvxl
X-Mailer: b4 0.12.3
Message-ID: <20240405-strncpy-xfs-split1-v1-1-3e3df465adb9@google.com>
Subject: [PATCH] xfs: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

The current code has taken care of NUL-termination by memset()'ing
@label. This is followed by a strncpy() to perform the string copy.

Instead, use strscpy_pad() to get both 1) NUL-termination and 2)
NUL-padding which is needed as this is copied out to userspace.

Note that this patch uses the new 2-argument version of strscpy_pad
introduced in Commit e6584c3964f2f ("string: Allow 2-argument
strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Split from https://lore.kernel.org/all/20240401-strncpy-fs-xfs-xfs_ioctl-c-v1-1-02b9feb1989b@google.com/
with feedback from Christoph H.
---
 fs/xfs/xfs_ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d0e2cec6210d..a1156a8b1e15 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1750,15 +1750,14 @@ xfs_ioc_getlabel(
 	char			__user *user_label)
 {
 	struct xfs_sb		*sbp = &mp->m_sb;
+	/* 1 larger than sb_fname, for a trailing NUL char */
 	char			label[XFSLABEL_MAX + 1];
 
 	/* Paranoia */
 	BUILD_BUG_ON(sizeof(sbp->sb_fname) > FSLABEL_MAX);
 
-	/* 1 larger than sb_fname, so this ensures a trailing NUL char */
-	memset(label, 0, sizeof(label));
 	spin_lock(&mp->m_sb_lock);
-	strncpy(label, sbp->sb_fname, XFSLABEL_MAX);
+	strscpy_pad(label, sbp->sb_fname);
 	spin_unlock(&mp->m_sb_lock);
 
 	if (copy_to_user(user_label, label, sizeof(label)))

---
base-commit: c85af715cac0a951eea97393378e84bb49384734
change-id: 20240405-strncpy-xfs-split1-a2c408b934c6

Best regards,
--
Justin Stitt <justinstitt@google.com>


