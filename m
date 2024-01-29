Return-Path: <linux-kernel+bounces-43284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C66298411BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69AD7B27225
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC03615B2EF;
	Mon, 29 Jan 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2I3ub+KA"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B615B10B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551572; cv=none; b=PcJflShk5gGa1KxGvKMt6MqHD9wRZyGHROfQ9xHnYHEU9bs6hmOHUGeSy62WCV2JhD6/GDzO3gDKerWT8Lhbp/te/1+BLWgXyFGl/2Bs/p3Lj3XwdfVrw7sTbvbdDnWdCGg+EEW1AgIswiKJR1mI4bX/6t+EqPfYCIV4feyGYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551572; c=relaxed/simple;
	bh=N7Dqbs6A3xIbAMqCtcMIQ29SguGASEykNJNGXXdKxFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kNbCIcEEPPrJmYxWm0NkPP+bAOoKkRWTDzlmYE5E1ydf4xpirSSAm4hlVJyzKX4TFemEneH+DjhgxB+n2oeF4XS34z++wc+xxOfSYO55S/OFHJ1ZaV9N+NdAAXfgQIexbMi0NcdZiDn3yLlKI4TSQQiMhleAeabXoUtdSSwqzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2I3ub+KA; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40eee438e92so15564265e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551570; x=1707156370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw+flZGULMSavtLRoK2qSf3V9Gu3GyVCc2w7RxQ06Ro=;
        b=2I3ub+KA+rXs8X6vvGIrFkAe+Gv/fHigK+cknQ8Tq99AuS080zBsMsYdeF/IHzGKDs
         f/kX1tPo+JdTFWylmqmjE1WS7H/x9PlEbGTIPctIcJSSUtgj4HVkODUp1omxzKZS4Pp8
         3bYOl6jSOMbOJ1F5Sd67BcJXP55dKmT5TYHlRHhsHwWZ05u+iffKBaKDDn3AYn/xYCnc
         ECDpukjhYD5vE+2XrgIe2DP6LJ9uG8fex8b+XHSDVm7sQge4/eIeXkYWJsxiKO/S/Ocw
         ABqIw6T0Agt2x0+jBf7g2bXhbvJnnwGCzxA57f/cpf+g1jl2/Yj9ddmIyU10EzJ9CHSv
         U5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551570; x=1707156370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw+flZGULMSavtLRoK2qSf3V9Gu3GyVCc2w7RxQ06Ro=;
        b=h7RxWA6B3SDzL1MWJ6JnNQP9ds7BHnMT9FYOKl6pTktzoVZxC5f3ockGROUGbJ8PFx
         bO98Q4ts36qFw6CbYdOtMLw18z4c9Dom7brzRIgCNAP6kKU64PNdt6IeqW2QPy0E0oHF
         Ywq+dNkcIF6dg4efSFIebHn1aA7MmNjvISzT+RI70wz5v0phsawwvQ4UtOHcepZl5KP+
         EDEd9FmmsYl9OyOR+enZlqgll4XcUMsrOvopdAoS9ojPUvwmmRKnnrf/Jqk9rWw41wUo
         hs4Z5k7aSQrP2JmoVrbCH5aRVyGxu+xfubx8+kx0RmVEloqmGvXPl4aR0/lZtsqDrA9j
         CGlA==
X-Gm-Message-State: AOJu0YwSlz+qU9QWw67sH/4DQRWRQVchHNeVXfHs2RbeK1ECok1Eq2Qw
	UmU9ObTntYXnO3QBx6lUH35X9SreiepULsg5zC+DemL5cFY6G7IA1++kuX2SkKzzOitzO33I9Qa
	iWyATG3ZWT9DtkhhbgTf/a78It6QQFX2Y+aNB2EjZ3wEFcrWcOoVFAB4oMq6SAMKjRU3Clkk4Qg
	BL+b26aU8ZDF6WOjr0Op9oq2pK3SlYYw==
X-Google-Smtp-Source: AGHT+IENcq3eVgTctzbegGvOoo9ucEIbkmBu/hWVgKdlKYbqpqwTZckCmZpKMHsy8T2zaFDU+s/vXnzc
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1708:b0:33a:f0f9:bebc with SMTP id
 n8-20020a056000170800b0033af0f9bebcmr4262wrc.7.1706551569728; Mon, 29 Jan
 2024 10:06:09 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:20 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=ardb@kernel.org;
 h=from:subject; bh=gUz2qElRticSrvsvtLUDoN8B1p79LARk6mWyXvU24wE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i4dqvH15HX5Wf/uN1EQe/hE6urU95U1q1p2ZgeqrZ
 6o4OO7sKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOpm8DIsD7idciuqibGy28P
 sYtcmGQ4exvfPMk+4cUb/bhsFEIyljH8L3704rv+6ZWdMRP4FHZsWvXR8MaPtf27Pkm3P9t/x7U 8kBMA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-38-ardb+git@google.com>
Subject: [PATCH v3 17/19] x86/sev: Use PIC codegen for early SEV startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Use PIC codegen for the compilation units containing code that may be
called very early during the boot, at which point the CPU still runs
from the 1:1 mapping of memory. This is necessary to prevent the
compiler from emitting absolute symbol references to addresses that are
not mapped yet.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/Makefile      | 2 ++
 arch/x86/kernel/vmlinux.lds.S | 1 +
 arch/x86/mm/Makefile          | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 42db41b04d8e..3819b65c64ec 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -24,7 +24,9 @@ endif
 # head64.c contains C code that may execute from a different virtual address
 # than it was linked at, so we always build it using PIE codegen
 CFLAGS_head64.o += $(PIE_CFLAGS)
+CFLAGS_sev.o += $(PIE_CFLAGS)
 UBSAN_SANITIZE_head64.o					:= n
+UBSAN_SANITIZE_sev.o					:= n
 
 KASAN_SANITIZE_head$(BITS).o				:= n
 KASAN_SANITIZE_dumpstack.o				:= n
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 77262e804250..bbdccb6362a9 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -182,6 +182,7 @@ SECTIONS
 
 		DATA_DATA
 		CONSTRUCTORS
+		*(.data.rel .data.rel.*)
 
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2..f3bb8b415348 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -31,7 +31,7 @@ obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
 CFLAGS_physaddr.o		:= -fno-stack-protector
-CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
+CFLAGS_mem_encrypt_identity.o	:= $(PIE_CFLAGS)
 
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.43.0.429.g432eaa2c6b-goog


