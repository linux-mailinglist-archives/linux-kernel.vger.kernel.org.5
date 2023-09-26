Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F767AF04D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjIZQJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIZQJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:09:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF6F95
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:09:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F55C433C7;
        Tue, 26 Sep 2023 16:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695744553;
        bh=KIbC1Ui2Ufy2ZZPQgUs1RBN/CWpdIljaKe9AGeuEHZU=;
        h=From:To:Cc:Subject:Date:From;
        b=nGT4zamObMbcyTm3cidGJPErWADcslA/S4HeodBErtmexNAHIo1FGdXIQbP1ZafTo
         dkUvTtPBLsSVezV3W4gOd73sZ9woyU0lEjWIZh0ZaLtSymgRZeQfa1mRx653HJgFKq
         eaDRjYsSRzOepbxCElSDxojz99v30Rz/xPk6rQhsEFeyqFNwF20T2VEZhOqF7H+eo+
         RC4oNgF4oB94j3Ade3j9wHiRz2Z/XDOnE6tA4FY2WUshPSEgwUWJofrE+FFuOFp86P
         Xm9UPJxXmiPdScr6z9pi9FML9rp0XgDJhSNGCx9Oc8H0zNLjX+d19P3D53EZFYK9Tj
         5lW5WrmgKUoiQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: fix get_user() broken with veneer
Date:   Wed, 27 Sep 2023 01:09:03 +0900
Message-Id: <20230926160903.62924-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32-bit ARM kernel stops working if the kernel grows to the point
where veneers for __get_user_* are created.

AAPCS32 [1] states, "Register r12 (IP) may be used by a linker as a
scratch register between a routine and any subroutine it calls. It
can also be used within a routine to hold intermediate values between
subroutine calls."

However, bl instructions buried within the inline asm are unpredictable
for compilers; hence, "ip" must be added to the clobber list.

This becomes critical when veneers for __get_user_* are created because
veneers use the ip register since commit 02e541db0540 ("ARM: 8323/1:
force linker to use PIC veneers").

[1]: https://github.com/ARM-software/abi-aa/blob/2023Q1/aapcs32/aapcs32.rst

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---

KernelVersion: v6.6-rc1

 arch/arm/include/asm/uaccess.h | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index bb5c81823117..c28f5ec21e41 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -109,16 +109,6 @@ extern int __get_user_64t_1(void *);
 extern int __get_user_64t_2(void *);
 extern int __get_user_64t_4(void *);
 
-#define __GUP_CLOBBER_1	"lr", "cc"
-#ifdef CONFIG_CPU_USE_DOMAINS
-#define __GUP_CLOBBER_2	"ip", "lr", "cc"
-#else
-#define __GUP_CLOBBER_2 "lr", "cc"
-#endif
-#define __GUP_CLOBBER_4	"lr", "cc"
-#define __GUP_CLOBBER_32t_8 "lr", "cc"
-#define __GUP_CLOBBER_8	"lr", "cc"
-
 #define __get_user_x(__r2, __p, __e, __l, __s)				\
 	   __asm__ __volatile__ (					\
 		__asmeq("%0", "r0") __asmeq("%1", "r2")			\
@@ -126,7 +116,7 @@ extern int __get_user_64t_4(void *);
 		"bl	__get_user_" #__s				\
 		: "=&r" (__e), "=r" (__r2)				\
 		: "0" (__p), "r" (__l)					\
-		: __GUP_CLOBBER_##__s)
+		: "ip", "lr", "cc")
 
 /* narrowing a double-word get into a single 32bit word register: */
 #ifdef __ARMEB__
@@ -148,7 +138,7 @@ extern int __get_user_64t_4(void *);
 		"bl	__get_user_64t_" #__s				\
 		: "=&r" (__e), "=r" (__r2)				\
 		: "0" (__p), "r" (__l)					\
-		: __GUP_CLOBBER_##__s)
+		: "ip", "lr", "cc")
 #else
 #define __get_user_x_64t __get_user_x
 #endif
-- 
2.39.2

