Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FDF7F5D68
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345041AbjKWLGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjKWLF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:05:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D62CD4E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:06:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43DDC43395;
        Thu, 23 Nov 2023 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700737561;
        bh=9L6ia8ZbTYYVbHNB3z9LNyIFtb/pxWEiG5AGGJleqic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0VyQ7PVXrgpHxXuRmTV8Wg6u7K/HjAAIEfu11YSMUUXsJVeV978M2gskJD8Avjb9
         ZB5kV6SE67ZAx7fc43cvAKQQcnfZ1BWg4eFGZWUJqIa5on//kgER/9tce+AIoFXgWk
         zowoZ5/rblNmUh7+n5DSkzof8B68ftWfi/4Bm3uFFM0OiYY9QfU9s/13gVPYGrLWfP
         dYIN19g0XPcGf5Nmb7Sg/RV1aH2dS4Rz+E9fs2rc8A8QVIcjSUPFmn5jrJzTXH3nKB
         fJcaV7yYwcK455NpW2ijR7YUCQVt+9Wq2658RaYTVnp6PTXXmkAhjphLHV/fQylLef
         elAqGL5fRFABA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 6/6] Makefile.extrawarn: turn on missing-prototypes globally
Date:   Thu, 23 Nov 2023 12:05:06 +0100
Message-Id: <20231123110506.707903-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123110506.707903-1-arnd@kernel.org>
References: <20231123110506.707903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Over the years we went from > 1000 of warnings to under 100 earlier
this year, and I sent patches to address all the ones that I saw with
compile testing randcom configs on arm64, arm and x86 kernels. This is a
really useful warning, as it catches real bugs when there are mismatched
prototypes. In particular with kernel control flow integrity enabled,
those are no longer allowed.

I have done extensive testing to ensure that there are no new build
errors or warnings on any configuration of x86, arm and arm64 builds.
I also made sure that at least the both the normal defconfig and an
allmodconfig build is clean for arc, csky, loongarch, m68k, microblaze,
openrisc, parisc, powerpc, riscv, s390, and xtensa, with the respective
maintainers doing most of the patches.

At this point, there are five architectures with a number of known
regressions: alpha, nios2, mips, sh and sparc. In the previous version
of this patch, I had turned off the missing prototype warnings for the 15
architectures that still had issues, but since there are only five left,
I think we can leave the rest to the maintainers (Cc'd here) as well.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Link: https://lore.kernel.org/lkml/20230810141947.1236730-1-arnd@kernel.org/
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 1527199161d7..8e9170f932ea 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -17,6 +17,8 @@ KBUILD_CFLAGS += -Wno-format-security
 KBUILD_CFLAGS += -Wno-trigraphs
 KBUILD_CFLAGS += $(call cc-disable-warning,frame-address,)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
+KBUILD_CFLAGS += -Wmissing-declarations
+KBUILD_CFLAGS += -Wmissing-prototypes
 
 ifneq ($(CONFIG_FRAME_WARN),0)
 KBUILD_CFLAGS += -Wframe-larger-than=$(CONFIG_FRAME_WARN)
@@ -95,10 +97,8 @@ export KBUILD_EXTRA_WARN
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 
 KBUILD_CFLAGS += -Wextra -Wunused -Wno-unused-parameter
-KBUILD_CFLAGS += -Wmissing-declarations
 KBUILD_CFLAGS += $(call cc-option, -Wrestrict)
 KBUILD_CFLAGS += -Wmissing-format-attribute
-KBUILD_CFLAGS += -Wmissing-prototypes
 KBUILD_CFLAGS += -Wold-style-definition
 KBUILD_CFLAGS += -Wmissing-include-dirs
 KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
-- 
2.39.2

