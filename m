Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD057D546B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbjJXOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJXOx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:53:26 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DBBD7F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:53:23 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7faa:e55:54a:cff])
        by albert.telenet-ops.be with bizsmtp
        id 1qtK2B00X5Uc89d06qtKeQ; Tue, 24 Oct 2023 16:53:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qvImO-007Q3C-T2;
        Tue, 24 Oct 2023 16:53:19 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qvImV-00BkS1-Nd;
        Tue, 24 Oct 2023 16:53:19 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] riscv: boot: Fix creation of loader.bin
Date:   Tue, 24 Oct 2023 16:53:18 +0200
Message-Id: <1086025809583809538dfecaa899892218f44e7e.1698159066.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When flashing loader.bin for K210 using kflash:

    [ERROR] This is an ELF file and cannot be programmed to flash directly: arch/riscv/boot/loader.bin

Before, loader.bin relied on "OBJCOPYFLAGS := -O binary" in the main
RISC-V Makefile to create a boot image with the right format.  With this
removed, the image is now created in the wrong (ELF) format.

Fix this by adding an explicit rule.

Fixes: 505b02957e74f0c5 ("riscv: Remove duplicate objcopy flag")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/riscv/boot/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 22b13947bd131e84..8e7fc0edf21d3ece 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -17,6 +17,7 @@
 KCOV_INSTRUMENT := n
 
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
+OBJCOPYFLAGS_loader.bin :=-O binary
 OBJCOPYFLAGS_xipImage :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
 targets := Image Image.* loader loader.o loader.lds loader.bin
-- 
2.34.1

