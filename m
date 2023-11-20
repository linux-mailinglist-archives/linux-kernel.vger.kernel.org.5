Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81847F2161
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjKTXYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:24:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A3FC1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:24:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25B3C433C8;
        Mon, 20 Nov 2023 23:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700522644;
        bh=67KEhLI0mEivJdbrkeCl+vFBBtgFo5YzYmUACDBON68=;
        h=From:To:Cc:Subject:Date:From;
        b=H8jniV24tZu68db9VGGm2q1zQTL4/mK90DWnFoovUtdjLOvX2sQaRAW9tq1BGVaOj
         7qX3z2eK3d6lvNNIKtJbLJ2Iw6euVJSNcBNlnv+gaQPgDbbDNXtCt6jA+iyW4IO6VF
         7m73afQT36H+vXmRCSH6nm2IjaNzTcC3ZhCVDkOaspknxf90tcCYnday6+8h5BfdBt
         wAl5D26oA/ehLsMMoHU5dV8CgCujZme+ru+sGtfkmjw6neS289tR8vbajgFjncYRxV
         JeGody4kjKgtnTgAbfwsz//Tmoq8zfFqKBbk7I1ak4r57jtbn+mag/3++tZF5bz1dT
         qAH0aq2JpD5mw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] powerpc: add crtsavres.o to always-y instead of extra-y
Date:   Tue, 21 Nov 2023 08:23:32 +0900
Message-Id: <20231120232332.4100288-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
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

crtsavres.o is linked to modules. However, as explained in commit
d0e628cd817f ("kbuild: doc: clarify the difference between extra-y
and always-y"), 'make modules' does not build extra-y.

For example, the following command fails:

  $ make ARCH=powerpc LLVM=1 KBUILD_MODPOST_WARN=1 mrproper ps3_defconfig modules
    [snip]
    LD [M]  arch/powerpc/platforms/cell/spufs/spufs.ko
  ld.lld: error: cannot open arch/powerpc/lib/crtsavres.o: No such file or directory
  make[3]: *** [scripts/Makefile.modfinal:56: arch/powerpc/platforms/cell/spufs/spufs.ko] Error 1
  make[2]: *** [Makefile:1844: modules] Error 2
  make[1]: *** [/home/masahiro/workspace/linux-kbuild/Makefile:350: __build_one_by_one] Error 2
  make: *** [Makefile:234: __sub-make] Error 2

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 51ad0397c17a..6eac63e79a89 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -45,7 +45,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 # so it is only needed for modules, and only for older linkers which
 # do not support --save-restore-funcs
 ifndef CONFIG_LD_IS_BFD
-extra-$(CONFIG_PPC64)	+= crtsavres.o
+always-$(CONFIG_PPC64)	+= crtsavres.o
 endif
 
 obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
-- 
2.40.1

