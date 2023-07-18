Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE4C757FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjGROhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGROhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:37:20 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ECD410A;
        Tue, 18 Jul 2023 07:37:19 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6E14392009E; Tue, 18 Jul 2023 16:37:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 676E392009D;
        Tue, 18 Jul 2023 15:37:18 +0100 (BST)
Date:   Tue, 18 Jul 2023 15:37:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MIPS: Fix CONFIG_CPU_DADDI_WORKAROUNDS `modules_install'
 regression
In-Reply-To: <alpine.DEB.2.21.2307180025120.62448@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2307181353110.61566@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2307180025120.62448@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a build-time check for the presence of the GCC `-msym32' option.  
This option has been there since GCC 4.1.0, which is below the minimum 
required as at commit 805b2e1d427a ("kbuild: include Makefile.compiler 
only when compiler is needed"), when an error message:

arch/mips/Makefile:306: *** CONFIG_CPU_DADDI_WORKAROUNDS unsupported without -msym32.  Stop.

started to trigger for the `modules_install' target with configurations 
such as `decstation_64_defconfig' that set CONFIG_CPU_DADDI_WORKAROUNDS, 
because said commit has made `cc-option-yn' an undefined function for 
non-build targets.

Reported-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 805b2e1d427a ("kbuild: include Makefile.compiler only when compiler is needed")
Cc: stable@vger.kernel.org # v5.13+
---
 arch/mips/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

linux-mips-msym32-uncond.diff
Index: linux-macro/arch/mips/Makefile
===================================================================
--- linux-macro.orig/arch/mips/Makefile
+++ linux-macro/arch/mips/Makefile
@@ -299,8 +299,8 @@ ifdef CONFIG_64BIT
     endif
   endif
 
-  ifeq ($(KBUILD_SYM32)$(call cc-option-yn,-msym32), yy)
-    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
+  ifeq ($(KBUILD_SYM32), y)
+    cflags-$(KBUILD_SYM32) += -msym32 -DKBUILD_64BIT_SYM32
   else
     ifeq ($(CONFIG_CPU_DADDI_WORKAROUNDS), y)
       $(error CONFIG_CPU_DADDI_WORKAROUNDS unsupported without -msym32)
