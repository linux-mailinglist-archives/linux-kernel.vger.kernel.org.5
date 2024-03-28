Return-Path: <linux-kernel+bounces-123690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4874B890CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CA2293534
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5CF1386DF;
	Thu, 28 Mar 2024 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGnlQTD1"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1E81752
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662783; cv=none; b=Iy8wep/+GQiguTsf5qvkNMz/Di/tHYGOLigkAknxGZ7EqcVFx/30EmwN0SWzgCPwNSf4/hYN9ovm7KrPDaiKt/I08L7GJeANy5kZLomj7OqfQCy8VevJkyCnJ8q87/a4xYBA/SL70YVpDMXg+Bj68H8RYea4PmFAGOIWf2j+cU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662783; c=relaxed/simple;
	bh=+KztE07UUscvi+sePNq+F6G3RCCKPYGdIgACZIMw9sE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kwvukE/HRxQ0ZU+TXmovb/H+XUO+IBXLGhP8yQtIqK2bvwiouMiLUq9x13KPmncuwM3G+aq46NAh86Y1PNC2YN3ugcVwsbfrOza6jz9f/mADz5D7uz3dEYDUoY2Fty3I0ofeYrfyOQaLnp3Q0UIWbgxY4dpAOizBst1qYfCdNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGnlQTD1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so355943276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711662780; x=1712267580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=foL4BCG62SLstRNbcMT9ASrhbCDRyY/z2HJbVm12o18=;
        b=SGnlQTD1WUj69/d/iPHqQPiVOQ2zy91KL1KUXiopxBDLhKzjMhYi3oLOGZA0MXow4k
         Pkn7qDPI1xagR8Qrwp/qYAoNrC1rbN6kfnqqBxjJsobfKtxEkzWiDDhC5xlRpPNgMYkO
         Wxr3uVijNH48aBoRruev3sm/9ipHr9z2mfdk+EfK9LUurT8Tu1jHFXvZghTeG8T3AYtY
         0s8pH484vrrXy44c+tbg6eaiyRy88DxHgW6v4fkR+AQeB2sRzaFU5zP7SCTo4ga413vk
         UZcMXWdjY0EjM7H5o2AQKu7LJmbF0gpIJFGahEF0yFA0ufpuxQHH3dQ9pev3sguj10V7
         E7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662780; x=1712267580;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foL4BCG62SLstRNbcMT9ASrhbCDRyY/z2HJbVm12o18=;
        b=oAPTQ89+eOYwu9gsrcvA4vZFy2n3HDGYkc5/b8edwfjyzY88kUPBgh8quHV3ZjjOZd
         QzezZZU7Qtp8Kfe/iQmC61jdrhFYJezNZpyKRqgkI2BeWhwRrHTqhS85KTUD+fajImc4
         0JEIG7DQBQE0VuAO5sO9uvFCMeXUTmp3iEiOnwO0+ph3j5y047tGHi5QHnMdWi82JLNs
         o1C+IPFti+vijh/SZW8gAiyHDMY2DaIsK1cLw1T9VWkJBBhBLB1QktTD359mDK+81PkR
         39nqZQRgXTJX9g+I7RFAUuWVNTT1PnJ6EfqjhYFZjYG6JDK4STSuSQ7wMIphgPWfG1AT
         2tjA==
X-Gm-Message-State: AOJu0Ywt3wUGcLWat8eGEgG8DDKEemmutdJV1gTz66aScOKxW7ZZs2E7
	XsfZzq7ft9hvP2HWu0zUHne+t/O/TAFM4caIT48ajenrZr3R9LrUBcjdHQfYbjSLMvlDiP7erzR
	jHVf6rS0B2jDpYJj+D1c1iA==
X-Google-Smtp-Source: AGHT+IHf0kRaer1qTwpKFR9hlTXJOef5AAkZ7xnug5Fstnj0aoj3edhfWu8ohddZy4lk1zR867c46XEOSVphH0twbg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:102f:b0:dc2:2ace:860 with
 SMTP id x15-20020a056902102f00b00dc22ace0860mr53549ybt.2.1711662779922; Thu,
 28 Mar 2024 14:52:59 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:52:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALrmBWYC/x3MTQ5AMBBA4avIrE1SRfxcRSyqBrNQdBAi7q6xe
 9/mPSDkmQTq6AFPJwsvLiCJI7CTcSMh98Gglc5UqkuU3Tu73jgIynYYmUI4MxOjxapXSVdWRU5 5CuGwehr4+u9N+74f13MkDm0AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711662779; l=1683;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=+KztE07UUscvi+sePNq+F6G3RCCKPYGdIgACZIMw9sE=; b=mfSF1PiukJaI3xLSOvlM/Mq03JtAOG9JoQ5+kKlFDvHqVTK5XTUD0IEHP5K+1rKi3qZJKGesr
 85HeNuR18anCA8f44CiRWM3AAuzqqN3tXOu+pCrdb+NO+leO2OgRCIU
X-Mailer: b4 0.12.3
Message-ID: <20240328-strncpy-fs-squashfs-namei-c-v1-1-5c7bcbbeb675@google.com>
Subject: [PATCH] Squashfs: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

The previous code took special care of NUL-terminating the destination
buffer via a manual assignment. As such, there is no bug in the current
implementation. However, in an effort to rid the kernel of strscpy()
[2], Let's instead use strscpy() which guarantees this behavior [3]. To
ensure we can copy the same number of bytes as before, add 1 to the
length argument provided to strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html  [3]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/squashfs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
index 11e4539b9eae..6c4704ba8f42 100644
--- a/fs/squashfs/namei.c
+++ b/fs/squashfs/namei.c
@@ -80,8 +80,7 @@ static int get_dir_index_using_name(struct super_block *sb,
 	}
 
 	str = &index->name[SQUASHFS_NAME_LEN + 1];
-	strncpy(str, name, len);
-	str[len] = '\0';
+	strscpy(str, name, len + 1);
 
 	for (i = 0; i < i_count; i++) {
 		err = squashfs_read_metadata(sb, index, &index_start,

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240328-strncpy-fs-squashfs-namei-c-9d01b8975e53

Best regards,
--
Justin Stitt <justinstitt@google.com>


