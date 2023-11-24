Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8AA7F6B10
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 04:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKXD4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 22:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXD4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 22:56:04 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D0601B2;
        Thu, 23 Nov 2023 19:56:08 -0800 (PST)
Received: from loongson.cn (unknown [112.22.232.197])
        by gateway (Coremail) with SMTP id _____8DxBfHXHmBlpXk8AA--.54866S3;
        Fri, 24 Nov 2023 11:56:07 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.232.197])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxO9zUHmBljVhLAA--.34762S2;
        Fri, 24 Nov 2023 11:56:06 +0800 (CST)
From:   WANG Rui <wangrui@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn, WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: Apply dynamic relocations for LLD
Date:   Fri, 24 Nov 2023 11:55:34 +0800
Message-ID: <20231124035534.70432-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxO9zUHmBljVhLAA--.34762S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryrJF18Aw47ury7Zw4DZFc_yoW8XrW5pr
        Wfur1UZw4kWryIqw1Dtw17Xw4UZ3W8GFnruF17Kry8AF9rXF93Xw4ktrsxWas3C395Wa40
        v3W5GFnF9F15J3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the following assembly code:

     .text
     .global func
 func:
     nop

     .data
 var:
     .dword func

When linked with `-pie`, GNU LD populates the `var` variable with the
pre-relocated value of `func`. However, LLVM LLD does not exhibit the
same behavior. This issue also arises with the `kernel_entry` in
arch/loongarch/kernel/head.S:

 _head:
     .word   MZ_MAGIC                /* "MZ", MS-DOS header */
     .org    0x8
     .dword  kernel_entry            /* Kernel entry point */

The correct kernel entry from the MS-DOS header is crucial for jumping
to vmlinux from zboot. This necessity is why the compressed kernel
compiled by Clang encounters difficulties in booting.

To address this problem, it is proposed to apply dynamic relocations to
place with `--apply-dynamic-relocs`.

Link: https://github.com/ClangBuiltLinux/linux/issues/1962
Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 arch/loongarch/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 1f0d74403419..05ab85118212 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -83,7 +83,7 @@ endif
 
 ifeq ($(CONFIG_RELOCATABLE),y)
 KBUILD_CFLAGS_KERNEL		+= -fPIE
-LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext
+LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext $(call ld-option, --apply-dynamic-relocs)
 endif
 
 cflags-y += $(call cc-option, -mno-check-zero-division)
-- 
2.43.0

