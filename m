Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6097F79C83A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjILHcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjILHcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:32:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67E710C2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:32:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB7BC433C7;
        Tue, 12 Sep 2023 07:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694503934;
        bh=SNTi6EXjRzqklc00AhX/G/qenKAaP0mCu6dWGFTJ448=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYnnR/ilRkGT4q9ek9ocgu4MaGhNF2mRvrrgfNo2WpDw23NReL/A8pizQ26tmjD7R
         juAJ6MV424uoVvVVEWzbmY6aadsfMg5z0lVP4QQ2udB0tzQhF3ECWF5GGVggNqSr4B
         DvxnT/UNemTM9BT2px1Tyxynh18gL12NGGyoXEMASZQlj/r6pHHXbHGMPQb4UTkHL8
         0D67ELq1bJ0L0V3JFrLZ6y2RY3SLgVNCZQRV6CEKI76NYH34w4lqEkMoWWp5X90pTZ
         zOk28jh56mjyvJ7Vxfe21TjDxZkwkdetE6O8V/8P1ZIaCQK176IHagZeRZGFib3lIs
         TmBOFMQmncTIA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [RESEND PATCH 2/3] riscv: vdso.lds.S: merge .data section into .rodata section
Date:   Tue, 12 Sep 2023 15:20:14 +0800
Message-Id: <20230912072015.2424-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912072015.2424-1-jszhang@kernel.org>
References: <20230912072015.2424-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .data section doesn't need to be separate from .rodata section,
they are both readonly.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/kernel/vdso/vdso.lds.S | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index d43fd7c7dd11..671aa21769bc 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -29,7 +29,13 @@ SECTIONS
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
 
-	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
+	.rodata		: {
+		*(.rodata .rodata.* .gnu.linkonce.r.*)
+		*(.got.plt) *(.got)
+		*(.data .data.* .gnu.linkonce.d.*)
+		*(.dynbss)
+		*(.bss .bss.* .gnu.linkonce.b.*)
+	}
 
 	/*
 	 * This linker script is used both with -r and with -shared.
@@ -44,13 +50,6 @@ SECTIONS
 	.alternative : {
 		*(.alternative)
 	}
-
-	.data		: {
-		*(.got.plt) *(.got)
-		*(.data .data.* .gnu.linkonce.d.*)
-		*(.dynbss)
-		*(.bss .bss.* .gnu.linkonce.b.*)
-	}
 }
 
 /*
-- 
2.40.1

