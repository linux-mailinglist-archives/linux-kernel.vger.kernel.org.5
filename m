Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8024F79FFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbjINJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjINJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:14:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC163CC3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:14:10 -0700 (PDT)
X-QQ-mid: bizesmtp73t1694682827tlz1i6o5
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 17:13:45 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: CR3LFp2JE4nYED5orq4xNbGCHZt0equu6uLslwzQkn9bzwZLLtMcHQM+UJQS6
        q8a4vVZNtlwe5E0SDTAN63nnOD5D9BnkKmoZ8jpiOl3Whuq2rjGJKTbLEMy1xGw8rr/PY5I
        wDzvFupyyeOXxuNVm28pTmnWbMw9I8alXmA6NVjbTGfJ6+Nzsyw9BwA3PTWeDL9/SYQfpaj
        0x019CPO5/oJxYCG0axv0PAuz8L35JavaxK+QiOq1BjIhlHc3SgAnbPAbjZkhBRQ5V+o6sa
        6nhsKHFu6PjdB7C5beR3tG3EtrwHfmJBgu0MBtb+yK5B5opyDqVZuQXbhBuTpiE61Pcfls5
        nJ8y3X+G+TRbZIZamtU8keRUAHqsQeWfBr1q5a31krVw4H3+2E=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10526122010686381623
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH -fixes] riscv: Remove duplicate objcopy flag
Date:   Thu, 14 Sep 2023 17:13:34 +0800
Message-Id: <20230914091334.1458542-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two duplicate `-O binary` flags when objcopying from vmlinux
to Image/xipImage.

RISC-V set `-O binary` flag in both OBJCOPYFLAGS in the top-level riscv
Makefile and OBJCOPYFLAGS_* in the boot/Makefile, and the objcopy cmd
in Kbuild would join them together.

The `-O binary` flag is only needed for objcopying Image, so remove the
OBJCOPYFLAGS in the top-level riscv Makefile.

Fixes: c0fbcd991860 ("RISC-V: Build flat and compressed kernel images")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 1329e060c548..b43a6bb7e4dc 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -6,7 +6,6 @@
 # for more details.
 #
 
-OBJCOPYFLAGS    := -O binary
 LDFLAGS_vmlinux := -z norelro
 ifeq ($(CONFIG_RELOCATABLE),y)
 	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext --emit-relocs
-- 
2.20.1

