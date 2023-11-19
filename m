Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382847F047F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 06:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjKSFcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 00:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSFcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 00:32:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDAE182
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 21:32:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804EAC433C8;
        Sun, 19 Nov 2023 05:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700371962;
        bh=q2CXtWLrjQSU6v2TX31hrhnxbzzNC8tayyo4CW4QiQ8=;
        h=From:To:Cc:Subject:Date:From;
        b=ItDSwe0zoyH4wntxB9RCiIScC/C0hCDFUdKwnxIxYka4Xz4fvaa32WQWrFSIiYIYd
         vWcE4aAfT9Wgg23v4MfW8VUihBekREtO54dJtkZwFoOXcVszl/+zidshJIwNaBT6gd
         nki+xx+tneERWHUHySGpex4G5FjcIgrNN5RBEM5nqfP/w1k5aBb1gPzi9Zzl87+wXG
         ZD03ZNOuXISAzNWzGhGPINirZDCxo0tvKj4ca7bmWAk8uFkCh+Gie3b7s4ABx0v4k9
         FovgdsxuhzciXu/QpuXG0X36U5oEWS6sLL/o/tj5zvC/EvNuWJBl/fEhH/4FANjgV/
         aQ5LIUjFHOwqQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] arm64: add dependency between vmlinuz.efi and Image
Date:   Sun, 19 Nov 2023 14:32:34 +0900
Message-Id: <20231119053234.2367621-1-masahiroy@kernel.org>
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

A common issue in Makefile is a race in parallel building.

You need to be careful to prevent multiple threads from writing to the
same file simultaneously.

Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
generate invalid images") addressed such a bad scenario.

A similar symptom occurs with the following command:

  $ make -j$(nproc) ARCH=arm64 Image vmlinuz.efi
    [ snip ]
    SORTTAB vmlinux
    OBJCOPY arch/arm64/boot/Image
    OBJCOPY arch/arm64/boot/Image
    AS      arch/arm64/boot/zboot-header.o
    PAD     arch/arm64/boot/vmlinux.bin
    GZIP    arch/arm64/boot/vmlinuz
    OBJCOPY arch/arm64/boot/vmlinuz.o
    LD      arch/arm64/boot/vmlinuz.efi.elf
    OBJCOPY arch/arm64/boot/vmlinuz.efi

The log "OBJCOPY arch/arm64/boot/Image" is displayed twice.

It indicates that two threads simultaneously enter arch/arm64/boot/
and write to arch/arm64/boot/Image.

It occasionally leads to a build failure:

  $ make -j$(nproc) ARCH=arm64 Image vmlinuz.efi
    [ snip ]
    SORTTAB vmlinux
    OBJCOPY arch/arm64/boot/Image
    PAD     arch/arm64/boot/vmlinux.bin
  truncate: Invalid number: 'arch/arm64/boot/vmlinux.bin'
  make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
  arch/arm64/boot/vmlinux.bin] Error 1
  make[2]: *** Deleting file 'arch/arm64/boot/vmlinux.bin'
  make[1]: *** [arch/arm64/Makefile:163: vmlinuz.efi] Error 2
  make[1]: *** Waiting for unfinished jobs....
  make: *** [Makefile:234: __sub-make] Error 2

vmlinuz.efi depends on Image, but such a dependency is not specified
in arch/arm64/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4a1ad3248c2d..47ecc4cff9d2 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -158,7 +158,7 @@ endif
 
 all:	$(notdir $(KBUILD_IMAGE))
 
-
+vmlinuz.efi: Image
 Image vmlinuz.efi: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-- 
2.40.1

