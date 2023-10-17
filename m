Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234827CC0C7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjJQKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJQKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:38:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA7A2;
        Tue, 17 Oct 2023 03:38:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2D4C433C7;
        Tue, 17 Oct 2023 10:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697539088;
        bh=eKMGcZsMQDmh2XIngoO27ap1DpB5rplaSJR1DYg/pc8=;
        h=From:To:Cc:Subject:Date:From;
        b=QaRapYwkwmCacW8HwqsxWXC31f2QMHrz+w7jsl7pBJeh3K1VQZVYvfufrilHhTjXd
         0EIVa98dnYgBaBrqDHc7TADhJhFHjiXu7JSD1PqXI4coxWuxLdi0D7xwC/PyneKGa4
         uSuOVuIxzN0xP8r/KD1DWUcu0mS5vKmwrFFO20/dDsJtbFszzO26DLqZnKguMDRqVn
         JO5cl1x5GwyOfcEivSoIZUk33J1YlsXTFWde/19Todb+P0Ac2JSqx710uBa/yVKUVH
         kBOa9m8ejE3dLKufSJAgZJho+OKWZk/ZIFllJ+qZ0x1igUTuAekdovLlkbfN8psEua
         B8DHWxdhlylww==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH 1/4] kbuild: remove ARCH_POSTLINK from module builds
Date:   Tue, 17 Oct 2023 19:37:39 +0900
Message-Id: <20231017103742.130927-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '%.ko' rule in arch/*/Makefile.postlink does nothing but call the
'true' command.

Remove the meaningless code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/Makefile.postlink    | 3 ---
 arch/powerpc/Makefile.postlink | 3 ---
 arch/riscv/Makefile.postlink   | 3 ---
 arch/x86/Makefile.postlink     | 3 ---
 scripts/Makefile.modfinal      | 5 +----
 5 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/mips/Makefile.postlink b/arch/mips/Makefile.postlink
index 34e3bd71f3b0..6cfdc149d3bc 100644
--- a/arch/mips/Makefile.postlink
+++ b/arch/mips/Makefile.postlink
@@ -31,9 +31,6 @@ ifeq ($(CONFIG_RELOCATABLE),y)
 	$(call if_changed,relocs)
 endif
 
-%.ko: FORCE
-	@true
-
 clean:
 	@true
 
diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
index 1f860b3c9bec..ae5a4256b03d 100644
--- a/arch/powerpc/Makefile.postlink
+++ b/arch/powerpc/Makefile.postlink
@@ -35,9 +35,6 @@ ifdef CONFIG_RELOCATABLE
 	$(call if_changed,relocs_check)
 endif
 
-%.ko: FORCE
-	@true
-
 clean:
 	rm -f .tmp_symbols.txt
 
diff --git a/arch/riscv/Makefile.postlink b/arch/riscv/Makefile.postlink
index a46fc578b30b..829b9abc91f6 100644
--- a/arch/riscv/Makefile.postlink
+++ b/arch/riscv/Makefile.postlink
@@ -36,9 +36,6 @@ ifdef CONFIG_RELOCATABLE
 	$(call if_changed,relocs_strip)
 endif
 
-%.ko: FORCE
-	@true
-
 clean:
 	@true
 
diff --git a/arch/x86/Makefile.postlink b/arch/x86/Makefile.postlink
index 936093d29160..fef2e977cc7d 100644
--- a/arch/x86/Makefile.postlink
+++ b/arch/x86/Makefile.postlink
@@ -34,9 +34,6 @@ ifeq ($(CONFIG_X86_NEED_RELOCS),y)
 	$(call cmd,strip_relocs)
 endif
 
-%.ko: FORCE
-	@true
-
 clean:
 	@rm -f $(OUT_RELOCS)/vmlinux.relocs
 
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index b3a6aa8fbe8c..8568d256d6fb 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -28,14 +28,11 @@ quiet_cmd_cc_o_c = CC [M]  $@
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
-ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
-
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
-		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
-	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
+		-T scripts/module.lds -o $@ $(filter %.o, $^)
 
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
-- 
2.40.1

