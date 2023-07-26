Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE6763DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGZRmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGZRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35665269A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C691E61BE2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90F2C433C7;
        Wed, 26 Jul 2023 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690393325;
        bh=FoAwbwQLJJvL1URKvVipUOgohpgmWIsUn9uEVNXhbv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hwi9cpkOp5qyxCKXnFW+26Vq/LNWYfZRyi9CI0m8x6q9gKxP0xKNHmKHxiN3khZdO
         VQKVo3IQ0913QtAp52fnxpEKeegDd7NI2ubQ9fxgGDHIUfy94gjD0Z2IV8hGPgxpVb
         YQaY1vexRV7F9vL3/dCQMUvaSMPUXkX/uW6+7HXBep4yEXbNYkBcaOQc5DvM5MdOrV
         3WJ00MF0BwFzViuZaXZPd6dDbHSZbSOCnTwivlK/bIE6ojgjAz3rET4r2/VKhdF0E3
         S/uMori21qVJjlBqjHW6hAccFsvwY0+ASlLx50f9Qt9LE811HW23GU769K4alyTT2i
         7MGwzfvVI3bbQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] riscv: vdso.lds.S: remove hardcoded 0x800 .text start addr
Date:   Thu, 27 Jul 2023 01:30:24 +0800
Message-Id: <20230726173024.3684-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230726173024.3684-1-jszhang@kernel.org>
References: <20230726173024.3684-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe the hardcoded 0x800 and related comments come from the long
history VDSO_TEXT_OFFSET in x86 vdso code, but commit 5b9304933730
("x86 vDSO: generate vdso-syms.lds") and commit f6b46ebf904f ("x86
vDSO: new layout") removes the comment and hard coding for x86.

Similar as x86 and other arch, riscv doesn't need the rigid layout
using VDSO_TEXT_OFFSET since it "no longer matters to the kernel".
so we could remove the hard coding now, and removing it brings a
small vdso.so and aligns with other architectures.

Also, having enough separation between data and text is important for
I-cache, so similar as x86, move .note, .eh_frame_hdr, and .eh_frame
between .rodata and .text.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vdso/vdso.lds.S | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index 671aa21769bc..cbe2a179331d 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -23,12 +23,8 @@ SECTIONS
 	.gnu.version_d	: { *(.gnu.version_d) }
 	.gnu.version_r	: { *(.gnu.version_r) }
 
-	.note		: { *(.note.*) }		:text	:note
 	.dynamic	: { *(.dynamic) }		:text	:dynamic
 
-	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
-	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
-
 	.rodata		: {
 		*(.rodata .rodata.* .gnu.linkonce.r.*)
 		*(.got.plt) *(.got)
@@ -37,13 +33,16 @@ SECTIONS
 		*(.bss .bss.* .gnu.linkonce.b.*)
 	}
 
+	.note		: { *(.note.*) }		:text	:note
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
 	/*
-	 * This linker script is used both with -r and with -shared.
-	 * For the layouts to match, we need to skip more than enough
-	 * space for the dynamic symbol table, etc. If this amount is
-	 * insufficient, ld -shared will error; simply increase it here.
+	 * Text is well-separated from actual data: there's plenty of
+	 * stuff that isn't used at runtime in between.
 	 */
-	. = 0x800;
+	. = ALIGN(16);
 	.text		: { *(.text .text.*) }		:text
 
 	. = ALIGN(4);
-- 
2.40.1

