Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DE27765CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjHIQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHIQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:58:26 -0400
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FCD2135;
        Wed,  9 Aug 2023 09:58:21 -0700 (PDT)
Received: from xmz-huawei.. (unknown [111.197.209.91])
        by APP-03 (Coremail) with SMTP id rQCowAAnLrKTxdNkNI2AAg--.29443S2;
        Thu, 10 Aug 2023 00:57:55 +0800 (CST)
From:   Mingzheng Xing <xingmingzheng@iscas.ac.cn>
To:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Bin Meng <bmeng@tinylab.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org,
        Mingzheng Xing <xingmingzheng@iscas.ac.cn>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5] riscv: Handle zicsr/zifencei issue between gcc and binutils
Date:   Thu, 10 Aug 2023 00:56:48 +0800
Message-Id: <20230809165648.21071-1-xingmingzheng@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAnLrKTxdNkNI2AAg--.29443S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4UGFyrury5GFWfKF1rJFb_yoW3uF4xp3
        y3CFyDCrWrWFy8Gr1xAw18Ww1Ygrs5G3ySg3y0y34UGr4qqFyqyrZY9w17XFyDZFs293yY
        9r1S9an5K3Z0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-Originating-IP: [111.197.209.91]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiCQYSCmTTm6T3jgAAsm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binutils-2.38 and GCC-12.1.0 bumped[0][1] the default ISA spec to the newer
20191213 version which moves some instructions from the I extension to the
Zicsr and Zifencei extensions. So if one of the binutils and GCC exceeds
that version, we should explicitly specifying Zicsr and Zifencei via -march
to cope with the new changes. but this only occurs when binutils >= 2.36
and GCC >= 11.1.0. It's a different story when binutils < 2.36.

binutils-2.36 supports the Zifencei extension[2] and splits Zifencei and
Zicsr from I[3]. GCC-11.1.0 is particular[4] because it add support Zicsr
and Zifencei extension for -march. binutils-2.35 does not support the
Zifencei extension, and does not need to specify Zicsr and Zifencei when
working with GCC >= 12.1.0.

To make our lives easier, let's relax the check to binutils >= 2.36 in
CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. For the other two cases,
where clang < 17 or GCC < 11.1.0, we will deal with them in
CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.

For more information, please refer to:
commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang and binutils")
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc [0]
Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd [1]
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=5a1b31e1e1cee6e9f1c92abff59cdcfff0dddf30 [2]
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=729a53530e86972d1143553a415db34e6e01d5d2 [3]
Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49 [4]
Link: https://lore.kernel.org/all/20230308220842.1231003-1-conor@kernel.org
Link: https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.org
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Guo Ren <guoren@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
---

Changelog and test results:

v4 -> v5:
- Add Reviewed-by and Acked-by to commit message, no other code
  changes.

v3 -> v4:
- Update the Kconfig help text and commit message.
Link: https://lore.kernel.org/all/20230731150511.38140-1-xingmingzheng@iscas.ac.cn

v2 -> v3:
- Relax the check to binutils >= 2.36.
- Update the Kconfig help text and commit message.
Link: https://lore.kernel.org/all/20230731095936.23397-1-xingmingzheng@iscas.ac.cn

v1 -> v2:
- Update the Kconfig help text and commit message.
- Add considerations for low version gcc case.
Link: https://lore.kernel.org/all/20230726174524.340952-1-xingmingzheng@iscas.ac.cn

v1:
Link: https://lore.kernel.org/all/20230725170405.251011-1-xingmingzheng@iscas.ac.cn

Here are my test results:
* Compiling the kernel for the master branch with a combination of
  multiple versions of gcc and binutils.

gcc        binutils        patched             no patch
11.4.0     2.35            ok                  ok
11.4.0     2.36            ok                  ok
11.4.0     2.38            ok                  ok

12.2.0     2.35            ok                  error[1]
12.2.0     2.36            ok                  error[2]
12.2.0     2.38            ok                  ok

10.5.0     2.35            ok                  ok
10.5.0     2.36            ok                  ok
10.5.0     2.38            ok                  error[3]

11.1.0     2.35            ok                  ok
11.1.0     2.36            ok                  ok
11.1.0     2.38            ok                  ok

11.2.0     2.35            ok                  ok
11.2.0     2.36            ok                  ok
11.2.0     2.38            ok                  ok

[1]
Assembler messages:
Fatal error: -march=rv32imafd_zicsr_zifencei: Invalid or unknown z ISA extension: 'zifencei'
make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:47: arch/riscv/kernel/compat_vdso/rt_sigreturn.o] Error 1

[2]
./arch/riscv/include/asm/vdso/gettimeofday.h: Assembler messages:
./arch/riscv/include/asm/vdso/gettimeofday.h:79: Error: unrecognized opcode `csrr a5,0xc01'
./arch/riscv/include/asm/vdso/gettimeofday.h:79: Error: unrecognized opcode `csrr a5,0xc01'
./arch/riscv/include/asm/vdso/gettimeofday.h:79: Error: unrecognized opcode `csrr a5,0xc01'
./arch/riscv/include/asm/vdso/gettimeofday.h:79: Error: unrecognized opcode `csrr a5,0xc01'
make[2]: *** [scripts/Makefile.build:243: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1

[3]
cc1: error: '-march=rv64imac_zicsr_zifencei': unsupported ISA subset 'z'
cc1: error: ABI requires '-march=rv64'
make[2]: *** [scripts/Makefile.build:243: scripts/mod/empty.o] Error 1
make[2]: *** Waiting for unfinished jobs....
cc1: error: '-march=rv64imac_zicsr_zifencei': unsupported ISA subset 'z'
cc1: error: ABI requires '-march=rv64'

 arch/riscv/Kconfig                     | 32 +++++++++++++++-----------
 arch/riscv/kernel/compat_vdso/Makefile |  8 ++++++-
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f52dd125ac5e..ce3a6667cfdb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -570,24 +570,30 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
 config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	def_bool y
 	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
-	depends on AS_IS_GNU && AS_VERSION >= 23800
-	help
-	  Newer binutils versions default to ISA spec version 20191213 which
-	  moves some instructions from the I extension to the Zicsr and Zifencei
-	  extensions.
+	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
+	depends on AS_IS_GNU && AS_VERSION >= 23600
+	help
+	  Binutils-2.38 and GCC-12.1.0 bumped the default ISA spec to the newer
+	  20191213 version, which moves some instructions from the I extension to
+	  the Zicsr and Zifencei extensions. This requires explicitly specifying
+	  Zicsr and Zifencei when binutils >= 2.38 or GCC >= 12.1.0. Zicsr
+	  and Zifencei are supported in binutils from version 2.36 onwards.
+	  To make life easier, and avoid forcing toolchains that default to a
+	  newer ISA spec to version 2.2, relax the check to binutils >= 2.36.
+	  For clang < 17 or GCC < 11.1.0, for which this is not possible, this is
+	  dealt with in CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
 
 config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 	def_bool y
 	depends on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	# https://github.com/llvm/llvm-project/commit/22e199e6afb1263c943c0c0d4498694e15bf8a16
-	depends on CC_IS_CLANG && CLANG_VERSION < 170000
-	help
-	  Certain versions of clang do not support zicsr and zifencei via -march
-	  but newer versions of binutils require it for the reasons noted in the
-	  help text of CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. This
-	  option causes an older ISA spec compatible with these older versions
-	  of clang to be passed to GAS, which has the same result as passing zicsr
-	  and zifencei to -march.
+	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49
+	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC_VERSION < 110100)
+	help
+	  Certain versions of clang and GCC do not support zicsr and zifencei via
+	  -march. This option causes an older ISA spec compatible with these older
+	  versions of clang and GCC to be passed to GAS, which has the same result
+	  as passing zicsr and zifencei to -march.
 
 config FPU
 	bool "FPU support"
diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
index 189345773e7e..b86e5e2c3aea 100644
--- a/arch/riscv/kernel/compat_vdso/Makefile
+++ b/arch/riscv/kernel/compat_vdso/Makefile
@@ -11,7 +11,13 @@ compat_vdso-syms += flush_icache
 COMPAT_CC := $(CC)
 COMPAT_LD := $(LD)
 
-COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
+# binutils 2.35 does not support the zifencei extension, but in the ISA
+# spec 20191213, G stands for IMAFD_ZICSR_ZIFENCEI.
+ifdef CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
+	COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
+else
+	COMPAT_CC_FLAGS := -march=rv32imafd -mabi=ilp32
+endif
 COMPAT_LD_FLAGS := -melf32lriscv
 
 # Disable attributes, as they're useless and break the build.
-- 
2.34.1

