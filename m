Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D724A7F047E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 06:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjKSFh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 00:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSFhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 00:37:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7499C192
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 21:37:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BDDC433C7;
        Sun, 19 Nov 2023 05:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700372271;
        bh=nCPW9jBGTKyH0lUgrulKPDATJP5U30lWuKcxg55VFaY=;
        h=From:To:Cc:Subject:Date:From;
        b=fPXthR4SMxV1YOulnCEOsajU77bv4NJMJaOkL5W2+lOvh8ay5diPw5thg79i2pgab
         RJGu1pUHfJSwCN4WAOEGNZh69U6h96xhwQ596fTffX5NgvIOZzKtHAqmkveddFi9ze
         QI7y8x/xj0TuCyfjuLw57bgkdvtAIQ3kLUO+03GDa07HzvIhKFbQeT1FLcA8Pu2iOv
         zop247siEZyS6ESBv6ES7nxk3AnjaMugRD/FVjAigmHOkPji63sPG1wpEp0GtJjDVX
         P0s7ZioSbrbL12twnOBgNFB5zYoYZrc0TpoDaqyk3vO8w90vbmh5Ak00jdAU/ztA2l
         OGMYPXHw1c2VQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] riscv: add dependency among Image(.gz), loader(.bin), and vmlinuz.efi
Date:   Sun, 19 Nov 2023 14:37:37 +0900
Message-Id: <20231119053737.2367955-1-masahiroy@kernel.org>
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

  $ make -j$(nproc) ARCH=riscv Image Image.gz loader loader.bin vmlinuz.efi
    [ snip ]
    SORTTAB vmlinux
    OBJCOPY arch/riscv/boot/Image
    OBJCOPY arch/riscv/boot/Image
    OBJCOPY arch/riscv/boot/Image
    OBJCOPY arch/riscv/boot/Image
    OBJCOPY arch/riscv/boot/Image
    GZIP    arch/riscv/boot/Image.gz
    AS      arch/riscv/boot/loader.o
    AS      arch/riscv/boot/loader.o
    Kernel: arch/riscv/boot/Image is ready
    PAD     arch/riscv/boot/vmlinux.bin
    GZIP    arch/riscv/boot/vmlinuz
    Kernel: arch/riscv/boot/loader is ready
    OBJCOPY arch/riscv/boot/loader.bin
    Kernel: arch/riscv/boot/loader.bin is ready
    Kernel: arch/riscv/boot/Image.gz is ready
    OBJCOPY arch/riscv/boot/vmlinuz.o
    LD      arch/riscv/boot/vmlinuz.efi.elf
    OBJCOPY arch/riscv/boot/vmlinuz.efi
    Kernel: arch/riscv/boot/vmlinuz.efi is ready

The log "OBJCOPY arch/arm64/boot/Image" is displayed 5 times.
(also "AS      arch/riscv/boot/loader.o" twice.)

It indicates that 5 threads simultaneously enter arch/riscv/boot/
and write to arch/riscv/boot/Image.

It occasionally leads to a build failure:

  $ make -j$(nproc) ARCH=riscv Image Image.gz loader loader.bin vmlinuz.efi
    [ snip ]
    SORTTAB vmlinux
    OBJCOPY arch/riscv/boot/Image
    OBJCOPY arch/riscv/boot/Image
    OBJCOPY arch/riscv/boot/Image
    OBJCOPY arch/riscv/boot/Image
    PAD     arch/riscv/boot/vmlinux.bin
  truncate: Invalid number: 'arch/riscv/boot/vmlinux.bin'
  make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13: arch/riscv/boot/vmlinux.bin] Error 1
  make[2]: *** Deleting file 'arch/riscv/boot/vmlinux.bin'
  make[1]: *** [arch/riscv/Makefile:167: vmlinuz.efi] Error 2
  make[1]: *** Waiting for unfinished jobs....
    Kernel: arch/riscv/boot/Image is ready
    GZIP    arch/riscv/boot/Image.gz
    AS      arch/riscv/boot/loader.o
    AS      arch/riscv/boot/loader.o
    Kernel: arch/riscv/boot/loader is ready
    OBJCOPY arch/riscv/boot/loader.bin
    Kernel: arch/riscv/boot/loader.bin is ready
    Kernel: arch/riscv/boot/Image.gz is ready
  make: *** [Makefile:234: __sub-make] Error 2

Image.gz, loader, vmlinuz.efi depend on Image. loader.bin depends
on loader. Such dependencies are not specified in arch/riscv/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 5cbe596345c1..1d6ed27e0a2a 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -163,6 +163,8 @@ BOOT_TARGETS := Image Image.gz loader loader.bin xipImage vmlinuz.efi
 
 all:	$(notdir $(KBUILD_IMAGE))
 
+loader.bin: loader
+Image.gz loader vmlinuz.efi: Image
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 	@$(kecho) '  Kernel: $(boot)/$@ is ready'
-- 
2.40.1

