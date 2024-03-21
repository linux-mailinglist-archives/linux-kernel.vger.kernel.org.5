Return-Path: <linux-kernel+bounces-110689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB51C886276
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B832854B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ECF13667D;
	Thu, 21 Mar 2024 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt9M+rxE"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57177135A7C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055936; cv=none; b=Q6M7LOWxmWPiCIrQd2upvWUu9dBwo2KlY5dBK4YCWUjAeqt8fd2BayaIyTVSncivYz5hfM+mvkI6XOnscbu5rw0+hwQ6JOYOf8IZztKK5umhPilK2+kUl+mhvGg7NvG8CZY580NqC1fhUY6ALubHI7iKEvc5HBvsPVovT47/IiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055936; c=relaxed/simple;
	bh=6SncT2xHQVsN3uYWdyB3MAV/FUGjtqsa2MWM+AyiGoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0I1XywjstHRW5CrQ3HaJA72/WIto7Mv3J2w4Hkfknix7JEbBsAqmGfLg/s6PWZGJC+BHr8oBlkgqYd2o86SsWa5JL6tB9XSmFxfbu81W0gljrz/FKID0XKzEo1U8M2st06I5/8anGLu1tXuHghf2U15AKAPLM9pmOB+UDLXJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vt9M+rxE; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4727b9d7b1fso148802137.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711055933; x=1711660733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m536zU+Ql7UMC3jfupH+HQpHMUR1QBM11u8xquMxNgk=;
        b=Vt9M+rxE2PVYuPALvBz+9IDI5/S/9r7JtHVkraVjEoB1yFnjed7wOBs6NMKgXANh55
         yLtY+7B8G27C7aGUj2ypA7PZxotP+S7kSfCTv5LgNiNo6ZQaBwydJwXp3IvyIP3W4mzc
         wezZk8fYXv3vjtAQMU/kTVAdgEXBBBZbRFo3XdBL7AoOwXmYDo9O8mVbcP1R45s4sD8j
         4LTH1JmrzeOxSESrRiy4XGqsrKdbtvnrjNXyQmRToz5/MR75Z5ugZHXybRgK57EU1+KF
         OzhFyLwGru777JeiYZDYGixCa411/m2D/hEpJheMO6lo/j1BZm6IVIUKhE5yavpH2UTl
         kTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055933; x=1711660733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m536zU+Ql7UMC3jfupH+HQpHMUR1QBM11u8xquMxNgk=;
        b=kpv5cW1AKTdKTms97fmp6x1Qp6zCvh4Vm5Am7tp/hxe6krFoo9VQOZb7mKseS1ovhL
         w96CRcN6GRnDDNr8ly5/QcwrWU6s9P4UO8qWNdsZztrhEgaCXaNOJjxayi94TO3YBydP
         60wNL/vrol6z+R3/yt4pfkcD+qGFpfIDPxEVr6ekJFWD3IImbhUo4LdYIZsltEw6qFQV
         Y5VDWK2N+/2uphAqvAu4QajZJzu6Oa7J6QHmRae2zQl+oiL4AZ3FV0E5wk/5iZAdSqRR
         ugQ5OC0TxQJexv2sOPXM2lrZwIqNVZZGrtyIVOxpPYifXJoGUKLq2MLujHCvAMqz0RF5
         e96Q==
X-Gm-Message-State: AOJu0Yx+Qm47an7EsZIcmdpZDe45MH0NVX2hV7Vatr35YjZxplLQmtYs
	FpoyzZ7wmxpVgCOl1BF9EvRvC0NCVxC6WRTR+wRjYNJlYCe5Zgj3ufVmVEQ=
X-Google-Smtp-Source: AGHT+IHyNPjsDXQagST7CTkdGw8YNDbD2bvIttXtqno9fzpxybO8vKGN7xGWjd10kwQLrlGOd34SSQ==
X-Received: by 2002:a05:6102:508a:b0:474:c306:9062 with SMTP id bl10-20020a056102508a00b00474c3069062mr1044686vsb.12.1711055933444;
        Thu, 21 Mar 2024 14:18:53 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id gs7-20020a056214226700b006961cdc3f7csm304903qvb.85.2024.03.21.14.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:18:52 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/2] x86/syscall/compat: Remove ia32_unistd.h
Date: Thu, 21 Mar 2024 17:18:47 -0400
Message-ID: <20240321211847.132473-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321211847.132473-1-brgerst@gmail.com>
References: <20240321211847.132473-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This header is now just a wrapper for unistd_32_ia32.h.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/entry_64_compat.S   |  1 -
 arch/x86/include/asm/ia32_unistd.h | 11 -----------
 arch/x86/include/asm/seccomp.h     |  2 +-
 arch/x86/kernel/signal_32.c        |  2 +-
 4 files changed, 2 insertions(+), 14 deletions(-)
 delete mode 100644 arch/x86/include/asm/ia32_unistd.h

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index eabf48c4d4b4..49cc4b8cfbb5 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -7,7 +7,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/current.h>
 #include <asm/errno.h>
-#include <asm/ia32_unistd.h>
 #include <asm/thread_info.h>
 #include <asm/segment.h>
 #include <asm/irqflags.h>
diff --git a/arch/x86/include/asm/ia32_unistd.h b/arch/x86/include/asm/ia32_unistd.h
deleted file mode 100644
index 7bcb82951c11..000000000000
--- a/arch/x86/include/asm/ia32_unistd.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_IA32_UNISTD_H
-#define _ASM_X86_IA32_UNISTD_H
-
-/*
- * This file contains the system call numbers of the ia32 compat ABI,
- * this is for the kernel only.
- */
-#include <asm/unistd_32_ia32.h>
-
-#endif /* _ASM_X86_IA32_UNISTD_H */
diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index fef16e398161..42bcd42d70d1 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -9,7 +9,7 @@
 #endif
 
 #ifdef CONFIG_COMPAT
-#include <asm/ia32_unistd.h>
+#include <asm/unistd_32_ia32.h>
 #define __NR_seccomp_read_32		__NR_ia32_read
 #define __NR_seccomp_write_32		__NR_ia32_write
 #define __NR_seccomp_exit_32		__NR_ia32_exit
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index c12624bc82a3..ef654530bf5a 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -34,7 +34,7 @@
 #include <asm/gsseg.h>
 
 #ifdef CONFIG_IA32_EMULATION
-#include <asm/ia32_unistd.h>
+#include <asm/unistd_32_ia32.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
-- 
2.44.0


