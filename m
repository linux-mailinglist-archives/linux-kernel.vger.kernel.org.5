Return-Path: <linux-kernel+bounces-123637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C387890C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAC01F24C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946D13A414;
	Thu, 28 Mar 2024 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ErPAJD+t"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5BE13A3F3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659260; cv=none; b=jxDQXygUaQSW0v2Um4lu+JXfZNwpxtB76ncCDiOeqVk80/wIeRdTqsoiplPfKfPvGVq8E0VJwxHxN+GweSQkQNOPJCjBsuz9W892n0gWYS/taErlHf4ti5DRlx1jp9ekcxJV80doeyYZxScGE+FXOsz/SpxqgWLA8fNmSqjjINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659260; c=relaxed/simple;
	bh=dxZ8bKhF+xsDNjClmZAMnCylDOfHbdXS5i6fIidiALI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YxWu0whLVyjwxy/WG09w6URUuz8hxsp5ysaYKmyNXAJraI7vwRUoxtB3yzeyM7TxQSFeYvdlJ/NAXxZXFlLsw0vstWGEP45EHRP6cb83sbXXNrE1ZGb8GimaM3+NkM56YOCgq3joLcRsU64qUrkHiUpApnss4F027pqRCyqG7Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErPAJD+t; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a08eb0956so22164307b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711659257; x=1712264057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oeh0VMbE9HOBRQtaIW93T8/UfTUlPooJDM6aAubdbLE=;
        b=ErPAJD+t8AnXK2ln282Y5dkbVgmUirXnZ089p7CvCBBu1LMm4naltRBRieYPQ2nt0O
         SzeOQGjJ8TLYDjkJ0mwq2Pk/IB8xUFFVwcCx9dczmFn/0vW7QeYFrxp0oP+3DRpQjMOP
         AFyXTO1Lh+KRjbdLkKDMGW3OsgwWysvzW4oZXkPt6/OyimhL37Ugqz88CK0UkZApghls
         Azuomt1oejEF0KyxU/ZQLlkC/QRDgToA1K3OINE3KWPjAN/JGDm9w8bufnDDFpdMPV8y
         hS5CdW4M347BqgNQhq6cMyWqOiJUDDjAfa3lo954Rxug/PMwPsxvLV5jUcWc8X7T9Okh
         k2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659257; x=1712264057;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeh0VMbE9HOBRQtaIW93T8/UfTUlPooJDM6aAubdbLE=;
        b=AZR/GDMyBMimUbrGiCDdonYb8XJmDmqgNE5rspq+1fmbvSgP/smGeDtBT/+HMOI3AN
         GnXWR6RoijirrTEQ4I5FdzrJFpdMvhjWL7dXDF0A10DbAf+nHId44qx7uXeA/Jr7VzsK
         09t2so2IQDyFUUWwCyb65ouRXRTaz8ziQ/B13D1uLYZO+JAfaL4+D7bBZwOPCJrDUUc3
         XWEeHN8S/+mlQxnuvTb32fb5CmnFHSTTkVvWcBJkrocYvDISLKPYLj0BrxAq46SJt1jI
         t7PRsdhogujYQsVmbQKqeYCgz7tdi8rxzXmBa/foc+/8SIvKw9e9BCjouRRfUlxH1Aj1
         oc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1qZqsNJDRzaULQ61dMzaT+2AbRfx8Giwc9GmOFWhYSQEGvCsZ6z1I0AHpEAgSsMNPnSGtUpMVEm25s8IyUKcze9nOiL50RQ9nkMMg
X-Gm-Message-State: AOJu0Yz82+YvFy8o2H2tqOX3X0eIU4akHiGbCUo2HHw9qD4IYuivYEqR
	X4B3WlNKxlbHDsZZ+wJnf9NaCGC2ri+MRbddmcgyyWtpLnhSokh+hFRzWaXpLquKthnOXICw8U9
	EFxuJv4NimqmFXI3r7up5eA==
X-Google-Smtp-Source: AGHT+IFAZ/FVFAQSXOFC7j7CtQVInEdn75Twn+yuFjapvh0FcmJJNWKvTbJUha8cYhBldw23UET06erMaMfGAVMUIQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:d654:0:b0:614:3269:ee5 with SMTP
 id y81-20020a0dd654000000b0061432690ee5mr121955ywd.6.1711659257672; Thu, 28
 Mar 2024 13:54:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 20:54:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPfYBWYC/x3MwQqDMAyA4VeRnA3UVlD3KsPDzFIXJrUkIhPx3
 Vc8fof/P8FYhQ0e1QnKu5isqaCpK6DPK82M8i4G73zrgu/RNk2UD4yG2bZVGafli4Q9NeQouG6 IAUqdlaP87vNzvK4/V04ddWkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711659257; l=2073;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=dxZ8bKhF+xsDNjClmZAMnCylDOfHbdXS5i6fIidiALI=; b=zIOARQoHQqKQceMMP/mGFv16wBKPu7koX3eX5V0NPub4Y2ClElGj59hdpG3oCm9gy947zPgsr
 TmO8YN6n6M7AMfKABsMOZxkr3z/CWnc6yxjR+OQB1q2vfFdOFOOYMDD
X-Mailer: b4 0.12.3
Message-ID: <20240328-strncpy-fs-pstore-blk-c-v1-1-5748cdc22a53@google.com>
Subject: [PATCH] pstore/blk: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We know that info-device should be NUL-terminated based on its use with
strlen():
|	static int __init mtdpstore_init(void)
|	{
|		int ret;
|		struct mtdpstore_context *cxt = &oops_cxt;
|		struct pstore_blk_config *info = &cxt->info;
|
|		ret = pstore_blk_get_config(info);
|		if (unlikely(ret))
|			return ret;
|
|		if (strlen(info->device) == 0) {
|			pr_err("mtd device must be supplied (device name is empty)\n");
..

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer.

Note that this patch relies on the _new_ 2-argument version of strscpy()
introduced in Commit e6584c3964f2f ("string: Allow 2-argument strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/pstore/blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index de8cf5d75f34..65b2473e22ff 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -241,7 +241,7 @@ static int __register_pstore_blk(struct pstore_device_info *dev,
 /* get information of pstore/blk */
 int pstore_blk_get_config(struct pstore_blk_config *info)
 {
-	strncpy(info->device, blkdev, 80);
+	strscpy(info->device, blkdev);
 	info->max_reason = max_reason;
 	info->kmsg_size = check_size(kmsg_size, 4096);
 	info->pmsg_size = check_size(pmsg_size, 4096);

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240328-strncpy-fs-pstore-blk-c-8c1c0c3079f3

Best regards,
--
Justin Stitt <justinstitt@google.com>


