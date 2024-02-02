Return-Path: <linux-kernel+bounces-49662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72923846DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972941C263D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512377FBB2;
	Fri,  2 Feb 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="djL/8cFR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90747E56A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869012; cv=none; b=P6tHVWzfGO4Y/1iz9PxT+yTxLUjjne3uq8/hDXh7y0dep/yjLR48oRJ5daiKnXWas+oBUONtIVNtlXWuhhC+SpwaDeaBDfrPFdr1TWO1TPLpJWwxJFX5bU4qkZvKHTIdSI52YLiYRLs0JwiezKQJZjb3xEfTA5Fhw2RzHK5OKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869012; c=relaxed/simple;
	bh=TzLGN/wZFrYl4sz0T0jyTqFgT2Lvj1xSfjBLlzj7afo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qT/kYlp2EolWzW6dtg1yGnKhouM8xHV46slrNwtGGRL4jhOwrnHrL5wjvet2gr+jebuQChW3CI9E9rjrdYymjLrDlSSp81nwFdqXL9fuhZnEpfVKfUIs96BL5ICoMBcd/0eOl2s8hYxCpgkPUD7s8Xsdoo7sFbKUUlvnN7DDzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=djL/8cFR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d93ddd76adso14813215ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706869007; x=1707473807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lpkhLqd7OEtlpbaedS5vxnqsFfxpeZmJYnh9HQNf48=;
        b=djL/8cFRC9zO6rWMD2YznvUp1nDRYdrcTU583ltjz/WTBfo0jbZDSDpUl351SckjO6
         qVr56IyBW0bYbRyCv1fiUfSYAkDs9m6wEAn88jx6cGrkKCXe/9tIsnQuT1FYgZQM6/9S
         f7uVssqshwnJGRyl3alz+AxL3qeLYgCF0H7D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869007; x=1707473807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lpkhLqd7OEtlpbaedS5vxnqsFfxpeZmJYnh9HQNf48=;
        b=JcldJ2LRWkHnhUGenOpavT07RhfUhvoGqC22Q9WPQPGJQshW1xPVesHyq5FkZvgN5S
         8pi+3+zZe0U+Q7OPAvr8S44HZO06DwPuQCE1jYQRBl4RSelb8QYuqO04sutDl3l7/9v0
         4dTjLYGyiJJmz95XAaKL6ui1F99k/J/WKL2K8E9k3qyXUaeJUWE4M6+NdYI0qFQSUygr
         f8yuWihfPKXXTeTntH7nuyZs3MmOX/dsHHbji4/ynOvNA79owqN5ypGlyglSm4RjJsad
         ds1xkAIMI6LAYHlv6zT4LP/DPITryFSCxoSrjkiW9ak0Hnuyfo5mDsGm8JxZCkgLUoTA
         NjGQ==
X-Gm-Message-State: AOJu0Yys1zIJ1/q+msxG4shozTkU5jHKCT3F2WByh9V5DP2IpoBg18ZZ
	bCBzcPlbIx6D/YTuF8Ui0syCBIkarNUkFjRolVuCEwyzE81uyhoXNdU2n48BNA==
X-Google-Smtp-Source: AGHT+IFhi06VOysbc5l+dFsXz7CKYAApKFvSoqKKtDFGPoyCY30ZTFRktNB+0SQzSsHBbZB1Unn1Bw==
X-Received: by 2002:a17:902:ec8f:b0:1d9:7ebe:431f with SMTP id x15-20020a170902ec8f00b001d97ebe431fmr75634plg.25.1706869007422;
        Fri, 02 Feb 2024 02:16:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXs4G8MUacPDVffkkW3YIupLvo7fOKngXgP+Sk6+29gQMVKJs08J0+3IxTwtNEEkiZ8eGAIttWEaHeXH6T6+fNfWQ+QDHgR8QFndX1YkdshPqcHnC8ZhMEw8Y205GGD/hXZeKG9lZA4KiQhE6/y0ZGb14IngWwfwvlekaGRRjUjWt0j5zMxr8icCHSkAzObwyJrh/jcvniTLARTNzCtWdffpO6cA+p9dquKTDehLQT1ImPrwzjg6dOQIOgvEOrnwmSgHcXAhPPG9s3ww8WwNDHHhWbYEbihBm1UxI5VGCz8gxJG/LPhjIEbOa50AtDgdzpicwFKl+d/veprf2CxavchMKcf1ZFpZMPnpeQdl7uabrqw/JibLaG0sc11Qk3+f1aw2VTEFjODk3/Auveeqk+wydW8nC0nhD/Yf0OmhO3pWVWzu8PP4+241P4he/xwQLRUGB3XgKIMTvlu1GPBSADeZq15+ug6D0fQt+Rd9xziIqyoAcned2NH8sAF9kIoBbad4ycXB8VLaDO4+Flm53lBdv1eUkmjzOR9OnaWoBqBFI5sNi2Q0JvocsOdwnb+1cJGO+I34RT7e4Uv35WZCcQjH4km59aPOS+QQP0=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001d94e6a7685sm1242824plk.234.2024.02.02.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:16:46 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	x86@kernel.org,
	netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Fangrui Song <maskray@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Bill Wendling <morbo@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 6/6] ubsan: Get x86_64 booting with unsigned wrap-around sanitizer
Date: Fri,  2 Feb 2024 02:16:39 -0800
Message-Id: <20240202101642.156588-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101311.it.893-kees@kernel.org>
References: <20240202101311.it.893-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9025; i=keescook@chromium.org;
 h=from:subject; bh=TzLGN/wZFrYl4sz0T0jyTqFgT2Lvj1xSfjBLlzj7afo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlvMEHyPK5ViviPn9azIBFUIYrlBFvd0kw+bqbP
 wVlizzw8PGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbzBBwAKCRCJcvTf3G3A
 Jj10EACxZp8csm9ZCk+xJiU3zMmobNiVh75p7eiqjwSp/+F5YknBmFn1AlM7gImi5vPAMhF+uJK
 S7tEGvBu0z8HJAYyprAsz8MTPA3XkwZaBvDh9ooyUaCGG4dQYhzZEamHqjAeDnajhy5ZftZymg1
 B+ufjH0oJ0ni6WwN8v+6NA2qQLUNSrjnKtiribhsUUvNU+RIbBsci8ifkfB+R/+u+pEbCf6P88A
 7+XDsZKTZQdFahZfTiTeUE/SXyL4N3tj6bSoRpsihC/55AJZVXSoatefKR16VpdBCKZKwTNweW6
 S0vj+nz1PDLZHYxiOQVF9JH1HUjMv4EXIi6sJ1rayPbtQpTapfFyPHsS/42+1og+ZkbBjhrPtgx
 V22ba3CXArD1r3+innlUCwo1gznduzvlxVifjuGsBnPTOKM9JeBPNWu75tm1vMoR65PHo4qxOG+
 O/tg1yEg6gja2mNPYPKJXZUW2S29A0iPG+8XuUSExGdu9BudGeVw18IasDUmfthZyPLWNROQGpN
 9JyUUkTnApR92NAMUzHLj3ne7upYSQJ31Ab+MogRw6at1STgZvaWFIE5e5a/XQYbuNQmITc7hVq
 6o5PuItNU7vlLrYD2InHp+9VTFqpLrw3s1toSBj+qbAQByyz+QyYIdE324S1o0WW6EeKf4cuLVm DqWvp1fbl88HqTQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In order to get x86_64 booting at all with the unsigned wrap-around
sanitizer, instrumentation needs to be disabled entirely for several
kernel areas that depend heavily on unsigned wrap-around. As we fine-tune
the sanitizer, we can revisit these and perform finer grain annotations.
The boot is still extremely noisy, but gets us to a common point where
we can continue experimenting with the sanitizer.

Cc: x86@kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/Makefile      | 1 +
 arch/x86/kernel/apic/Makefile | 1 +
 arch/x86/mm/Makefile          | 1 +
 arch/x86/mm/pat/Makefile      | 1 +
 crypto/Makefile               | 1 +
 drivers/acpi/Makefile         | 1 +
 kernel/Makefile               | 1 +
 kernel/locking/Makefile       | 1 +
 kernel/rcu/Makefile           | 1 +
 kernel/sched/Makefile         | 1 +
 lib/Kconfig.ubsan             | 5 +++--
 lib/Makefile                  | 1 +
 lib/crypto/Makefile           | 1 +
 lib/crypto/mpi/Makefile       | 1 +
 lib/zlib_deflate/Makefile     | 1 +
 lib/zstd/Makefile             | 2 ++
 mm/Makefile                   | 1 +
 net/core/Makefile             | 1 +
 net/ipv4/Makefile             | 1 +
 19 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..de93f8b8a149 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -30,6 +30,7 @@ KASAN_SANITIZE_sev.o					:= n
 
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
+UBSAN_WRAP_UNSIGNED := n
 KCSAN_SANITIZE := n
 KMSAN_SANITIZE_head$(BITS).o				:= n
 KMSAN_SANITIZE_nmi.o					:= n
diff --git a/arch/x86/kernel/apic/Makefile b/arch/x86/kernel/apic/Makefile
index 3bf0487cf3b7..aa97b5830b64 100644
--- a/arch/x86/kernel/apic/Makefile
+++ b/arch/x86/kernel/apic/Makefile
@@ -6,6 +6,7 @@
 # Leads to non-deterministic coverage that is not a function of syscall inputs.
 # In particular, smp_apic_timer_interrupt() is called in random places.
 KCOV_INSTRUMENT		:= n
+UBSAN_WRAP_UNSIGNED	:= n
 
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o apic_common.o apic_noop.o ipi.o vector.o init.o
 obj-y				+= hw_nmi.o
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2..7a43466d4581 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Kernel does not boot with instrumentation of tlb.c and mem_encrypt*.c
+UBSAN_WRAP_UNSIGNED := n
 KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
diff --git a/arch/x86/mm/pat/Makefile b/arch/x86/mm/pat/Makefile
index ea464c995161..281a5786c5ea 100644
--- a/arch/x86/mm/pat/Makefile
+++ b/arch/x86/mm/pat/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+UBSAN_WRAP_UNSIGNED := n
 
 obj-y				:= set_memory.o memtype.o
 
diff --git a/crypto/Makefile b/crypto/Makefile
index 408f0a1f9ab9..c7b23d99e715 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -2,6 +2,7 @@
 #
 # Cryptographic API
 #
+UBSAN_WRAP_UNSIGNED := n
 
 obj-$(CONFIG_CRYPTO) += crypto.o
 crypto-y := api.o cipher.o compress.o
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 12ef8180d272..92a8e8563b1b 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the Linux ACPI interpreter
 #
+UBSAN_WRAP_UNSIGNED := n
 
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
diff --git a/kernel/Makefile b/kernel/Makefile
index ce105a5558fc..1b31aa19b4fb 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the linux kernel.
 #
+UBSAN_WRAP_UNSIGNED := n
 
 obj-y     = fork.o exec_domain.o panic.o \
 	    cpu.o exit.o softirq.o resource.o \
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 0db4093d17b8..dd6492509596 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -2,6 +2,7 @@
 # Any varying coverage in these files is non-deterministic
 # and is generally not a function of system call inputs.
 KCOV_INSTRUMENT		:= n
+UBSAN_WRAP_UNSIGNED	:= n
 
 obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
 
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 0cfb009a99b9..305c13042633 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -2,6 +2,7 @@
 # Any varying coverage in these files is non-deterministic
 # and is generally not a function of system call inputs.
 KCOV_INSTRUMENT := n
+UBSAN_WRAP_UNSIGNED := n
 
 ifeq ($(CONFIG_KCSAN),y)
 KBUILD_CFLAGS += -g -fno-omit-frame-pointer
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 976092b7bd45..e487b0e86c2e 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -7,6 +7,7 @@ ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
 # These files are disabled because they produce non-interesting flaky coverage
 # that is not a function of syscall inputs. E.g. involuntary context switches.
 KCOV_INSTRUMENT := n
+UBSAN_WRAP_UNSIGNED := n
 
 # Disable KCSAN to avoid excessive noise and performance degradation. To avoid
 # false positives ensure barriers implied by sched functions are instrumented.
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 0611120036eb..54981e717355 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -132,8 +132,9 @@ config UBSAN_UNSIGNED_WRAP
 	depends on !COMPILE_TEST
 	help
 	  This option enables -fsanitize=unsigned-integer-overflow which checks
-	  for wrap-around of any arithmetic operations with unsigned integers. This
-	  currently causes x86 to fail to boot.
+	  for wrap-around of any arithmetic operations with unsigned integers.
+	  Given the history of C and the many common code patterns involving
+	  unsigned wrap-around, this is a very noisy option right now.
 
 config UBSAN_POINTER_WRAP
 	bool "Perform checking for pointer arithmetic wrap-around"
diff --git a/lib/Makefile b/lib/Makefile
index bc36a5c167db..f68385b69247 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for some libs needed in the kernel.
 #
+UBSAN_WRAP_UNSIGNED := n
 
 ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 8d1446c2be71..fce88a337a53 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+UBSAN_WRAP_UNSIGNED := n
 
 obj-$(CONFIG_CRYPTO_LIB_UTILS)			+= libcryptoutils.o
 libcryptoutils-y				:= memneq.o utils.o
diff --git a/lib/crypto/mpi/Makefile b/lib/crypto/mpi/Makefile
index 6e6ef9a34fe1..ce95653915b1 100644
--- a/lib/crypto/mpi/Makefile
+++ b/lib/crypto/mpi/Makefile
@@ -2,6 +2,7 @@
 #
 # MPI multiprecision maths library (from gpg)
 #
+UBSAN_WRAP_UNSIGNED := n
 
 obj-$(CONFIG_MPILIB) = mpi.o
 
diff --git a/lib/zlib_deflate/Makefile b/lib/zlib_deflate/Makefile
index 2622e03c0b94..5d71690554bb 100644
--- a/lib/zlib_deflate/Makefile
+++ b/lib/zlib_deflate/Makefile
@@ -6,6 +6,7 @@
 # This is the compression code, see zlib_inflate for the
 # decompression code.
 #
+UBSAN_WRAP_UNSIGNED := n
 
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate.o
 
diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index 20f08c644b71..7a187cb08c1f 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -8,6 +8,8 @@
 # in the COPYING file in the root directory of this source tree).
 # You may select, at your option, one of the above-listed licenses.
 # ################################################################
+UBSAN_WRAP_UNSIGNED := n
+
 obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
 obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
 obj-$(CONFIG_ZSTD_COMMON) += zstd_common.o
diff --git a/mm/Makefile b/mm/Makefile
index e4b5b75aaec9..cacbdd1a2d40 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the linux memory manager.
 #
+UBSAN_WRAP_UNSIGNED := n
 
 KASAN_SANITIZE_slab_common.o := n
 KASAN_SANITIZE_slub.o := n
diff --git a/net/core/Makefile b/net/core/Makefile
index 821aec06abf1..501d7300da83 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the Linux networking core.
 #
+UBSAN_WRAP_UNSIGNED := n
 
 obj-y := sock.o request_sock.o skbuff.o datagram.o stream.o scm.o \
 	 gen_stats.o gen_estimator.o net_namespace.o secure_seq.o \
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index ec36d2ec059e..c738d463bb7e 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the Linux TCP/IP (INET) layer.
 #
+UBSAN_WRAP_UNSIGNED := n
 
 obj-y     := route.o inetpeer.o protocol.o \
 	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
-- 
2.34.1


