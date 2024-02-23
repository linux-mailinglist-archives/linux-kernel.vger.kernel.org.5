Return-Path: <linux-kernel+bounces-78768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF22C861895
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C6CB2108E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D54129A8E;
	Fri, 23 Feb 2024 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nitAuW0n"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAB9128397
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707590; cv=none; b=j/L7fiD+j9CACOO5mFr1GyTdAyTHbs7XzMqcCh38ZDh17XfZVp0cbDAuJuSMx1Guid3mtbQMTsBU/zpYzZMIhSOqPQtpm0K1a94ErL8mRH51kzN8lkK9QukL1qz0MmyuAFSsdztjRYB4s5EQmVP0wfh0/KZsO7r6t3PPzsVT3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707590; c=relaxed/simple;
	bh=GFnd+uRgcZ5JE6+yaYSUeEigjBZZ5ehiRJbCdQFjMSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozekoIdvCTY2azSc2/ucZPKKWjmewyAOwP6c0RJ53waWnFutXRPQDkCiOLDFwaCSlFrKzI0IWHG2WQQEyj0eJbtpu3Sl2SFE6rNfnHB6ufIv9muiBoZPo8M9BtqfmFWD2l7Y7MY+hGpbxM+u0OAljmklIQvWisKF09T5xyJV4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nitAuW0n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e4ca46ab04so363461b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708707588; x=1709312388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDMzDk/lBMFwiZnh7jtuEycU3dW7wec2i4CrQjkGJo4=;
        b=nitAuW0nEJXqcuwrvok8CkVkbfn2pnfOCTGqhqgni0qOUhvTAhltyrpkmRwSRrbh0B
         98mW8FxQhTkRddbNuvjY1OlR4EehYdeL0eARCJG8gW0y3gsHiuUVmVyOiDl/jLh1TF5D
         j58bfHK882zi2L5G6JAhTPLzgzIjkBqHE0PuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707588; x=1709312388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDMzDk/lBMFwiZnh7jtuEycU3dW7wec2i4CrQjkGJo4=;
        b=evv99R0qFf5590B6m7HlF2L8yvJIqLPNzOphe7lyp1BKAsUKuRLvtIYei9UWOa3e0a
         DlRbCTtrsPoVk22VLe0TNpvY17uj79Ta49NV72UKsObXcW2c66Wog8FjTWuUgxfQO59V
         7ljc18t8xwf+CS5x736ZIPDVYv/zghGeE4u19svlJ2RL4gulPexsfb1Gcuc0pRRP3jFO
         fJ+WMiLAr+WhcvegbkYIXTEaNYsd76ntRwO2YyrzIQAF4A4oA9EZ6yBDovMfzfJ42ABR
         gC96UAPdb15EcZLmBMpuXVk4EobqfdFU2F5I0C+alVz1s3DnndAN6bUwJavA1qaeQA2I
         g5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXqHc2CeWiGX+skA72TRQ19pdYX5vf4uG3iAtgMghtd+fsYBW+D4hv9zAerxxGGMTophApGVQTm0ONmglNe+BCOzIHUKaQk4FBbi+8M
X-Gm-Message-State: AOJu0YzAc3Q8JiJJTtRO/zeiCoxqrthbxcRq0ct+1riGgELEKQCS9P6H
	yGKLrDmBPU/iGxk7LKR2W9A26kI/Zf8l9b4PBCMBIgjOTcPME+P1N7nkSgrAzA==
X-Google-Smtp-Source: AGHT+IHX/Yc4T9nL5wRR/DYkhblZDpzp2THzLbdrmdP4IR1mBZ1kcT2liaypJSpebHmorYbeiH+inw==
X-Received: by 2002:aa7:9d82:0:b0:6e3:636b:dd99 with SMTP id f2-20020aa79d82000000b006e3636bdd99mr331864pfq.24.1708707588228;
        Fri, 23 Feb 2024 08:59:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o74-20020a62cd4d000000b006e3f09fd6a7sm11865200pfg.85.2024.02.23.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:59:47 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Helge Deller <deller@gmx.de>,
	Guo Ren <guoren@kernel.org>,
	sparclinux@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 23 Feb 2024 08:59:45 -0800
Message-Id: <20240223165942.work.950-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GFnd+uRgcZ5JE6+yaYSUeEigjBZZ5ehiRJbCdQFjMSg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl2M8BVTkPTYzeAtIdjSlijqw9uZvhDwrdnLvn9
 blIHXwVpeGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdjPAQAKCRCJcvTf3G3A
 JoCwEACKVFAmUO4no0Qaxq8qbED2OYobHjEx8UJ+OGsvTvGLxdH8D7zH1Jm07MIB5qteNWszAPW
 mmeZi2C8ojqf8QZCcqjRXQJWlCBUm6nET1lK20B7bHNNenRsAU3f+oq4vdh143ne09ThQL0vycD
 GkDx6xhb0cdwF/fuoUugrYKfxI242MeUa/lIkLQMoxXyJ+uQvBLKYtshUKKs/AdBkdZ56fsAR6W
 WK/+Q26n6BKUSxtMnNvhGt+AiOe0ElsbAbAPLSAf/+ACWu34JMXSe6b3o6WbemF7w6zZSFfxx3L
 aiWCjVpYB49at5XwwkPh4ZiViM11V4RJIIV8Wq2Lj3Wn2SfL+xAfohSXysGvuiAxtXG7wgnWXCl
 YkaEHux6vs5pt1/gsv6WKr+/UpXZvWQJkqpYBmRJY502AnAbYg00exgRnJoCpHC2bgyAS+cb9Zu
 YqnvktgImg3XSAhBvOhxXMf/40ggBFstPwm6YOucNM1IdW4aKRktYWll8E0i3M54hNRCm8eREdF
 7CUN7Wo3pISsoJ5iWpsP3QdnuKVtUTXyu7XI5CcS33ZzxMMFpWTwMH1yZcEwM7e5+h4a4tSFsuK
 jSEdGEu1KEwGh3gepDThUCJTuVkHMRQLz80mbbn4/SrwStrx23fql2KEfgBMP0h30pfMsV78289
 Q67U30eW 2zupgVA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The UBSAN instrumentation cannot work in the vDSO since it is executing
in userspace, so disable it in the Makefile. Fixes the build failures
such as:

arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Guo Ren <guoren@kernel.org>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 7f5eedf1f5e0..e8aef2c8ae99 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -2,6 +2,7 @@
 #
 # Building vDSO images for sparc.
 #
+UBSAN_SANITIZE := n
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o
-- 
2.34.1


