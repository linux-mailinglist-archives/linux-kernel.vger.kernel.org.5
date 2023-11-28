Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A977FC8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346825AbjK1VLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346742AbjK1VKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:10:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F34273F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:08:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624AEC193E8;
        Tue, 28 Nov 2023 21:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205715;
        bh=v90/onzfQhtX7ISsYZo9X74ReIoVFkLHycA+Qck6/lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+7DabubCSUaU4mJqlapubI3smezyb6UL42Nt8whGWN0dKZ5r1LaTGG3pDUootbvd
         kYiDKvGmZ7teJlqFXcCrVbiDBN4PofIsZeuCmz/npk++dgZPrN16oK7lamU9jhyVYA
         Id7lfQHyetWmDy1eB0CiOXAah41NL7T6aMdoMeqB12pKhJQkluR/8oXJqPODhmItgH
         DbXrGGAuZRu0JRvYNtPwh4Z3VgTZhUKFcoK3CfJMe1oK0KlnUi9wI6zvKbtQmUVlpv
         /hxa4sFo2ONpwt7OvXQbZ28iNvn50AZRlPkMGOKhf78/VVRVShz3SwyrgeUCtjVZpz
         x2xOZs205PhtQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        SImon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 25/25] arm64: add dependency between vmlinuz.efi and Image
Date:   Tue, 28 Nov 2023 16:07:41 -0500
Message-ID: <20231128210750.875945-25-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
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

[ Upstream commit c0a8574204054effad6ac83cc75c02576e2985fe ]

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
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: SImon Glass <sjg@chromium.org>
Link: https://lore.kernel.org/r/20231119053234.2367621-1-masahiroy@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5e56d26a22398..c9496539c3351 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -157,7 +157,7 @@ endif
 
 all:	$(notdir $(KBUILD_IMAGE))
 
-
+vmlinuz.efi: Image
 Image vmlinuz.efi: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-- 
2.42.0

