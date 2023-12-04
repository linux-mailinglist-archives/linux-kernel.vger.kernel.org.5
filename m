Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE14802DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbjLDIsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjLDIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:48:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A1AD5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:48:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FDDC433C8;
        Mon,  4 Dec 2023 08:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701679739;
        bh=avRXNhCgn7huAp4F/lOPdGun6ihRx2iYEOZ6I0ARj98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KunQWSpPMiSXBTeto8o1JSoSfRtvxFcZSjJqYzs1ugXuv5vhahAxLJe9FIwR7ce6t
         JpRC11NgJfw2BPupZBtJXLX6RB0RhAimTnD7b6O04mqUPWLjRzfdceE93Yb8lRgLfB
         /f8rsN7AIbxIgJ9Ta4MY1WS2I5qSxd2pPf5PZKq7CKeMfUktZUbSUV7AiOvVt7RhX8
         aH8rCBfE3TSmJSvgFcnBt/iWUqThOAq+tuaMQuJzK1C5okpCArVob/H2biUvM4krH1
         ImbbVv1dS0vd66tQPRioJXqfqRlTMZZBi7WsJnfM5xIwDjCsLMNdBR/5wdnlqqCpj2
         1Uc/FdPrAHbaA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86: rework CONFIG_X86_PAE dependency
Date:   Mon,  4 Dec 2023 09:47:02 +0100
Message-Id: <20231204084722.3789473-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204084722.3789473-1-arnd@kernel.org>
References: <20231204084722.3789473-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

While looking at a Xen Kconfig dependency issue, I tried to understand the
exact dependencies for CONFIG_X86_PAE, which is selected by CONFIG_HIGHMEM64G
but can also be enabled manually.

Apparently the dependencies for CONFIG_HIGHMEM64G are strictly about CPUs
that do support PAE, but the actual feature can be incorrectly enabled on
older CPUs as well. The CONFIG_X86_CMPXCHG64 dependencies on the other hand
include X86_PAE because cmpxchg8b is requried for PAE to work.

Rework this for readability and correctness, using a positive list of CPUs
that support PAE in a new X86_HAVE_PAE symbol that can serve as a dependency
for both X86_PAE and HIGHMEM64G as well as simplify the X86_CMPXCHG64
dependency list.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
This did not solve the original problem of the Xen dependencies on
64 byte cache lines, as there are a number of CPUs that support PAE
but have 32 byte L1 cache lines.
---
 arch/x86/Kconfig     | 4 ++--
 arch/x86/Kconfig.cpu | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 17a6b304fc0c..c53ebc86ce4f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1412,7 +1412,7 @@ config HIGHMEM4G
 
 config HIGHMEM64G
 	bool "64GB"
-	depends on !M486SX && !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !MWINCHIP3D && !MK6
+	depends on X86_HAVE_PAE
 	select X86_PAE
 	help
 	  Select this if you have a 32-bit processor and more than 4
@@ -1469,7 +1469,7 @@ config HIGHMEM
 
 config X86_PAE
 	bool "PAE (Physical Address Extension) Support"
-	depends on X86_32 && !HIGHMEM4G
+	depends on X86_32 && X86_HAVE_PAE
 	select PHYS_ADDR_T_64BIT
 	select SWIOTLB
 	help
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 00468adf180f..b9224cf2ee4d 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -362,9 +362,13 @@ config X86_TSC
 	def_bool y
 	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCORE2 || MATOM) || X86_64
 
+config X86_HAVE_PAE
+	def_bool y
+	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM || X86_64
+
 config X86_CMPXCHG64
 	def_bool y
-	depends on X86_PAE || X86_64 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586TSC || M586MMX || MATOM || MGEODE_LX || MGEODEGX1 || MK6 || MK7 || MK8
+	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
-- 
2.39.2

