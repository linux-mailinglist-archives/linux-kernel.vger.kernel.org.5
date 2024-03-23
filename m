Return-Path: <linux-kernel+bounces-112388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C5887932
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE2D1C20CC4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BE441760;
	Sat, 23 Mar 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQbDpNn1"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648B1E522
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711207779; cv=none; b=B0WsXhGFoNUJ3aPFSgpOTL4OsLRBVXIM02WP7bup7V0kmwxxPKETYYYfzHmbGf0QNXdI+u0Qd+FNQl1ZTRQY4z+1ynzWG+9GCMMM7KuML6FlTM+9vAsL+MJ4tFZRb306lzanAIuBdhGNZO6gUetI/doO69aZ1D5ZCrgc9p+MFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711207779; c=relaxed/simple;
	bh=YO9gUTgaDfigG3pnRo6pI1UE2a7gJsLDI12TUEB7w6A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i8PVtv7OZPE/v9E/DgUGEWJmejFpX4q9yjsGXu0KZp3mEXXdzqYGHLGAHD3MTGT+IbrdYTtRE7nR9PUd31YGCqpSIQZGM24nlGqGLxGJgSADUU8k80L8mT1LQzWfhSETa8ERwuzLXZeD2eIXPWzB05HRkHcxpz6LpYztKEXaZ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQbDpNn1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso4862075276.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711207777; x=1711812577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t7v2PUoOrrqBlYQ910Be8a+zXgflKBAv0+UOOU5fes8=;
        b=tQbDpNn1AEDpcI/o3JSNAodRE41U7fJ6/7i9blNJv+wCuS97Z0vv2Gw8sQLcUqtq/W
         cpqXniVXqlYfphPHFM8VDyJqO/La+cbSfpDlftxdOBvP6UqzSGz2lq35eNxepa+d4EEI
         OOxGBrIpWtiwphnwRsKqVochgxm0th+NTwfo2IvcTXzS3P4e9ligFIPSLmqN4VW+aj/d
         xRJO6duXAsb41593ygV8b9wKoS+npt+sBY6Fctp81V8L8NUFcGKLh/x1rr0HrpSc3YMB
         7Sbq3Y7KS9J3dnaGgeKtXmFMYOT/ul6/noA/m+NIgOFgidjUBGsqjyFtggm79Ah7nrfK
         bO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711207777; x=1711812577;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7v2PUoOrrqBlYQ910Be8a+zXgflKBAv0+UOOU5fes8=;
        b=Irzx8znH2a97KWWSpgfiaTegHZ/iNlg2b7gjnUHEt9hk7LeGVfPyTPP8tppb6jOGX5
         qbSefdn97toMtXcJJ2YRAW0/DBrh9wDzXCJHZSfK/a/S9Of7jQh/ZzwFqejX8vNLQiVY
         ag1OmC8Gapa1rCaHUWYyf8Wjffgk3JDnCx6+7JtAh54diZfBpkh2jXT7Ri5kmQcSx0FR
         Ko0VfVKTKWlki4ioN395XpZU2yegVLkBYNjI0cLHmndcXDxVcTWzqXGd/0Ks6Lf1FtGJ
         Y2TOIDW4+jiIdfLCIHAPPlhYXcEoeOkJ7basc4f2bzzErzvZlcyRbo29oUnCbDMFT8Jj
         E8yw==
X-Forwarded-Encrypted: i=1; AJvYcCVHvgmihK9gdZyi+OPYRrmThOBo+cuz1CUfuPtmKX7TdCVLgG+thjqTFB7oUKLbvO6QRBuvgif82g/V2gRSSuZV00tuA5Pp7jBTECVh
X-Gm-Message-State: AOJu0YxYB5IrP0GuungSXd+XIp+NPmyQnIMgIar3WJIeMAA6uA+unzmW
	H4smMs1KAheIzP2FIaylqPJ17T1XwoVa/BqMV4hQ24hi+O3G+N9hVudGFgnu1tvcG9brIddeF1F
	XZyKVxQ/a2ZlEkQ==
X-Google-Smtp-Source: AGHT+IH1aqpo+RMPBCE170zDzlc6ueuHMt1fRst/EWwK7w2daYEfs0yyjpcSlEJTd0vB8iyuPKyN2cM72lpsRnA=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a05:6902:1b09:b0:dc7:865b:22c6 with SMTP
 id eh9-20020a0569021b0900b00dc7865b22c6mr71331ybb.8.1711207777038; Sat, 23
 Mar 2024 08:29:37 -0700 (PDT)
Date: Sat, 23 Mar 2024 08:29:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240323152934.3307391-1-jsperbeck@google.com>
Subject: [PATCH] init: open output files from cpio unpacking with O_LARGEFILE
From: John Sperbeck <jsperbeck@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	"ndesaulniers@google.com" <ndesaulniers@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"

If a member of a cpio archive for an initrd or initrams is larger
than 2Gb, we'll eventually fail to write to that file when we
get to that limit, unless O_LARGEFILE is set.

The problem can be seen with this recipe, assuming that BLK_DEV_RAM
is not configured:

cd /tmp
dd if=/dev/zero of=BIGFILE bs=1048576 count=2200
echo BIGFILE | cpio -o -H newc -R root:root > initrd.img
kexec -l /boot/vmlinuz-$(uname -r) --initrd=initrd.img --reuse-cmdline
kexec -e

The console will show 'Initramfs unpacking failed: write error'.  With
the patch, the error is gone.

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 76deb48c38cb..b5ede45d2f7e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -366,7 +366,7 @@ static int __init do_name(void)
 	if (S_ISREG(mode)) {
 		int ml = maybe_link();
 		if (ml >= 0) {
-			int openflags = O_WRONLY|O_CREAT;
+			int openflags = O_WRONLY|O_CREAT|O_LARGEFILE;
 			if (ml != 1)
 				openflags |= O_TRUNC;
 			wfile = filp_open(collected, openflags, mode);
-- 
2.44.0.396.g6e790dbe36-goog


