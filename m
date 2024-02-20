Return-Path: <linux-kernel+bounces-73588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490785C48D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B2B1F245AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D1314A4E6;
	Tue, 20 Feb 2024 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5hyRRlD"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621414A0B2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456924; cv=none; b=rN+FLP40pGklrsSx/HiY7cd9cDREgaIya5GQKprmVmffAN6nbpI2WonzVNT2FV2vmx9abJuGbnRYfy32oSiq2F2pQc3s4GPfcbeS9D7KO5qotMREoVn+lkKkPzy5n0oQv6vuzUi6UJn1BDgo/JE7GKLNHVg0KIlM6QaRwngsZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456924; c=relaxed/simple;
	bh=37+UeHfbaDdGookO0QGGmnoCJCoWAfLqrxDYxUd6jj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeCnCRFpD9p863NgpEfOYjFEsHgZsZ0wgGWm7dyKAP7dTPOVLmHlrX0c7LWMKA/2P3j7JeHhc7BUB40Bnj5OLNdAEMQRyrHiflQ9r6IrDmVhpBgAtqkitdb69E/IfcO+mZzbdA/MqoFWWMjX2ILcNqNPXKCsjo9cQ7BGqWjB64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5hyRRlD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4126df1e7bbso12955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708456920; x=1709061720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah2+kizpm1MHuuLA0gzHwJWSSIWURWYNeGGYOg4ToNY=;
        b=u5hyRRlDJ5tTD41TlVL/eEcLdqhBVkcXd/nFbviYoXj/o1PCW0bVBzyBFf/nhy4sIR
         EVZPHE2Q+B8lopTWJpmZ4PKn0JzN0w4W/+Gcd6kZkY01kSplbmxeux3yvXzGtOiYmbim
         0LRuNTLVf4ETg9hQgGaVKlOZf7YhJkDqL7jMV2ekX88nHl98zCLrYnNEqb6biKHB3iJT
         w4FnowJhKEuPyK+NQvV9Cyrs8Fkpsd4Y0nbR7oBja/PjBbUOI5UlL4rsd1uoMYTV8RwH
         rDnoT05vi9xH/nD0cJQaO+6Ug5xWXLfRcEeIPMcxEYrKQOqfikVBl62zyvJj6WPu6IAU
         wDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456920; x=1709061720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ah2+kizpm1MHuuLA0gzHwJWSSIWURWYNeGGYOg4ToNY=;
        b=WMneCUq3QIMe7cFPD4JDhYIMdXU64tWi+Ws2Av413dumy5nvJ5ekParDJhTsL8up5M
         9BVO4f2WskW7WoK/PtR47yrPZZuhMyYqLTnyFhB0S7/bmZ8zjJi6UbYFtwzA3bNeoWsm
         ojdTVQ7nt8pbKYRdGKMOGLO6Oobynf0itYAcSJUGOyCt/mqXucUsdTZVDdQNTQpb+JLX
         JxNoYOFlE+CJV0MdVMyN9hCmtth+XIZkwWgusBGCWHrzEnjj8aTvv2GE5r5cHrKwEYsK
         IHaGWZt+1fz/nIz+MHea99+HK9qcOR9oB5B3Gp8Wvwe41xwqxGZon5nKGtenkPfW/1q2
         ZbAg==
X-Forwarded-Encrypted: i=1; AJvYcCV1LAiHkAkKyNyQ+SsgDFshye5MJRu6CIVQW02j0eSBxfC6qyW4WqL/yxLbDOunYqSm8wKw6bHU7s22ASkhKZSMjgccsAbmBz+JHbkr
X-Gm-Message-State: AOJu0YwqVy5brmC0B+/fFV5HRSb2ko+xwaRvJB8TjyPpeZO9+i4L3Pyu
	nxH8D9ApJJV6I95dXp63UjJS/N8GOEyCJQxljRxOifyhx743XLCCME0J1CN4Nw==
X-Google-Smtp-Source: AGHT+IFaJto0kjN4iHXGg9qOyIhhHDl/BkTSt/fv2A+3NKrqFrHBpsa9FcDKPypAEWzw2yO8U6z2Og==
X-Received: by 2002:a05:600c:600f:b0:412:6d66:81d8 with SMTP id az15-20020a05600c600f00b004126d6681d8mr10163wmb.7.1708456920465;
        Tue, 20 Feb 2024 11:22:00 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:cba0:1b55:6833:859e])
        by smtp.gmail.com with ESMTPSA id y17-20020a05600c365100b004126101915esm4500wmq.4.2024.02.20.11.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:22:00 -0800 (PST)
From: Jann Horn <jannh@google.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Jann Horn <jannh@google.com>
Subject: [PATCH 2/3] x86/boot: avoid recompiling misc.c for incremental rebuilds
Date: Tue, 20 Feb 2024 20:21:43 +0100
Message-ID: <20240220192144.2050167-3-jannh@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240220192144.2050167-1-jannh@google.com>
References: <20240220192144.2050167-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we rebuild misc.c on every incremental compilation because
the generated header voffset.h (containing kernel image offsets)
changes on every build.

Turn the three macros we need from that header into external variables
that we can separately store in another C file.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/boot/compressed/Makefile       |  4 ++--
 arch/x86/boot/compressed/dynamic_vars.c |  9 +++++++++
 arch/x86/boot/compressed/dynamic_vars.h | 11 +++++++++++
 arch/x86/boot/compressed/misc.c         |  6 ++----
 4 files changed, 24 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/boot/compressed/dynamic_vars.c
 create mode 100644 arch/x86/boot/compressed/dynamic_vars.h

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f19c038409aa..d18a553c16fa 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -94,11 +94,11 @@ targets += ../voffset.h
 $(obj)/../voffset.h: vmlinux FORCE
 	$(call if_changed,voffset)
 
-$(obj)/misc.o: $(obj)/../voffset.h
+$(obj)/dynamic_vars.o: $(obj)/../voffset.h
 
 vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/kernel_info.o $(obj)/head_$(BITS).o \
 	$(obj)/misc.o $(obj)/string.o $(obj)/cmdline.o $(obj)/error.o \
-	$(obj)/piggy.o $(obj)/cpuflags.o
+	$(obj)/piggy.o $(obj)/cpuflags.o $(obj)/dynamic_vars.o
 
 vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
 vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
diff --git a/arch/x86/boot/compressed/dynamic_vars.c b/arch/x86/boot/compressed/dynamic_vars.c
new file mode 100644
index 000000000000..cda64ff4b6da
--- /dev/null
+++ b/arch/x86/boot/compressed/dynamic_vars.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/const.h>
+#include "dynamic_vars.h"
+#include "../voffset.h"
+
+const unsigned long vo__text = VO__text;
+const unsigned long vo___bss_start = VO___bss_start;
+const unsigned long vo__end = VO__end;
+const unsigned long kernel_total_size = VO__end - VO__text;
diff --git a/arch/x86/boot/compressed/dynamic_vars.h b/arch/x86/boot/compressed/dynamic_vars.h
new file mode 100644
index 000000000000..a0f7dc359cb6
--- /dev/null
+++ b/arch/x86/boot/compressed/dynamic_vars.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header defines some variables that change on every compilation and are
+ * stored separately in the small file dynamic-vars.c, so that we can avoid
+ * rebuilding some of the other C files in this directory on every incremental
+ * rebuild.
+ */
+
+/* Variables containing VO__text, VO___bss_start, VO__end */
+extern const unsigned long vo__text, vo___bss_start, vo__end;
+extern const unsigned long kernel_total_size;
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b99e08e6815b..ff13cc3e703d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -15,8 +15,8 @@
 #include "misc.h"
 #include "error.h"
 #include "pgtable.h"
+#include "dynamic_vars.h"
 #include "../string.h"
-#include "../voffset.h"
 #include <asm/bootparam_utils.h>
 
 /*
@@ -188,7 +188,7 @@ static void handle_relocations(void *output, unsigned long output_len,
 	int *reloc;
 	unsigned long delta, map, ptr;
 	unsigned long min_addr = (unsigned long)output;
-	unsigned long max_addr = min_addr + (VO___bss_start - VO__text);
+	unsigned long max_addr = min_addr + (vo___bss_start - vo__text);
 
 	/*
 	 * Calculate the delta between where vmlinux was linked to load
@@ -330,8 +330,6 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
-const unsigned long kernel_total_size = VO__end - VO__text;
-
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
 
 extern unsigned char input_data[];
-- 
2.44.0.rc0.258.g7320e95886-goog


