Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0052776ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjHIVLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjHIVLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6A2211B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3E6B649E6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2BCC433BA;
        Wed,  9 Aug 2023 21:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691615471;
        bh=e+yBdXe6YH6EAyOPKB3mcLVmPCMP0zUx7UJIGD0M24w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPqTAqDwPtJ1adwP/Ym9C+awpJpFqEqJivs/iuesBtoennfgdBbZX3ea3L3TV/z7+
         96H5CL//YII1mgUJNlkO+3nTN0OT3lcJdj7/K2Um+hlUF2gDzUsEns0OuGAjl1n5Yf
         Exi7GhbHsmfkP8byLH5s9hJVW5c+JHmqYcSGYb8130SIBFUGSiT6EfXAC/eG2UjU+y
         uvXvQ0ZYSE8pnpbx6ui9r29DLsQ5hIzbD7ZC3tPgfJAceYjaJ1L4nLWx8rVcgb3/Vk
         gKlaR+roTAzP6FIL4oqFwjeXKzX3oxiKBSZC79ggrV6ajft9PflD3Fp53TqUKAu+R1
         mo504NW7osw6Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] m68k: add memcmp() declarartion
Date:   Wed,  9 Aug 2023 23:10:50 +0200
Message-Id: <20230809211057.60514-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809211057.60514-1-arnd@kernel.org>
References: <20230809211057.60514-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

There is a global definition of memcmp() that gets built on m68k but is never
used and causes a warning because of the missing prototype:

lib/string.c:671:15: error: no previous prototype for 'memcmp' [-Werror=missing-prototypes]

Add the corresponding declaration to avoid the warning. As far as I understand
the #define to redirect memcmp() to __builtin_memcmp() does not actually do anything
here since this is what it does anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/include/asm/string.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
index f0f5021d6327d..760cc13acdf41 100644
--- a/arch/m68k/include/asm/string.h
+++ b/arch/m68k/include/asm/string.h
@@ -41,6 +41,7 @@ static inline char *strncpy(char *dest, const char *src, size_t n)
 #define __HAVE_ARCH_MEMMOVE
 extern void *memmove(void *, const void *, __kernel_size_t);
 
+extern int memcmp(const void *, const void *, __kernel_size_t);
 #define memcmp(d, s, n) __builtin_memcmp(d, s, n)
 
 #define __HAVE_ARCH_MEMSET
-- 
2.39.2

