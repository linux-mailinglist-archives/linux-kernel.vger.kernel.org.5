Return-Path: <linux-kernel+bounces-105575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A0B87E09C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CC0B217CA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681C521101;
	Sun, 17 Mar 2024 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJTeERWS"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EAF208C3
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710713744; cv=none; b=Ry9bQJumJbJXuvw0l64l6Z0oqMECfVOsiIXX1L4rV0jCfVoFkEu/dY9fXOa5IvYTR0KybFeDnDg3QoZMPFiQIRJM5PT9D3plXR02l3LuRZyYseey4kOGb8xaplSo16zKtpxRHsa0nu0iOuRTcVjp74ggpHb2KHT6v23810WUWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710713744; c=relaxed/simple;
	bh=fCtYvy28FaAej3ITUauy8DKmshf/fP8+we1BlTQCf1w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cYyjfV+9mVJSVGHvt1t5yinQ01kboLQpw411kOq+6hZWN3MEFx2+7yaWrkC1IQ/WWh9O53wV6MSU74OghqRHvF+23wgktVOR6Z3C78M7s7vs6kHsHrFtxpvEtx4DO3pjxB7vkLbD+8BYKXtNz0hni477+biOcPFkpyD6tA4XSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJTeERWS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e6bf91a8dfso4092082b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710713743; x=1711318543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X2JEuG0AZF0MAOLSKLcKLKNaQIvFupZs8LUprgw+gE4=;
        b=hJTeERWS7EajtqBqi48gcqOee3UxsCteETIv57erATm8SeTB3/a+IXlLLRhQWV/Ivh
         FRNXnzz1Dwi0B/HXFU6V9JN2mADZ3riHrGgYfccTQK0jh5YjY12BPtkJl/ZY4k0JSyZy
         jxj1Q1jdcMT7jC3TtBya38H9hfUFN7RO34FnBqEM+OBINTpLHhjWlMcLGzXm3HLbDnqA
         2O3pmlYOEE0XgKqYwUVnZG/0ufyYE2FdD0dKS5gTwcPIJycA3RKFB+BZHBSzTqCSpfPX
         wfxnlT6OxxJ/s3eXqEE4VbLCxGVhLucR0BpRlo/bycBP+FTj1zhmuoAEIEI3RVD9Yihj
         hrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710713743; x=1711318543;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2JEuG0AZF0MAOLSKLcKLKNaQIvFupZs8LUprgw+gE4=;
        b=qgyjz16S1D+IU/kzEzvVbhmqFtP7RLxgNJNh180hUbFQ9pxoLhHi5YThPse0lSKcs3
         hRc1sM4tujd6epN92iryvUieohCaYK28R+CTZvjzhS5HaYeTtgcbU+xaX+nmiUAUbuUZ
         2G+4xlsK+idz/kiHvTpoJ0uxiF9+VSrGvGFzHiQQdmQNSkTEo2xacuVXszQG1V+9OrRf
         PICV9OUetNjdzDGqhIBQzagYBxLI/iPwDxm/uoH5c3TiYct1QkwNIN8310hBXliiJvrh
         z2B7BCX+Z5yBUk2kVoMGG8nHxP+JN2iVrBxyxljlpT8O6i5NZwLPwZpjIYEBB663hjDW
         yjWQ==
X-Gm-Message-State: AOJu0YwW6Mm1qzmhwwJm0wcPGUBjBz1ZeAeFqmrAT763JP972Ly4zvW0
	/81ZO1I7ENR/RAs52nzm9kbUx4ZVBYA8yB4RjwYFolldZEyb8yK8755qqBfLB1k74DYT8xas87L
	dxL6632jB2Stt9g==
X-Google-Smtp-Source: AGHT+IFm+Bfmaj1ntoYGQWqKBf58zU56NDscckwskdM7Yn2Z0C39AIjn+BDhQg157vht4TN/CyPltnlSwYYtuCI=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a05:6a00:399f:b0:6e5:3e08:cbeb with SMTP
 id fi31-20020a056a00399f00b006e53e08cbebmr226316pfb.2.1710713742502; Sun, 17
 Mar 2024 15:15:42 -0700 (PDT)
Date: Sun, 17 Mar 2024 15:15:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240317221522.896040-1-jsperbeck@google.com>
Subject: [PATCH] init: open /initrd.image with O_LARGEFILE
From: John Sperbeck <jsperbeck@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	"ndesaulniers@google.com" <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"

If initrd data is larger than 2Gb, we'll eventually fail to write to
the /initrd.image file when we hit that limit, unless O_LARGEFILE is set.

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 76deb48c38cb..b607d3463b47 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -683,7 +683,7 @@ static void __init populate_initrd_image(char *err)
 
 	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
 			err);
-	file = filp_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
+	file = filp_open("/initrd.image", O_WRONLY|O_CREAT|O_LARGEFILE, 0700);
 	if (IS_ERR(file))
 		return;
 
-- 
2.44.0.291.gc1ea87d7ee-goog


