Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D3D7FC88B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376411AbjK1VHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346746AbjK1VHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:07:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472AA1FF3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF79C433C7;
        Tue, 28 Nov 2023 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205609;
        bh=xRoEIjR3KV/1kAEQG2vgN5KGGWtoecQCkzDjciK9N1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aiWeM5qQns4M7irrxvJIn1lTTAyaAZbs86/QCO2v+Y2kc0l1tLFVIVWUkgdM8aMGc
         G+e0PWBmBWe9+YkDzoWc5H7rqR6B4MOcAzwjX1R3tEK50OzFWK3zqgqMR0t/Zg0nFZ
         LyxxuQMcXMttXI8os53ZJONFJYEw9ZsoZBrZrDeZuTGWHNKuBhP1gRHCeM17VphznU
         Wvig8Qa6KiOloUD4UwiBPPpDeAjkAHCFcAJzON6bbd9wm8EK4HCbjfl+SbWissloLl
         GOCN3DDiiD90il4oayJ8OWiQDtd0+92kWrFfOEgD71EjxJI3mTAnvMvG4l/mqTnupW
         jZv1T1ItfYiNQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 18/40] LoongArch: Add dependency between vmlinuz.efi and vmlinux.efi
Date:   Tue, 28 Nov 2023 16:05:24 -0500
Message-ID: <20231128210615.875085-18-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit d3ec75bc635cb0cb8185b63293d33a3d1b942d22 ]

A common issue in Makefile is a race in parallel building.

You need to be careful to prevent multiple threads from writing to the
same file simultaneously.

Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
generate invalid images") addressed such a bad scenario.

A similar symptom occurs with the following command:

  $ make -j$(nproc) ARCH=loongarch vmlinux.efi vmlinuz.efi
    [ snip ]
    SORTTAB vmlinux
    OBJCOPY arch/loongarch/boot/vmlinux.efi
    OBJCOPY arch/loongarch/boot/vmlinux.efi
    PAD     arch/loongarch/boot/vmlinux.bin
    GZIP    arch/loongarch/boot/vmlinuz
    OBJCOPY arch/loongarch/boot/vmlinuz.o
    LD      arch/loongarch/boot/vmlinuz.efi.elf
    OBJCOPY arch/loongarch/boot/vmlinuz.efi

The log "OBJCOPY arch/loongarch/boot/vmlinux.efi" is displayed twice.

It indicates that two threads simultaneously enter arch/loongarch/boot/
and write to arch/loongarch/boot/vmlinux.efi.

It occasionally leads to a build failure:

  $ make -j$(nproc) ARCH=loongarch vmlinux.efi vmlinuz.efi
    [ snip ]
    SORTTAB vmlinux
    OBJCOPY arch/loongarch/boot/vmlinux.efi
    PAD     arch/loongarch/boot/vmlinux.bin
  truncate: Invalid number: ‘arch/loongarch/boot/vmlinux.bin’
  make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
  arch/loongarch/boot/vmlinux.bin] Error 1
  make[2]: *** Deleting file 'arch/loongarch/boot/vmlinux.bin'
  make[1]: *** [arch/loongarch/Makefile:146: vmlinuz.efi] Error 2
  make[1]: *** Waiting for unfinished jobs....
  make: *** [Makefile:234: __sub-make] Error 2

vmlinuz.efi depends on vmlinux.efi, but such a dependency is not
specified in arch/loongarch/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index fb0fada43197e..96747bfec1a10 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -142,6 +142,8 @@ vdso_install:
 
 all:	$(notdir $(KBUILD_IMAGE))
 
+vmlinuz.efi: vmlinux.efi
+
 vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(bootvars-y) $(boot)/$@
 
-- 
2.42.0

