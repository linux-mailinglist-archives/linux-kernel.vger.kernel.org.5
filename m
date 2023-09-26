Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB907AF1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjIZRXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjIZRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:23:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74E1124
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:22:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06493C433C7;
        Tue, 26 Sep 2023 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695748979;
        bh=de4PaIe+gi6uEbnNSfbPH0YnkVx5n1zdlOSbQRUr3R0=;
        h=From:To:Cc:Subject:Date:From;
        b=hBLd32l3ouSF4pP2Rfe6jGzyEY4zTZRNbyPjNq7hLseYmzVm3j2mIUM080MmsQVXB
         Y3qIu2vb44eRdlLzw4FbbydqVtacnC79Z8gVDEuhIvvPoBKOGPYTr44ud9D/sI2YOw
         UDRMIGZQnKhqjGjt1U8SB5wHI7g/nSl4bw5byXzjrSiH7x0rDmx/Vr4eYzxSJJXPQq
         h4itxT41PNAfrYanOcTwQO5windtKNu6XVTGV+iyLJIecsiHPoYV9hzgSKd422/aLO
         DZPyDai3P+nm9c9EN7oKhGJPMNis3CE7uiXHvgvrNUuOjJs8aLyYULQVA9m69EnOLT
         FXpL4whjGsjeg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: make <linux/uaccess.h> self-contained for ARM
Date:   Wed, 27 Sep 2023 02:22:53 +0900
Message-Id: <20230926172253.73204-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I compiled the following code for ARM, I encountered numerous
errors.

[Test Code]

    #include <linux/compiler.h>
    #include <linux/uaccess.h>

    int foo(int *x, int __user *ptr)
    {
            return get_user(*x, ptr);
    }

To fix them, make some asm headers self-contained:

 1. In arch/arm/include/asm/traps.h, include <linux/init.h> for __init,
    and <linux/linkage.h> for asmlinkage.

 2. In arch/arm/include/asm/domain.h, include <linux/thread_info.h>
    for current_thread_info().

 3. In arch/arm/include/asm/uaccess.h, include <linux/kernel.h> for
    might_fault().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v6.6-rc1

 arch/arm/include/asm/domain.h  | 2 +-
 arch/arm/include/asm/traps.h   | 2 ++
 arch/arm/include/asm/uaccess.h | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 41536feb4392..d48859fdf32c 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -8,8 +8,8 @@
 #define __ASM_PROC_DOMAIN_H
 
 #ifndef __ASSEMBLY__
+#include <linux/thread_info.h>
 #include <asm/barrier.h>
-#include <asm/thread_info.h>
 #endif
 
 /*
diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 0aaefe3e1700..d44df9eac170 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -2,6 +2,8 @@
 #ifndef _ASMARM_TRAP_H
 #define _ASMARM_TRAP_H
 
+#include <linux/init.h>
+#include <linux/linkage.h>
 #include <linux/list.h>
 
 struct pt_regs;
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index bb5c81823117..6a2cc57f015a 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -8,6 +8,7 @@
 /*
  * User space memory access functions
  */
+#include <linux/kernel.h>
 #include <linux/string.h>
 #include <asm/page.h>
 #include <asm/domain.h>
-- 
2.39.2

