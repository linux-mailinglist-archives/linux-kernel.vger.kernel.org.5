Return-Path: <linux-kernel+bounces-121942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41888EFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466661F3131F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204E8153BF3;
	Wed, 27 Mar 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DZ4eto3m"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65B15383D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569733; cv=none; b=dxvTB3RnprjcTnPts+9ZcerP/uyjLzNTq1Zq4gHJmUXYmlj0UrXyHopPo+yznBftXF7iTRcWcYgubYiOFkc9RIimkgmAT8wTvG74WmDKcrSxWOi5q0cVs72HCKqBrLnKZ2FzYM9GXBOjopRNqt4SlD9mlIqm2Jjr93ggeJ4kc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569733; c=relaxed/simple;
	bh=u3gLe8mn9KzvJCWJ9YuG1b0TOQTZ68daTmfzwdg2XXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch84SXS3BxRPDzntnrQW8TId12ItKIkns3989+WXFx+iVr/QgrIYOO/kEplxLLc5VuKTHS2MpbsTuZ7f4c/S6vb6mF2LsGHhE9Y4vlD6U1K4nhfKRAUDBYb4T4JT0L99ctA5i6doh/1QAYLXXbI4fraRw6cAWwUQmDzHbKTmlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DZ4eto3m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dffa5e3f2dso1835865ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569731; x=1712174531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnfcb5HAvzgd9XZtKey8r+Hj1U7B+/pwxPGR+srUxos=;
        b=DZ4eto3m08paP0+UU1jm/9cXAZl8AdFMrJuH/RpFuA75lgxnWUeVsfC0vrtCNwENSU
         NX3bR08YGbNT5f/TWTOoMc9XsjpzP+ayL1eCS6a1/9KQGbR+l72v14t2a8D7/58kBskr
         YWC5DTNyckpXFeS95X0q8hqkThgF5pnRhIKUOxYgf3+TqXktO2E2bA2Q6+/kGhCL01qQ
         oaRhVTQDQAZ7oyAbNw6BzoBSpZqDat8nAUI1JLHLbqddieFWf53mWfVW7tKb1/qbGYlL
         +TzfASMvsUnEHy3C9k7A+1BifQYNgKySMWQGU6C2+pstLMM3e5x7ZQjVTsMNmlbSaNg4
         sg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569731; x=1712174531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnfcb5HAvzgd9XZtKey8r+Hj1U7B+/pwxPGR+srUxos=;
        b=P0lcyBioruO0RFOeaRy7plC+GXKTT0ipUK1vX6sVMtDaRgF/FQvTY3qJh6ZAlZWtOE
         yBl0AAgAQboYXJwZgHi7SkBWPVQpRvN2tvDW4kkcan7d6URBTQLczt6wEw7yAj5l6ISA
         PknjKP67MVxrxr3ZXt8lFluGbRFRRWqfeNz+DrhR8VYjTUMVRnXC7ewwv66lvdoGZ42E
         pAnMeLJCNkCZWJzD/lSDmP5DtrlGNiPqanuZHQ/zdyJqQ0+yZnW1/HcLyOi/5Oy/Xvlc
         tjdLu4Sbif1tS3H+1uj24/NIDC2wnVFp4S+xmWu5bwizj5hVgRqzojKHOqcXiaD2mrPh
         2g0g==
X-Gm-Message-State: AOJu0YzSKDPGzm1qu4dwQM6UhTLq6DYIS/xcEALj1Qgwn/VhnWb1QCIN
	aKj/wkvEhJb55gL1DRlFQKTFg3/sxoUkwsam6uha7kYccJxTG8W5/2giO7zPyJU=
X-Google-Smtp-Source: AGHT+IGwHWClv4VHwAUMeRko9/IrGC0nK3n3EBnq+VQl6LUZXOQ24ITW9JUdRJyNTiGgpBBFPtyemA==
X-Received: by 2002:a17:902:f545:b0:1dd:73ba:cd7f with SMTP id h5-20020a170902f54500b001dd73bacd7fmr731731plf.47.1711569731200;
        Wed, 27 Mar 2024 13:02:11 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:10 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 09/14] x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Mar 2024 13:00:40 -0700
Message-ID: <20240327200157.1097089-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86 already provides kernel_fpu_begin() and kernel_fpu_end(), but in a
different header. Add a wrapper header, and export the CFLAGS
adjustments as found in lib/Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/x86/Kconfig           |  1 +
 arch/x86/Makefile          | 20 ++++++++++++++++++++
 arch/x86/include/asm/fpu.h | 13 +++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/x86/include/asm/fpu.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39886bab943a..7c9d032ee675 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -83,6 +83,7 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_KERNEL_FPU_SUPPORT
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 662d9d4033e6..5a5f5999c505 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -74,6 +74,26 @@ KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
 KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
 
+#
+# CFLAGS for compiling floating point code inside the kernel.
+#
+CC_FLAGS_FPU := -msse -msse2
+ifdef CONFIG_CC_IS_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
+# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
+#
+# The "-msse" in the first argument is there so that the
+# -mpreferred-stack-boundary=3 build error:
+#
+#  -mpreferred-stack-boundary=3 is not between 4 and 12
+#
+# can be triggered. Otherwise gcc doesn't complain.
+CC_FLAGS_FPU += -mhard-float
+CC_FLAGS_FPU += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
+endif
+
 ifeq ($(CONFIG_X86_KERNEL_IBT),y)
 #
 # Kernel IBT has S_CET.NOTRACK_EN=0, as such the compilers must not generate
diff --git a/arch/x86/include/asm/fpu.h b/arch/x86/include/asm/fpu.h
new file mode 100644
index 000000000000..b2743fe19339
--- /dev/null
+++ b/arch/x86/include/asm/fpu.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef _ASM_X86_FPU_H
+#define _ASM_X86_FPU_H
+
+#include <asm/fpu/api.h>
+
+#define kernel_fpu_available()	true
+
+#endif /* ! _ASM_X86_FPU_H */
-- 
2.43.1


