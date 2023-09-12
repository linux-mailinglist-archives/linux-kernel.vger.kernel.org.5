Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC579C839
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjILHcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjILHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:32:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D039A10C9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:32:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EA6C433C8;
        Tue, 12 Sep 2023 07:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694503936;
        bh=LVkhyWFH59zqNCV7QiwAO5x1uYMJKWUxGuvv3jXu/IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHhhtPBV+49U1o/r/CM1Znsy1im0RnVGuv+yP6AeptLwXw+lvr/lhnlUccKnXlFza
         CxEAXhnH8pc8T94zdnvctdmtyVQtYbVkveTHcQ/0W4T/hAyXENARO14ni3pqj/yTbq
         hqGY1FVIM78CX8gH7hQSR4vMDLOj4f0ag7rE/LHveaIEzJPws+iZ2dZg5hlAskdD9B
         Scm6tv7vyPmLHmgJVNN5Jhsb/5WxilSJr+cLda46qfqDuVnkHsTDUEXGp1zG/8JysC
         mdO0kLM+J+gwzJQpXmq/5H5BxIWp5rrynf9cN1Dp5FNkOeD80HSRR4Yltjl9BuFFYP
         1X5TKbkKrh+eg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [RESEND PATCH 3/3] riscv: vdso.lds.S: remove hardcoded 0x800 .text start addr
Date:   Tue, 12 Sep 2023 15:20:15 +0800
Message-Id: <20230912072015.2424-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912072015.2424-1-jszhang@kernel.org>
References: <20230912072015.2424-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
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

