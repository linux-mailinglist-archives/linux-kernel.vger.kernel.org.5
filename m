Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6127713F8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 10:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHFIal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 04:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHFIaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 04:30:39 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8587131
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1691310632; bh=1PmgJ9UnGd7n2iOLnmG8C4ChzRpzduUPBOOmTK9zmH4=;
        h=From:To:Cc:Subject:Date:From;
        b=aORIwgZcAgfREdgO3i/MAXyip30WQh7Ju+cHHDGE3LrsfKMzunSQgNuaiZli7qyJz
         MzQ2quDLiPQ8iyhlS/TvrVrN1ZFjWKV/xQ33g60df/0PqiASyweEhLQIVgSrivBs1d
         5dJFPyZqPNbVnohNfinR6eyaiWFrAyQLfk6g3/T4=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id C02B2600F8;
        Sun,  6 Aug 2023 16:30:31 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] LoongArch: Replace -ffreestanding with finer-grained -fno-builtin's
Date:   Sun,  6 Aug 2023 16:30:21 +0800
Message-Id: <20230806083021.2243574-1-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

As explained by Nick in the original issue: the kernel usually does a
good job of providing library helpers that have similar semantics as
their ordinary userspace libc equivalents, but -ffreestanding disables
such libcall optimization and other related features in the compiler,
which can lead to unexpected things such as CONFIG_FORTIFY_SOURCE not
working (!).

As it turns out to be the case, only the memory operations really need
to be prevented from expansion by the compiler, and this is doable with
finer-grained -fno-builtin-* toggles. So only disable memcpy, memmove
and memset, while leaving other builtins enabled, to fix source
fortification among others.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1897
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: WANG Xuerui <git@xen0n.name>
---

Changes in v2:

- Keep the memory operation builtins disabled, add comments, and tweak the
  commit message along the way.

 arch/loongarch/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index b1e5db51b61c..34fc48df87f2 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -83,7 +83,14 @@ KBUILD_CFLAGS_KERNEL		+= -fPIE
 LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext
 endif
 
-cflags-y += -ffreestanding
+# Make sure the memory libcalls are not expanded by the compiler, for better
+# control over unaligned accesses with respect to CONFIG_ARCH_STRICT_ALIGN,
+# and also for avoiding https://gcc.gnu.org/PR109465.
+#
+# The overly broad -ffreestanding is undesirable as it disables *all* libcall
+# handling, that unfortunately includes proper FORTIFY_SOURCE instrumentation.
+cflags-y += -fno-builtin-memcpy -fno-builtin-memmove -fno-builtin-memset
+
 cflags-y += $(call cc-option, -mno-check-zero-division)
 
 load-y		= 0x9000000000200000
-- 
2.40.0

