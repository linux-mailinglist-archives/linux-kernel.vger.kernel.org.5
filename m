Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD675C81A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGUNqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGUNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E961731;
        Fri, 21 Jul 2023 06:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EB0161B2A;
        Fri, 21 Jul 2023 13:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0543C433C7;
        Fri, 21 Jul 2023 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689947159;
        bh=Y+KzTs8+PzyDlj+I4KwGMIMgwXWbHAbN6snUeh5qmNk=;
        h=From:To:Cc:Subject:Date:From;
        b=L67onQyS74Pnfx6UGTk/eusNu4C0c3ZMB7dzcL7H6aH+EVteGl0lC4CtSQf2HwlAD
         uYFTBSIZLHDmSuIhmTyG4X/KJ2SeHzUOzt1BpFTnckdLLUrhuFaKVgxeVuZjDzz1Yt
         8GEzbIOpuGO0iDL5Q8LMMJDDsDJj6l3YJKscOl4vUWoaVBEZgYtZLHor3zWpaQIDIA
         umxkNhBUuECZ5M8wnVguwZEEtTk4G/TvQyjFgYxxYqdbdVA35T75Dd90x3d2LOTeta
         eyxwL8AwKtwyxcmwl6BSbqK8gqN4ZyX2ARGuvQZ3exThwtgm5S6W/uyIcMiykB02xK
         8fsn32/MXR5Sg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 1/2] UML: hard-code the result of 'uname -s'
Date:   Fri, 21 Jul 2023 22:45:47 +0900
Message-Id: <20230721134548.3438376-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We rely on 'uname -s' returning 'Linux' as there are arch/um/os-Linux/
and arch/x86/um/os-Linux/, but no other os-*/ directories.

Supporting a non-Linux host is unlikely to happen.

Let's hard-code 'Linux'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/um/Makefile     | 7 +++----
 arch/x86/um/Makefile | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index da4d5256af2f..1735a562453d 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -18,14 +18,13 @@ else
 endif
 
 ARCH_DIR := arch/um
-OS := $(shell uname -s)
 # We require bash because the vmlinux link and loader script cpp use bash
 # features.
 SHELL := /bin/bash
 
 core-y			+= $(ARCH_DIR)/kernel/		\
 			   $(ARCH_DIR)/drivers/		\
-			   $(ARCH_DIR)/os-$(OS)/
+			   $(ARCH_DIR)/os-Linux/
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 
@@ -78,7 +77,7 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
 
 #This will adjust *FLAGS accordingly to the platform.
-include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
+include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
 
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/include \
 		   -I$(srctree)/$(HOST_DIR)/include/uapi \
@@ -155,4 +154,4 @@ archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 
-export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
+export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index ee89f6bb9242..e207e6748aa2 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -13,7 +13,7 @@ obj-y = bugs_$(BITS).o delay.o fault.o ldt.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_$(BITS).o stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
-	mem_$(BITS).o subarch.o os-$(OS)/
+	mem_$(BITS).o subarch.o os-Linux/
 
 ifeq ($(CONFIG_X86_32),y)
 
-- 
2.39.2

