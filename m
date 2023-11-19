Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1987F0514
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKSKAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKSKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:00:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E395CE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:00:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA6BC433C8;
        Sun, 19 Nov 2023 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700388032;
        bh=naEGp220Hlp/9TKOLlkrInZMXHL++3zGxHRa1Qn2VXM=;
        h=From:To:Cc:Subject:Date:From;
        b=WqPTCY3CPwP92hiBsGumKLNmvLDW6/1mtslFwykWsMmHeTvUehwOike6DbS/UmuZ/
         JYQfaIEfswVgN2c5BipGTvsGqXC+CrskcsTtemYcabPYVBfOQPGMWF+FrIZGB0kikz
         hhNCYHSc43etV69mXhCgNTtmn31LCFXSqTqTlTg8nv2xoM0IBwsX5yqxkuRIgbRB7m
         sjnLbTeVKSrLWTjcz+v1I3uYru5jZN/NLKU2cisIn7p2vggjxfyDzhs5IQ/G+l+IB3
         wepBMinkKrHZ9Nmj+KNkzvO91KNikghE4nt9xmupP4lAzrUCBXSQ+sigKOgpj6TqPk
         9fTV+wFKmNtrw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] riscv: add dependency among Image(.gz), loader(.bin), and vmlinuz.efi
Date:   Sun, 19 Nov 2023 19:00:24 +0900
Message-Id: <20231119100024.2370992-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

The log "OBJCOPY arch/riscv/boot/Image" is displayed 5 times.
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

Changes in v2:
  - Fix commit log

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

