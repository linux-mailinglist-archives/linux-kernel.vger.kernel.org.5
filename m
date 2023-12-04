Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED78031EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjLDL6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjLDL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:58:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D919AB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83113C43391;
        Mon,  4 Dec 2023 11:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691059;
        bh=f7mPCoikKyAxX+kfcbgmRu4ug6L+LPkQ+dYSgFSXlPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+jHt4x+nSEjuW01cDgKtc9kiRiD2SdnQ0deE6o2yur28Abjmd+mteEoC5EX5hGYl
         WwFf/aGQVD7cK/QNkEYiN2WyIMOok0CAP+bRzshMJUq+JV8FxNybIS4RfUq9ps+DYs
         b0KEPHDDdWJLzI/IlcQCKKmWHbUoW3AY07f8caszW3as77BaEC8i5d7Q+s7K1lf6U+
         iJKZZdhyVcbP155OJL2U89uctz+E6AZSSAVd17wBQs6VU2MygoB4w9nuYd2s9dv4Cu
         lPyBn7eLiYjo8ENI57IXmZLxMjO3KZKCvEmFJp2UyEQRiY6uwEj2+OQa6Ixd2T7fBI
         ASP0AAnjxrYIQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 10/20] mips: fix setup_zero_pages() prototype
Date:   Mon,  4 Dec 2023 12:57:00 +0100
Message-Id: <20231204115710.2247097-11-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204115710.2247097-1-arnd@kernel.org>
References: <20231204115710.2247097-1-arnd@kernel.org>
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

setup_zero_pages() has a local declaration in a platform specific header,
but that is not seen in the file it is defined in:

arch/mips/mm/init.c:60:6: error: no previous prototype for 'setup_zero_pages' [-Werror=missing-prototypes]

Move it to the corresponding global header and include that where needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/mach-loongson64/mmzone.h | 1 -
 arch/mips/include/asm/mmzone.h                 | 2 ++
 arch/mips/mm/init.c                            | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson64/mmzone.h b/arch/mips/include/asm/mach-loongson64/mmzone.h
index ebb1deaa77b9..a3d65d37b8b5 100644
--- a/arch/mips/include/asm/mach-loongson64/mmzone.h
+++ b/arch/mips/include/asm/mach-loongson64/mmzone.h
@@ -18,7 +18,6 @@ extern struct pglist_data *__node_data[];
 
 #define NODE_DATA(n)		(__node_data[n])
 
-extern void setup_zero_pages(void);
 extern void __init prom_init_numa_memory(void);
 
 #endif /* _ASM_MACH_MMZONE_H */
diff --git a/arch/mips/include/asm/mmzone.h b/arch/mips/include/asm/mmzone.h
index 602a21aee9d4..14226ea42036 100644
--- a/arch/mips/include/asm/mmzone.h
+++ b/arch/mips/include/asm/mmzone.h
@@ -20,4 +20,6 @@
 #define nid_to_addrbase(nid) 0
 #endif
 
+extern void setup_zero_pages(void);
+
 #endif /* _ASM_MMZONE_H_ */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 5dcb525a8995..c2e0e5aebe90 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -38,6 +38,7 @@
 #include <asm/dma.h>
 #include <asm/maar.h>
 #include <asm/mmu_context.h>
+#include <asm/mmzone.h>
 #include <asm/sections.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
-- 
2.39.2

