Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC37F3A80
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjKUX5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbjKUX5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:57:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD40CE7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:57:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1C7C433C9;
        Tue, 21 Nov 2023 23:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700611032;
        bh=PgDod9JVK1SlTO6PB/we26pgwxZ6Hugtd6ddfhtvips=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5Oqx2adFYIoQ9k4t/Fy/+5td7AJw0Ktf33vV/fGcP8SzAfragsJVRdICPCn1rAiq
         DY+8pX8mR5/DxUtJobAPYiON00qCGoJvj2BP+5n2et1TWEtFdgFs7egce9cUf+jEoM
         QuJAxXvWLW5r0KMCYoemcPkKHSz6roL/PrJIA8KHkR+/mWH94Fs+p2YMq8QI05E6ou
         s/mPI0QIWI4BLxziJ6Est+vJPCMnCuC9lG/Og/BKs8zJ3RLi+amuJSo3nbUqiRZ5bi
         rhC+VekE2qEghO/hzfZWrvY282W1JlDo00ewShT6Eo4W3aeFl1AH+6vr3odn1i+x/i
         lKcGM2Gr47bOg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] x86: vdso: simplify obj-y addition
Date:   Wed, 22 Nov 2023 08:56:59 +0900
Message-Id: <20231121235701.239606-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121235701.239606-1-masahiroy@kernel.org>
References: <20231121235701.239606-1-masahiroy@kernel.org>
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

Add objects to obj-y in a more straightforward way.

CONFIG_X86_32 and CONFIG_IA32_EMULATION are not enabled simultaneously,
but even if they are, Kbuild graciously deduplicates obj-y entries.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/vdso/Makefile | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 2038d9c8e527..cbfb5aab5e9c 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -18,11 +18,6 @@ OBJECT_FILES_NON_STANDARD	:= y
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT		:= n
 
-VDSO64-$(CONFIG_X86_64)		:= y
-VDSOX32-$(CONFIG_X86_X32_ABI)	:= y
-VDSO32-$(CONFIG_X86_32)		:= y
-VDSO32-$(CONFIG_IA32_EMULATION)	:= y
-
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
@@ -38,11 +33,11 @@ OBJECT_FILES_NON_STANDARD_vma.o		:= n
 OBJECT_FILES_NON_STANDARD_extable.o	:= n
 
 # vDSO images to build
-vdso_img-$(VDSO64-y)		+= 64
-vdso_img-$(VDSOX32-y)		+= x32
-vdso_img-$(VDSO32-y)		+= 32
+obj-$(CONFIG_X86_64)		+= vdso-image-64.o
+obj-$(CONFIG_X86_X32_ABI)	+= vdso-image-x32.o
+obj-$(CONFIG_X86_32)		+= vdso-image-32.o vdso32-setup.o
+obj-$(CONFIG_IA32_EMULATION)	+= vdso-image-32.o vdso32-setup.o
 
-obj-$(VDSO32-y)				 += vdso32-setup.o
 OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
@@ -53,9 +48,6 @@ $(obj)/vdso.o: $(obj)/vdso.so
 targets += vdso.lds $(vobjs-y)
 targets += vdso32/vdso32.lds $(vobjs32-y)
 
-# Build the vDSO image C files and link them in.
-vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
-obj-y += $(vdso_img_objs)
 targets += $(foreach x, 64 x32 32, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg)
 
 CPPFLAGS_vdso.lds += -P -C
-- 
2.40.1

