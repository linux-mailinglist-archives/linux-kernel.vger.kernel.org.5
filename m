Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56E805717
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjLEOVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345857AbjLEOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:20:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CF7B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:21:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so4628331f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701786063; x=1702390863; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKjChNKAYXhPgPUdf08Tx3S9lUm9NDGS4FN+qjSCqos=;
        b=g3o+lg59AF0xUNE53WGjlbU+bAAt5KTa5FzfTQv7PCqcnPrk8ebPlkrIIL6Xo1n0Yx
         MCGg6eFRy8bJpPiC7rN6R5YxVWI+uM3xuNAma2NRwuDj5FHx6ajI7GEvtp6VL47hwrSq
         jqt7YIwC3pRfQxCxzZf1RI+Vfjs6iDS/gOR51+xfWyHeQQAt//aKa/0m+RbX4eMqr/5v
         LoUsoMn6Dcx7tsoYSXcU4nVFRk7sqj/xEbpJGfm/3mdIYyeWEZRUErpKNOQgH1T4OAG2
         oORhyL1BBptGR3vImUceTiL8H27V7lyFlnnvh0OLpONht2HrOA7dbvhia+s5FDJ+UlRE
         7YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701786063; x=1702390863;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKjChNKAYXhPgPUdf08Tx3S9lUm9NDGS4FN+qjSCqos=;
        b=dNHX762xuWiUytKnJjBIpwQEHs3coJa9Ac0MpZ1D3pfP62RIDFmSgbmT2WmgjF/flk
         GaRbFwwHjkn8AEkmBMmJIoJV1ONmhRwpDQWrBfSc3F+dwzZau5Q4oyNzGzJTVdITOqF+
         5b4wx1B8X7DC7iGJbK3gF+6isrTH0RLjN/1FyeaGRH3AzyyS2cQG+p4D5qWClANS1ddS
         h7rMPoaAUZk8jy6WV24xLtS98hwJaUSg54lvMtQazC7S18PXeNJmyWevCe2U/6lHexNH
         OHL95Es7EqLxskpcGEu+MmKtv5kGaoCoYvOia5lp1gzqL1fYQ6+l+MgvtfMFcSbsP0Qx
         gk4Q==
X-Gm-Message-State: AOJu0YyiX1uax7RUrvBOWQWIKzXot+wYRbxZPyW52A28r3oisjD5DkQP
        hl4+O4vtE+Gri4uqeJ7y+A==
X-Google-Smtp-Source: AGHT+IGC9arPAcKsWyswOsGb13d92VUA2ljwVWpPfgJOR7Gl2vLtY+eJKzjp015zvvH+R8NED8swkw==
X-Received: by 2002:a7b:cc94:0:b0:40b:5e59:ea1d with SMTP id p20-20020a7bcc94000000b0040b5e59ea1dmr524516wma.188.1701786062558;
        Tue, 05 Dec 2023 06:21:02 -0800 (PST)
Received: from p183 ([46.53.254.107])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b0040b2976eb02sm18891612wmb.10.2023.12.05.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:21:02 -0800 (PST)
Date:   Tue, 5 Dec 2023 17:21:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86_64: test xmm/ymm register state after execve(2)
Message-ID: <ea599d98-7d26-4278-9d79-a115650289df@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test that xmm/ymm registers are cleared immediately after execve(2).

It is opportunistically named "check_xmm_ymm_zmm" because I don't have
AVX-512 machine but it will be trivial to extend without renaming stuff.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	I want to draw attention to executable sizes:

	-rwxr-xr-x.   1 ad ad 723920 Dec  5 12:28 check_initial_reg_state_32
	-rwxr-xr-x.   1 ad ad 825904 Dec  5 12:28 check_initial_reg_state_64
	-rw-r--r--.   1 ad ad   1901 Dec  5 12:18 check_initial_reg_state.c
	-rwxr-xr-x.   1 ad ad 827976 Dec  5 17:09 check_xmm_ymm_zmm_64
	-rw-r--r--.   1 ad ad   4705 Dec  5 17:09 check_xmm_ymm_zmm.c

	which are absolutely ridiculous!

	These tests should fit into 1 page, both!

 tools/testing/selftests/x86/Makefile            |    2 
 tools/testing/selftests/x86/check_xmm_ymm_zmm.c |  176 ++++++++++++++++++++++++
 2 files changed, 178 insertions(+)

--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -20,6 +20,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
 			corrupt_xstate_header amx lam test_shadow_stack
+TARGETS_C_64BIT_ONLY += check_xmm_ymm_zmm
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -110,6 +111,7 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
 # state.
 $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
+$(OUTPUT)/check_xmm_ymm_zmm_64: CFLAGS += -Wl,-ee_entry -static
 
 $(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/x86/check_xmm_ymm_zmm.c
@@ -0,0 +1,176 @@
+/*
+ * Copyright (c) 2023 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/* Test that xmm, ymm registers are cleared immediately after execve(2). */
+
+#include <stdio.h>
+#include <string.h>
+
+#if   defined __amd64__
+#elif defined __i386__
+#error "fix register count, SSE2 detection"
+#else
+#error
+#endif
+
+#define array_size(a)	(sizeof(a) / sizeof(a[0]))
+
+typedef char xmm_t[16];
+static const xmm_t xmm_z;
+static xmm_t xmm[16];
+
+typedef char ymm_t[32];
+static const ymm_t ymm_z;
+static ymm_t ymm[16];
+
+enum {
+	TEST_XMM = 1,
+	TEST_YMM = 2,
+};
+static volatile char g_test;
+
+/*
+ * Homework: write and install #UD handler in assembly and just start
+ * executing AVX-512/AVX2/SSE2 instructions falling back SIMD ladder
+ * if necessary.
+ *
+ * jk, use cpuid instead like any normal programmer would do.
+ */
+asm (
+".pushsection .text;"
+".type e_entry,@function;"
+".global e_entry;"
+"e_entry:"
+	/* test AVX2 support */
+	"mov $7, %eax;"
+	"xor %ecx, %ecx;"
+	"cpuid;"
+	"bt $5, %ebx;"
+	"jnc .Ltest_xmm;"
+
+	"vmovdqu %ymm0, ymm + 32 * 0;"
+	"vmovdqu %ymm1, ymm + 32 * 1;"
+	"vmovdqu %ymm2, ymm + 32 * 2;"
+	"vmovdqu %ymm3, ymm + 32 * 3;"
+	"vmovdqu %ymm4, ymm + 32 * 4;"
+	"vmovdqu %ymm5, ymm + 32 * 5;"
+	"vmovdqu %ymm6, ymm + 32 * 6;"
+	"vmovdqu %ymm7, ymm + 32 * 7;"
+	"vmovdqu %ymm8, ymm + 32 * 8;"
+	"vmovdqu %ymm9, ymm + 32 * 9;"
+	"vmovdqu %ymm10, ymm + 32 * 10;"
+	"vmovdqu %ymm11, ymm + 32 * 11;"
+	"vmovdqu %ymm12, ymm + 32 * 12;"
+	"vmovdqu %ymm13, ymm + 32 * 13;"
+	"vmovdqu %ymm14, ymm + 32 * 14;"
+	"vmovdqu %ymm15, ymm + 32 * 15;"
+	"movb $2, g_test;"	/* TEST_YMM */
+	"jmp .Llibc_start;"
+
+".Ltest_xmm:"
+	"movdqu %xmm0, xmm + 16 * 0;"
+	"movdqu %xmm1, xmm + 16 * 1;"
+	"movdqu %xmm2, xmm + 16 * 2;"
+	"movdqu %xmm3, xmm + 16 * 3;"
+	"movdqu %xmm4, xmm + 16 * 4;"
+	"movdqu %xmm5, xmm + 16 * 5;"
+	"movdqu %xmm6, xmm + 16 * 6;"
+	"movdqu %xmm7, xmm + 16 * 7;"
+	"movdqu %xmm8, xmm + 16 * 8;"
+	"movdqu %xmm9, xmm + 16 * 9;"
+	"movdqu %xmm10, xmm + 16 * 10;"
+	"movdqu %xmm11, xmm + 16 * 11;"
+	"movdqu %xmm12, xmm + 16 * 12;"
+	"movdqu %xmm13, xmm + 16 * 13;"
+	"movdqu %xmm14, xmm + 16 * 14;"
+	"movdqu %xmm15, xmm + 16 * 15;"
+	"movb $1, g_test;"	/* TEST_XMM */
+	"jmp .Llibc_start;"
+
+".Llibc_start:"
+	/*
+	 * Undo cpuid, this is important for clean exit:
+	 *
+	 * Program received signal SIGSEGV, Segmentation fault.
+	 * 0x0000000000000010 in ?? ()
+	 * (gdb) bt
+	 * #0  0x0000000000000010 in ?? ()
+	 * #1  0x00000000004090c9 in __run_exit_handlers ()
+	 * #2  0x0000000000409220 in exit ()
+	 * #3  0x0000000000401da1 in __libc_start_call_main ()
+	 * #4  0x00000000004034f0 in __libc_start_main_impl ()
+	 * #5  0x0000000000401555 in _start ()
+	 */
+	"xor %eax, %eax;"
+	"xor %ecx, %ecx;"
+	"xor %edx, %edx;"
+	"xor %ebx, %ebx;"
+	"jmp _start;"
+
+".size e_entry, .-e_entry;"
+".popsection;"
+);
+
+#define F stderr
+
+static void print_xymm(FILE *f, const char *pfx, const void *r, int len)
+{
+	fputs(pfx, f);
+	for (int i = 0; i < len; i += 1) {
+		fprintf(f, "%02hhx", *(unsigned char *)(r + i));
+	}
+	fputc('\n', f);
+}
+
+int main(void)
+{
+	int rv = 0;
+	if (g_test == TEST_YMM) {
+		for (int i = 0; i < array_size(ymm); i += 1) {
+			rv |= memcmp(&ymm[i], &ymm_z, sizeof(ymm_t)) != 0;
+		}
+		if (rv) {
+			fprintf(F, "FAIL\tymm\n");
+			for (int i = 0; i < array_size(ymm); i += 1) {
+				char buf[64];
+				snprintf(buf, sizeof(buf), "ymm%-2d = ", i);
+				print_xymm(F, buf, &ymm[i], sizeof(ymm_t));
+			}
+			return 1;
+		} else {
+			fprintf(F, "PASS\tymm0 .. ymm%zu == 0\n", array_size(ymm) - 1);
+			return 0;
+		}
+	} else if (g_test == TEST_XMM) {
+		for (int i = 0; i < array_size(xmm); i += 1) {
+			rv |= memcmp(&xmm[i], &xmm_z, sizeof(xmm_t)) != 0;
+		}
+		if (rv) {
+			fprintf(F, "FAIL\txmm\n");
+			for (int i = 0; i < array_size(xmm); i += 1) {
+				char buf[64];
+				snprintf(buf, sizeof(buf), "xmm%-2d = ", i);
+				print_xymm(F, buf, &xmm[i], sizeof(xmm_t));
+			}
+			return 1;
+		} else {
+			fprintf(F, "PASS\txmm0 .. xmm%zu == 0\n", array_size(xmm) - 1);
+			return 0;
+		}
+	} else {
+		fprintf(F, "FAIL\tg_test %d\n", +g_test);
+		return 1;
+	}
+}
