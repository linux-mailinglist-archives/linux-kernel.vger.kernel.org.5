Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC076D727
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjHBStW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjHBStN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:49:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AFF1734;
        Wed,  2 Aug 2023 11:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F0FD61AFB;
        Wed,  2 Aug 2023 18:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84374C433CB;
        Wed,  2 Aug 2023 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691002149;
        bh=WYKfkfr7MebQWbq9faERXzPtA07lKx6EmcLFTn6CB2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cn+VZaY8lMvlmlTfVKNePJotkfJKqjUlKZcWScSemSjw/30kG7ayyX4xn54AyicAK
         woCQXOz72VOsNW7LZXdIpQZf3iQlV5/sKexruF+XUqNRDZjQ5TAvEGrVKmPl3dN07t
         y+cslHEo0B4HsmB61mp5uk5dmGBfk7iMsV6VuBs46T//rxlbNAdyGJbItW2ZdBXMF/
         pnvhXtz8tgrL7ClXGkeSkrpUBIK9uLBs//D7eSoZR3ioOPdO0rsSrdiWD0TorMYp0O
         QHIWq/f8J2+Rr/1N4pqDe+baG/Ml/QyMRMF/vkjLNPe//JDctKB3QCD8IckxW+9StM
         rNhw1qVpB9eGQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
Date:   Wed,  2 Aug 2023 20:48:49 +0200
Message-Id: <20230802184849.1019466-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802184849.1019466-1-arnd@kernel.org>
References: <20230802184849.1019466-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These functions were only used on the microdev
board that is now gone, so remove them to simplify
the ioport handling.

This could be further simplified to use the generic
I/O port accessors now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/asm/io.h      |  4 ++--
 arch/sh/include/asm/machvec.h |  5 -----
 arch/sh/kernel/ioport.c       | 13 +------------
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index f2f38e9d489ac..ac521f287fa59 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -181,7 +181,7 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 {									\
 	volatile type *__addr;						\
 									\
-	__addr = __ioport_map(port, sizeof(type));			\
+	__addr = (void __iomem *)sh_io_port_base + port;		\
 	*__addr = val;							\
 	slow;								\
 }									\
@@ -191,7 +191,7 @@ static inline type pfx##in##bwlq##p(unsigned long port)			\
 	volatile type *__addr;						\
 	type __val;							\
 									\
-	__addr = __ioport_map(port, sizeof(type));			\
+	__addr = (void __iomem *)sh_io_port_base + port;		\
 	__val = *__addr;						\
 	slow;								\
 									\
diff --git a/arch/sh/include/asm/machvec.h b/arch/sh/include/asm/machvec.h
index 2b4b085e8f219..4e5314b921f19 100644
--- a/arch/sh/include/asm/machvec.h
+++ b/arch/sh/include/asm/machvec.h
@@ -19,11 +19,6 @@ struct sh_machine_vector {
 	int (*mv_irq_demux)(int irq);
 	void (*mv_init_irq)(void);
 
-#ifdef CONFIG_HAS_IOPORT_MAP
-	void __iomem *(*mv_ioport_map)(unsigned long port, unsigned int size);
-	void (*mv_ioport_unmap)(void __iomem *);
-#endif
-
 	int (*mv_clk_init)(void);
 	int (*mv_mode_pins)(void);
 
diff --git a/arch/sh/kernel/ioport.c b/arch/sh/kernel/ioport.c
index f39446a658bdb..c8aff8a20164d 100644
--- a/arch/sh/kernel/ioport.c
+++ b/arch/sh/kernel/ioport.c
@@ -12,15 +12,6 @@
 unsigned long sh_io_port_base __read_mostly = -1;
 EXPORT_SYMBOL(sh_io_port_base);
 
-void __iomem *__ioport_map(unsigned long addr, unsigned int size)
-{
-	if (sh_mv.mv_ioport_map)
-		return sh_mv.mv_ioport_map(addr, size);
-
-	return (void __iomem *)(addr + sh_io_port_base);
-}
-EXPORT_SYMBOL(__ioport_map);
-
 void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
 	void __iomem *ret;
@@ -29,13 +20,11 @@ void __iomem *ioport_map(unsigned long port, unsigned int nr)
 	if (ret)
 		return ret;
 
-	return __ioport_map(port, nr);
+	return (void __iomem *)(port + sh_io_port_base);
 }
 EXPORT_SYMBOL(ioport_map);
 
 void ioport_unmap(void __iomem *addr)
 {
-	if (sh_mv.mv_ioport_unmap)
-		sh_mv.mv_ioport_unmap(addr);
 }
 EXPORT_SYMBOL(ioport_unmap);
-- 
2.39.2

