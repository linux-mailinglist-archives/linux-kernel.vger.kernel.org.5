Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCAA7E4F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 05:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjKHEFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 23:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHEFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 23:05:36 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20E6610D8;
        Tue,  7 Nov 2023 20:05:32 -0800 (PST)
Received: from loongson.cn (unknown [112.22.233.25])
        by gateway (Coremail) with SMTP id _____8DxRvEJCUtlOOw3AA--.44432S3;
        Wed, 08 Nov 2023 12:05:29 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.233.25])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxL90ECUtleMA7AA--.1906S2;
        Wed, 08 Nov 2023 12:05:27 +0800 (CST)
From:   WANG Rui <wangrui@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn, WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: Disable module from accessing external data directly
Date:   Wed,  8 Nov 2023 12:04:47 +0800
Message-ID: <20231108040447.288870-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxL90ECUtleMA7AA--.1906S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Gry5XFWxCw47CrW7ArW3twc_yoW8JF17pF
        Z7ur1DGws5ur4vvFnFyFWxXa90yr4DJr4fZa4Ikr45ZFW3uryFvw4Fyrs0g3W2kw4kX34x
        Ww4fCF9rtFW5JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The distance between vmlinux and the module is too far so that PC-REL
cannot be accessed directly, only GOT.

When compiling module with GCC, the option `-mdirect-extern-access` is
disabled by default. The Clang option `-fdirect-access-external-data`
is enabled by default, so it needs to be explicitly disabled.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 arch/loongarch/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index b86f2ff31659..9eeb0c05f3f4 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -68,6 +68,8 @@ LDFLAGS_vmlinux			+= -static -n -nostdlib
 ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
 cflags-y			+= $(call cc-option,-mexplicit-relocs)
 KBUILD_CFLAGS_KERNEL		+= $(call cc-option,-mdirect-extern-access)
+KBUILD_AFLAGS_MODULE		+= $(call cc-option,-fno-direct-access-external-data)
+KBUILD_CFLAGS_MODULE		+= $(call cc-option,-fno-direct-access-external-data)
 KBUILD_AFLAGS_MODULE		+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno-relax)
 KBUILD_CFLAGS_MODULE		+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno-relax)
 else
-- 
2.42.1

